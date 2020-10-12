Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F70C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DDB2074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DDB2074A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwPn-0002nd-SB
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kRwLw-0007AB-1e; Mon, 12 Oct 2020 07:50:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kRwLr-0000kn-6b; Mon, 12 Oct 2020 07:50:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 20BD1746333;
 Mon, 12 Oct 2020 13:50:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ECDA07461AE; Mon, 12 Oct 2020 13:50:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EBB4974594E;
 Mon, 12 Oct 2020 13:50:44 +0200 (CEST)
Date: Mon, 12 Oct 2020 13:50:44 +0200 (CEST)
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
In-Reply-To: <20201012065436.GB71119@yekko.fritz.box>
Message-ID: <9f7e4847-801d-dcd3-b876-bf2d276251@eik.bme.hu>
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
 <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
 <20201012065436.GB71119@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2123707662-1602503444=:51921"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2123707662-1602503444=:51921
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 12 Oct 2020, David Gibson wrote:
> On Mon, Oct 12, 2020 at 08:21:41AM +0200, Philippe Mathieu-Daudé wrote:
>> On 10/12/20 12:34 AM, David Gibson wrote:
>>> On Sun, Oct 11, 2020 at 09:03:32PM +0200, Philippe Mathieu-Daudé wrote:
>>>> The Grackle PCI host model expects the interrupt controller
>>>> being set, but does not verify it is present. Add a check to
>>>> help developers using this model.
>>>
>>> I don't think thaqt's very likely, but, sure, applied to ppc-for-5.2
>>
>> Do you want I correct the description as:
>> "The Grackle PCI host model expects the interrupt controller
>> being set, but does not verify it is present.
>> A developer basing its implementation on the Grackle model
>> might hit this problem. Add a check to help future developers
>> using this model as reference."?
>
> No, it's fine.  All I was saying is that the chances of anyone using
> Grackle in future seem very low to me.

So maybe an assert instead of a user visible error would be enough?

Regards,
BALATON Zoltan

>
>
>>
>>>
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>   hw/pci-host/grackle.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
>>>> index 57c29b20afb..20361d215ca 100644
>>>> --- a/hw/pci-host/grackle.c
>>>> +++ b/hw/pci-host/grackle.c
>>>> @@ -76,6 +76,10 @@ static void grackle_realize(DeviceState *dev, Error **errp)
>>>>       GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
>>>>       PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>>>> +    if (!s->pic) {
>>>> +        error_setg(errp, TYPE_GRACKLE_PCI_HOST_BRIDGE ": 'pic' link not set");
>>>> +        return;
>>>> +    }
>>>>       phb->bus = pci_register_root_bus(dev, NULL,
>>>>                                        pci_grackle_set_irq,
>>>>                                        pci_grackle_map_irq,
>>>
>>
>
>
--3866299591-2123707662-1602503444=:51921--

