Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FBC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 02:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DECF2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 02:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DECF2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id3Co-0005N5-Hw
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 21:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1id3BN-0004Fy-K0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 21:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1id3BL-0002ik-W9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 21:17:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55732 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1id3BL-0002Yf-Gk
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 21:17:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0CF62AC8E08CE5E3A7BA;
 Fri,  6 Dec 2019 10:17:17 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 10:17:06 +0800
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
To: Amit Shah <amit@kernel.org>, <mst@redhat.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <1eaf11e84a6c1cbfbacebe2ae4361925142c1ab6.camel@kernel.org>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <32796046-ef9b-6157-3bd0-23eef4d4950b@huawei.com>
Date: Fri, 6 Dec 2019 10:17:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1eaf11e84a6c1cbfbacebe2ae4361925142c1ab6.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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


On 2019/12/6 0:45, Amit Shah wrote:
> On Wed, 2019-12-04 at 15:31 +0800, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Shouldn't this be From: mst?
>=20
> I didn't find a ref to the original patch to confirm if you had to
> adapt it in any way, though.
>=20

Here is the original
patch:=E3=80=80https://lists.nongnu.org/archive/html/qemu-devel/2019-12/m=
sg00402.html

I just change one line(set used_elems to NULL). In next version, I will
change function name from virtio_delete_queue to virtio_queue_cleanup
(It's too similar between "virtio_del_queue" and "virtio_delete_queue"):
https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg00877.html.

According to these, should I change it in next version?

Thanks.

>> Devices tend to maintain vq pointers, allow deleting them trough a vq
>> pointer.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Changes v2 to v1:
>> - add a new function virtio_delete_queue to cleanup vq through a vq
>> pointer
>> ---
>>  hw/virtio/virtio.c         | 16 +++++++++++-----
>>  include/hw/virtio/virtio.h |  2 ++
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 04716b5..6de3cfd 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice
>> *vdev, int queue_size,
>>      return &vdev->vq[i];
>>  }
>> =20
>> +void virtio_delete_queue(VirtQueue *vq)
>> +{
>> +    vq->vring.num =3D 0;
>> +    vq->vring.num_default =3D 0;
>> +    vq->handle_output =3D NULL;
>> +    vq->handle_aio_output =3D NULL;
>> +    g_free(vq->used_elems);
>> +    vq->used_elems =3D NULL;
>> +}
>> +
>>  void virtio_del_queue(VirtIODevice *vdev, int n)
>>  {
>>      if (n < 0 || n >=3D VIRTIO_QUEUE_MAX) {
>>          abort();
>>      }
>> =20
>> -    vdev->vq[n].vring.num =3D 0;
>> -    vdev->vq[n].vring.num_default =3D 0;
>> -    vdev->vq[n].handle_output =3D NULL;
>> -    vdev->vq[n].handle_aio_output =3D NULL;
>> -    g_free(vdev->vq[n].used_elems);
>> +    virtio_delete_queue(&vdev->vq[n]);
>>  }
>> =20
>>  static void virtio_set_isr(VirtIODevice *vdev, int value)
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index c32a815..e18756d 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev,
>> int queue_size,
>> =20
>>  void virtio_del_queue(VirtIODevice *vdev, int n);
>> =20
>> +void virtio_delete_queue(VirtQueue *vq);
>> +
>>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>>                      unsigned int len);
>>  void virtqueue_flush(VirtQueue *vq, unsigned int count);
>=20
>=20
> .
>=20


