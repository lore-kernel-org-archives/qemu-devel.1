Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33352C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D530214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D530214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzmqz-0003eh-Ra
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzmpA-0001P0-Mb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzmp9-0001sp-Hk
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzmp7-0001rO-2P; Mon, 19 Aug 2019 14:56:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64A963060288;
 Mon, 19 Aug 2019 18:56:08 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ABFC1C9;
 Mon, 19 Aug 2019 18:56:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 20:55:47 +0200
Message-Id: <20190819185602.4267-2-mreitz@redhat.com>
In-Reply-To: <20190819185602.4267-1-mreitz@redhat.com>
References: <20190819185602.4267-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 19 Aug 2019 18:56:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 01/16] include: Move endof() up from
 hw/virtio/virtio.h
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

endof() is a useful macro, we can make use of it outside of virtio.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/hw/virtio/virtio.h |  7 -------
 include/qemu/compiler.h    |  7 +++++++
 hw/block/virtio-blk.c      |  4 ++--
 hw/net/virtio-net.c        | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04ff6..ef083af550 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -37,13 +37,6 @@ static inline hwaddr vring_align(hwaddr addr,
     return QEMU_ALIGN_UP(addr, align);
 }
=20
-/*
- * Calculate the number of bytes up to and including the given 'field' o=
f
- * 'container'.
- */
-#define virtio_endof(container, field) \
-    (offsetof(container, field) + sizeof_field(container, field))
-
 typedef struct VirtIOFeature {
     uint64_t flags;
     size_t end;
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 09fc44cca4..dab3d7fad4 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -60,6 +60,13 @@
=20
 #define sizeof_field(type, field) sizeof(((type *)0)->field)
=20
+/*
+ * Calculate the number of bytes up to and including the given 'field' o=
f
+ * 'container'.
+ */
+#define endof(container, field) \
+    (offsetof(container, field) + sizeof_field(container, field))
+
 /* Convert from a base type to a parent type, with compile time checking=
.  */
 #ifdef __GNUC__
 #define DO_UPCAST(type, field, dev) ( __extension__ ( { \
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 18851601cb..1ad6a784f0 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -41,9 +41,9 @@
  */
 static VirtIOFeature feature_sizes[] =3D {
     {.flags =3D 1ULL << VIRTIO_BLK_F_DISCARD,
-     .end =3D virtio_endof(struct virtio_blk_config, discard_sector_alig=
nment)},
+     .end =3D endof(struct virtio_blk_config, discard_sector_alignment)}=
,
     {.flags =3D 1ULL << VIRTIO_BLK_F_WRITE_ZEROES,
-     .end =3D virtio_endof(struct virtio_blk_config, write_zeroes_may_un=
map)},
+     .end =3D endof(struct virtio_blk_config, write_zeroes_may_unmap)},
     {}
 };
=20
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9f11422337..2c4909c5f9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -90,15 +90,15 @@ static inline __virtio16 *virtio_net_rsc_ext_num_dupa=
cks(
=20
 static VirtIOFeature feature_sizes[] =3D {
     {.flags =3D 1ULL << VIRTIO_NET_F_MAC,
-     .end =3D virtio_endof(struct virtio_net_config, mac)},
+     .end =3D endof(struct virtio_net_config, mac)},
     {.flags =3D 1ULL << VIRTIO_NET_F_STATUS,
-     .end =3D virtio_endof(struct virtio_net_config, status)},
+     .end =3D endof(struct virtio_net_config, status)},
     {.flags =3D 1ULL << VIRTIO_NET_F_MQ,
-     .end =3D virtio_endof(struct virtio_net_config, max_virtqueue_pairs=
)},
+     .end =3D endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags =3D 1ULL << VIRTIO_NET_F_MTU,
-     .end =3D virtio_endof(struct virtio_net_config, mtu)},
+     .end =3D endof(struct virtio_net_config, mtu)},
     {.flags =3D 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
-     .end =3D virtio_endof(struct virtio_net_config, duplex)},
+     .end =3D endof(struct virtio_net_config, duplex)},
     {}
 };
=20
--=20
2.21.0


