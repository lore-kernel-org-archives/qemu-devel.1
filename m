Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6BAC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18FE208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fseDScvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18FE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWuT-0001Tt-Vl
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlWmC-0008SI-QU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlWmB-0001Dw-IH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:58:12 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:40205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlWmB-0001DW-7b
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:58:11 -0400
Received: by mail-ot1-x332.google.com with SMTP id e8so5378819otl.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CIJ1OgRCdquFncu22tR6eJdqPnkUHXVdN6rPHTwHlZo=;
 b=fseDScvGXRId30tS6j7zpWT1kIDbS35HbaKsZiywP5RXRGG4GK93Fr1a5aOgn2QfpK
 DLzjCInbYS4Av3DpC06Myx8MDghiYFPyrUZ2zF3Xl0UR4J6VTGpANFaMVEEjENpBF/3y
 Dg/HOYT8X6K3AabS6ZaAzqZOxKDydJHbFNX157j71Lg/6N2y0Hq6n1tqJ+SMIIl+0Atn
 ccKdZ2YwKVtT3vvB+x/fTjofAxIWJs1mz5hKIKR8eVfbVvGnLNh+GjxsXAvd2bMseHbW
 YXoEnyd7G2WUNaUeMECMgUo0Yi5a3dbomYvVQ3oZllEVjdVyYCkM7J3IIOknSWUtMm1W
 z70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CIJ1OgRCdquFncu22tR6eJdqPnkUHXVdN6rPHTwHlZo=;
 b=SfzvP6nN8KuAi4vAHriAVJcWyH0VuSU1GC/WYOBxfAiVMYgLw/seSelmpK/HkO2Mhp
 47qtWWUMV2rzbe22AlRebUuXnCiorJHVW0m0nRmyQI/NyfcZ45KTHe06wuUXNacyKPpw
 ffBpLVv3IsTGYcYDO6gZc2Ykqf7qSk5eP8IHOF+IIHGL7N7AvuVYA6q5DYz599Gl+xXg
 Q49oQ6kq/XksjU7CLzhKBguzIWCiNPK2iyy4YvqExpjXvGZ0+3kJpsbHL18Q0QXoOMRP
 quY6uGBujRTbw2DEd8GMdf3HuPyY3hojWvHpmutHcCs1FBSIaA/Sai417ZSYIAcS1ae1
 wmmQ==
X-Gm-Message-State: APjAAAVVjqNto+dtR+c/aeNY/rVdMoTRPYG8PFUlS2sYJ8EbP3RX8zaT
 AzhUnhkKuLNzht8nqoyd/fKrq8S8pxwnBvM9cy8x+93ILZ4=
X-Google-Smtp-Source: APXvYqy9SiRnMiR5XgT0x/QdAPui08ffwLWA9pauc9SxlOYRP52DVTtnW5vrEc7WZnImRUzkgR006CKJk0NhNgTXvHo=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr2678974otj.97.1562842690273; 
 Thu, 11 Jul 2019 03:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190710102557.3107-1-alex.bennee@linaro.org>
In-Reply-To: <20190710102557.3107-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 11:57:59 +0100
Message-ID: <CAFEAcA8B=pbXHKycmOyWs_msAHZynz1wJm_aj885bj9zSs0+yg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL for 4.1 0/4] testing and gdbstub fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jul 2019 at 11:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fd=
fa:
>
>   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-gdbstub-10071=
9-1
>
> for you to fetch changes up to 94b2a62bb65b80760bcc59737bec908c9175abf4:
>
>   gdbstub: revert to previous set_reg behaviour (2019-07-10 10:54:46 +010=
0)
>
> ----------------------------------------------------------------
> Testing and gdbstub fixes:
>
>   - fix diff-out pass in check-tcg
>   - ensure generation of fprem reference
>   - fix gdb set_reg fallback
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

