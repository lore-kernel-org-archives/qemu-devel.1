Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66C5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 22:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4AC2469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 22:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4AC2469F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7nlh-0005Z8-Rt
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 17:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j7nkx-0004y1-4u
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 17:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j7nkv-0003U2-5o
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 17:05:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:27412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j7nku-0003EZ-Qt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 17:05:13 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 30C1A747DCF;
 Fri, 28 Feb 2020 23:05:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 02D277475F6; Fri, 28 Feb 2020 23:05:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 00A0674637E;
 Fri, 28 Feb 2020 23:05:00 +0100 (CET)
Date: Fri, 28 Feb 2020 23:05:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: RE: Emulating Solaris 10 on SPARC64 sun4u
In-Reply-To: <alpine.BSF.2.22.395.2002192059340.88848@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2002282148540.17122@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <LO2P123MB2271B1493AD1B4DC8DDCB97783100@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
 <alpine.BSF.2.22.395.2002191904370.88848@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2002192059340.88848@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
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
Cc: mark.cave-ayland@ilande.co.uk, jsnow@redhat.com, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020, BALATON Zoltan wrote:
> On Wed, 19 Feb 2020, BALATON Zoltan wrote:
>> faster or doing something differently? Does someone know what interrupts 
>> are generated on real hardware in DMA mode so we can compare that to what 
>> we see with QEMU?
>
> The document Programming Interface for Bus Master IDE Controller, Revision 
> 1.0 (5/16/94) has some info on this. AFAIU it says that after DMA operation 
> is completed an IRQ should be raised. On page 5, section 3.1. Data 
> Synchronization it says:
>
> "Another way to view this requirement is that the first read to the 
> controller Status register in response to the IDE device interrupt must 
> return with the Interrupt bit set and with the guarantee that all buffered 
> data has been written to memory."
>
> Not sure if this is relevant but how is it handled in QEMU? Is the right 
> interrupt bit set after DMA transfer is done? If so is it the one that's 
> checked by the OS driver?

I think I now understand the problem with via-ide at least and the 
following is true for that case. I'm not sure about the CMD646 but it may 
be similar as these seem to be similar designs or maybe even related 
somehow. The problem in my case stems from that the device has two modes 
documented: legacy where it uses standard ISA ioports and INT14 and 15 for 
the two channels and native mode in which it uses PCI BARs for io address 
and an IRQ configurable via PCI_INTERRUPT_LINE (config reg 9). It seems 
the IRQ in native mode is still not a PCI INT line but an ISA IRQ, however 
it can be selected by config reg and it's a single interrupt instead of 
two for separate channels (Linux prints these during boot so that's a good 
way to check which mode it thinks it's using). That's so far is complex 
enough to not be easy to emulate in QEMU as we can set up legacy ISA ports 
with ide_init_ioport() but there's no way then to switch it off so via-ide 
either implemented legacy or native mode but can't correctly switch 
between those. This may not be a problem most of the time for Linux at 
least which tries to check which mode the controller is in and use that so 
it would work with whatever is there as long as the regs match what's 
emulated so we can just emulate one mode and still work.

But all of the above is further complicated by that on some (most?) boards 
there's also a "non 100% native mode" in which the io addresses are taken 
from the PCI BARs but still using hardcoded INT14 and 15, ignoring the 
setting in PCI_INTERRUPT_LINE. So guest drivers may assume this without 
checking regs and not care about what's set in PCI_INTERRUPT_LINE just 
expect interrupts on INT14 and 15. If the emulation raises PCI INT or some 
other isa interrupt it won't work, even if config regs correctly describe 
the difference following the docs but guest drivers don't care about the 
chip spec only the implementation on the board they meant to run on. 
Unfortunately different guests use different heuristics and workarounds 
(even Linux does so on different archs) so it's not easy to make an 
emulation that works with all. The pegasos2 firmware for example sets 
via-ide in native mode and assigns interrupt 9 but on real hardware this 
reg seems to be hardcoded to 14 and Linux uses this to detect if it needs 
to use the half-native mode but sets the mode reg to legacy to note this 
despite then using PCI BARs (so we can't hardcode mode reg to always 
native without breaking this but have to force int reg and emulate half 
native mode to work with other guests). Linux would also work with 100% 
native mode with IRQ9 but Amiga like OSes don't seem to care and just use 
hardcoded half-native mode regardless of config regs and expect interrupt 
on IRQ14 and 15. I could make a patch to work with all these on pegasos2 
but the via-ide is also used on a mips board where the corresponding Linux 
version also applies its own (different) workarounds corresponding to the 
quirks of that board and ends up either trying to use legacy mode (which 
is not emulated as io is only on PCI BARs) or trying to use 100% native 
mode which does not work with half-native interrupts. I think I'll need to 
add a special property to the device to set it to half-native for pegasos2 
and leave it 100% native for mips, otherwise there may not be a 
combination which works with all these firmwares and guests on both 
machines. (We still can avoid having to implement native mode as well but 
I can imagine if some PC guests were involved we may need that too but on 
these ppc and mips boards and also in your case I think native and 
half-native modes should be enough as that's all guests use.)

The CMD646 case might be similar and that's also used on a hppa board so 
you may need to check with that too if you make changes. To check this 
theory you might try forcing ide interrupts to be IRQ14 and 15 via 
something like:

qemu_set_irq(isa_get_irq(NULL, (channel ? 15 : 14)), level);

instead of using PCI interrupt or configured ISA interrupt in native mode 
and see if Solaris likes it better. If so then go on a quest to find a 
combination that works with at least Linux on both the sparc and hppa 
boards and Solaris (if that's not enough you can also try NeXTSTEP :-) ). 
So I think after all the common ide and bmdma code is probably OK and we 
have problems in individual controller emulations which is made difficult 
because of different hardware quirks and assumptions of guest sofware.

Regards,
BALATON Zoltan


