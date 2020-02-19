Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A32C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5E02064C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5E02064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4UVh-0001xR-3Y
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 13:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j4UV6-0001Qf-0X
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j4UV3-0007PF-Or
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:55:11 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:12625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j4UV0-00078z-5J
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:55:09 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 524DD747871;
 Wed, 19 Feb 2020 19:54:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 042A774637E; Wed, 19 Feb 2020 19:54:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01CA6745953;
 Wed, 19 Feb 2020 19:54:56 +0100 (CET)
Date: Wed, 19 Feb 2020 19:54:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: RE: Emulating Solaris 10 on SPARC64 sun4u
In-Reply-To: <LO2P123MB2271B1493AD1B4DC8DDCB97783100@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
Message-ID: <alpine.BSF.2.22.395.2002191904370.88848@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <LO2P123MB2271B1493AD1B4DC8DDCB97783100@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: jsnow@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020, jasper.lowell@bt.com wrote:
> When configuring devices, Solaris 10 uses the SET_FEATURE command on the CMD646 to set the transfer mode to MDMA mode.
> From what I can tell, this is successful and the emulated IDE controller 
> raises an interrupt acknowledging that the command was completed 
> successfully. To determine whether or not this interrupt was 
> successfully propagated to Solaris 10, I made manual changes to ensure 
> that the interrupt was not raised for this event at this specific time. 
> This resulted in a new error from Solaris 10 regarding "set_features".
> - Solaris 10 appears to be able to see the interrupt from the completion of the SET_FEATURE command.
> - Solaris 10 appears to then perform two reads on the status register. From what I understand, this has the side effect of clearing interrupts.
> - Solaris 10 then writes to the device/head register.
> - Solaris 10 then spins on ARTTIM23_INTR_CH1 expecting it to be set. 
> When it is not set, the operation times out and we are presented with 
> the fatal error regarding set_features.
>
> I am not intimately familiar with the workings of the CMD646 or the ATA specification so I can only speculate.
> - If the interrupt that Solaris 10 expects is the one from the 
> SET_FEATURE command, then Solaris 10 is not expecting reading from the 
> status register to clear ARTTIM23_INTR_CH1.
> - If the interrupt that Solaris 10 expects is not the one from the 
> SET_FEATURE command, then it must expect an interrupt to occur from 
> writing to the device/head register.

I don't have definitive answers so these are some ideas but I may be 
completely wrong.

I don't know about Solaris but what I've seen on PPC and via-ide is that 
it works until switched to UDMA mode then it freezes on the first command 
issued after switching to UDMA so it seems like it expects an interrupt 
that's not generated or not routed correctly but only in DMA mode, in the 
initial PIO mode it works. Not sure if this is useful at all for your case 
though so you may just disregard it.

> I found it strange that Solaris 10 was spinning on ARTTIM23_INTR_CH1. Is 
> it possible that Solaris 10 is not expecting the values of 
> ARTTIM23_INTR_CH1 and MRDMODE_INTR_CH1 to be synced? I made changes to 
> disable the syncing and the fatal error from Solaris 10 disappeared. 
> Unfortunately, I can't tell whether or not this actually improved the 
> emulation of Solaris 10 as the serial console is still unresponsive.

I think the syncing was added in commit 271dddd1 and the commit log:

https://lists.gnu.org/archive/html/qemu-devel/2014-08/msg02644.html

cites the data sheet for that and there were other commits around it that 
were changing similar things as well. I guess this was fixing some problem 
at the time (Mark may remember more) so maybe these are correct but I 
don't know what actual hardware does. I also remember this IDE controller 
chip had different versions with early ones having implementation bugs 
that could cause problems so people generally avoided it or drivers may 
have hacks to fix those so it's possible that this tries to work around 
some hardware bug? I don't remember the details but maybe Linux kernel 
source has some history on this.

> If there is a bug in the Solaris 10 driver I would expect this error to 
> be more widely referenced online. I suspect that the emulated CMD646 is 
> not perfectly faithful to the hardware and this is causing problems for 
> Solaris 10.
> I am not convinced that this problem is related to IRQ routing as 
> Solaris 10 appears to recognise interrupts when they happen (or don't). 
> Because of this, I don't think this error is related to the DMA problem 
> under MorphOS but I could be wrong.

I'm not sure either because during testing I've seen two cases and in one 
IRQ was raised but did not reach CPU due to being masked in interrupt 
controller so that suggests it's not a problem with generating the IRQ in 
IDE code but problem is afterwards but still could not understand why it 
fails. (Seems to work on Linux though so maybe understanding what the 
working and non-working cases do differently could get closer to the 
answer.)

> Does anyone have any ideas that might explain why Solaris 10 insists 
> that ARTTIM23_INTR_CH1 is set despite two previous reads of the status 
> register?

I can only guess. The data sheet says that in PCI native mode these bits 
should be checked to determine if an interrupt on PCI INTA is coming from 
this controller (but for PIO mode, for DMA it just refers to Intel's spec 
without any more info). Specifically:

"When an IDE port is in PCI IDE Native Mode, the IDE task file registers 
may be mapped to non-standard port addresses, and IDE drive interrupts 
occur at PCI INTA. [As opposed to Legacy mode when it uses standard ISA 
IDE port numbers and IRQ14 and 15.] Therefore, if both IDE ports are in 
PCI IDE Native Mode, drive interrupts from both IDE ports are multiplexed 
into PCI INTA. In this case, the interrupt status bits must be polled to 
determine which IDE port generated the interrupt, or whether the interrupt 
was generated by another PCI device sharing INTA on the bus.

1) The host reads CFR (index 50h). If bit 2 is set, then the interrupt 
occurred on the primary IDE port.

2) The host reads ARTTIM23. If bit 4 is set, then the interrupt occurred 
on the secondary IDE port.

3) If 1) and 2) are both false, then the interrupt was generated by 
another PCI device sharing INTA with the PCI0646."

As for why it polls this reg, if it's not expecting interrupt on primary 
port and just reading both as described above, it may be expecting more 
interrupts than QEMU is generating or it may expect them to arrive with 
some delay or after previous one is cleared that QEMU could just raise 
once due to being faster or doing something differently? Does someone know 
what interrupts are generated on real hardware in DMA mode so we can 
compare that to what we see with QEMU?

Regards,
BALATON Zoltan

