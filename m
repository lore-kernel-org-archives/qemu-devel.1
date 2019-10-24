Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999DCA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175FE21655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gik9ryM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175FE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdcA-0001Je-Lk
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdNc-0001uW-89
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdNb-00060S-2g
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:20 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNdNa-00060B-Si
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:19 -0400
Received: by mail-oi1-x244.google.com with SMTP id i185so20617509oif.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=svkYQX9Ip6YQ4FFQEFmC1PFZSBnrWFKrE59EzO0oH3A=;
 b=Gik9ryM2r3Gl/84LiXXVChpMzk/x9TmA0l7+fX3uOiyHQvbDbFQR4GbBRmsJl5qiVM
 SXwAybh6TSFyzMvklkHHybZbI9BIxj+Xelw1+TvD+15sUE4/T5ourSxoEUbNGbuXIRG3
 tplxzNtASrn/2dF5oBe6LyxcN9a/DTH+AE8FArrVIgvMWOsBpBZ8ZecrUNzZw/mvccKY
 OgRqXtYjA49PiqDc46P2yND3ry/7lAHN5KkqlnI8LurPlAFz1StZ2piRP0/TOhreiQnI
 yrOPH4W5tyiB5t5lq5byPhJ/Njee15xSGTE5txUMZNxsoelNTRkGyodGd4mZa2bAWyT2
 rP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=svkYQX9Ip6YQ4FFQEFmC1PFZSBnrWFKrE59EzO0oH3A=;
 b=aHsgdiytW12ssa/k54pBE/ioDFhVExBfl83joB12Pj2MFR4VAhvtyO19By18Ahtf2X
 0dvKpbit3eJLqa4MfL2eyboIqxwDDvZmNYQBjwxjajy68CY7iKceDIQhfso/baXfUymp
 msCfSFRxtOdoHar6n0Si9X9S6QBWDZleSf1NMiv1qPKXxbDzEb2aumwsOfOEzfd2kw+f
 wsons2KHJbXUF45s5kXVYXLRbHLexeTKlGYQzi3Ecq0KL3lvnRXNDTZr10OvEee9+Hue
 Sl5ii7TJObigKtptynYIwx+zXHoxWofkuN5zvGxxcvFrh26nRQdX0Z3PrHwwBWZlx2yw
 MJFg==
X-Gm-Message-State: APjAAAWioz37qQdn4mEVr9DG/lxYFGJESc2NezmvBPyHrJQcprH8Mzcd
 jdH31w33K2c58/ZPG8Hg3LDoMdMbQIKcSXt/C+qjYA==
X-Google-Smtp-Source: APXvYqxN82VfPmOGF4L8cznBIdyHi7HndV+DgZmU3QYMxIVDCKhagL388OokANsREeFk5Nibvd29N5B7JwrvWgAJZd0=
X-Received: by 2002:a05:6808:608:: with SMTP id
 y8mr4531937oih.146.1571924537936; 
 Thu, 24 Oct 2019 06:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 14:42:06 +0100
Message-ID: <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] hw/arm/raspi: Add thermal/timer, improve address
 space, run U-boot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Rob Herring <robh@kernel.org>, Matthias Brugger <mbrugger@suse.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 20 Oct 2019 at 00:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Since v2:
> - fixed issue in videocore address space
> - allow to start with some cores OFF (to boot firmwares)
> - add proof-of-concept test for '-smp cores=3D1' and U-boot
> - fixed my email setup
>
> Previous cover:
>
> Hi,
>
> Some patches from v1 are already merged. This v2 addresses the
> review comment from v1, and add patches to clean the memory
> space when using multiple cores.
>
> Laurent, if you test U-Boot with this patchset again, do you mind
> replying with a "Tested-by:" tag?
>
> The next patchset is probably about the interrupt controller blocks,
> then will come another one about the MBox/Properties.
>
> The last patch is unrelated to the series, but since I cleaned this
> for the raspi and the highbank is the only board with the same issue,
> I included the patch in this series.

I'm going to apply 1-10 and 14 to target-arm.next.
(I've reviewed 10, and the rest have been reviewed.)

thanks
-- PMM

