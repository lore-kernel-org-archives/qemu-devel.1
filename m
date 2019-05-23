Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3043C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8178320863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8178320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnmG-0007IF-Nh
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:29:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTnek-0000OI-35
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTnej-0004XU-3s
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hTnei-0004XB-Tk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 483BA307D96D
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:21:12 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47E8A67C9B;
	Thu, 23 May 2019 13:21:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:20:30 +0200
Message-Id: <20190523132035.20559-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190523132035.20559-1-marcandre.lureau@redhat.com>
References: <20190523132035.20559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 23 May 2019 13:21:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v8 3/8] virtio-gpu: add a pixman helper header
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow to share the format conversion function with
vhost-user-gpu.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu-pixman.h | 45 +++++++++++++++++++++++++++
 hw/display/virtio-gpu.c               | 29 ++---------------
 2 files changed, 48 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/virtio/virtio-gpu-pixman.h

diff --git a/include/hw/virtio/virtio-gpu-pixman.h b/include/hw/virtio/vi=
rtio-gpu-pixman.h
new file mode 100644
index 0000000000..4dba782758
--- /dev/null
+++ b/include/hw/virtio/virtio-gpu-pixman.h
@@ -0,0 +1,45 @@
+/*
+ * Virtio GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2014
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VIRTIO_GPU_PIXMAN_H
+#define HW_VIRTIO_GPU_PIXMAN_H
+
+#include "ui/qemu-pixman.h"
+#include "standard-headers/linux/virtio_gpu.h"
+
+static inline pixman_format_code_t
+virtio_gpu_get_pixman_format(uint32_t virtio_gpu_format)
+{
+    switch (virtio_gpu_format) {
+    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
+        return PIXMAN_BE_b8g8r8x8;
+    case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
+        return PIXMAN_BE_b8g8r8a8;
+    case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
+        return PIXMAN_BE_x8r8g8b8;
+    case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
+        return PIXMAN_BE_a8r8g8b8;
+    case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
+        return PIXMAN_BE_r8g8b8x8;
+    case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
+        return PIXMAN_BE_r8g8b8a8;
+    case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
+        return PIXMAN_BE_x8b8g8r8;
+    case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
+        return PIXMAN_BE_a8b8g8r8;
+    default:
+        return 0;
+    }
+}
+
+#endif
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c35025b6fb..3262f7f1f1 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -21,6 +21,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-bswap.h"
+#include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/display/edid.h"
 #include "migration/blocker.h"
@@ -298,30 +299,6 @@ void virtio_gpu_get_edid(VirtIOGPU *g,
     virtio_gpu_ctrl_response(g, cmd, &edid.hdr, sizeof(edid));
 }
=20
-static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_format=
)
-{
-    switch (virtio_gpu_format) {
-    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
-        return PIXMAN_BE_b8g8r8x8;
-    case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
-        return PIXMAN_BE_b8g8r8a8;
-    case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
-        return PIXMAN_BE_x8r8g8b8;
-    case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
-        return PIXMAN_BE_a8r8g8b8;
-    case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
-        return PIXMAN_BE_r8g8b8x8;
-    case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
-        return PIXMAN_BE_r8g8b8a8;
-    case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
-        return PIXMAN_BE_x8b8g8r8;
-    case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
-        return PIXMAN_BE_a8b8g8r8;
-    default:
-        return 0;
-    }
-}
-
 static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
                                    uint32_t width, uint32_t height)
 {
@@ -368,7 +345,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *=
g,
     res->format =3D c2d.format;
     res->resource_id =3D c2d.resource_id;
=20
-    pformat =3D get_pixman_format(c2d.format);
+    pformat =3D virtio_gpu_get_pixman_format(c2d.format);
     if (!pformat) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: host couldn't handle guest format %d\n",
@@ -1142,7 +1119,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaqu=
e, size_t size,
         res->iov_cnt =3D qemu_get_be32(f);
=20
         /* allocate */
-        pformat =3D get_pixman_format(res->format);
+        pformat =3D virtio_gpu_get_pixman_format(res->format);
         if (!pformat) {
             g_free(res);
             return -EINVAL;
--=20
2.22.0.rc1.1.g079e7d2849.dirty


