Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ECAC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496BB21881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496BB21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAB92-0004y4-7f
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iAAqX-0003Gk-Fb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iAAqV-0005nC-So
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iAAqV-0005mD-KL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:36:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0357C10C0920;
 Tue, 17 Sep 2019 10:36:30 +0000 (UTC)
Received: from [10.72.12.121] (ovpn-12-121.pek2.redhat.com [10.72.12.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 958616012C;
 Tue, 17 Sep 2019 10:36:25 +0000 (UTC)
To: "Tian, Kevin" <kevin.tian@intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
Date: Tue, 17 Sep 2019 18:36:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 17 Sep 2019 10:36:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: 'Alex Williamson' <alex.williamson@redhat.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/9/17 =E4=B8=8B=E5=8D=884:48, Tian, Kevin wrote:
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Monday, September 16, 2019 4:33 PM
>>
>>
>> On 2019/9/16 =E4=B8=8A=E5=8D=889:51, Tian, Kevin wrote:
>>> Hi, Jason
>>>
>>> We had a discussion about dirty page tracking in VFIO, when vIOMMU
>>> is enabled:
>>>
>>> https://lists.nongnu.org/archive/html/qemu-devel/2019-
>> 09/msg02690.html
>>> It's actually a similar model as vhost - Qemu cannot interpose the fa=
st-
>> path
>>> DMAs thus relies on the kernel part to track and report dirty page
>> information.
>>> Currently Qemu tracks dirty pages in GFN level, thus demanding a
>> translation
>>> from IOVA to GPA. Then the open in our discussion is where this
>> translation
>>> should happen. Doing the translation in kernel implies a device iotlb
>> flavor,
>>> which is what vhost implements today. It requires potentially large
>> tracking
>>> structures in the host kernel, but leveraging the existing log_sync f=
low in
>> Qemu.
>>> On the other hand, Qemu may perform log_sync for every removal of
>> IOVA
>>> mapping and then do the translation itself, then avoiding the GPA
>> awareness
>>> in the kernel side. It needs some change to current Qemu log-sync flo=
w,
>> and
>>> may bring more overhead if IOVA is frequently unmapped.
>>>
>>> So we'd like to hear about your opinions, especially about how you ca=
me
>>> down to the current iotlb approach for vhost.
>>
>> We don't consider too much in the point when introducing vhost. And
>> before IOTLB, vhost has already know GPA through its mem table
>> (GPA->HVA). So it's nature and easier to track dirty pages at GPA leve=
l
>> then it won't any changes in the existing ABI.
> This is the same situation as VFIO.
>
>> For VFIO case, the only advantages of using GPA is that the log can th=
en
>> be shared among all the devices that belongs to the VM. Otherwise
>> syncing through IOVA is cleaner.
> I still worry about the potential performance impact with this approach=
.
> In current mdev live migration series, there are multiple system calls
> involved when retrieving the dirty bitmap information for a given memor=
y
> range.


I haven't took a deep look at that series. Technically dirty bitmap=20
could be shared between device and driver, then there's no system call=20
in synchronization.


> IOVA mappings might be changed frequently. Though one may
> argue that frequent IOVA change already has bad performance, it's still
> not good to introduce further non-negligible overhead in such situation=
.


Yes, it depends on the behavior of vIOMMU driver, e.g the frequency and=20
granularity of the flushing.


>
> On the other hand, I realized that adding IOVA awareness in VFIO is
> actually easy. Today VFIO already maintains a full list of IOVA and its
> associated HVA in vfio_dma structure, according to VFIO_MAP and
> VFIO_UNMAP. As long as we allow the latter two operations to accept
> another parameter (GPA), IOVA->GPA mapping can be naturally cached
> in existing vfio_dma objects.


Note that the HVA to GPA mapping is not an 1:1 mapping. One HVA range=20
could be mapped to several GPA ranges.


>   Those objects are always updated according
> to MAP and UNMAP ioctls to be up-to-date. Qemu then uniformly
> retrieves the VFIO dirty bitmap for the entire GPA range in every pre-c=
opy
> round, regardless of whether vIOMMU is enabled. There is no need of
> another IOTLB implementation, with the main ask on a v2 MAP/UNMAP
> interface.


Or provide GPA to HVA mapping as vhost did. But a question is, I believe=20
device can only do dirty page logging through IOVA. So how do you handle=20
the case when IOVA is removed in this case?

Thanks


>
> Alex, your thoughts?
>
> Thanks
> Kevin

