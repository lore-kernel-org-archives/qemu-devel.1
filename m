Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5265AC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC962051A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3K+9Jwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC962051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1UI4-0000eE-Aj
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 07:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1UHS-00009M-A2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1UHQ-00030x-Ov
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:04:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1UHQ-00030a-K4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581422679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjQwrMmKYTsdFrSHKfW1siyerTxdkA/ZJqrqrVqTmls=;
 b=L3K+9JwurkdYuIkDUa6cQrRijWsW9CWlsn71peAXp7lEba0NN7U9KSwrDv3QrKkWqWEpWh
 2+GPvsdeptwazWkBa5rW9lnglJmhI1L71H79nrIk4OmWkfr106ZM15Di8+W7sb2qaheBRk
 fajrFPBUnnb/jDcJHM92503SP3U6A2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-070av-dGNxCVVe93W4fnVw-1; Tue, 11 Feb 2020 07:04:36 -0500
X-MC-Unique: 070av-dGNxCVVe93W4fnVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A383107ACC9;
 Tue, 11 Feb 2020 12:04:34 +0000 (UTC)
Received: from [10.72.13.150] (ovpn-13-150.pek2.redhat.com [10.72.13.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56C6960BF4;
 Tue, 11 Feb 2020 12:04:25 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
Date: Tue, 11 Feb 2020 20:04:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200211065319-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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


On 2020/2/11 =E4=B8=8B=E5=8D=887:58, Michael S. Tsirkin wrote:
> On Tue, Feb 11, 2020 at 03:40:23PM +0800, Jason Wang wrote:
>> On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
>>> On 2/11/2020 12:02 PM, Jason Wang wrote:
>>>> On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>>>>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>>>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>>
>>>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take
>>>>>>> advantage of using
>>>>>>> virtio over mmio devices as a lightweight machine model for moder=
n
>>>>>>> cloud. The standard virtio over MMIO transport layer
>>>>>>> only supports one
>>>>>>> legacy interrupt, which is much heavier than virtio over
>>>>>>> PCI transport
>>>>>>> layer using MSI. Legacy interrupt has long work path and
>>>>>>> causes specific
>>>>>>> VMExits in following cases, which would considerably slow down th=
e
>>>>>>> performance:
>>>>>>>
>>>>>>> 1) read interrupt status register
>>>>>>> 2) update interrupt status register
>>>>>>> 3) write IOAPIC EOI register
>>>>>>>
>>>>>>> We proposed to add MSI support for virtio over MMIO via new featu=
re
>>>>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performanc=
e.
>>>>>>>
>>>>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio=
 MSI
>>>>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>>>>> Bit 1 is 0: device uses non-sharing and fixed vector per
>>>>>>> event mapping.
>>>>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>>>> I believe dynamic mapping should cover the case of fixed vector?
>>>>>>
>>>>> Actually this bit*aims*  for msi sharing or msi non-sharing.
>>>>>
>>>>> It means, when msi sharing bit is 1, device doesn't want vector
>>>>> per queue
>>>>>
>>>>> (it wants msi vector sharing as name) and doesn't want a high
>>>>> interrupt rate.
>>>>>
>>>>> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>>>>>
>>>>> So they are opposite not superset.
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Jing
>>>> I think you need add more comments on the command.
>>>>
>>>> E.g if I want to map vector 0 to queue 1, how do I need to do?
>>>>
>>>> write(1, queue_sel);
>>>> write(0, vector_sel);
>>> That's true. Besides, two commands are used for msi sharing mode,
>>>
>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>>>
>>> "To set up the event and vector mapping for MSI sharing mode, driver
>>> SHOULD write a valid MsiVecSel followed by
>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command =
to
>>> map the configuration change/selected queue events respectively.=C2=A0=
 " (See
>>> spec patch 5/5)
>>>
>>> So if driver detects the msi sharing mode, when it does setup vq, wri=
tes
>>> the queue_sel (this already exists in setup vq), vector sel and then
>>> MAP_QUEUE command to do the queue event mapping.
>>>
>> So actually the per vq msix could be done through this. I don't get wh=
y you
>> need to introduce MSI_SHARING_MASK which is the charge of driver inste=
ad of
>> device. The interrupt rate should have no direct relationship with whe=
ther
>> it has been shared or not.
>>
>> Btw, you introduce mask/unmask without pending, how to deal with the l=
ost
>> interrupt during the masking then?
> pending can be an internal device register. as long as device
> does not lose interrupts while masked, all's well.


You meant raise the interrupt during unmask automatically?


>
> There's value is being able to say "this queue sends no
> interrupts do not bother checking used notification area".
> so we need way to say that. So I guess an enable interrupts
> register might have some value...
> But besides that, it's enough to have mask/unmask/address/data
> per vq.


Just to check, do you mean "per vector" here?

Thanks


>
>


