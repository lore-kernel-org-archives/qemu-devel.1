Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16630C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2DE21726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2DE21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3c3v-0007OF-Tu
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 04:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i3c1X-0006Ce-Dz
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i3c1V-00055w-WD
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:12:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i3c1L-0004LU-PE; Fri, 30 Aug 2019 04:12:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A5C28CF1A3;
 Fri, 30 Aug 2019 08:12:30 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C76905D9E5;
 Fri, 30 Aug 2019 08:12:19 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-4-eric.auger@redhat.com> <20190815135400.GC8463@xz-x1>
 <f6a3b750-8439-7934-565b-37e1001f84d4@redhat.com>
 <20190830012614.GK8729@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <016b4d8e-7d65-d9e6-880f-8533e4f7f4af@redhat.com>
Date: Fri, 30 Aug 2019 10:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190830012614.GK8729@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 30 Aug 2019 08:12:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 03/15] virtio-iommu: Add
 skeleton
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 8/30/19 3:26 AM, Peter Xu wrote:
> On Thu, Aug 29, 2019 at 02:18:42PM +0200, Auger Eric wrote:
>> Hi Peter,
>>
>> First of all, please forgive me for the delay.
>> On 8/15/19 3:54 PM, Peter Xu wrote:
>>> On Tue, Jul 30, 2019 at 07:21:25PM +0200, Eric Auger wrote:
>>>> +static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>>> +{
>>>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
>>>> +    struct virtio_iommu_req_head head;
>>>> +    struct virtio_iommu_req_tail tail;
>>>
>>> [1]
>>>
>>>> +    VirtQueueElement *elem;
>>>> +    unsigned int iov_cnt;
>>>> +    struct iovec *iov;
>>>> +    size_t sz;
>>>> +
>>>> +    for (;;) {
>>>> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>>>> +        if (!elem) {
>>>> +            return;
>>>> +        }
>>>> +
>>>> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
>>>> +            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
>>>> +            virtio_error(vdev, "virtio-iommu bad head/tail size");
>>>> +            virtqueue_detach_element(vq, elem, 0);
>>>> +            g_free(elem);
>>>> +            break;
>>>> +        }
>>>> +
>>>> +        iov_cnt = elem->out_num;
>>>> +        iov = g_memdup(elem->out_sg, sizeof(struct iovec) * elem->out_num);
>>>
>>> Could I ask why memdup is needed here?
>> Indeed I don't think it is needed and besides iov is not freed!
>>
>> I got inspired from hw/net/virtio-net.c. To be honest I don't get why
>> the g_memdup is needed there either. The out_sg gets duplicated and
>> commands work on the duplicated data and not in place.
> 
> Oh true, I found that it's because of calling of iov_discard_front().
> Please have a look at 771b6ed37e3.  Though it seems to me that
> virtio-iommu does not truncate iovs so it should not be needed.

thanks for the sha1. indeed virtio-iommu does not use iov_discard_front
so I shouldn't need it.
> 
>>>
>>>> +        sz = iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
>>>> +        if (unlikely(sz != sizeof(head))) {
>>>> +            tail.status = VIRTIO_IOMMU_S_DEVERR;
>>>
>>> Do you need to zero the reserved bits to make sure it won't contain
>>> garbage?  Same question to below uses of tail.
>> yes. I initialized tail.
>>>
>>>> +            goto out;
>>>> +        }
>>>> +        qemu_mutex_lock(&s->mutex);
>>>> +        switch (head.type) {
>>>> +        case VIRTIO_IOMMU_T_ATTACH:
>>>> +            tail.status = virtio_iommu_handle_attach(s, iov, iov_cnt);
>>>> +            break;
>>>> +        case VIRTIO_IOMMU_T_DETACH:
>>>> +            tail.status = virtio_iommu_handle_detach(s, iov, iov_cnt);
>>>> +            break;
>>>> +        case VIRTIO_IOMMU_T_MAP:
>>>> +            tail.status = virtio_iommu_handle_map(s, iov, iov_cnt);
>>>> +            break;
>>>> +        case VIRTIO_IOMMU_T_UNMAP:
>>>> +            tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
>>>> +            break;
>>>> +        default:
>>>> +            tail.status = VIRTIO_IOMMU_S_UNSUPP;
>>>> +        }
>>>> +        qemu_mutex_unlock(&s->mutex);
>>>> +
>>>> +out:
>>>> +        sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>>>> +                          &tail, sizeof(tail));
>>>> +        assert(sz == sizeof(tail));
>>>> +
>>>> +        virtqueue_push(vq, elem, sizeof(tail));
>>>
>>> s/tail/head/ (though they are the same size)?
>> That's unclear to me. Similarly when checking against virtio-net.c, the
>> element is pushed back to the used ring and len is set to the size of
>> the status with:
>>
>> /*
>>  * Control virtqueue data structures
>>  *
>>  * The control virtqueue expects a header in the first sg entry
>>  * and an ack/status response in the last entry.  Data for the
>>  * command goes in between.
>>  */
> 
> I was referencing the balloon code when reading the patch, e.g.,
> virtio_balloon_handle_output().  Though after I read more carefully I
> see that other places are using it as you described.  Now I tend to
> agree with you, because virtqueue_push() who calls
> virtqueue_unmap_sg() used the len to unmap in_sg[] rather than
> out_sg[].  So please ignore my previous comment.

OK
> 
> (then I'm not sure whether the usage in the balloon code was correct
>  now...)
> 
>>>
>>>> +        virtio_notify(vdev, vq);
>>>> +        g_free(elem);
>>>> +    }
>>>> +}
>>>
>>> [...]
>>>
>>>> +static void virtio_iommu_set_features(VirtIODevice *vdev, uint64_t val)
>>>> +{
>>>> +    VirtIOIOMMU *dev = VIRTIO_IOMMU(vdev);
>>>> +
>>>> +    dev->acked_features = val;
>>>> +    trace_virtio_iommu_set_features(dev->acked_features);
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_virtio_iommu_device = {
>>>> +    .name = "virtio-iommu-device",
>>>> +    .unmigratable = 1,
>>>
>>> Curious, is there explicit reason to not support migration from the
>>> first version? :)
>> The state is made of red black trees, lists. For the former there is no
>> VMSTATE* ready. I am working on it but I think this should be handled
>> separately
> 
> Fair enough.  Would you mind to add a similar comment above
> unmigratable?
sure

Thanks!

Eric
> 
> Thanks,
> 

