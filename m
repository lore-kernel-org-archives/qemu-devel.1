Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2EEC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CB720678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAwFJboT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CB720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACn1-0008Na-Vd
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iACf2-000303-1Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iACez-0002Be-6h
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:32:47 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iACex-000292-65
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:32:43 -0400
Received: by mail-oi1-x244.google.com with SMTP id w144so2668324oia.6
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D0o0aUvbawcXJQPBbfWL5KuT4pQyujcBNucaqsPdCdc=;
 b=qAwFJboTskR9dtbTpDG4diihIB78sTcvHRDc+snYYgmvLbIHC5e9Rwkh8mCblDhj96
 lBFlZpHBlNGexb+sheSOKBE5f/HemqeNFr4rkSmvXNNzca0Qsha0X/ShjwVEUvj89eB8
 19lgxdC2qaF4kJeGxcB0IktJEeoPUxFJdrar+IVrNaYcLIxVkmeWlwYsU0NxnLueoz/v
 IxLm8cXj/XdxqnCK3ZQdER8fc+EAvA6wwMaqFI92NSSu38kXM9Wz6LIwOmV6bz9rSLJt
 YKBNq/F4RPhfuCJ/J47Yn4WwyWleSl8t1ASXX1w1V+9Z1u7ez8A3rimrKcbFTluEeebB
 eFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D0o0aUvbawcXJQPBbfWL5KuT4pQyujcBNucaqsPdCdc=;
 b=i0rxbcOraln7x+HmMfd2mjxCqG6uWQnRx3E/jUQidzk9/S5XXaqgaAQMPLGZbpjGf1
 M+GnGVkdB6tVP120Cbim8W7GlHxEpoI/BfeJ+D0zHc31jyyAZBiTJaf3HvxwcSYkJRke
 qEhl/0BEJQOB7kfVTJ7UqJukXJlFpQDDPVABt5JYxeQzXWmCUS7k5LO98ftDpmvsytsM
 C0CdYW3w2zNHf5spAX6bxnDQaWqPUPzp294PmZj+YI/Z4d9ozL/rkx71C1D7+k/BNS1d
 LOSOY1CQwAQmOo+EHbhucjosGCK9Tmr1Y7MaS7D18gPKKLEcCHR42Dzc34ztlAQ0uL/D
 vgNw==
X-Gm-Message-State: APjAAAXdmj98xGKbpocXaiViX8IvaN+NNubsHkzj7RionH5Z+GKJ81YN
 FxKtHmVOaRS/VXLaofIlaZ2UANKTMKydDqcMgvl7dA==
X-Google-Smtp-Source: APXvYqyTyiFIpEbJx0z3mH204LsKgbgSqG+uWxk/ZKF9DqVDlpT4NOBkbrbdHXo0qXbD79gKPbsh/qv1oDdoVOX3+ag=
X-Received: by 2002:aca:b646:: with SMTP id g67mr3426173oif.163.1568723557380; 
 Tue, 17 Sep 2019 05:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <9cf47438fa943b28ee987cea7b76a459@fau.de>
In-Reply-To: <9cf47438fa943b28ee987cea7b76a459@fau.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 13:32:26 +0100
Message-ID: <CAFEAcA-oP9QkYnQr1SQUvTks+9ySjDCn0G5yuULdOBepQi-PSw@mail.gmail.com>
To: "Konopik, Andreas" <andreas.konopik@fau.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [Qemu-discuss] Segmentation fault on target tricore
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 at 13:24, Konopik, Andreas <andreas.konopik@fau.de> wrote:
>
> Hello,
>
> I am wondering why the "Hello world"-program available in TASKING
> (v6.2r1) generates a segfault.
>
> I compiled the program for the 'TC1796' Processor (Infineon TriCore 1
> Family -> AUDO NextGeneration Family).
> QEMU was built with gcc 9.1.0 and I added a memory region, that was
> necessary [1].
> Running QEMU with following options:
> `./qemu/build/tricore-softmmu/qemu-system-tricore -nographic -M
> tricore_testboard -cpu tc1796 -kernel hello.elf`
> led to a segfault in a short time

Hi -- I'm cc'ing the qemu-devel list and the TriCore maintainer;
not everybody reads the -discuss mailing list.

> Using gdb and valgrind I found out that:
> - 'gen_mtcr()' and 'gen_mfcr()' access uninitialized values, i.e. CSFRs,
> which leads to the Segfault
> - The uninitialised values were created by stack allocation of
> DisasContext in 'gen_intermediate_code()'

This definitely sounds like a bug: do you have a stack
backtrace from valgrind or gdb of the bad access and the
segfault?

> The segfault does not occur when configuring QEMU with '--enable-debug'
> flag, so i suspect it might be a compiler error while building QEMU.
> It did not come up before target/tricore implemented the
> DisasContextBase API (commit d013d220c710054a6d755941460f88c186fef7b5).
>
> Does anybody else have this problem?
>
>
> Regards,
>
> Andreas
>
>
>
> [1] Memory-layout addition (according to TASKING memory-layout):
>
> > diff --git a/hw/tricore/tricore_testboard.c
> > b/hw/tricore/tricore_testboard.c
> > index aef3289f8c..c287e0e7f5 100644
> > --- a/hw/tricore/tricore_testboard.c
> > +++ b/hw/tricore/tricore_testboard.c
> > @@ -59,6 +59,7 @@ static void tricore_testboard_init(MachineState
> > *machine, int board_id)
> >     CPUTriCoreState *env;
> >
> >     MemoryRegion *sysmem = get_system_memory();
> > +    MemoryRegion *pflash = g_new(MemoryRegion, 1);
> >     MemoryRegion *ext_cram = g_new(MemoryRegion, 1);
> >     MemoryRegion *ext_dram = g_new(MemoryRegion, 1);
> >     MemoryRegion *int_cram = g_new(MemoryRegion, 1);
> > @@ -68,6 +69,8 @@ static void tricore_testboard_init(MachineState
> > *machine, int board_id)
> >
> >     cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
> >     env = &cpu->env;
> > +    memory_region_init_ram(pflash, NULL, "pflash",
> > +                           2 * MiB, &error_fatal);
> >     memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
> >                            2 * MiB, &error_fatal);
> >     memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram",
> > @@ -81,6 +84,7 @@ static void tricore_testboard_init(MachineState
> > *machine, int board_id)
> >     memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram",
> >                            32 * KiB, &error_fatal);
> >
> > +    memory_region_add_subregion(sysmem, 0xa0000000, pflash);
> >     memory_region_add_subregion(sysmem, 0x80000000, ext_cram);
> >     memory_region_add_subregion(sysmem, 0xa1000000, ext_dram);
> >     memory_region_add_subregion(sysmem, 0xd4000000, int_cram);

I don't know enough about TriCore or the board QEMU is
emulating here to know whether this is the right thing;
Bastian?

thanks
-- PMM

