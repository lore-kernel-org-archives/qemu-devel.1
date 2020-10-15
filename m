Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8D62074A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8D62074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9ke-0007fh-Ho
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kT9gq-000593-L0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:17:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:55974
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kT9gn-0002IM-AY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:17:31 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kT9gj-0002E7-Ti; Thu, 15 Oct 2020 21:17:30 +0100
To: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 alxndr@bu.edu
References: <4f9846b5-4112-9598-fb9a-be26e28f2759@ilande.co.uk>
 <e1cccc73-efbf-1999-9d4a-d8b9e36be8bb@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1dbfe85a-10d9-55a4-6eb3-a328de62fbe3@ilande.co.uk>
Date: Thu, 15 Oct 2020 21:17:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e1cccc73-efbf-1999-9d4a-d8b9e36be8bb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: ide: Linux reports drive diagnostic failures on boot
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.019,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/2020 19:39, John Snow wrote:

> On 10/13/20 6:59 AM, Mark Cave-Ayland wrote:
>> During my latest OpenBIOS boot tests I've noticed the following IDE diagnostics 
>> failure message appearing in dmesg at Linux boot time when booting from CDROM on 
>> both SPARC64 and PPC:
>> 
> Sorry for the inconvenience.

Well it wasn't too bad - in my case the kernel was able to recover so it wasn't a 
complete showstopper for my tests. It seemed worth mentioning in case this causes 
other failures elsewhere though.

>> [    9.347342] scsi host0: pata_cmd64x
>> [    9.369055] scsi host1: pata_cmd64x
>> [    9.371622] ata1: PATA max UDMA/33 cmd 0x1fe02008000 ctl 0x1fe02008080 bmdma 
>> 0x1fe02008200 irq 8
>> [    9.372805] ata2: PATA max UDMA/33 cmd 0x1fe02008100 ctl 0x1fe02008180 bmdma 
>> 0x1fe02008208 irq 8
>> [    9.711740] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
>> [    9.712591] ata2.00: Drive reports diagnostics failure. This may indicate a drive
>> [    9.713256] ata2.00: fault or invalid emulation. Contact drive vendor for 
>> information.
>> [    9.737677] ata2.00: configured for UDMA/33
>> [    9.790179] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM 2.5+ PQ: 0 
>> ANSI: 5
>> [   10.381172] hme 0000:01:01.1 enp1s1f1: renamed from eth0
>> [   10.508819] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
>> [   10.509805] cdrom: Uniform CD-ROM driver Revision: 3.20
>>
>>
>> A session with git bisect points to the following commit:
>>
>> 55adb3c45620c31f29978f209e2a44a08d34e2da is the first bad commit
>> commit 55adb3c45620c31f29978f209e2a44a08d34e2da
>> Author: John Snow <jsnow@redhat.com>
>> Date:   Fri Jul 24 01:23:00 2020 -0400
>>
>>      ide: cancel pending callbacks on SRST
>>
>>      The SRST implementation did not keep up with the rest of IDE; it is
>>      possible to perform a weak reset on an IDE device to remove the BSY/DRQ
>>      bits, and then issue writes to the control/device registers which can
>>      cause chaos with the state machine.
>>
>>      Fix that by actually performing a real reset.
>>
>>      Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>      Fixes: https://bugs.launchpad.net/qemu/+bug/1878253
>>      Fixes: https://bugs.launchpad.net/qemu/+bug/1887303
>>      Fixes: https://bugs.launchpad.net/qemu/+bug/1887309
>>      Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> :040000 040000 70a7c1cfbafb22fa815d3ae4d7ed075ac3918188 
>> 3f37762f20e9ca9d2874eaf819d7175a1dca1dd9 M      hw
>>
>>
>> John/Alexander: any chance you could take a look at this? The message above is 
>> really simple to reproduce under qemu-system-sparc64 using 
>> http://cdimage.debian.org/cdimage/ports/9.0/sparc64/iso-cd/debian-9.0-sparc64-NETINST-1.iso 
>> and the following command line:
>>
>> ./qemu-system-sparc64 \
>>      -cdrom debian-9.0-sparc64-NETINST-1.iso \
>>      -m 256 \
>>      -nographic \
>>      -boot d
>>
>>
>> ATB,
>>
>> Mark.
>>
> 
> Shucks.
> 
> This patch happened because the old SRST code reset the IDE state machine (cleared 
> the status register) but then didn't cancel any of the pending callbacks, so it was 
> possible to shuffle the state machine off the rails onto junk data. Obviously bad.
> 
> Now, SRST actually cancels the callbacks which I thought would have been safe, but 
> it's possible that doing a "real" reset here is touching more registers than it ought 
> to.
> 
> Let's take a look at the linux source code ...
> 
> /* Let the user know. We don't want to disallow opens for
>     rescue purposes, or in case the vendor is just a blithering
>     idiot. Do this after the dev_config call as some controllers
>     with buggy firmware may want to avoid reporting false device
>     bugs */
> 
> Ah, always a nice day to be called an idiot. Thank you for your service, Alan Cox.
> 
> This message gets printed when ATA_HORKAGE_DIAGNOSTIC is set. libata-sff.c suggests 
> this happens when the error register* comes back 0x00 after an SRST.
> 
> (*I think that tf.feature is only feature on writes, but error on reads. Same address.)
> 
> Now, ide_reset -- which we use for initialization and resets both always sets the 
> error register to 0x00. libata thinks that 0x00 means a failed diagnostics test, though.
> 
> This ought to be covered by ATA8-APT. Section 9.2, Software reset protocol.
> 
> Cliff notes:
> 
> - Host writes to SRST and waits for 5 μs.
> - Both devices obey the SRST write, regardless of drive selection.
> - Each device clears their registers and sets BSY (within 400ns.)
> - Host clears SRST and waits for at least 2ms.
> - Host polls devices, waiting for BSY to be 0.
> 
> 
> device0 can set bit7 in the error register to 0 or 1, depending on the presence or 
> absence of device1 and how it behaves following a diagnostic test.
> 
> 
> Device 1 is absent: bit7 is cleared.
> Device 1 is present:
>    - If PDIAG- is asserted, bit7 is cleared.
>    - If PDIAG- is not asserted within 31 seconds, bit7 is set.
> 
> Then, ah:
> 
> The EXECUTE DEVICE DIAGNOSTICS diagnostic code shall be placed in bits (6:0) of the 
> Error register (See Clause 0). The device shall set the signature values (See Clause 
> 0). The content of the Features register is undefined.
> 
> I got this pretty wrong. I'm seeing a few problems:
> 
> 1. I thought SRST was triggered on the falling edge, but that's not entirely true. 
> BSY should be set immediately and the SRST can begin as soon as possible. The device 
> does not seem to have any interaction with the SRST bit being cleared from what I can 
> tell.
> 
> 2. We aren't running the diagnostic command, actually. That should fix this 
> particular case. The old version of the code had an open-coded version of this, but 
> it wasn't clear at the time this is what it was doing.
> 
> 3. There are likely other things to handle relating to the presence/absence of 
> device1 that we have never done for either version of the code.
> 
> 
> 
> Try this patch:
> 
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 693b352d5e..98cea7ad45 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2254,10 +2254,8 @@ static void ide_perform_srst(IDEState *s)
>       /* Cancel PIO callback, reset registers/signature, etc */
>       ide_reset(s);
> 
> -    if (s->drive_kind == IDE_CD) {
> -        /* ATAPI drives do not set READY or SEEK */
> -        s->status = 0x00;
> -    }
> +    /* perform diagnostic */
> +    cmd_exec_dev_diagnostic(s, WIN_DIAGNOSE);
>   }
> 
>   static void ide_bus_perform_srst(void *opaque)
> @@ -2282,9 +2280,7 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
> 
>       /* Device0 and Device1 each have their own control register,
>        * but QEMU models it as just one register in the controller. */
> -    if ((bus->cmd & IDE_CTRL_RESET) &&
> -        !(val & IDE_CTRL_RESET)) {
> -        /* SRST triggers on falling edge */
> +    if (!(bus->cmd & IDE_CTRL_RESET) && (val & IDE_CTRL_RESET)) {
>           for (i = 0; i < 2; i++) {
>               s = &bus->ifs[i];
>               s->status |= BUSY_STAT;

I've just given this a quick boot test on qemu-system-sparc64 (both HD and CD) and it 
seems to fix the problem here - thanks!


ATB,

Mark.

