Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E74C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F39B2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F39B2238C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqdan-0003ta-SE
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wangxiongfeng2@huawei.com>) id 1hqbYp-0000Ul-B1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wangxiongfeng2@huawei.com>) id 1hqbYn-0002ln-VU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:05:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2178 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wangxiongfeng2@huawei.com>)
 id 1hqbYn-0002jH-J3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:05:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8994C28F071BB7DB8308;
 Thu, 25 Jul 2019 19:05:14 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Jul 2019
 19:05:05 +0800
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <0259E1C966E8C54AA93AA2B1240828E672DF61CC@dggeml509-mbx.china.huawei.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <a2bd48e8-7313-974b-81d2-cb3854da83a2@huawei.com>
Date: Thu, 25 Jul 2019 19:05:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DF61CC@dggeml509-mbx.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
X-Mailman-Approved-At: Thu, 25 Jul 2019 09:14:59 -0400
Subject: Re: [Qemu-devel] CC wangxiongfeng. RE: [PATCH] pcie: fix device
 unplug timeout
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
Cc: fangying <fangying1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "limingwang \(A\)" <limingwang@huawei.com>, "dengkai
 \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/7/25 17:23, Zhangbo (Oscar) wrote:
>>> If the linux kernel only receives an ABP event during pcie unplug, it will sleep 5s
>>> to expect a PDC event, which will cause device unplug timeout.
>>
>> My understanding is that there's no timeout. Spec says:
>> 	If present, the Power Indicator provides visual feedback to the human
>> operator (if the system
>> 	software accepts the request initiated by the Attention Button) by blinking.
>> Once the Power
>> 	Indicator begins blinking, a 5-second abort interval exists during which a
>> second depression of the
>> 	Attention Button cancels the operation.
>>
>> this is exactly what linux implements.
>> Thus after an ABP event, linux starts a 5 second timer:
>> 	schedule_delayed_work(&ctrl->button_work, 5 * HZ);

Sorry for the confusion. It's not timeout.
It's just that we hope the hotplug process to be faster.

>>
>>
>>> In the meanwhile, if the kernel only receives a PDC event during the unplug, it
>>> will wait for at least 1 second before checking card present as data link layer
>>> state changed (link down) event reported prior to presence detect changed
>>> (card is not present).

It's because kernel will wait one second for link to become active if
Link Active Reporting Capable is not available.
Refer to 'pciehp_check_link_status()' in drivers/pci/hotplug/pciehp_hpc.c.

>>
>> I don't understand what you are saying exactly.
>> But I don't see any other delayed work in
>> drivers/pci/hotplug/pciehp_ctrl.c
>>
>>
>>> Therefore we can send both ABP and PDC events to the kernel in unplug
>> process
>>> to avoid unplug timeout.
>>>
>>> Signed-off-by: limingwang@huawei.com
>>> Signed-off-by: fangying1@huawei.com
>>> Signed-off-by: oscar.zhangbo@huawei.com
>>
>> I see this in linux:
>>
>> /**
>> * pciehp_check_presence() - synthesize event if presence has changed
>> *
>> * On probe and resume, an explicit presence check is necessary to bring up an
>> * occupied slot or bring down an unoccupied slot.  This can't be triggered by
>> * events in the Slot Status register, they may be stale and are therefore
>> * cleared.  Secondly, sending an interrupt for "events that occur while
>> * interrupt generation is disabled [when] interrupt generation is subsequently
>> * enabled" is optional per PCIe r4.0, sec 6.7.3.4.
>> */
>>
>>
>> My suggestion therefore is to try to clear Presence Detect State,
>> set presence detect changed and do not set attention button
>> pressed.

We have tried that but found out the PDC event can't be sent because PDCE is not set in SlotCtrl Register.
It's because kernel didn't set PDCE if there exists the attention button.
Refer to 'pcie_enable_notification()' in drivers/pci/hotplug/pciehp_hpc.c
It seems to avoid power interrupt storm on some machine.
Also I think we may clear Presence Detect State after the device is remove, otherwise
kernel will print 'Card not present'. But it has no bad effect, the device is still removed.
Kernel will power off the slot after remove the device. If qemu can catch this event, we can clear
Presence Detect State there.

Thanks,
Xiongfeng

>>
> @wangxiongfeng
> 
>>
>>> ---
>>>  hw/pci/pcie.c         | 8 ++------
>>>  include/hw/pci/pcie.h | 1 -
>>>  2 files changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>>> index 174f392..a800f23 100644
>>> --- a/hw/pci/pcie.c
>>> +++ b/hw/pci/pcie.c
>>> @@ -485,7 +485,8 @@ void
>> pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>>>                                       PCI_EXP_LNKSTA_DLLLA);
>>>      }
>>>
>>> -    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
>>> +    pcie_cap_slot_event(PCI_DEVICE(hotplug_dev),
>>> +                        PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
>>>  }
>>>
>>>  /* pci express slot for pci express root/downstream port
>>> @@ -701,11 +702,6 @@ int pcie_cap_slot_post_load(void *opaque, int
>> version_id)
>>>      return 0;
>>>  }
>>>
>>> -void pcie_cap_slot_push_attention_button(PCIDevice *dev)
>>> -{
>>> -    pcie_cap_slot_event(dev, PCI_EXP_HP_EV_ABP);
>>> -}
>>> -
>>>  /* root control/capabilities/status. PME isn't emulated for now */
>>>  void pcie_cap_root_init(PCIDevice *dev)
>>>  {
>>> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
>>> index 8cf3361..0975a54 100644
>>> --- a/include/hw/pci/pcie.h
>>> +++ b/include/hw/pci/pcie.h
>>> @@ -112,7 +112,6 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
>>>                                  uint16_t old_slt_ctl, uint16_t
>> old_slt_sta,
>>>                                  uint32_t addr, uint32_t val, int len);
>>>  int pcie_cap_slot_post_load(void *opaque, int version_id);
>>> -void pcie_cap_slot_push_attention_button(PCIDevice *dev);
>>>
>>>  void pcie_cap_root_init(PCIDevice *dev);
>>>  void pcie_cap_root_reset(PCIDevice *dev);
>>> --
>>> 1.8.3.1


