Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA379C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1EA21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1EA21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialLC-00013s-Cq
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1ialDR-0005OI-A6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1ialDO-0002BN-Gg
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:42:04 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:49133)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ialDM-00022H-96
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:42:00 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C9AB07456F8;
 Fri, 29 Nov 2019 19:41:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ABBB47456ED; Fri, 29 Nov 2019 19:41:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AA99D7456CD;
 Fri, 29 Nov 2019 19:41:57 +0100 (CET)
Date: Fri, 29 Nov 2019 19:41:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC 0/1] ATI R300 emulated grpahics card V2
In-Reply-To: <20191128113023.gdw63adoooqlider@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.99999.352.1911291908110.15049@zero.eik.bme.hu>
References: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
 <20191128113023.gdw63adoooqlider@sirius.home.kraxel.org>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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

On Thu, 28 Nov 2019, Gerd Hoffmann wrote:
> The infrastructure to branch into model-specific code is pretty rough
> right now, we might refine that, for example with some helper functions
> (ati_get_model() returning an enum, or ati_is_$model() functions
> returning bool, or both).

Maybe we could define ATI_IS_$MODEL macros to save some typing but I 
thought it's not much better than the current if() and also model specific 
functions could be grouped into separate ati_$model files so we don't need 
too many branches in the main file.

> Trouble-shooting linux guests shouldn't be too hard, you have the source
> code so you can check what the driver tries to do and you can add debug
> printk's to trace where exactly things are failing ;)

I think the main difficulties are to find out how the card works then once 
one gets that the next question is how to implement that in QEMU: e.g. how 
can we make the micro engine emulation run in a separate thread. I think 
it probably can be done with existing qemu thread and locking functions. 
The synchronisation between CPU and GPU should be solved by the protocol 
between them (after all in real hardware they also run parallel so this 
should have been solved). If so, the micro engine thread may only have to 
read memory packets then generate register accesses. For this to work the 
register access FIFO may also need to be added which is now missing as in 
current version register writes are executed immediately but once we have 
both the CPU and micro engine that can access registers we either need to 
implement the FIFO or have some synchronisation between the two. This 
needs some thought. (If we have the register write FIFO then the actual 
drawing can also be done in a separate thread which is more like what the 
real GPU does but to make it simple I did not try that in first version.)

If the microcode of the microengine/CCE could be reversed or is documented 
somewhere it may be easier to implement emulation of that instead of doing 
the packet parsing for all possible command packets of which there are 
quite a lot, but in the real GPU all those are handled by the small 
microcode. The ME/CCE is probably some VLIW processor with 40 bit 
instructions which likely have ops to read and write memory and access 
registers and maybe some branching and synchronisation but I have no idea 
how to find out which opcode means what. This microengine is probably very 
similar throughout the early Radeons, only the microcode changes so if we 
could implement that it might work for several cards (also even for 
Rage128Pro).

Regards,
BALATON Zoltan

