Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BF9C2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF6E208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF6E208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMbn-0006uu-A6
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jHMbE-0006PR-Cd
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jHMb8-0003WO-A9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:06:39 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jHMb7-0003NO-I4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:06:38 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0TtfYrM9_1585206379; 
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0TtfYrM9_1585206379) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 26 Mar 2020 15:06:24 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH for QEMU v2] virtio-balloon: Add option cont-pages to set
 VIRTIO_BALLOON_VQ_INFLATE_CONT
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <1584893097-12317-2-git-send-email-teawater@gmail.com>
Date: Thu, 26 Mar 2020 15:06:18 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <575FA585-343A-4246-830B-C1CB3153B7E0@linux.alibaba.com>
References: <1584893097-12317-1-git-send-email-teawater@gmail.com>
 <1584893097-12317-2-git-send-email-teawater@gmail.com>
To: Hui Zhu <teawater@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 115.124.30.42
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
Cc: pagupta@redhat.com, aquini@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 mojha@codeaurora.org, david@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 namit@vmware.com, Andrew Morton <akpm@linux-foundation.org>,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

Thanks,
Hui

> 2020=E5=B9=B43=E6=9C=8823=E6=97=A5 00:04=EF=BC=8CHui Zhu =
<teawater@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> Set option cont-pages to on will open flags =
VIRTIO_BALLOON_VQ_INFLATE_CONT
> and set continuous pages order to THP order.
> Then It will get continuous pages PFN from VQ icvq use use madvise
> MADV_DONTNEED release the THP page.
> This will handle the THP split issue.
>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
> hw/virtio/virtio-balloon.c                      | 32 =
+++++++++++++++++++++----
> include/hw/virtio/virtio-balloon.h              |  4 +++-
> include/standard-headers/linux/virtio_balloon.h |  4 ++++
> 3 files changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7..88bdaca 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -34,6 +34,7 @@
> #include "hw/virtio/virtio-access.h"
>=20
> #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> +#define CONT_PAGES_ORDER   9
>=20
> typedef struct PartiallyBalloonedPage {
>     ram_addr_t base_gpa;
> @@ -65,7 +66,8 @@ static bool =
virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
>=20
> static void balloon_inflate_page(VirtIOBalloon *balloon,
>                                  MemoryRegion *mr, hwaddr mr_offset,
> -                                 PartiallyBalloonedPage *pbp)
> +                                 PartiallyBalloonedPage *pbp,=20
> +                                 bool is_cont_pages)
> {
>     void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
>     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
> @@ -76,6 +78,13 @@ static void balloon_inflate_page(VirtIOBalloon =
*balloon,
>     /* XXX is there a better way to get to the RAMBlock than via a
>      * host address? */
>     rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
> +
> +    if (is_cont_pages) {
> +        ram_block_discard_range(rb, rb_offset,
> +                                BALLOON_PAGE_SIZE << =
CONT_PAGES_ORDER);
> +        return;
> +    }
> +
>     rb_page_size =3D qemu_ram_pagesize(rb);
>=20
>     if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
> @@ -361,9 +370,10 @@ static void =
virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>             =
trace_virtio_balloon_handle_output(memory_region_name(section.mr),
>                                                pa);
>             if (!qemu_balloon_is_inhibited()) {
> -                if (vq =3D=3D s->ivq) {
> +                if (vq =3D=3D s->ivq || vq =3D=3D s->icvq) {
>                     balloon_inflate_page(s, section.mr,
> -                                         =
section.offset_within_region, &pbp);
> +                                         =
section.offset_within_region, &pbp,
> +                                         vq =3D=3D s->icvq);
>                 } else if (vq =3D=3D s->dvq) {
>                     balloon_deflate_page(s, section.mr, =
section.offset_within_region);
>                 } else {
> @@ -618,9 +628,12 @@ static size_t =
virtio_balloon_config_size(VirtIOBalloon *s)
>     if (s->qemu_4_0_config_size) {
>         return sizeof(struct virtio_balloon_config);
>     }
> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +    if (virtio_has_feature(s->host_features, =
VIRTIO_BALLOON_F_CONT_PAGES)) {
>         return sizeof(struct virtio_balloon_config);
>     }
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +        return offsetof(struct virtio_balloon_config, pages_order);
> +    }
>     if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) =
{
>         return offsetof(struct virtio_balloon_config, poison_val);
>     }
> @@ -646,6 +659,10 @@ static void =
virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>     }
>=20
> +    if (virtio_has_feature(dev->host_features, =
VIRTIO_BALLOON_F_CONT_PAGES)) {
> +        config.pages_order =3D cpu_to_le32(CONT_PAGES_ORDER);
> +    }
> +
>     trace_virtio_balloon_get_config(config.num_pages, config.actual);
>     memcpy(config_data, &config, virtio_balloon_config_size(dev));
> }
> @@ -816,6 +833,11 @@ static void =
virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>             virtio_error(vdev, "iothread is missing");
>         }
>     }
> +
> +    if (virtio_has_feature(s->host_features, =
VIRTIO_BALLOON_F_CONT_PAGES)) {
> +        s->icvq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_handle_output);
> +    }
> +
>     reset_stats(s);
> }
>=20
> @@ -916,6 +938,8 @@ static Property virtio_balloon_properties[] =3D {
>                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_CONT_PAGES, false),
>     /* QEMU 4.0 accidentally changed the config size even when =
free-page-hint
>      * is disabled, resulting in QEMU 3.1 migration incompatibility.  =
This
>      * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h =
b/include/hw/virtio/virtio-balloon.h
> index d1c968d..61d2419 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>=20
> typedef struct VirtIOBalloon {
>     VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
>     uint32_t free_page_report_status;
>     uint32_t num_pages;
>     uint32_t actual;
> @@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
>     uint32_t host_features;
>=20
>     bool qemu_4_0_config_size;
> +
> +    uint32_t pages_order;
> } VirtIOBalloon;
>=20
> #endif
> diff --git a/include/standard-headers/linux/virtio_balloon.h =
b/include/standard-headers/linux/virtio_balloon.h
> index 9375ca2..ee18be7 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -36,6 +36,8 @@
> #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on =
OOM */
> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free =
pages */
> #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page =
poisoning */
> +#define VIRTIO_BALLOON_F_CONT_PAGES	5 /* VQ to report continuous =
pages */
> +
>=20
> /* Size of a PFN in the balloon interface. */
> #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -51,6 +53,8 @@ struct virtio_balloon_config {
> 	uint32_t free_page_report_cmd_id;
> 	/* Stores PAGE_POISON if page poisoning is in use */
> 	uint32_t poison_val;
> +	/* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
> +	uint32_t pages_order;
> };
>=20
> #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in =
*/
> --=20
> 2.7.4
>=20


