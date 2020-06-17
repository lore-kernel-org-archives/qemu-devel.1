Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF62C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED46B208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED46B208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZwK-0005iY-9q
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlZvM-0004Bn-D6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:24:24 -0400
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:37157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlZvG-0000ZE-Tx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:24:21 -0400
Received: from player787.ha.ovh.net (unknown [10.110.103.112])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id A3AD41CB1A4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 17:24:15 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id CECBF13A759DF;
 Wed, 17 Jun 2020 15:24:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005e2e89b5a-4ed4-4133-982c-db340b003c72,ABECD89738EEB0C75E5395B338997A57DB3A3EEE)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 5/6] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-6-hskinnemoen@google.com>
 <18fa4025-0a2a-4427-b74f-2b1b678e0661@kaod.org>
 <CAFQmdRY9f6tV7VoDOFpRJ0x0hr_0EAaGqZwmXnkJpbvmbF4FVQ@mail.gmail.com>
 <5f0864e4-5e63-4819-1f30-68a5f207e275@kaod.org>
 <CAFEAcA86vzp7hTYzk54+Qu+WQDzB-gLbUsqbB409f9F3ONdekQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <763b7791-c2d8-b9a8-3e2f-1ad6d3ac8c09@kaod.org>
Date: Wed, 17 Jun 2020 17:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86vzp7hTYzk54+Qu+WQDzB-gLbUsqbB409f9F3ONdekQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3863807006465297321
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -77
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejvddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlvdefmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfevvdehieeftdevfeelleffgfehtdfgvdegteeijeetudejgedutdduudfhteeknecuffhomhgrihhnpehophgvnhhpohifvghrrdighiiinecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.158.110; envelope-from=clg@kaod.org;
 helo=7.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 11:24:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, PDS_OTHER_BAD_TLD=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 11:38 AM, Peter Maydell wrote:
> On Thu, 11 Jun 2020 at 07:12, Cédric Le Goater <clg@kaod.org> wrote:
>> Some don't some do. This is a bit confusing.
> 
> Probably the usual thing of people not noticing that they
> need to do something for big-endian hosts and nobody testing
> the minor platforms there.
> 
>> Peter, should we fix the boards not doing the tswap in the secondary
>> bootloader ?
> 
> Yes, we should -- it's an actual bug as well as just not being
> very consistent.
> 
>> I still have access to a PP64 BE host to test.
> 
> In an ideal world the bugs would cause "make check" and/or
> "make check-acceptance" to fail on BE hosts :-)

I gave it a try manually with an Aspeed machine and the kernel fails to boot.

Download an OpenBMC witherspoon flash image : 

  wget https://openpower.xyz/job/openbmc-build/lastSuccessfulBuild/distro=ubuntu,label=builder,target=witherspoon/artifact/deploy/images/witherspoon/obmc-phosphor-image-witherspoon.ubi.mtd

and run :

  qemu-system-arm -M witherspoon-bmc -nic user -drive file=obmc-phosphor-image-witherspoon.ubi.mtd,format=raw,if=mtd -nographic 

The kernel hangs right after activating the translation :

#ifdef CONFIG_MMU
 ARM_BE8(	orr	r0, r0, #1 << 25 )	@ big-endian page tables
		mrcne   p15, 0, r6, c2, c0, 2   @ read ttb control reg
		orrne	r0, r0, #1		@ MMU enabled
		movne	r1, #0xfffffffd		@ domain 0 = client
		bic     r6, r6, #1 << 31        @ 32-bit translation system
		bic     r6, r6, #(7 << 0) | (1 << 4)	@ use only ttbr0
		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
		mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
#endif
		mcr	p15, 0, r0, c7, c5, 4	@ ISB
 *there* -->	mcr	p15, 0, r0, c1, c0, 0	@ load control register
		mrc	p15, 0, r0, c1, c0, 0	@ and read it back
		mov	r0, #0
		mcr	p15, 0, r0, c7, c5, 4	@ ISB
		mov	pc, r12


C.

