Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E7C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCA8208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCA8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEoQ-0000eG-Aq
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hZEm1-0007ND-0F
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hZElz-00051W-Sr
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hZElz-0004uZ-Kw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64E3A3084213
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 13:19:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6634D7DE35;
 Fri,  7 Jun 2019 13:19:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1B78917536; Fri,  7 Jun 2019 15:19:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 15:19:00 +0200
Message-Id: <20190607131901.20107-5-kraxel@redhat.com>
In-Reply-To: <20190607131901.20107-1-kraxel@redhat.com>
References: <20190607131901.20107-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 13:19:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/5] egl-helpers: add modifier support to
 egl_get_fd_for_texture().
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

Add modifier parameter to egl_get_fd_for_texture(), to return the used
modifier on dmabuf exports.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190529072144.26737-4-kraxel@redhat.com
---
 include/ui/egl-helpers.h | 3 ++-
 ui/egl-helpers.c         | 5 +++--
 ui/spice-display.c       | 7 ++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index b976cb872821..d71412779913 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -36,7 +36,8 @@ extern struct gbm_device *qemu_egl_rn_gbm_dev;
 extern EGLContext qemu_egl_rn_ctx;
 
 int egl_rendernode_init(const char *rendernode, DisplayGLMode mode);
-int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc);
+int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
+                           EGLuint64KHR *modifier);
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
 void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e90eef8c9c3a..0c9716067cfb 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -200,7 +200,8 @@ err:
     return -1;
 }
 
-int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc)
+int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
+                           EGLuint64KHR *modifier)
 {
     EGLImageKHR image;
     EGLint num_planes, fd;
@@ -214,7 +215,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc)
     }
 
     eglExportDMABUFImageQueryMESA(qemu_egl_display, image, fourcc,
-                                  &num_planes, NULL);
+                                  &num_planes, modifier);
     if (num_planes != 1) {
         eglDestroyImageKHR(qemu_egl_display, image);
         return -1;
diff --git a/ui/spice-display.c b/ui/spice-display.c
index a5e26479a866..104df2302575 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -888,7 +888,8 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
     if (ssd->ds) {
         surface_gl_create_texture(ssd->gls, ssd->ds);
         fd = egl_get_fd_for_texture(ssd->ds->texture,
-                                    &stride, &fourcc);
+                                    &stride, &fourcc,
+                                    NULL);
         if (fd < 0) {
             surface_gl_destroy_texture(ssd->gls, ssd->ds);
             return;
@@ -945,7 +946,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     int fd = -1;
 
     assert(tex_id);
-    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc);
+    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc, NULL);
     if (fd < 0) {
         fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
         return;
@@ -1063,7 +1064,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                 egl_fb_setup_new_tex(&ssd->blit_fb,
                                      dmabuf->width, dmabuf->height);
                 fd = egl_get_fd_for_texture(ssd->blit_fb.texture,
-                                            &stride, &fourcc);
+                                            &stride, &fourcc, NULL);
                 spice_qxl_gl_scanout(&ssd->qxl, fd,
                                      dmabuf->width, dmabuf->height,
                                      stride, fourcc, false);
-- 
2.18.1


