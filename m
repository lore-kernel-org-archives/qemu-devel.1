Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EC3ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717DF2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+ThUQ+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717DF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLSZ-0008J4-4m
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iFL35-0004Uu-Tm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iFL33-0007um-Lu
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:30:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1iFL31-0007qS-JR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:30:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so4065789wma.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iDE3NPxK2YgasB7/UtWZn8dDQ9EAgUrKIEWxXkVOJEs=;
 b=Z+ThUQ+xug7orDJ6yRzSKmboswm1kWjiB2agoyiTUNh4x3wAf0YD0YcWjh22THsmtQ
 gn/f0sQRWXAYFaCtstRqGFFxGkc1RK1jt0O3BAo7wctY8ntLdu2YZbwnHpjiwMzOx0LX
 5jQmCOzvAnn2W6GyqDcD3S2CTvVFY2HnEe0SNHRlwnIgm6sPBopaOXXhJxTaILtdONN0
 lbrD+Y1rbRQNV2RVo7bwc70M3WpSGXY7gEYRBraS4H+9wy9d+eqZbKG5TTAbFlchfX/q
 6ddW+REWFJJewJkinmVhOsU2Bl4Ite9mzoIFArQL8A4/c3Zd6w5/DMDc//i/ChKjN8g3
 LV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iDE3NPxK2YgasB7/UtWZn8dDQ9EAgUrKIEWxXkVOJEs=;
 b=ZNZ7ojID41fupWmj4l5wm5en8Ij3lzcAjvAXh/5RWUsfmhhrsI0u9h4AJ5oGIv/RqM
 eyo7HPB7HfZevhshSsDO8AHpeXH0uaGUVYXmixCqmcO8U3rvYOvJF5dmkCZqqfn6kySL
 Ie14vkruLiWjjgn7qqqrrYxKejfHFqsMDYZuEXt9pgZjkis/e4dzFPXODIRlhFwog/VW
 oWHW4obHqZ1CsMYYlDqjuEkebrOAXO2nmy/AkkBoohdUCMPQ2+Xq7ZcnMv5vNRTecxuX
 HIMPlw8TUvu2qfulKoeWAR9ISoAgGX1KSmzjuymvKfC+0IuZKd78CrzvKhKej0xbSYXy
 e8kg==
X-Gm-Message-State: APjAAAVQ7sixpfLQn7dhCVL4UkS8nXrJkwQ3zAl4mwwxCqLhdXlnWvQa
 3s+8yd9Id0vPkkJ9qdK9WduNaPcJn1XwrciHYoSQNA==
X-Google-Smtp-Source: APXvYqwipksf2TwEi2e68Whm0YBn1mVgixnRiNECnv3He5K5g1x0UStfqNvDR5EZOcqecODCsX04tSrjHC7XFo34klA=
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr4537934wmj.53.1569947443269; 
 Tue, 01 Oct 2019 09:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <21633062-b021-a8e7-0cc8-062f4c29dde5@linux.microsoft.com>
 <ca5c74db-cf5d-0c3f-eb6f-27d1092420ae@linux.microsoft.com>
 <65b49cb0-c9fb-d966-8dec-1e39d09ab8c7@redhat.com>
 <88878b22-803f-41fc-9df2-2c6eb551b98d@linux.microsoft.com>
In-Reply-To: <88878b22-803f-41fc-9df2-2c6eb551b98d@linux.microsoft.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 1 Oct 2019 18:30:31 +0200
Message-ID: <CAKv+Gu8kwg_tsrH7qne3H11hUPyA6zw-J_jpUmiyJMvXo3-SNQ@mail.gmail.com>
Subject: Re: Is kexec supported in QEMU for ARM64 (qemu-system-aarch64) with
 arm-trusted-firmware, optee, and u-boot.
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Oct 2019 at 00:27, Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 9/27/19 2:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > Cc'ing Ard too
> >>
> >> https://salsa.debian.org/debian/atf-allwinner/commit/b6b671c4ac4bd5595=
306863225bb3bece1e6135c
> >>
> >>
> >> Current limitations:
> >> * Only cold boot is supported
> >> * No build instructions for QEMU_EFI.fd and rootfs-arm64.cpio.gz
> >> * No instructions for how to load a BL32 (Secure Payload)
> >>
> >> So looks like only cold boot is supported (no kexec support)
> >> Is this correct?
>
> Just wanted to check again -
>
> Does ATF and QEMU (for ARM64) support cold boot only and does not have
> support for kexec?
>

kexec is a linux concept, so whether it is supported should not depend
on the secure world firmware or the underlying host.

