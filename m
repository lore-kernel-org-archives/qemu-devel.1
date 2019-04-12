Received: from eggs.gnu.org ([209.51.188.92]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hElX3-0003wl-ND
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hElX2-0000jH-6d
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:03:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2203 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1hElX0-0000cj-Ct
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:03:07 -0400
References: <f3a469aa-4a18-a8be-3a37-8989401e2db7@huawei.com>
	<20190403144550-mutt-send-email-mst@kernel.org>
	<4c3d0235-f5b6-a3d7-89b9-2054f24f84f7@redhat.com>
	<4f416cdc-4fd8-c815-b8d2-d4a1121d2981@huawei.com>
	<c2d44853-4fdb-f1e5-4fe3-2a5553427eec@huawei.com>
	<f8355d3b-dc9a-3d5a-9b8a-3e79ee15fc13@redhat.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <cf976fed-ce12-bc6e-c428-afdc6eba095d@huawei.com>
Date: Fri, 12 Apr 2019 10:02:52 +0800
MIME-Version: 1.0
In-Reply-To: <f8355d3b-dc9a-3d5a-9b8a-3e79ee15fc13@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question: can we hot plug a PCIe switch on machine
 "virt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: wanghaibin 00208455 <wanghaibin.wang@huawei.com>, qemu-devel@nongnu.org

Hi Eric and Michael,

Appreciate your sharing of this information. But sorry I'm still a little confused due to my poor English...


On 2019/4/11 20:19, Auger Eric wrote:
> Hi Heyi,
>
> On 4/11/19 1:30 PM, Heyi Guo wrote:
>> Hi Eric,
>>
>> Could you help to confirm?
> Practically I have not tried anything else than hot-plugging the
> downstream port downstream to the upstream port. This looks not
> supported as documented.
Do you mean you *have* tried hot-plugging the downstream port to the upstream port? Have you succeeded? Could you tell how to do that?

>
> Michael answered that up to him, the downstream port could only be
> plugged downto the upstream port.
Is only code-plugging supported here, or hot-plugging is supported as well?

Thanks,
Heyi

>
> On my side I have not aware of any usage of the downstream port outside
> of the switch's scope.
>
> Thanks
>
> Eric
>> Thanks,
>>
>> Heyi
>>
>>
>> On 2019/4/7 9:59, Heyi Guo wrote:
>>> Hi Eric,
>>>
>>> My real interesting is about the hotplug of PCIe switch, which means
>>> we don't need to provide lots of PCIe root ports or PCIe down stream
>>> ports at the beginning, but we can extend the capacity by hot adding
>>> PCIe switches which can provide more hot-pluggable slots for endpoint
>>> devices.
>>>
>>> The document docs/pcie.txt says "PCI Express Downstream Ports can't be
>>> hot-plugged into an existing PCI Express Upstream Port" which confuses
>>> me. Does it actually mean Downstream Ports can't be hot-plugged? For
>>> they can't be hot-plugged into an existing Upstream Port as the doc
>>> says, either they can't be hot-plugged into an non-existing Upstream
>>> Port or another place...
>>>
>>> Thanks,
>>>
>>> Heyi
>>>
>>>
>>> On 2019/4/4 15:39, Auger Eric wrote:
>>>> Hi Heyi,
>>>>
>>>> On 4/3/19 8:50 PM, Michael S. Tsirkin wrote:
>>>>> On Wed, Apr 03, 2019 at 03:32:09PM +0800, Heyi Guo wrote:
>>>>>> Hi folks,
>>>>>>
>>>>>> In physical world, a PCIe switch including one upstream port and
>>>>>> several downstream ports is a single physical device, however we
>>>>>> treat each port as a device in qemu world. In qemu docs/pcie.txt,
>>>>>> we have below statements:
>>>>>>
>>>>>> Line 230: Be aware that PCI Express Downstream Ports can't be
>>>>>> hot-plugged into
>>>>>> Line 231: an existing PCI Express Upstream Port.
>>>>>>
>>>>>> To my understanding, it implies PCIe downstream ports *can* be
>>>>>> hot-plugged into something which is not an existing upstream port.
>>>>>> If it is true, how can we do that? AFAIK monitor command device_add
>>>>>> can only add one device at a time.
>>>>>>
>>>>>> Please help to show the truth.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Heyi
>>>>>>
>>>>> afaik they can only be plugged into upstearm ports with or without
>>>>> hotplug.
>>>> Hotplug on upstream port does not look supported, as mentionned in
>>>> the doc:
>>>> (QEMU) device_add driver=xio3130-downstream id=down0 bus=upstream_port1
>>>> {"error": {"class": "GenericError", "desc": "Bus 'upstream_port1' does
>>>> not support hotplugging"}}
>>>>
>>>> Looks the std way to use the downstream port is the one documented in
>>>> 2.2.3:
>>>>
>>>> 2.2.3 Plugging a PCI Express device into a Switch:
>>>> -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]
>>>> -device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]
>>>> -device
>>>> xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]]
>>>>
>>>> -device <dev>,bus=downstream_port1
>>>>
>>>> For my curiosity why do you want to hotplug a downstream port in another
>>>> place than an upstream port?
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>
>>>>
>>>> .
>>>>
>>
> .
>
