Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FE1C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B0320759
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8pVlIeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B0320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHosb-0006EB-2D
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHokp-0002mt-AY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHokm-00037D-AJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600090962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tF8qpzdaZ/T6Te/ZEiZs8KXYQcEQMACXlftO9ZA3/MU=;
 b=L8pVlIeRo/Y6sTxoupCixDmo9GFPjQrE9Z7TPAs0e/60gWOVvqnwCIC+7PpDwShErWbKdu
 RYq8vCgdPGSnX78eSk9CvgqqUDaFDxeWUXsTfVlsXK5poL+BN7DB6tKy2HOqJ0DEkp+kL2
 0eVx7PgbvmkWfeuEF2/vOLPJ7U/9BIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-CBhB85IvNTGaYlL1jsoW5g-1; Mon, 14 Sep 2020 09:42:41 -0400
X-MC-Unique: CBhB85IvNTGaYlL1jsoW5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24A8A1006701
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 13:42:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C34627BE5B;
 Mon, 14 Sep 2020 13:42:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C5BF131F73; Mon, 14 Sep 2020 15:42:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] virtio-gpu: make virtio_gpu_ops static
Date: Mon, 14 Sep 2020 15:42:23 +0200
Message-Id: <20200914134224.29769-6-kraxel@redhat.com>
In-Reply-To: <20200914134224.29769-1-kraxel@redhat.com>
References: <20200914134224.29769-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reference it via ops pointer instead, simliar to the vga one.
Removes hard symbol reference, needed to build virtio-gpu modular.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  3 +--
 hw/display/virtio-gpu-base.c   |  3 ++-
 hw/display/virtio-vga.c        | 16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f334b780858c..6b45b4799a3e 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -106,6 +106,7 @@ struct VirtIOGPUBase {
 
     struct virtio_gpu_base_conf conf;
     struct virtio_gpu_config virtio_config;
+    const GraphicHwOps *hw_ops;
 
     bool use_virgl_renderer;
     int renderer_blocked;
@@ -171,8 +172,6 @@ struct VhostUserGPU {
     bool backend_blocked;
 };
 
-extern const GraphicHwOps virtio_gpu_ops;
-
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
         size_t s;                                                       \
         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 796130860657..aeb87235420a 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -112,7 +112,7 @@ virtio_gpu_gl_block(void *opaque, bool block)
     }
 }
 
-const GraphicHwOps virtio_gpu_ops = {
+static const GraphicHwOps virtio_gpu_ops = {
     .invalidate = virtio_gpu_invalidate_display,
     .gfx_update = virtio_gpu_update_display,
     .text_update = virtio_gpu_text_update,
@@ -162,6 +162,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =
             graphic_console_init(DEVICE(g), i, &virtio_gpu_ops, g);
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 573e7d59282a..f9410a0c2e61 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -13,7 +13,7 @@ static void virtio_vga_base_invalidate_display(void *opaque)
     VirtIOGPUBase *g = vvga->vgpu;
 
     if (g->enable) {
-        virtio_gpu_ops.invalidate(g);
+        g->hw_ops->invalidate(g);
     } else {
         vvga->vga.hw_ops->invalidate(&vvga->vga);
     }
@@ -25,7 +25,7 @@ static void virtio_vga_base_update_display(void *opaque)
     VirtIOGPUBase *g = vvga->vgpu;
 
     if (g->enable) {
-        virtio_gpu_ops.gfx_update(g);
+        g->hw_ops->gfx_update(g);
     } else {
         vvga->vga.hw_ops->gfx_update(&vvga->vga);
     }
@@ -37,8 +37,8 @@ static void virtio_vga_base_text_update(void *opaque, console_ch_t *chardata)
     VirtIOGPUBase *g = vvga->vgpu;
 
     if (g->enable) {
-        if (virtio_gpu_ops.text_update) {
-            virtio_gpu_ops.text_update(g, chardata);
+        if (g->hw_ops->text_update) {
+            g->hw_ops->text_update(g, chardata);
         }
     } else {
         if (vvga->vga.hw_ops->text_update) {
@@ -52,8 +52,8 @@ static int virtio_vga_base_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
     VirtIOVGABase *vvga = opaque;
     VirtIOGPUBase *g = vvga->vgpu;
 
-    if (virtio_gpu_ops.ui_info) {
-        return virtio_gpu_ops.ui_info(g, idx, info);
+    if (g->hw_ops->ui_info) {
+        return g->hw_ops->ui_info(g, idx, info);
     }
     return -1;
 }
@@ -63,8 +63,8 @@ static void virtio_vga_base_gl_block(void *opaque, bool block)
     VirtIOVGABase *vvga = opaque;
     VirtIOGPUBase *g = vvga->vgpu;
 
-    if (virtio_gpu_ops.gl_block) {
-        virtio_gpu_ops.gl_block(g, block);
+    if (g->hw_ops->gl_block) {
+        g->hw_ops->gl_block(g, block);
     }
 }
 
-- 
2.27.0


