Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAB8C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C612467D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C612467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irXar-0000Yk-IC
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 20:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1irXaC-0008MP-Em
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1irXa9-0007Qw-KE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:34:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59966 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1irXa9-0007OM-9W
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:34:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1668C6D4435996E50868;
 Wed, 15 Jan 2020 09:34:50 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 15 Jan
 2020 09:34:40 +0800
Subject: Re: [PATCH] vhost-vsock: delete vqs in vhost_vsock_unrealize to avoid
 memleaks
To: Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi
 <stefanha@gmail.com>
References: <20200114075229.40520-1-pannengyuan@huawei.com>
 <20200114164441.GG132666@stefanha-x1.localdomain>
 <CAGxU2F7CC2bjUg=6P0UDYehKqyCq+kHc=hoyvSV8rPSj8oFAZg@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <a92d4fbc-b97b-132e-7061-176a93367335@huawei.com>
Date: Wed, 15 Jan 2020 09:34:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGxU2F7CC2bjUg=6P0UDYehKqyCq+kHc=hoyvSV8rPSj8oFAZg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: qemu devel list <qemu-devel@nongnu.org>, Michael
 Tsirkin <mst@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/15/2020 12:59 AM, Stefano Garzarella wrote:
> On Tue, Jan 14, 2020 at 5:45 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Tue, Jan 14, 2020 at 03:52:29PM +0800, pannengyuan@huawei.com wrote:
>>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>>
>>> Receive/transmit/event vqs forgot to cleanup in vhost_vsock_unrealize. This
>>> patch save receive/transmit vq pointer in realize() and cleanup vqs
>>> through those vq pointers in unrealize(). The leak stack is as follow:
>>>
>>> Direct leak of 21504 byte(s) in 3 object(s) allocated from:
>>>   #0 0x7f86a1356970 (/lib64/libasan.so.5+0xef970)  ??:?
>>>   #1 0x7f86a09aa49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
>>>   #2 0x5604852f85ca (./x86_64-softmmu/qemu-system-x86_64+0x2c3e5ca)  /mnt/sdb/qemu/hw/virtio/virtio.c:2333
>>>   #3 0x560485356208 (./x86_64-softmmu/qemu-system-x86_64+0x2c9c208)  /mnt/sdb/qemu/hw/virtio/vhost-vsock.c:339
>>>   #4 0x560485305a17 (./x86_64-softmmu/qemu-system-x86_64+0x2c4ba17)  /mnt/sdb/qemu/hw/virtio/virtio.c:3531
>>>   #5 0x5604858e6b65 (./x86_64-softmmu/qemu-system-x86_64+0x322cb65)  /mnt/sdb/qemu/hw/core/qdev.c:865
>>>   #6 0x5604861e6c41 (./x86_64-softmmu/qemu-system-x86_64+0x3b2cc41)  /mnt/sdb/qemu/qom/object.c:2102
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>>> ---
>>>  hw/virtio/vhost-vsock.c         | 9 +++++++--
>>>  include/hw/virtio/vhost-vsock.h | 2 ++
>>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>>> index f5744363a8..896c0174c1 100644
>>> --- a/hw/virtio/vhost-vsock.c
>>> +++ b/hw/virtio/vhost-vsock.c
>>> @@ -335,8 +335,10 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>                  sizeof(struct virtio_vsock_config));
>>>
>>>      /* Receive and transmit queues belong to vhost */
>>> -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_output);
>>> -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_output);
>>> +    vsock->recv_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
>>> +                                      vhost_vsock_handle_output);
>>> +    vsock->trans_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
>>> +                                       vhost_vsock_handle_output);
>>>
>>>      /* The event queue belongs to QEMU */
>>>      vsock->event_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
>>> @@ -378,6 +380,9 @@ static void vhost_vsock_device_unrealize(DeviceState *dev, Error **errp)
>>>      /* This will stop vhost backend if appropriate. */
>>>      vhost_vsock_set_status(vdev, 0);
>>>
>>> +    virtio_delete_queue(vsock->recv_vq);
>>> +    virtio_delete_queue(vsock->trans_vq);
>>> +    virtio_delete_queue(vsock->event_vq);
>>>      vhost_dev_cleanup(&vsock->vhost_dev);
>>>      virtio_cleanup(vdev);
>>>  }
>>
>> Please delete the virtqueues after vhost cleanup (the reverse
>> initialization order).  There is currently no reason why it has to be
>> done in reverse initialization order, your patch should work too, but
>> it's a good default for avoiding user-after-free bugs.
>>
> 
> Agree!
> 
> Since we are here, should we delete the queues also in the error path
> of vhost_vsock_device_realize()?

Yes, I will change the cleanup order and aslo delete in the error path.

Thanks.

> 
> Thanks,
> Stefano
> 
> .
> 

