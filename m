Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD36FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F59B21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F59B21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXcS-0007pP-RW
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihXbk-00079S-7B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihXbi-0000Xu-UK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:35:12 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihXbi-0000M4-Jr; Wed, 18 Dec 2019 06:35:10 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MnJdE-1i0oL00i3w-00jKi9; Wed, 18 Dec 2019 12:34:50 +0100
Subject: Re: [PATCH] target/sparc: Remove old TODO file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20190930171044.25312-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2d4b45cb-686d-ba70-a6dd-acb7fecc1bcb@vivier.eu>
Date: Wed, 18 Dec 2019 12:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20190930171044.25312-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F0R5tE+18Ez+qH7y6pY8GB8Ii3p3t4RmJWxPiCUXQQ5AX/9DqyK
 d4oWu3EfzfvWPqIYIOdY30CUifFh8hTE0D+48VkpTfiE5fl76UAwg66HDiv6PSoh+W2fwcV
 xqeKIEoDVgSL1UYDJlsSZrmQ2PyPxxF4jzkG/Rs5aqsxIy+Wp/C4SyclQuzoPW1jRcPuiqb
 ahUdL9YoaYvMJd5I/SxlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Xj3l5nRLQw=:xDmydpkJDUBLhif5xJh0b9
 senNEj4SOXZijGgNZF3TTf9uhBvGL06xzUp8Rlz+DpR6E9sq1alJUxJOIIT2mZTzQdCqiS5kc
 uEVt4jg53zGeUT/1xgVVt2gCLmftr5yATjx0VQ/te001xHzQoBvDsdt//B8oqCs5lf2PCrJE2
 I7o3E6MJP02YIRoyJ9pUSqK4IWSBCOFH/E6EKHVZ752vfpq83Q9wRnoU3lvPf2BoibXQkr7gj
 DwUkZJhaU+Mg/m5ruz2z+4oWIvXdHop6gE83jGxe+R/5ltNogz+dKV5BBXU9DnqJUPv6t4xx1
 zS6Wf2YZN6noTRdLciebeY9nEhE+G76Nzm5FyINw4WAaAlgeOEz3UrvYFQvSBnhfM88wIy3NX
 lMvJCzSL5JXN/SDDOypCmjEgmR3whqoKIS4nBdf9N0Caslq9ufqPg8kMq/4VxNYXLDXjS3I1Y
 kflwQlhdrLIq4Syw/Ffyc9xDv8Y/CFuqWHF7iYFLLyYA699CoaPLfsZ+qPUhmr8dwfrvc1kcL
 4tjkTFpKDq6Ny5rhBZCVCuhv5+bYiWQ8hSFAtArq7QJUgcTLwNJo8MSs9yM4CVnvAOhV0E9w9
 A746Tgk9Y+ba1MWSYLyYgLSrGJrlSPNRxkcVgFiCn6rhHjfW3kkyEfNUmRZmNCUj60wFhRFo+
 SYBwi4IHHGV1sRpBsfG/Zf0gqEizfkJleAVPIFDDn5QtktiNx+xJ2aJ1oYOrBURXLb7GyTXu3
 FMOOtO5fFbEwn/qeQo2rll1aGkl1QVCCP5swtZsXlJIRYXayHVdDyiQ8ONvB01f3A3GT9NUtK
 dj6GUi5YZdCGU6mWaSrdk37gYz8pmd2AvoOml0vN4KZql7J6nP7DYEN6CME929Hvp01vvsVSM
 TmADdmlWiStWzBBB7aHnABfF4aehuTuRIhceywFbs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/09/2019 à 19:10, Thomas Huth a écrit :
> This file hasn't seen a real (non-trivial) update since 2008 anymore,
> so we can assume that it is pretty much out of date and nobody cares
> for it anymore. Let's simply remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/sparc/TODO | 88 -----------------------------------------------
>  1 file changed, 88 deletions(-)
>  delete mode 100644 target/sparc/TODO
> 
> diff --git a/target/sparc/TODO b/target/sparc/TODO
> deleted file mode 100644
> index b8c727e858..0000000000
> --- a/target/sparc/TODO
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -TODO-list:
> -
> -CPU common:
> -- Unimplemented features/bugs:
> - - Delay slot handling may fail sometimes (branch end of page, delay
> - slot next page)
> - - Atomical instructions
> - - CPU features should match real CPUs (also ASI selection)
> -- Optimizations/improvements:
> - - Condition code/branch handling like x86, also for FPU?
> - - Remove remaining explicit alignment checks
> - - Global register for regwptr, so that windowed registers can be
> - accessed directly
> - - Improve Sparc32plus addressing
> - - NPC/PC static optimisations (use JUMP_TB when possible)? (Is this
> - obsolete?)
> - - Synthetic instructions
> - - MMU model dependent on CPU model
> - - Select ASI helper at translation time (on V9 only if known)
> - - KQemu/KVM support for VM only
> - - Hardware breakpoint/watchpoint support
> - - Cache emulation mode
> - - Reverse-endian pages
> - - Faster FPU emulation
> - - Busy loop detection
> -
> -Sparc32 CPUs:
> -- Unimplemented features/bugs:
> - - Sun4/Sun4c MMUs
> - - Some V8 ASIs
> -
> -Sparc64 CPUs:
> -- Unimplemented features/bugs:
> - - Interrupt handling
> - - Secondary address space, other MMU functions
> - - Many V9/UA2005/UA2007 ASIs
> - - Rest of V9 instructions, missing VIS instructions
> - - IG/MG/AG vs. UA2007 globals
> - - Full hypervisor support
> - - SMP/CMT
> - - Sun4v CPUs
> -
> -Sun4:
> -- To be added
> -
> -Sun4c:
> -- A lot of unimplemented features
> -- Maybe split from Sun4m
> -
> -Sun4m:
> -- Unimplemented features/bugs:
> - - Hardware devices do not match real boards
> - - Floppy does not work
> - - CS4231: merge with cs4231a, add DMA
> - - Add cg6, bwtwo
> - - Arbitrary resolution support
> - - PCI for MicroSparc-IIe
> - - JavaStation machines
> - - SBus slot probing, FCode ROM support
> - - SMP probing support
> - - Interrupt routing does not match real HW
> - - SuSE 7.3 keyboard sometimes unresponsive
> - - Gentoo 2004.1 SMP does not work
> - - SS600MP ledma -> lebuffer
> - - Type 5 keyboard
> - - Less fixed hardware choices
> - - DBRI audio (Am7930)
> - - BPP parallel
> - - Diagnostic switch
> - - ESP PIO mode
> -
> -Sun4d:
> -- A lot of unimplemented features:
> - - SBI
> - - IO-unit
> -- Maybe split from Sun4m
> -
> -Sun4u:
> -- Unimplemented features/bugs:
> - - Interrupt controller
> - - PCI/IOMMU support (Simba, JIO, Tomatillo, Psycho, Schizo, Safari...)
> - - SMP
> - - Happy Meal Ethernet, flash, I2C, GPIO
> - - A lot of real machine types
> -
> -Sun4v:
> -- A lot of unimplemented features
> - - A lot of real machine types
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


