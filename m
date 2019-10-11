Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF5C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619C2214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619C2214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIws4-0003B7-Tv
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwq9-0001BD-3O
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwq7-0006N0-Tr
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwq5-0006Kd-EQ; Fri, 11 Oct 2019 11:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A964C10B78;
 Fri, 11 Oct 2019 15:28:20 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1480E4535;
 Fri, 11 Oct 2019 15:28:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/16] include: Move endof() up from hw/virtio/virtio.h
Date: Fri, 11 Oct 2019 17:27:59 +0200
Message-Id: <20191011152814.14791-2-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 11 Oct 2019 15:28:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
index 7b93c73340..85c02c16d3 100644
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
index ed2ddebd2b..ac857edc73 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -42,9 +42,9 @@
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


