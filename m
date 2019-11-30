Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A8EC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 12:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534EC20801
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 12:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534EC20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib1c0-0003Lo-Fr
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 07:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1ib1bK-0002wQ-Ib
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 07:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1ib1bI-0006mD-Rv
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 07:11:49 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ib1bI-0006kR-M1
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 07:11:48 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 44259745702;
 Sat, 30 Nov 2019 13:11:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 276587456F8; Sat, 30 Nov 2019 13:11:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2615B7456CD;
 Sat, 30 Nov 2019 13:11:44 +0100 (CET)
Date: Sat, 30 Nov 2019 13:11:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC 0/1] ATI R300 emulated grpahics card V2
In-Reply-To: <alpine.BSF.2.21.99999.352.1911291908110.15049@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.99999.352.1911301300470.56280@zero.eik.bme.hu>
References: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
 <20191128113023.gdw63adoooqlider@sirius.home.kraxel.org>
 <alpine.BSF.2.21.99999.352.1911291908110.15049@zero.eik.bme.hu>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-devel@nongnu.org, aaron.zakhrov@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019, BALATON Zoltan wrote:
> If the microcode of the microengine/CCE could be reversed or is documented 
> somewhere it may be easier to implement emulation of that instead of doing 
> the packet parsing for all possible command packets of which there are quite 
> a lot, but in the real GPU all those are handled by the small microcode. The 
> ME/CCE is probably some VLIW processor with 40 bit instructions which likely 
> have ops to read and write memory and access registers and maybe some 
> branching and synchronisation but I have no idea how to find out which opcode 
> means what. This microengine is probably very similar throughout the early 
> Radeons, only the microcode changes so if we could implement that it might 
> work for several cards (also even for Rage128Pro).

This is the microcode that the driver uploads to the card that the ME 
should execute and presumably implements the PM4 way of programming the 
GPU via packets read from memory:

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/radeon/R100_cp.bin

This one is for R100 which is also used for RV100 I think; R300 has a 
different one but probably very similar:

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/radeon/R300_cp.bin

(and I've seen that even the MacOS driver for Rage128Pro uses a similar 
microcode but Linux does not implement DRM for that card so it's not in 
the kernel sources).

Does this make sense to anyone?

Later Radeons (after R600) have a different microengine with different 
microcode but some Adreno GPUs seem to be based on that. Those microcodes 
were reversed for the Linux Adreno driver and the freedreno project has 
some results but it does not match up with these older Radeons so I'm not 
sure if that's any use for understanding these microcodes.

That's all I could find out so far, any help to get further is  appreciated.

Regards,
BALATON Zoltan

