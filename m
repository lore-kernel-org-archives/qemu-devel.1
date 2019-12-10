Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26ACC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 02:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B8020726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 02:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B8020726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieUy0-0007Ow-ID
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 21:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ieUxP-0006x4-Gx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ieUxO-0003dW-83
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:08:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2220 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ieUxN-0003ba-Rh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:08:58 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5B65ABA68B9D237322A9;
 Tue, 10 Dec 2019 10:08:50 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Dec 2019
 10:08:42 +0800
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <20191209114042-mutt-send-email-mst@kernel.org>
 <20191209115829-mutt-send-email-mst@kernel.org>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <5628c5a0-538a-8c84-f06e-84acb2b75378@huawei.com>
Date: Tue, 10 Dec 2019 10:08:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209115829-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/10 0:58, Michael S. Tsirkin wrote:
> On Mon, Dec 09, 2019 at 11:43:20AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Dec 04, 2019 at 03:31:54PM +0800, pannengyuan@huawei.com wrote:
>>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>>
>>> Devices tend to maintain vq pointers, allow deleting them trough a vq pointer.
>>
>> You want to also mention something about clearing
>> .used_elems to avoid chances of double free.
>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>>
>>
>> So let's just name the new one virtio_del_queue then,
>> and drop the old one.
> 
> I tried but it seems like too much work.

Yes, some of them do not maintain the vq pointer, so can we just rename
the virtio_delete_queue to avoid confusion?

I have sent a new version before your reply, can you check whether it's
appropriate or not?

> 
>>
>>> ---
>>> Changes v2 to v1:
>>> - add a new function virtio_delete_queue to cleanup vq through a vq pointer
>>> ---
>>>  hw/virtio/virtio.c         | 16 +++++++++++-----
>>>  include/hw/virtio/virtio.h |  2 ++
>>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 04716b5..6de3cfd 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
>>>      return &vdev->vq[i];
>>>  }
>>>  
>>> +void virtio_delete_queue(VirtQueue *vq)
>>> +{
>>> +    vq->vring.num = 0;
>>> +    vq->vring.num_default = 0;
>>> +    vq->handle_output = NULL;
>>> +    vq->handle_aio_output = NULL;
>>> +    g_free(vq->used_elems);
>>> +    vq->used_elems = NULL;
>>> +}
>>> +
>>>  void virtio_del_queue(VirtIODevice *vdev, int n)
>>>  {
>>>      if (n < 0 || n >= VIRTIO_QUEUE_MAX) {
>>>          abort();
>>>      }
>>>  
>>> -    vdev->vq[n].vring.num = 0;
>>> -    vdev->vq[n].vring.num_default = 0;
>>> -    vdev->vq[n].handle_output = NULL;
>>> -    vdev->vq[n].handle_aio_output = NULL;
>>> -    g_free(vdev->vq[n].used_elems);
>>> +    virtio_delete_queue(&vdev->vq[n]);
>>>  }
>>>  
>>>  static void virtio_set_isr(VirtIODevice *vdev, int value)
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index c32a815..e18756d 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
>>>  
>>>  void virtio_del_queue(VirtIODevice *vdev, int n);
>>>  
>>> +void virtio_delete_queue(VirtQueue *vq);
>>> +
>>>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>>>                      unsigned int len);
>>>  void virtqueue_flush(VirtQueue *vq, unsigned int count);
>>> -- 
>>> 2.7.2.windows.1
>>>
> 
> 
> .
> 


