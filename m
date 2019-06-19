Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07DC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 01:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A552085A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 01:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUDWMi5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A552085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdP5e-0000kE-8k
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 21:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51493)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdP4O-0008WC-S4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdP4N-0007XB-Pq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:07:24 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdP4K-0007T9-A1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 21:07:21 -0400
Received: by mail-lf1-x141.google.com with SMTP id u10so10665951lfm.12
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OpKDJ/kYeXsdyVh9nmAU38ufjY6q2wYsuOhq1QB+93k=;
 b=kUDWMi5Z37n8Ov2N3o+6R5jwiK7yTR6knshkreN0PxFuvHDDmTyacb5+YYaWbQu+6F
 1o/Fgha9urvFpV9E3f4/JbcofyKb6Ah978nzqTeRDjshXFvkDXxT7+k2WE3/mKXZqEHi
 Dv3PATlkFx/9pm2vftTA68CCGJ8JQVgBW4j8sjhRjsB/0RUeTADdwCRBjDhxgGN7rVeN
 fBxhlhoErnfck5eqfMeR9/A+S8EN6Ln43/rgMZw3kUeKtl436BSgUDroNEJuuTf/97uZ
 Q9Ii0I+OjHIJ97tiaEO2HR5zzekM8pcyoU2fXUV1Hvbuu/ef8t04K6lkkD7a0BjSTu+3
 DlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OpKDJ/kYeXsdyVh9nmAU38ufjY6q2wYsuOhq1QB+93k=;
 b=KMlvxjDFKBEHeVdjnhg7ZaG+VJkqzfbSUApqQvFqADuuvs3Sstme1y4DRhaUQ/LM6G
 tWA50F8u++0PDnpFMFP4RvrCYd5IlH1y1Tj2UsHbTWeiL3wAKQ8DyTOsZKpQQW6m1UWz
 HdAJcv6Y/dAfFBBUuT2+lFwgU/pDXGDLGJw+jN8twsoeSR/OWyIySwZ1UIbTlhYh0kgy
 ssTwhImkmwfx5Aw/BupZXFQo/wWGqB6NDFXycRvy5ecJuHQS2+numDXTEZSKYumWpxK6
 BlgHVImL21k/g7+RubTsDSeUgmHrH4yikFkXZPg1TI/j8IqTRAGNto/sT4GgvX1QjEXy
 P6hQ==
X-Gm-Message-State: APjAAAUxCuKP21Kz9H0hSgsSOnLjl30aiPaUocZ4V2ZGFYdEdRubBUpF
 IqkuR/sjcgtq8gK11P6ChlzWDVTlU2jaRI0AePI=
X-Google-Smtp-Source: APXvYqzfMH9q9PZteWciUbmrxD07VnPnH2dZ3cr2rXHgnAIxnXYzFseHoq/M5FXfS+NCq30gFlkvazZkmzcNujJ6r1w=
X-Received: by 2002:ac2:5324:: with SMTP id f4mr19628160lfh.156.1560906434742; 
 Tue, 18 Jun 2019 18:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
 <PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
 <CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
 <CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
 <CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
 <97245929-a8b5-4b67-bfee-656db4438cd0@www.fastmail.com>
 <CAKmqyKOhfjwO+8UBj+-RiZiYUHM7LeDeJk+cmXfuKd5psowP3A@mail.gmail.com>
 <CAFEAcA_0NpQRJnMx-1vUCD_=e1GsfTBhO3z1rrz99CY+GNmGhA@mail.gmail.com>
In-Reply-To: <CAFEAcA_0NpQRJnMx-1vUCD_=e1GsfTBhO3z1rrz99CY+GNmGhA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Jun 2019 18:04:26 -0700
Message-ID: <CAKmqyKNW+Y1geGZUBa9WHPWZ_i40bDLxCJx5up5N1sLFTU32Zg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
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
Cc: Alistair <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 5, 2019 at 8:34 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 4 May 2019 at 06:26, Alistair Francis <alistair23@gmail.com> wrote:
> > Ah, it seems like -device loader doesn't work, it looks like not
> > setting the thumb register causes this core dump:
> >
> > qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> >
> > R00=20000000 R01=00000574 R02=200015d0 R03=200015d0
> > R04=00000000 R05=00000000 R06=00000000 R07=00000000
> > R08=00000000 R09=00000000 R10=00000000 R11=00000000
> > R12=00000000 R13=ffffffe0 R14=fffffff9 R15=0800cba4
>
> Is the ELF file incorrectly setting the entry point address to not
> be a Thumb one (ie low bit set), or is the loader device not honouring
> that? (I thought that we'd fixed the latter of those recently...)

It looks like all the reset logic is correct in terms of these lines
in arm_cpu_reset():
        env->regs[13] = initial_msp & 0xFFFFFFFC;
        env->regs[15] = initial_pc & ~1;
        env->thumb = initial_pc & 1;

The problem is that vecbase is 0, as cpu->init_svtor is 0.

cpu->init_svtor is set via QOM properties in armv7m_realize() based on
the armv7m property "init-svtor".

So hopefully I should be able to just set the property "init-svtor"
for the armv7m object. I'll test that out and see how it goes.

Alistair

>
> thanks
> -- PMM

