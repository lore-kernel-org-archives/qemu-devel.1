Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D4C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC7A208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC7A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZErD-0003vg-TP
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34486)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hZEm6-0007UL-Et
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hZEm5-0005WW-FQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hZEm5-0005Te-A7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B6BC6EB99
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 13:19:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEE221001B0C;
 Fri,  7 Jun 2019 13:19:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2396A17538; Fri,  7 Jun 2019 15:19:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 15:19:01 +0200
Message-Id: <20190607131901.20107-6-kraxel@redhat.com>
In-Reply-To: <20190607131901.20107-1-kraxel@redhat.com>
References: <20190607131901.20107-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 07 Jun 2019 13:19:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/5] egl-helpers: add modifier support to
 egl_dmabuf_import_texture()
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check and use QemuDmaBuf->modifier in egl_dmabuf_import_texture()
for dmabuf imports.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190529072144.26737-5-kraxel@redhat.com
---
 ui/egl-helpers.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 0c9716067cfb..edc53f6d3464 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -229,20 +229,36 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
 {
     EGLImageKHR image = EGL_NO_IMAGE_KHR;
-    EGLint attrs[] = {
-        EGL_DMA_BUF_PLANE0_FD_EXT,      dmabuf->fd,
-        EGL_DMA_BUF_PLANE0_PITCH_EXT,   dmabuf->stride,
-        EGL_DMA_BUF_PLANE0_OFFSET_EXT,  0,
-        EGL_WIDTH,                      dmabuf->width,
-        EGL_HEIGHT,                     dmabuf->height,
-        EGL_LINUX_DRM_FOURCC_EXT,       dmabuf->fourcc,
-        EGL_NONE, /* end of list */
-    };
+    EGLint attrs[64];
+    int i = 0;
 
     if (dmabuf->texture != 0) {
         return;
     }
 
+    attrs[i++] = EGL_WIDTH;
+    attrs[i++] = dmabuf->width;
+    attrs[i++] = EGL_HEIGHT;
+    attrs[i++] = dmabuf->height;
+    attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
+    attrs[i++] = dmabuf->fourcc;
+
+    attrs[i++] = EGL_DMA_BUF_PLANE0_FD_EXT;
+    attrs[i++] = dmabuf->fd;
+    attrs[i++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
+    attrs[i++] = dmabuf->stride;
+    attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
+    attrs[i++] = 0;
+#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
+    if (dmabuf->modifier) {
+        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
+        attrs[i++] = (dmabuf->modifier >>  0) & 0xffffffff;
+        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
+        attrs[i++] = (dmabuf->modifier >> 32) & 0xffffffff;
+    }
+#endif
+    attrs[i++] = EGL_NONE;
+
     image = eglCreateImageKHR(qemu_egl_display,
                               EGL_NO_CONTEXT,
                               EGL_LINUX_DMA_BUF_EXT,
-- 
2.18.1


