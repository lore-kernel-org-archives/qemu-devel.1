Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77894C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B67B20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B67B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Ve-0006Ko-Ei
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jE9Ec-0001n3-2v
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jE9EV-0007h5-2K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:14:00 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:58653)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jE9EU-000740-Ko
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:13:59 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04452; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0Tss.xHA_1584440013; 
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0Tss.xHA_1584440013) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 Mar 2020 18:13:38 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC for QEMU] virtio-balloon: Add option thp-order to set
 VIRTIO_BALLOON_F_THP_ORDER
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200312042340-mutt-send-email-mst@kernel.org>
Date: Tue, 17 Mar 2020 18:13:32 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9436807-D9CA-49FD-AEE3-3B7CE4BBB711@linux.alibaba.com>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <1583999395-9131-2-git-send-email-teawater@gmail.com>
 <20200312042340-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
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
Cc: pagupta@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 akpm@linux-foundation.org, jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> 2020=E5=B9=B43=E6=9C=8812=E6=97=A5 16:25=EF=BC=8CMichael S. Tsirkin =
<mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Mar 12, 2020 at 03:49:55PM +0800, Hui Zhu wrote:
>> If the guest kernel has many fragmentation pages, use virtio_balloon
>> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
>> the balloon pages.
>> Set option thp-order to on will open flags =
VIRTIO_BALLOON_F_THP_ORDER.
>> It will set balloon size to THP size to handle the THP split issue.
>>=20
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>=20
> What's wrong with just using the PartiallyBalloonedPage machinery
> instead? That would make it guest transparent.

In balloon_inflate_page:
    rb_page_size =3D qemu_ram_pagesize(rb);

    if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
        /* Easy case */

It seems that PartiallyBalloonedPage is only used when rb_page_size is =
greater than BALLOON_PAGE_SIZE.
Do you mean I should modify the working mechanism of =
balloon_inflate_page function?

Thanks,
Hui

>=20
>> ---
>> hw/virtio/virtio-balloon.c                      | 67 =
++++++++++++++++---------
>> include/standard-headers/linux/virtio_balloon.h |  4 ++
>> 2 files changed, 47 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index a4729f7..cfe86b0 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -340,37 +340,49 @@ static void =
virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, =
4) =3D=3D 4) {
>>             unsigned int p =3D virtio_ldl_p(vdev, &pfn);
>>             hwaddr pa;
>> +            size_t handle_size =3D BALLOON_PAGE_SIZE;
>>=20
>>             pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>>             offset +=3D 4;
>>=20
>> -            section =3D memory_region_find(get_system_memory(), pa,
>> -                                         BALLOON_PAGE_SIZE);
>> -            if (!section.mr) {
>> -                trace_virtio_balloon_bad_addr(pa);
>> -                continue;
>> -            }
>> -            if (!memory_region_is_ram(section.mr) ||
>> -                memory_region_is_rom(section.mr) ||
>> -                memory_region_is_romd(section.mr)) {
>> -                trace_virtio_balloon_bad_addr(pa);
>> -                memory_region_unref(section.mr);
>> -                continue;
>> -            }
>> +            if (virtio_has_feature(s->host_features,
>> +                                   VIRTIO_BALLOON_F_THP_ORDER))
>> +                handle_size =3D BALLOON_PAGE_SIZE << =
VIRTIO_BALLOON_THP_ORDER;
>> +
>> +            while (handle_size > 0) {
>> +                section =3D memory_region_find(get_system_memory(), =
pa,
>> +                                             BALLOON_PAGE_SIZE);
>> +                if (!section.mr) {
>> +                    trace_virtio_balloon_bad_addr(pa);
>> +                    continue;
>> +                }
>> +                if (!memory_region_is_ram(section.mr) ||
>> +                    memory_region_is_rom(section.mr) ||
>> +                    memory_region_is_romd(section.mr)) {
>> +                    trace_virtio_balloon_bad_addr(pa);
>> +                    memory_region_unref(section.mr);
>> +                    continue;
>> +                }
>>=20
>> -            =
trace_virtio_balloon_handle_output(memory_region_name(section.mr),
>> -                                               pa);
>> -            if (!qemu_balloon_is_inhibited()) {
>> -                if (vq =3D=3D s->ivq) {
>> -                    balloon_inflate_page(s, section.mr,
>> -                                         =
section.offset_within_region, &pbp);
>> -                } else if (vq =3D=3D s->dvq) {
>> -                    balloon_deflate_page(s, section.mr, =
section.offset_within_region);
>> -                } else {
>> -                    g_assert_not_reached();
>> +                =
trace_virtio_balloon_handle_output(memory_region_name(section.mr),
>> +                                                   pa);
>> +                if (!qemu_balloon_is_inhibited()) {
>> +                    if (vq =3D=3D s->ivq) {
>> +                        balloon_inflate_page(s, section.mr,
>> +                                             =
section.offset_within_region,
>> +                                             &pbp);
>> +                    } else if (vq =3D=3D s->dvq) {
>> +                        balloon_deflate_page(s, section.mr,
>> +                                             =
section.offset_within_region);
>> +                    } else {
>> +                        g_assert_not_reached();
>> +                    }
>>                 }
>> +                memory_region_unref(section.mr);
>> +
>> +                pa +=3D BALLOON_PAGE_SIZE;
>> +                handle_size -=3D BALLOON_PAGE_SIZE;
>>             }
>> -            memory_region_unref(section.mr);
>>         }
>>=20
>>         virtqueue_push(vq, elem, offset);
>> @@ -693,6 +705,8 @@ static void =
virtio_balloon_set_config(VirtIODevice *vdev,
>>=20
>>     memcpy(&config, config_data, virtio_balloon_config_size(dev));
>>     dev->actual =3D le32_to_cpu(config.actual);
>> +    if (virtio_has_feature(vdev->host_features, =
VIRTIO_BALLOON_F_THP_ORDER))
>> +        dev->actual <<=3D VIRTIO_BALLOON_THP_ORDER;
>>     if (dev->actual !=3D oldactual) {
>>         qapi_event_send_balloon_change(vm_ram_size -
>>                         ((ram_addr_t) dev->actual << =
VIRTIO_BALLOON_PFN_SHIFT));
>> @@ -728,6 +742,9 @@ static void virtio_balloon_to_target(void =
*opaque, ram_addr_t target)
>>     }
>>     if (target) {
>>         dev->num_pages =3D (vm_ram_size - target) >> =
VIRTIO_BALLOON_PFN_SHIFT;
>> +        if (virtio_has_feature(dev->host_features,
>> +                               VIRTIO_BALLOON_F_THP_ORDER))
>> +            dev->num_pages >>=3D VIRTIO_BALLOON_THP_ORDER;
>>         virtio_notify_config(vdev);
>>     }
>>     trace_virtio_balloon_to_target(target, dev->num_pages);
>> @@ -916,6 +933,8 @@ static Property virtio_balloon_properties[] =3D {
>>                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>>     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>>                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>> +    DEFINE_PROP_BIT("thp-order", VirtIOBalloon, host_features,
>> +                    VIRTIO_BALLOON_F_THP_ORDER, false),
>>     /* QEMU 4.0 accidentally changed the config size even when =
free-page-hint
>>      * is disabled, resulting in QEMU 3.1 migration incompatibility.  =
This
>>      * property retains this quirk for QEMU 4.1 machine types.
>> diff --git a/include/standard-headers/linux/virtio_balloon.h =
b/include/standard-headers/linux/virtio_balloon.h
>> index 9375ca2..f54d613 100644
>> --- a/include/standard-headers/linux/virtio_balloon.h
>> +++ b/include/standard-headers/linux/virtio_balloon.h
>> @@ -36,10 +36,14 @@
>> #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on =
OOM */
>> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free =
pages */
>> #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page =
poisoning */
>> +#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Set balloon page order to =
thp order */
>>=20
>> /* Size of a PFN in the balloon interface. */
>> #define VIRTIO_BALLOON_PFN_SHIFT 12
>>=20
>> +/* The order of the balloon page */
>> +#define VIRTIO_BALLOON_THP_ORDER 9
>> +
>> #define VIRTIO_BALLOON_CMD_ID_STOP	0
>> #define VIRTIO_BALLOON_CMD_ID_DONE	1
>> struct virtio_balloon_config {
>> --=20
>> 2.7.4


