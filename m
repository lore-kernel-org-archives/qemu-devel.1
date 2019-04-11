Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7018C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA66A2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA66A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48055 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYiU-0008Rt-Ty
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:22:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEYfi-0006Wq-Hk
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEYfg-0001z5-Lb
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEYff-0001y6-Nr
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:19:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE742285CC;
	Thu, 11 Apr 2019 12:19:08 +0000 (UTC)
Received: from [10.36.117.161] (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C3D45D9D5;
	Thu, 11 Apr 2019 12:19:05 +0000 (UTC)
To: Heyi Guo <guoheyi@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <f3a469aa-4a18-a8be-3a37-8989401e2db7@huawei.com>
	<20190403144550-mutt-send-email-mst@kernel.org>
	<4c3d0235-f5b6-a3d7-89b9-2054f24f84f7@redhat.com>
	<4f416cdc-4fd8-c815-b8d2-d4a1121d2981@huawei.com>
	<c2d44853-4fdb-f1e5-4fe3-2a5553427eec@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f8355d3b-dc9a-3d5a-9b8a-3e79ee15fc13@redhat.com>
Date: Thu, 11 Apr 2019 14:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c2d44853-4fdb-f1e5-4fe3-2a5553427eec@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 11 Apr 2019 12:19:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Question: can we hot plug a PCIe switch on machine
 "virt"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: wanghaibin 00208455 <wanghaibin.wang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411121904.we-ZxnrrpXZafd63Y6guipGB99-aSkPSbbojpaCd15c@z>

Hi Heyi,

On 4/11/19 1:30 PM, Heyi Guo wrote:
> Hi Eric,
> 
> Could you help to confirm?

Practically I have not tried anything else than hot-plugging the
downstream port downstream to the upstream port. This looks not
supported as documented.

Michael answered that up to him, the downstream port could only be
plugged downto the upstream port.

On my side I have not aware of any usage of the downstream port outside
of the switch's scope.

Thanks

Eric
> 
> Thanks,
> 
> Heyi
> 
> 
> On 2019/4/7 9:59, Heyi Guo wrote:
>> Hi Eric,
>>
>> My real interesting is about the hotplug of PCIe switch, which means
>> we don't need to provide lots of PCIe root ports or PCIe down stream
>> ports at the beginning, but we can extend the capacity by hot adding
>> PCIe switches which can provide more hot-pluggable slots for endpoint
>> devices.
>>
>> The document docs/pcie.txt says "PCI Express Downstream Ports can't be
>> hot-plugged into an existing PCI Express Upstream Port" which confuses
>> me. Does it actually mean Downstream Ports can't be hot-plugged? For
>> they can't be hot-plugged into an existing Upstream Port as the doc
>> says, either they can't be hot-plugged into an non-existing Upstream
>> Port or another place...
>>
>> Thanks,
>>
>> Heyi
>>
>>
>> On 2019/4/4 15:39, Auger Eric wrote:
>>> Hi Heyi,
>>>
>>> On 4/3/19 8:50 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Apr 03, 2019 at 03:32:09PM +0800, Heyi Guo wrote:
>>>>> Hi folks,
>>>>>
>>>>> In physical world, a PCIe switch including one upstream port and
>>>>> several downstream ports is a single physical device, however we
>>>>> treat each port as a device in qemu world. In qemu docs/pcie.txt,
>>>>> we have below statements:
>>>>>
>>>>> Line 230: Be aware that PCI Express Downstream Ports can't be
>>>>> hot-plugged into
>>>>> Line 231: an existing PCI Express Upstream Port.
>>>>>
>>>>> To my understanding, it implies PCIe downstream ports *can* be
>>>>> hot-plugged into something which is not an existing upstream port.
>>>>> If it is true, how can we do that? AFAIK monitor command device_add
>>>>> can only add one device at a time.
>>>>>
>>>>> Please help to show the truth.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Heyi
>>>>>
>>>> afaik they can only be plugged into upstearm ports with or without
>>>> hotplug.
>>> Hotplug on upstream port does not look supported, as mentionned in
>>> the doc:
>>> (QEMU) device_add driver=xio3130-downstream id=down0 bus=upstream_port1
>>> {"error": {"class": "GenericError", "desc": "Bus 'upstream_port1' does
>>> not support hotplugging"}}
>>>
>>> Looks the std way to use the downstream port is the one documented in
>>> 2.2.3:
>>>
>>> 2.2.3 Plugging a PCI Express device into a Switch:
>>> -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]
>>> -device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]
>>> -device
>>> xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]]
>>>
>>> -device <dev>,bus=downstream_port1
>>>
>>> For my curiosity why do you want to hotplug a downstream port in another
>>> place than an upstream port?
>>>
>>> Thanks
>>>
>>> Eric
>>>
>>>
>>> .
>>>
>>
> 
> 

