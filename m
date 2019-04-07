Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B70C282DA
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 02:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DDD2133F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 02:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DDD2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCx6W-0001rN-Mj
	for qemu-devel@archiver.kernel.org; Sat, 06 Apr 2019 22:00:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hCx5j-0001Y0-Mt
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 21:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hCx5h-0007g5-Ud
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 21:59:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2200 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1hCx5h-0007ed-77
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 21:59:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id D39792B5FFFE89113D02;
	Sun,  7 Apr 2019 09:59:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS406-HUB.china.huawei.com
	(10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Sun, 7 Apr 2019
	09:59:07 +0800
To: Auger Eric <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <f3a469aa-4a18-a8be-3a37-8989401e2db7@huawei.com>
	<20190403144550-mutt-send-email-mst@kernel.org>
	<4c3d0235-f5b6-a3d7-89b9-2054f24f84f7@redhat.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <4f416cdc-4fd8-c815-b8d2-d4a1121d2981@huawei.com>
Date: Sun, 7 Apr 2019 09:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <4c3d0235-f5b6-a3d7-89b9-2054f24f84f7@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
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
Message-ID: <20190407015906.Ub4v8TISipujc3Wpchitf3kAgVH1Y4Xxb7dCC3Mgrhs@z>

Hi Eric,

My real interesting is about the hotplug of PCIe switch, which means we don't need to provide lots of PCIe root ports or PCIe down stream ports at the beginning, but we can extend the capacity by hot adding PCIe switches which can provide more hot-pluggable slots for endpoint devices.

The document docs/pcie.txt says "PCI Express Downstream Ports can't be hot-plugged into an existing PCI Express Upstream Port" which confuses me. Does it actually mean Downstream Ports can't be hot-plugged? For they can't be hot-plugged into an existing Upstream Port as the doc says, either they can't be hot-plugged into an non-existing Upstream Port or another place...

Thanks,

Heyi


On 2019/4/4 15:39, Auger Eric wrote:
> Hi Heyi,
>
> On 4/3/19 8:50 PM, Michael S. Tsirkin wrote:
>> On Wed, Apr 03, 2019 at 03:32:09PM +0800, Heyi Guo wrote:
>>> Hi folks,
>>>
>>> In physical world, a PCIe switch including one upstream port and several downstream ports is a single physical device, however we treat each port as a device in qemu world. In qemu docs/pcie.txt, we have below statements:
>>>
>>> Line 230: Be aware that PCI Express Downstream Ports can't be hot-plugged into
>>> Line 231: an existing PCI Express Upstream Port.
>>>
>>> To my understanding, it implies PCIe downstream ports *can* be hot-plugged into something which is not an existing upstream port. If it is true, how can we do that? AFAIK monitor command device_add can only add one device at a time.
>>>
>>> Please help to show the truth.
>>>
>>> Thanks,
>>>
>>> Heyi
>>>
>> afaik they can only be plugged into upstearm ports with or without hotplug.
> Hotplug on upstream port does not look supported, as mentionned in the doc:
> (QEMU) device_add driver=xio3130-downstream id=down0 bus=upstream_port1
> {"error": {"class": "GenericError", "desc": "Bus 'upstream_port1' does
> not support hotplugging"}}
>
> Looks the std way to use the downstream port is the one documented in 2.2.3:
>
> 2.2.3 Plugging a PCI Express device into a Switch:
> -device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]
> -device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]
> -device
> xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]]
> -device <dev>,bus=downstream_port1
>
> For my curiosity why do you want to hotplug a downstream port in another
> place than an upstream port?
>
> Thanks
>
> Eric
>
>
> .
>



