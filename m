Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E31CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A302920679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A302920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNafF-0004gT-7X
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iNaSy-0004qN-AP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iNaSw-0002RI-Rk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:35:39 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:37167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iNaSu-0002Pq-Sp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:35:37 -0400
Received: from player697.ha.ovh.net (unknown [10.108.35.90])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id CD1F3147CBB
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 12:35:33 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id D4A14B5E2947;
 Thu, 24 Oct 2019 10:35:28 +0000 (UTC)
Subject: Re: PowerNV decrementer fails to fire
To: Anton Blanchard <anton@ozlabs.org>, qemu-ppc@nongnu.org
References: <20191024090431.68322431@kryten>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <172499f5-e119-9d47-1815-2b88f0d15a0e@kaod.org>
Date: Thu, 24 Oct 2019 12:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024090431.68322431@kryten>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9112189421143493606
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.60
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
Cc: Michael Neuling <mikey@neuling.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Anton,

On 24/10/2019 00:04, Anton Blanchard wrote:
> Hi,
> 
> Mikey and I noticed that the decrementer isn't firing when
> it should. If a decrementer is pending and an mtmsrd(MSR_EE) is
> executed then we should take the decrementer exception. From the PPC AS:
> 
>   If MSR EE = 0 and an External, Decrementer, or Per-
>   formance Monitor exception is pending, executing
>   an mtmsrd instruction that sets MSR EE to 1 will
>   cause the interrupt to occur before the next instruc-
>   tion is executed, if no higher priority exception
>   exists

I suppose we are missing a test on MSR_EE in the store helper routine 
of MSR to generate the exception ? See helper_store_msr() and 
hreg_store_msr().


C.






> 
> A test case is below. r31 is incremented for every decrementer
> exception.
> 
> powerpc64le-linux-gcc -c test.S
> powerpc64le-linux-ld -Ttext=0x0 -o test.elf test.o
> powerpc64le-linux-objcopy -O binary test.elf test.bin
> 
> r31 never moves. If I build with:
> 
> powerpc64le-linux-gcc -DFIX_BROKEN -c test.S
> 
> I see r31 move.
> 
> Thanks,
> Anton
> --
> 
> #include <ppc-asm.h>
> 
> /* Load an immediate 64-bit value into a register */
> #define LOAD_IMM64(r, e)			\
> 	lis	r,(e)@highest;			\
> 	ori	r,r,(e)@higher;			\
> 	rldicr	r,r, 32, 31;			\
> 	oris	r,r, (e)@h;			\
> 	ori	r,r, (e)@l;
> 
> #define FIXUP_ENDIAN						   \
> 	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
> 	b     191f;	  /* Skip trampoline if endian is good	*/ \
> 	.long 0xa600607d; /* mfmsr r11				*/ \
> 	.long 0x01006b69; /* xori r11,r11,1			*/ \
> 	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
> 	.long 0xa602487d; /* mflr r10				*/ \
> 	.long 0x14004a39; /* addi r10,r10,20			*/ \
> 	.long 0xa64b5a7d; /* mthsrr0 r10			*/ \
> 	.long 0xa64b7b7d; /* mthsrr1 r11			*/ \
> 	.long 0x2402004c; /* hrfid				*/ \
> 191:
> 
> 	.= 0x0
> .globl _start
> _start:
> 	b	1f
> 
> 	.= 0x10
> 	FIXUP_ENDIAN
> 	b	1f
> 
> 	.= 0x100
> 1:
> 	FIXUP_ENDIAN
> 	b	__initialize
> 
> #define EXCEPTION(nr)		\
> 	.= nr			;\
> 	b	.
> 
> 	/* More exception stubs */
> 	EXCEPTION(0x300)
> 	EXCEPTION(0x380)
> 	EXCEPTION(0x400)
> 	EXCEPTION(0x480)
> 	EXCEPTION(0x500)
> 	EXCEPTION(0x600)
> 	EXCEPTION(0x700)
> 	EXCEPTION(0x800)
> 
> 	.= 0x900
> 	LOAD_IMM64(r0, 0x1000000)
> 	mtdec	r0
> 	addi	r31,r31,1
> 	rfid
> 
> 	EXCEPTION(0x980)
> 	EXCEPTION(0xa00)
> 	EXCEPTION(0xb00)
> 	EXCEPTION(0xc00)
> 	EXCEPTION(0xd00)
> 	EXCEPTION(0xe00)
> 	EXCEPTION(0xe20)
> 	EXCEPTION(0xe40)
> 	EXCEPTION(0xe60)
> 	EXCEPTION(0xe80)
> 	EXCEPTION(0xf00)
> 	EXCEPTION(0xf20)
> 	EXCEPTION(0xf40)
> 	EXCEPTION(0xf60)
> 	EXCEPTION(0xf80)
> 	EXCEPTION(0x1000)
> 	EXCEPTION(0x1100)
> 	EXCEPTION(0x1200)
> 	EXCEPTION(0x1300)
> 	EXCEPTION(0x1400)
> 	EXCEPTION(0x1500)
> 	EXCEPTION(0x1600)
> 
> __initialize:
> 	/* SF, HV, EE, RI, LE */
> 	LOAD_IMM64(r0, 0x9000000000008003)
> 	mtmsrd	r0
> 
> 	LOAD_IMM64(r0, 0x1000000)
> 	mtdec r0
> 
> 1:	LOAD_IMM64(r30,0x8000)
> 	mtmsrd	r30,1
> 
> 	/* We should take the decrementer here */
> #ifdef FIX_BROKEN
> 	LOAD_IMM64(r29,0x100000000)
> 	mtctr	r29
> 2:	bdnz	2b
> #endif
> 
> 	li	r30,0x0
> 	mtmsrd	r30,1
> 	b	1b
> 


