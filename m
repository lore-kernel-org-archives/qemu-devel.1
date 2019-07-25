Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE51C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F892238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F892238C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqdah-0003de-QT
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wangxiongfeng2@huawei.com>) id 1hqYQA-0004yx-Bo
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 03:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wangxiongfeng2@huawei.com>) id 1hqYQ9-0001Mg-2l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 03:44:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2177 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wangxiongfeng2@huawei.com>)
 id 1hqYQ8-0001Ig-NP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 03:44:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 99377D247FDFEC012AAD;
 Thu, 25 Jul 2019 15:43:58 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Jul 2019
 15:43:51 +0800
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0259E1C966E8C54AA93AA2B1240828E672DF606C@dggeml509-mbx.china.huawei.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <78b73d10-3c7c-daf5-9342-cc10029417cc@huawei.com>
Date: Thu, 25 Jul 2019 15:43:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DF606C@dggeml509-mbx.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
X-Mailman-Approved-At: Thu, 25 Jul 2019 09:14:59 -0400
Subject: Re: [Qemu-devel] CC wangxiongfeng. : RE: [PATCH] pcie: fix device
 hotplug failure at the meantime of VM boot
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
Cc: fangying <fangying1@huawei.com>, "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/7/25 11:19, Zhangbo (Oscar) wrote:
>>> If the PCI_EXP_LNKSTA_DLLLA capability is set by default, linux kernel will send
>>> PDC event to detect whether there is a device in pcie slot. If a device is pluged
>>> in the pcie-root-port at the same time, hot-plug device will send ABP + PDC
>>> events to the kernel. The VM kernel will wrongly unplug the device if two PDC
>>> events get too close. Thus we'd better set the PCI_EXP_LNKSTA_DLLLA
>>> capability only in hotplug callback.
>>
>> Could you please describe a reproducer in a bit more detail?
>>
> Step1: start a VM with qemu, the VM boots up within 500ms.
>   /path/to/qemu-2.8.1/aarch64-softmmu/qemu-system-aarch64 \
>   -name test-c65961652639ccf9ce0b8476a325421811d4fdc873e90c27168497bc9e204776 \
>   -uuid a8ed4a86-3f49-45a3-a8ce-28d61b2f2914 \
>   -machine virt,usb=off,accel=kvm,gic-version=3 \
>   -cpu host \
>   -m 2048M,slots=10,maxmem=239477M \
>   -qmp unix:/var/run/qmp.sock,server,nowait \
>   -device pcie-root-port,port=0x8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 \
>   -device pcie-root-port,port=0x9,chassis=2,id=pci.2,bus=pcie.0,addr=0x1.0x1 \
>   -device pcie-root-port,port=0xa,chassis=3,id=pci.3,bus=pcie.0,addr=0x1.0x2 \
>   -device pcie-root-port,port=0xb,chassis=4,id=pci.4,bus=pcie.0,addr=0x1.0x3 \
>   -device pcie-root-port,port=0xc,chassis=5,id=pci.5,bus=pcie.0,addr=0x1.0x4 \
>   -device pcie-root-port,port=0xd,chassis=6,id=pci.6,bus=pcie.0,addr=0x1.0x5 \
>   -device pcie-root-port,port=0xe,chassis=7,id=pci.7,bus=pcie.0,addr=0x1.0x6 \
>   -device pcie-pci-bridge,id=pci.8,bus=pci.1,addr=0x0 \
>   -device pcie-root-port,port=0xf,chassis=9,id=pci.9,bus=pcie.0,addr=0x1.0x7 \
>   .......
>   
> Step2: Immediately hotplug a pcie device:
>   qmp_msg='{ "execute": "qmp_capabilities" }
> {"arguments":{"addr":"0x0","bus":"pci.4","driver":"virtio-net-pci","id":"virtio-e1356802-4b9f-44bb-b8f0-5f98bf765823","mac":"02:42:20:6e:a2:59"},"execute":"device_del"}
> {"arguments":{"id":"netport_test_1","ifname":"nfs_tap"},"execute":"netdev_del"}'
> 
>   echo $qmp_msg | nc -U /var/run/qmp.sock
> 
> Result expected:  hotplug successful, the pcie device could be seen inside the VM
> 
> Result in fact: we found a "hotplug" and "unplug" message inside the VM, it failed in hotplug.
> 

I think it's because the device is plugged into the system before the pciehp modules  is loaded.
When pciehp module is being loaded, it will firstly check whether the device is present in pciehp_probe()->pciehp_check_presence().
In our situation, the link is active, so the device is emumerated and added into the system.
But the slot may not be powered on yet.
After pciehp interrupt is initialized, an ABP event is received and the device is plugged out.

>>
>>>
>>> By the way, we should clean up the PCI_EXP_LNKSTA_DLLLA capability during
>>> unplug to avoid VM restart or migration failure which will enter the same
>>> abnormal scenario as above.
>>>
>>> Signed-off-by: limingwang@huawei.com
>>> Signed-off-by: fangying1@huawei.com
>>> Signed-off-by: oscar.zhangbo@huawei.com
>>
>> So looking at linux I see:
>>
>> * pciehp_card_present_or_link_active() - whether given slot is occupied
>> * @ctrl: PCIe hotplug controller
>> *
>> * Unlike pciehp_card_present(), which determines presence solely from the
>> * Presence Detect State bit, this helper also returns true if the Link Active
>> * bit is set.  This is a concession to broken hotplug ports which hardwire
>> * Presence Detect State to zero, such as Wilocity's [1ae9:0200].
>>
>> so it looks like linux actually looks at presence detect state,
>> but we have a bug just like Wilocity's and keeping
>> link active up fixes that. Can't we fix the bug instead?
>>
> @wangxiongfeng 
>>> ---
>>>  hw/pci/pcie.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>>> index a6beb56..174f392 100644
>>> --- a/hw/pci/pcie.c
>>> +++ b/hw/pci/pcie.c
>>> @@ -75,10 +75,6 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t
>> type, uint8_t version)
>>>
>> QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1) |
>>>
>> QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT));
>>>
>>> -    if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
>>> -        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
>>> -                                   PCI_EXP_LNKSTA_DLLLA);
>>> -    }
>>>
>>>      /* We changed link status bits over time, and changing them across
>>>       * migrations is generally fine as hardware changes them too.
>>
>> Does this actually change anything?
>>
>> I don't know why do we bother setting it here but we do
>> set it later in pcie_cap_slot_plug_cb, correct?
>>
>> I'd like to understand whether this is part of fix or
>> just a cleanup.
>>
>>
>>> @@ -484,6 +480,11 @@ void
>> pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>>>          return;
>>>      }
>>>
>>> +    if (pci_dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
>>> +        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
>>> +                                     PCI_EXP_LNKSTA_DLLLA);
>>> +    }
>>> +
>>>      pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
>>>  }
>>
>> So this reports data link inactive immediately after
>> unplug request. Seems a bit questionable: guest did not
>> respond yet. I'd like to see a comment explaining why
>> this makes sense.
>>
>>
>>> --
>>> 1.8.3.1


