Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD24C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D812220717
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D812220717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA0l4-0007rY-3w
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 19:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jA0k5-0007Lk-Qc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jA0k4-0004yH-Hf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:21:29 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:16019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jA0jx-0004iN-Gc; Thu, 05 Mar 2020 19:21:25 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 01DF874637E;
 Fri,  6 Mar 2020 01:21:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CD01574637C; Fri,  6 Mar 2020 01:21:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB0E574569F;
 Fri,  6 Mar 2020 01:21:18 +0100 (CET)
Date: Fri, 6 Mar 2020 01:21:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <alpine.BSF.2.22.395.2003060007040.48868@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2003060115170.85813@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
 <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011731130.95594@zero.eik.bme.hu>
 <57ff6676-5054-d3f6-f4fc-6ff02b09019f@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011902490.28669@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2003011951370.28669@zero.eik.bme.hu>
 <38cb0f83-79fc-7021-38fc-c1e28c3c0fa0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003012202330.79908@zero.eik.bme.hu>
 <9ce6d135-4169-96ae-c457-1131b4510c49@ilande.co.uk>
 <alpine.BSF.2.22.395.2003022145430.47473@zero.eik.bme.hu>
 <2a39ccab-e4d4-8172-9a1d-0bc089e0104c@ilande.co.uk>
 <alpine.BSF.2.22.395.2003032356230.41934@zero.eik.bme.hu>
 <a579c016-fd6c-ad4f-c091-2286265c9a57@ilande.co.uk>
 <alpine.BSF.2.22.395.2003042227190.70853@zero.eik.bme.hu>
 <b3bce0d3-3ab3-7fb3-ed3c-60f1f19159d6@ilande.co.uk>
 <alpine.BSF.2.22.395.2003060007040.48868@zero.eik.bme.hu>
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020, BALATON Zoltan wrote:
> On Thu, 5 Mar 2020, Mark Cave-Ayland wrote:
>> On 04/03/2020 22:33, BALATON Zoltan wrote:
>> another possibility: PCI configuration space register 0x3d (Interrupt pin) 
>> is
>> documented as having value 0 == Legacy IRQ routing which should be the 
>> initial value
>> on reset, but QEMU incorrectly sets it to 1 which indicates PCI IRQ 
>> routing.
>
> The VT8231 docs say this should always read 1 but may be this is somehow set 
> to 0 on the Pegasos2. What does that mean? Should we use this value instead 
> of the feature bit to force using legacy interrupts? We'd still need a 
> property in via-ide to set this reg or is it possible to set it from board 
> code overriding the default after device is created? That would allow to drop 
> patch 1. I can try this.

This seemed like it could simplify patches a bit but it does not work. 
Setting this reg to 0 breaks Linux and MorphOS which then think the device 
does not have an interrupt at all and fail as before waiting for the irq. 
So we still need the feature bit, cant use this reg to force legacy 
interrupts. I've spent considerable time testing different OSes before 
I've ended up with this patch series I've submitted and I could not find a 
simpler way that works with everything.

Regards,
BALATON Zoltan

>> In your previous email you included a trace of the PCI configuration 
>> accesses to the
>> via-ide device. Can you try this again with the following diff and post the 
>> same
>> output once again?
>> 
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index 096de8dba0..db9f4af861 100644
>> --- a/hw/ide/via.c
>> +++ b/hw/ide/via.c
>> @@ -139,7 +139,7 @@ static void via_ide_reset(DeviceState *dev)
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>     pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 
>> 20-23h */
>> -    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>> +    pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000000e);
>>
>>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>     pci_set_long(pci_conf + 0x40, 0x0a090600);
>
> This does not change much:
>
> pci_cfg_write via-ide 12:1 @0x9 <- 0xf
> pci_cfg_write via-ide 12:1 @0x40 <- 0xb
> pci_cfg_write via-ide 12:1 @0x41 <- 0xf2
> pci_cfg_write via-ide 12:1 @0x43 <- 0x35
> pci_cfg_write via-ide 12:1 @0x44 <- 0x18
> pci_cfg_write via-ide 12:1 @0x45 <- 0x1c
> pci_cfg_write via-ide 12:1 @0x46 <- 0xc0
> pci_cfg_write via-ide 12:1 @0x50 <- 0x17171717
> pci_cfg_write via-ide 12:1 @0x54 <- 0x14
> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
> pci_cfg_read via-ide 12:1 @0x8 -> 0x1018f06
> pci_cfg_read via-ide 12:1 @0xc -> 0x0
> pci_cfg_read via-ide 12:1 @0x2c -> 0x11001af4
> pci_cfg_read via-ide 12:1 @0x3c -> 0xe
> pci_cfg_read via-ide 12:1 @0x4 -> 0x2800080
> pci_cfg_read via-ide 12:1 @0x3c -> 0xe
> pci_cfg_write via-ide 12:1 @0x3c <- 0x9
>
> compared to
>
>> pci_cfg_write via-ide 12:1 @0x9 <- 0xf
>> pci_cfg_write via-ide 12:1 @0x40 <- 0xb
>> pci_cfg_write via-ide 12:1 @0x41 <- 0xf2
>> pci_cfg_write via-ide 12:1 @0x43 <- 0x35
>> pci_cfg_write via-ide 12:1 @0x44 <- 0x18
>> pci_cfg_write via-ide 12:1 @0x45 <- 0x1c
>> pci_cfg_write via-ide 12:1 @0x46 <- 0xc0
>> pci_cfg_write via-ide 12:1 @0x50 <- 0x17171717
>> pci_cfg_write via-ide 12:1 @0x54 <- 0x14
>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>> pci_cfg_read via-ide 12:1 @0x8 -> 0x1018f06
>> pci_cfg_read via-ide 12:1 @0xc -> 0x0
>> pci_cfg_read via-ide 12:1 @0x2c -> 0x11001af4
>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>> pci_cfg_read via-ide 12:1 @0x4 -> 0x2800080
>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>> pci_cfg_write via-ide 12:1 @0x3c <- 0x109
>
> firmware does not seem to care about this value.
>
> Regards,
> BALATON Zoltan
>

