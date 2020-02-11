Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB34C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3E1206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMvGlPwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3E1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1UWD-0006VE-R4
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 07:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1UVZ-000623-Ri
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1UVY-0007EJ-5T
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:19:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1UVX-0007C3-TH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581423551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANsA7vqtjun7svPIoAV0ILYiLkp9u0k8cszuL0qtwAk=;
 b=ZMvGlPwf+KPpB92RPSNx0Hjwf4V9pdqNegpcq3+qWrC41AQIZSOyMjOlP32UwII4FZCa75
 A7zpd25phR7igXHl/HmUrKi5bCxQpbhmSPp95n2fin7YA9MiYZHQnbtF46PzKr6bVsDaus
 0J9KeXIryMw2sWOJw7RuKf0XE1Ejt8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212--FL98XOyNniFvKlNRtNXHA-1; Tue, 11 Feb 2020 07:19:10 -0500
X-MC-Unique: -FL98XOyNniFvKlNRtNXHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A175618A8C81;
 Tue, 11 Feb 2020 12:19:08 +0000 (UTC)
Received: from [10.72.13.150] (ovpn-13-150.pek2.redhat.com [10.72.13.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B1FC857AE;
 Tue, 11 Feb 2020 12:18:55 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
 <20200211070523-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
Date: Tue, 11 Feb 2020 20:18:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200211070523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, "Liu, Jing2" <jing2.liu@linux.intel.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/11 =E4=B8=8B=E5=8D=888:08, Michael S. Tsirkin wrote:
> On Tue, Feb 11, 2020 at 08:04:24PM +0800, Jason Wang wrote:
>> On 2020/2/11 =E4=B8=8B=E5=8D=887:58, Michael S. Tsirkin wrote:
>>> On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
>>>> On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
>>>>> On 2/11/2020 12:02 PM, Jason Wang wrote:
>>>>>> On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>>>>>>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>>>>>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>>>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>>>>
>>>>>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take
>>>>>>>>> advantage of using
>>>>>>>>> virtio over mmio devices as a lightweight machine model for mod=
ern
>>>>>>>>> cloud. The standard virtio over MMIO transport layer
>>>>>>>>> only supports one
>>>>>>>>> legacy interrupt, which is much heavier than virtio over
>>>>>>>>> PCI transport
>>>>>>>>> layer using MSI. Legacy interrupt has long work path and
>>>>>>>>> causes specific
>>>>>>>>> VMExits in following cases, which would considerably slow down =
the
>>>>>>>>> performance:
>>>>>>>>>
>>>>>>>>> 1) read interrupt status register
>>>>>>>>> 2) update interrupt status register
>>>>>>>>> 3) write IOAPIC EOI register
>>>>>>>>>
>>>>>>>>> We proposed to add MSI support for virtio over MMIO via new fea=
ture
>>>>>>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performa=
nce.
>>>>>>>>>
>>>>>>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mm=
io MSI
>>>>>>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>>>>>>> Bit 1 is 0: device uses non-sharing and fixed vector per
>>>>>>>>> event mapping.
>>>>>>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>>>>>> I believe dynamic mapping should cover the case of fixed vector?
>>>>>>>>
>>>>>>> Actually this bit*aims*  for msi sharing or msi non-sharing.
>>>>>>>
>>>>>>> It means, when msi sharing bit is 1, device doesn't want vector
>>>>>>> per queue
>>>>>>>
>>>>>>> (it wants msi vector sharing as name) and doesn't want a high
>>>>>>> interrupt rate.
>>>>>>>
>>>>>>> So driver turns to !per_vq_vectors and has to do dynamical mappin=
g.
>>>>>>>
>>>>>>> So they are opposite not superset.
>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>> Jing
>>>>>> I think you need add more comments on the command.
>>>>>>
>>>>>> E.g if I want to map vector 0 to queue 1, how do I need to do?
>>>>>>
>>>>>> write(1, queue_sel);
>>>>>> write(0, vector_sel);
>>>>> That's true. Besides, two commands are used for msi sharing mode,
>>>>>
>>>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>>>>>
>>>>> "To set up the event and vector mapping for MSI sharing mode, drive=
r
>>>>> SHOULD write a valid MsiVecSel followed by
>>>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE comman=
d to
>>>>> map the configuration change/selected queue events respectively.=C2=
=A0 " (See
>>>>> spec patch 5/5)
>>>>>
>>>>> So if driver detects the msi sharing mode, when it does setup vq, w=
rites
>>>>> the queue_sel (this already exists in setup vq), vector sel and the=
n
>>>>> MAP_QUEUE command to do the queue event mapping.
>>>>>
>>>> So actually the per vq msix could be done through this. I don't get =
why you
>>>> need to introduce MSI_SHARING_MASK which is the charge of driver ins=
tead of
>>>> device. The interrupt rate should have no direct relationship with w=
hether
>>>> it has been shared or not.
>>>>
>>>> Btw, you introduce mask/unmask without pending, how to deal with the=
 lost
>>>> interrupt during the masking then?
>>> pending can be an internal device register. as long as device
>>> does not lose interrupts while masked, all's well.
>>
>> You meant raise the interrupt during unmask automatically?
>>
>
> yes - that's also what pci does.
>
> the guest visible pending bit is partially implemented in qemu
> as per pci spec but it's unused.


Ok.


>
>>> There's value is being able to say "this queue sends no
>>> interrupts do not bother checking used notification area".
>>> so we need way to say that. So I guess an enable interrupts
>>> register might have some value...
>>> But besides that, it's enough to have mask/unmask/address/data
>>> per vq.
>>
>> Just to check, do you mean "per vector" here?
>>
>> Thanks
>>
> No, per VQ. An indirection VQ -> vector -> address/data isn't
> necessary for PCI either, but that ship has sailed.


Yes, it can work but it may bring extra effort when you want to mask a=20
vector which is was shared by a lot of queues.

Thanks

>


