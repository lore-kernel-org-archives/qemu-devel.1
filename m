Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0126C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B522168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXMLkkmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B522168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j25La-0000t0-IR
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j25L3-0000UC-3k
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j25L1-0002ow-AY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:38:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j25L1-0002jw-6d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581565130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siHjLti79eNab49m9VmN2I96BJq+1gJqUI5rNubl/tg=;
 b=QXMLkkmTpluEPqLBmhgyHDw1HO+qR4UMvxEMKn17ZVwpfpofiBbR45nx9/AX3rwkFht03F
 oKRqVTT7AwDyCDp+4WTAULRgmaxz5DcahVAFlPu39nx3qhhQCa9DX4hf+jVTHX65MdxXIV
 NaSTNtLXjuEnF33mlg5NeqIlnc8T9wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-nexhK39lNd67jEn2kgmk0g-1; Wed, 12 Feb 2020 22:38:42 -0500
X-MC-Unique: nexhK39lNd67jEn2kgmk0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7754713E5;
 Thu, 13 Feb 2020 03:38:41 +0000 (UTC)
Received: from [10.72.13.212] (ovpn-13-212.pek2.redhat.com [10.72.13.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D51C5C101;
 Thu, 13 Feb 2020 03:38:32 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
 <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
 <20200212024158-mutt-send-email-mst@kernel.org>
 <d4eb9cde-5d06-3df9-df28-15378a9c6929@redhat.com>
 <82d99b35-0c64-2eb2-9c23-7af2597b880b@redhat.com>
 <20200212045245-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ff1a4d50-cfff-a354-3c64-30a6ed50a9fe@redhat.com>
Date: Thu, 13 Feb 2020 11:38:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200212045245-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 slp@redhat.com, jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/12 =E4=B8=8B=E5=8D=885:55, Michael S. Tsirkin wrote:
> On Wed, Feb 12, 2020 at 05:33:06PM +0800, Jason Wang wrote:
>> On 2020/2/12 =E4=B8=8B=E5=8D=884:53, Jason Wang wrote:
>>> On 2020/2/12 =E4=B8=8B=E5=8D=884:18, Michael S. Tsirkin wrote:
>>>> On Wed, Feb 12, 2020 at 11:39:54AM +0800, Jason Wang wrote:
>>>>> On 2020/2/11 =E4=B8=8B=E5=8D=887:33, Michael S. Tsirkin wrote:
>>>>>> On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
>>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>>
>>>>>>> The standard virtio-mmio devices use notification register to sig=
nal
>>>>>>> backend. This will cause vmexits and slow down the
>>>>>>> performance when we
>>>>>>> passthrough the virtio-mmio devices to guest virtual machines.
>>>>>>> We proposed to update virtio over MMIO spec to add the per-queue
>>>>>>> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VM=
M to
>>>>>>> configure notify location for each queue.
>>>>>>>
>>>>>>> [1]https://lkml.org/lkml/2020/1/21/31
>>>>>>>
>>>>>>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>> Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
>>>>>>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>>>>>>> Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
>>>>>>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
>>>>>>> Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
>>>>>>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
>>>>>> Hmm. Any way to make this static so we don't need
>>>>>> base and multiplier?
>>>>> E.g page per vq?
>>>>>
>>>>> Thanks
>>>> Problem is, is page size well defined enough?
>>>> Are there cases where guest and host page sizes differ?
>>>> I suspect there might be.
>>>
>>> Right, so it looks better to keep base and multiplier, e.g for vDPA.
>>>
>>>
>>>> But I also think this whole patch is unproven. Is someone actually
>>>> working on QEMU code to support pass-trough of virtio-pci
>>>> as virtio-mmio for nested guests? What's the performance
>>>> gain like?
>>>
>>> I don't know.
>>>
>>> Thanks
>>
>> Btw, I think there's no need for a nested environment to test. Current
>> eventfd hook to MSIX should still work for MMIO.
>>
>> Thanks
>
> Oh yes it's the wildcard thingy but how much extra performance does one=
 get
> from it with MMIO? A couple % might not be worth the trouble for MMIO.


The cover letter have some numbers but I'm not sure whether or not it=20
was measured by vhost or other which needs some clarification.

Thanks


>


