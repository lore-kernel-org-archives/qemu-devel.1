Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B308CA9ED4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E3D2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCl+uc6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E3D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRl5n-0006cL-Hy
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 17:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iRl4s-00069R-Bl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iRl4r-0007fI-66
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:44:02 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iRl4o-0007cV-H0; Mon, 04 Nov 2019 17:43:58 -0500
Received: by mail-lf1-x141.google.com with SMTP id b20so13529746lfp.4;
 Mon, 04 Nov 2019 14:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J0pWweTQhy6WIFbw5Gf0DhUrRGgO4RQYzVx9awR7bkw=;
 b=DCl+uc6fmgr3HIHloW10okZZFjTSmohOwGtLHFrzGGDNlujGUHmRSyAeR/kT1VLH+u
 mS/SBZCEKjREnGW7xFN6CjNPwIaKVHi/plRHuXfpjBF+KDg/+cm/Ue+9l7C7PxtF5bYt
 mgMkK1b6DCyz2yUNn0ELHONuFBjwPOv6PX+x8pVR2D3mS9CcoLWTDhMOX9C+M2CT8p4g
 IeFG6KzTEyD1DIXfpAxaD+qFVXma8522BgssAd0KQ5PaW9ZXz7j3vWtcmiwTrCyoOxZY
 9NSPp4HqT7GwPmbsbJjxOwK0syDDOWmx7iLncKQuwiKz7b3p9niJ5SUinmBsXsSAlUA8
 9FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J0pWweTQhy6WIFbw5Gf0DhUrRGgO4RQYzVx9awR7bkw=;
 b=LEmXCLOS9p6Wy3w62wBh6LW8vCDer3y0YFYotWSTdDZAkYjZA9iMzOhvNbL5ujJAI5
 Zf1j9RM54BAIQ+QIHeQPvWuB4yCPx5kpjIoL3I03gxPuV1SnGOQ0pIgjXzauCKjeWwPX
 7rn91bzapS6KHaNzG9b6xbP+2HFNu7qHgL5mR3+Vgl2C4+R0SHLOGCswOcapz2I+aRLC
 gaEVRh2Rxp7k2bKTBDaTdXstCdODRrIIfpms6/lobSokh8kEFFJXdciPZ53570jykuzV
 dkPz8M64WtXCZrMbaZnmcaIDhxj6fXdI3bfBkfDSxnBCaO8TfnMWP4gH832sADkZ7nuB
 kAag==
X-Gm-Message-State: APjAAAUOm6Fdb3N7grrJCYk4QMoiyuhiRoNDab3JLUuCQBPb8QiD0m7d
 BvQtbzu/MLNbl15xo4GPRhRKaTou5jtcE+wA1+0=
X-Google-Smtp-Source: APXvYqyvBUSKPiiTVb/vxNSLj3JfUdRXAWIjQlCs7roKI9A8qkEFEcOoO6J4Duwg0nJLVdUgwrcKtJP0epJXDPynsCs=
X-Received: by 2002:ac2:5210:: with SMTP id a16mr18636360lfl.156.1572907437086; 
 Mon, 04 Nov 2019 14:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20191025042734.69244-1-anup.patel@wdc.com>
 <CAKmqyKMQz-OMFQRTdmpBpGMLiZ_ZM+UL5T5aAWZ5F1fC6vddOQ@mail.gmail.com>
 <CAFEAcA9bV=-t0+ro6rxu7Atodj6J78aT1aMnz9bjaqyfLDV3_w@mail.gmail.com>
In-Reply-To: <CAFEAcA9bV=-t0+ro6rxu7Atodj6J78aT1aMnz9bjaqyfLDV3_w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Nov 2019 14:38:20 -0800
Message-ID: <CAKmqyKNUsZBt=Pa3TAkGUP_DFThWSs2nwjXMJSbQ5r927jtnkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] RTC support for QEMU RISC-V virt machine
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 2, 2019 at 3:37 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 29 Oct 2019 at 13:25, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Fri, Oct 25, 2019 at 6:28 AM Anup Patel <Anup.Patel@wdc.com> wrote:
> > >
> > > This series adds RTC device to QEMU RISC-V virt machine. We have
> > > selected Goldfish RTC device model for this. It's a pretty simple
> > > synthetic device with few MMIO registers and no dependency external
> > > clock. The driver for Goldfish RTC is already available in Linux so
> > > we just need to enable it in Kconfig for RISCV and also update Linux
> > > defconfigs.
> > >
> > > We have tested this series with Linux-5.4-rc4 plus defconfig changes
> > > available in 'goldfish_rtc_v2' branch of:
> > > https://github.com/avpatel/linux.git
> >
> > @Peter Maydell this has been reviewed, do you mind taking this in you
> > next PR? I don't see a maintainer for hw/rtc.
>
> Generally devices used by a single architecture should
> go via the tree of the maintainer who handles that
> architecture -- in this case that's riscv. (The reason
> is that it's only riscv folks who can test whether the
> device works in the machine model, and only riscv
> folks who can reasonably review whether the device
> is the right way of implementing the functionality for
> them.)

Makes sense

Alistair

>
> thanks
> -- PMM

