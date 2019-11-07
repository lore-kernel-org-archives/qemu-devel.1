Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D56C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4291020869
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKRP3Ltm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4291020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmEc-0004XV-Gs
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSm5z-00033m-5G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSm5x-0005x9-2X
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSm5v-0005vY-6M
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:19 -0500
Received: by mail-ot1-x341.google.com with SMTP id r24so2763731otk.12
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QLPMILH9Am1e1pRaM3fL2+ZRqB+1lVT4Qo02XzZ4mk4=;
 b=yKRP3LtmMcoAdqC26lP9ifieVNGgdNVwb4keCWDbt38lhhas1XCa37UV7/jxeC7eFg
 I4H9jFmDXyenZICG7X/ile7j8+NAyQzdyUOiEIPZR8bIYvkrb385tsVDcfp+05yZMmU+
 5PW1XBX7PqQfVSezFV4DvAdI20dNZ/WHd0wWskEaQmVvYN+FKU2H5VPeT9LHaqu0UnIB
 3uPUNRhOIP6NYVOwa7zBoFviHIuxFBYObPVSFqqVHMDFcLOaVcN6zDCkqv7ZoPS2//b8
 yGi1Bb8UHDZX6AcS8NqmMFgO8pua+jllIWBDX1ihLNBSvzhc040DLchggSdQ3/W8LtXf
 AQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QLPMILH9Am1e1pRaM3fL2+ZRqB+1lVT4Qo02XzZ4mk4=;
 b=MPCvRT01KtytoT8M8P2pA+60Rfe2eFH5AeyNRzG1Jw6vDV9kOqVe/MXAIBDUK9NUPm
 DTuRoe2dJLQrKyaBeK9/f4eMcvMsn3cxixNaEs35+ZtPl75eSiMjq10E+P0tU01gutat
 8PIXU+EJee3hGzghsG+EatOmyS+p/t6i/Qzs/0MXd8pS22LutPIUQZwbCjiRUCKPRTp3
 iYndGxVQ0XfYKTGwM2vn/Szz1hGm4hgS42NIMdKNGRpRzR32sx2Rnp4oxN+ty87ExhdG
 M9MwN/chxvvqVT1VfgUWfM2y5UjyQ21PnW8l1nzjwJbJeHoQBgMsJuv4FtFI7dj9B8qZ
 /Skw==
X-Gm-Message-State: APjAAAVG/7essXJZvsKL0nqh6cIOUwE3sEBrxJ4IrgZKOnma59DGmO2Q
 peMeAohVO4McAH5qiYvl0cteiQPmiOkO55GeR2Yi3g==
X-Google-Smtp-Source: APXvYqwciffcph1l800dGrbynVRr12rMouK0JMs3akfp83xorl4Q2x5H7zDBmK152Kr1IcAOk+8vwsw7vJMWOi3jf3M=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr4317335otg.232.1573149677554; 
 Thu, 07 Nov 2019 10:01:17 -0800 (PST)
MIME-Version: 1.0
References: <03c2f42b32fb4e304319c241122ae83584f085e0.1573087610.git.alistair.francis@wdc.com>
 <mhng-35530489-a164-4825-90da-e550083fef9d@palmer-si-x1c4>
In-Reply-To: <mhng-35530489-a164-4825-90da-e550083fef9d@palmer-si-x1c4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 18:01:06 +0000
Message-ID: <CAFEAcA8YU5pp5xwqJSBqLtChp1WFmGFLUsHjnWPGk6+k1MtV3Q@mail.gmail.com>
Subject: Re: [PATCH for 4.2 v1 1/1] riscv/virt: Increase flash size
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 at 17:09, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 06 Nov 2019 16:47:20 PST (-0800), Alistair Francis wrote:
> > Coreboot developers have requested that they have at least 32MB of flash
> > to load binaries. We currently have 32MB of flash, but it is split in
> > two to allow loading two flash binaries. Let's increase the flash size
> > from 32MB to 64MB to ensure we have a single region that is 32MB.
> >
> > No QEMU release has include flash in the RISC-V virt machine, so this
> > isn't a breaking change.
>
> Even if we had, I wouldn't consider it a breaking change because it adds to
> the memory map so existing programs will continue to run fine.

I have a feeling you may find that some old command lines won't
work any more because they specified a flash contents binary
that was the old 32MB and now it needs to be padded out to 64MB.
But I haven't tested whether this theory is correct (it will
depend on how the flash contents are specified -- --bios will
be ok, as will loading contents directly as an ELF file or
similar, specifying contents by a -drive option intended to be
consumed by the pflash is the case which likely needs extra padding.)

thanks
-- PMM

