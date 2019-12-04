Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCFC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8FA2081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqWwN2hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8FA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXue-00037Y-TA
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <atar4qemu@gmail.com>) id 1icXln-0000XL-U3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1icXla-0000BJ-AZ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:44:47 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:37012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
 id 1icXla-0007ET-4M; Wed, 04 Dec 2019 11:44:42 -0500
Received: by mail-il1-x144.google.com with SMTP id t9so156828iln.4;
 Wed, 04 Dec 2019 08:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pDN1+c8AalYiVNXGBNDFbxymBo5liH2GkMsr9iK10LY=;
 b=NqWwN2hv8/IKsrff0SnoufIJy80NmHo86vQlc8rKzPiT7QLM8ks2rgNbIntQC4oox8
 rOSVBRQF+G2CyGZlIP7/F4cVbWC2ZfOA9gqzqqjzmzD2iL+85lJEFW75ib2UB8yufL7Q
 fz5zoeJGKDTRTrOtWUgmCxMiaD6+vyDth6UQzy6io3alLnLFnmzTBChgoYsr6r1f1ZCF
 ytIFDHWtlsVzmRazCohAPIfw93QCAGX9XVIl1wKnq4UJBVTzgY77etB6P2hFWogdb2xo
 G2Gk8p1EgFwGs7AEFmbQAOOtNvKk7KxijNSaQy7hBhiQ7NvcSF0AINajsDY3v18OO7lz
 g0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pDN1+c8AalYiVNXGBNDFbxymBo5liH2GkMsr9iK10LY=;
 b=E8ikmkT5uNwbgwyreEaa2GIMe+jjlFzjGTI3Nl8dYLau+SJn7wjgwxiBlEsK/YV54o
 E7t+xIid8ObwtjZLsUXYubIIYwa4Pp08HFyKbB1mnAgDGxPd0KAPX0tpJAmofmV5do12
 JqSZZ41AbBLuSNW6heejisM/MQapvp7HJ2A0H10sGCVzVaYWFbvBdYR6dBIHmNHtCqpv
 mAcxXmDMhFZZopjrF1hRCHpVpZsvLuAwp4H60I9qlBviGBIrcX/WpmqGlSArO1HjOuVO
 vtHtLJOHJRhcCV+mrq1f69kOmLDKB4qYW36Uwo1sFwv75tpUgrVcYFGv86Xlff7W1Cuh
 BkYA==
X-Gm-Message-State: APjAAAX3BxbdcmksA2DwLGux0gTtkW9gJ5kqFo/uvRhlRZ3CuC1ktdii
 hPFvd9Gyov+/zkEQwL3cizUT6yvO+GgXnfAZmC8=
X-Google-Smtp-Source: APXvYqyNZI48YOrAj70jdDJntFGvwb/aanq88XY9o7y7nYGOGY9HVCKAj3tBHzasoNoNAI3yCjTvBDkFGno6nVWb8d0=
X-Received: by 2002:a92:1655:: with SMTP id r82mr4402389ill.72.1575477868602; 
 Wed, 04 Dec 2019 08:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20190930171044.25312-1-thuth@redhat.com>
 <1b2ecf64-ee98-6a05-2455-436f822a7163@redhat.com>
In-Reply-To: <1b2ecf64-ee98-6a05-2455-436f822a7163@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 4 Dec 2019 17:44:17 +0100
Message-ID: <CACXAS8CVBUmVdR8a6bLS8x-DP8QKKyMhMpd1vrBUB30_dm7tXA@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Remove old TODO file
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 4, 2019 at 5:27 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 30/09/2019 19.10, Thomas Huth wrote:
> > This file hasn't seen a real (non-trivial) update since 2008 anymore,
> > so we can assume that it is pretty much out of date and nobody cares
> > for it anymore. Let's simply remove it.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  target/sparc/TODO | 88 -----------------------------------------------
> >  1 file changed, 88 deletions(-)
> >  delete mode 100644 target/sparc/TODO
> >
> > diff --git a/target/sparc/TODO b/target/sparc/TODO
> > deleted file mode 100644
> > index b8c727e858..0000000000
> > --- a/target/sparc/TODO
> > +++ /dev/null
> > @@ -1,88 +0,0 @@
> > -TODO-list:
> > -
> > -CPU common:
> > -- Unimplemented features/bugs:
> > - - Delay slot handling may fail sometimes (branch end of page, delay
> > - slot next page)
> > - - Atomical instructions
> > - - CPU features should match real CPUs (also ASI selection)
> > -- Optimizations/improvements:
> > - - Condition code/branch handling like x86, also for FPU?
> > - - Remove remaining explicit alignment checks
> > - - Global register for regwptr, so that windowed registers can be
> > - accessed directly
> > - - Improve Sparc32plus addressing
> > - - NPC/PC static optimisations (use JUMP_TB when possible)? (Is this
> > - obsolete?)
> > - - Synthetic instructions
> > - - MMU model dependent on CPU model
> > - - Select ASI helper at translation time (on V9 only if known)
> > - - KQemu/KVM support for VM only
> > - - Hardware breakpoint/watchpoint support
> > - - Cache emulation mode
> > - - Reverse-endian pages
> > - - Faster FPU emulation
> > - - Busy loop detection
> > -
> > -Sparc32 CPUs:
> > -- Unimplemented features/bugs:
> > - - Sun4/Sun4c MMUs
> > - - Some V8 ASIs
> > -
> > -Sparc64 CPUs:
> > -- Unimplemented features/bugs:
> > - - Interrupt handling
> > - - Secondary address space, other MMU functions
> > - - Many V9/UA2005/UA2007 ASIs
> > - - Rest of V9 instructions, missing VIS instructions
> > - - IG/MG/AG vs. UA2007 globals
> > - - Full hypervisor support
> > - - SMP/CMT
> > - - Sun4v CPUs
> > -
> > -Sun4:
> > -- To be added
> > -
> > -Sun4c:
> > -- A lot of unimplemented features
> > -- Maybe split from Sun4m
> > -
> > -Sun4m:
> > -- Unimplemented features/bugs:
> > - - Hardware devices do not match real boards
> > - - Floppy does not work
> > - - CS4231: merge with cs4231a, add DMA
> > - - Add cg6, bwtwo
> > - - Arbitrary resolution support
> > - - PCI for MicroSparc-IIe
> > - - JavaStation machines
> > - - SBus slot probing, FCode ROM support
> > - - SMP probing support
> > - - Interrupt routing does not match real HW
> > - - SuSE 7.3 keyboard sometimes unresponsive
> > - - Gentoo 2004.1 SMP does not work
> > - - SS600MP ledma -> lebuffer
> > - - Type 5 keyboard
> > - - Less fixed hardware choices
> > - - DBRI audio (Am7930)
> > - - BPP parallel
> > - - Diagnostic switch
> > - - ESP PIO mode
> > -
> > -Sun4d:
> > -- A lot of unimplemented features:
> > - - SBI
> > - - IO-unit
> > -- Maybe split from Sun4m
> > -
> > -Sun4u:
> > -- Unimplemented features/bugs:
> > - - Interrupt controller
> > - - PCI/IOMMU support (Simba, JIO, Tomatillo, Psycho, Schizo, Safari...)
> > - - SMP
> > - - Happy Meal Ethernet, flash, I2C, GPIO
> > - - A lot of real machine types
> > -
> > -Sun4v:
> > -- A lot of unimplemented features
> > - - A lot of real machine types
> >
>
> Ping?

Sorry for the delay, you are right the file doesn't reflect the
current state, so

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

