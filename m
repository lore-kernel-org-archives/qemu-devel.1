Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43089C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB12223AE
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB12223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWdn0-0001kX-FP
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 07:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWdkN-0000jd-Ca
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 06:59:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:45990
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWdkK-0003iv-9K
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 06:59:35 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWdkM-0001dW-DN; Sun, 25 Oct 2020 10:59:39 +0000
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, atar4qemu@gmail.com
References: <20201011081347.2146-1-mark.cave-ayland@ilande.co.uk>
 <eee17b95-c1ba-cb6b-f687-2ef6e87c80e0@ilande.co.uk>
 <d89d2dac-484b-7e1c-9bed-27b929614e71@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <990bcd28-0dbf-d888-db54-f0054ebaa606@ilande.co.uk>
Date: Sun, 25 Oct 2020 10:59:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d89d2dac-484b-7e1c-9bed-27b929614e71@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] sabre: increase number of PCI bus IRQs from 32 to 64
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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

On 24/10/2020 21:41, Philippe Mathieu-Daudé wrote:

> On 10/21/20 11:27 AM, Mark Cave-Ayland wrote:
>> On 11/10/2020 09:13, Mark Cave-Ayland wrote:
>>
>>> The rework of the sabre IRQs in commit 6864fa3897 "sun4u: update PCI topology to
>>> include simba PCI bridges" changed the IRQ routing so that both PCI and legacy
>>> OBIO IRQs are routed through the sabre PCI host bridge to the CPU.
>>>
>>> Unfortunately this commit failed to increase the number of PCI bus IRQs
>>> accordingly meaning that access to the legacy IRQs OBIO (irqnum >= 0x20) would
>>> overflow the PCI bus IRQ array causing strange failures running qemu-system-sparc64
>>> in NetBSD.
>>>
>>> Reported-by: Harold Gutch <logix@foobar.franken.de>
>>> Fixes: https://bugs.launchpad.net/qemu/+bug/1838658
>>> Fixes: 6864fa3897 ("sun4u: update PCI topology to include simba PCI bridges")
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/pci-host/sabre.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
>>> index 5ac6283623..ffdba1d865 100644
>>> --- a/hw/pci-host/sabre.c
>>> +++ b/hw/pci-host/sabre.c
>>> @@ -396,7 +396,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>>>                                        pci_sabre_set_irq, pci_sabre_map_irq, s,
>>>                                        &s->pci_mmio,
>>>                                        &s->pci_ioport,
>>> -                                     0, 32, TYPE_PCI_BUS);
>>> +                                     0, 0x40, TYPE_PCI_BUS);
>>>       pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
>>
>> Applied to my qemu-sparc branch.
> 
> FWIW I spent some time looking at this, and your patch is indeed
> the simplest fix in the current state of this model.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks! I'll add the tag to my pending PR.


ATB,

Mark.

