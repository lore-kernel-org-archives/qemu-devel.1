Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B86CC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54082078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCODwzB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54082078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDlz-00056Y-1D
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFDkR-00031y-4S
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:47:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFDkP-00069q-GU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599472056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0BN2erNjMTA/HM6V0aC0MuGaZ4GVq2PlUkckYYe+Bk=;
 b=UCODwzB48KcSiucunfjbjFMtZ05GkhZ1AXjBcM3lfUD9tvExQ27vdVo0HDK/ircOxKsHi8
 HHdvl22CTTdUqykpfAvWol//JXhwGYXV5ULkK7UA1hQLWeBq1iuUwY6sMXwHrkG7+JRkBC
 CEsBGEajxehysNbWo9IpvXthp2noSYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-Oy_TkWvHMjaUBax88iNp1A-1; Mon, 07 Sep 2020 05:47:34 -0400
X-MC-Unique: Oy_TkWvHMjaUBax88iNp1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC83427F3
 for <qemu-devel@nongnu.org>; Mon,  7 Sep 2020 09:47:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C5261A8EC;
 Mon,  7 Sep 2020 09:47:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5433E204AD; Mon,  7 Sep 2020 11:47:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] virtio-gpu: make virtio_gpu_ops static
Date: Mon,  7 Sep 2020 11:47:18 +0200
Message-Id: <20200907094719.12850-2-kraxel@redhat.com>
In-Reply-To: <20200907094719.12850-1-kraxel@redhat.com>
References: <20200907094719.12850-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
index 7517438e10aa..6c639a0e0272 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -107,6 +107,7 @@ typedef struct VirtIOGPUBase {
 
     struct virtio_gpu_base_conf conf;
     struct virtio_gpu_config virtio_config;
+    const GraphicHwOps *hw_ops;
 
     bool use_virgl_renderer;
     int renderer_blocked;
@@ -172,8 +173,6 @@ typedef struct VhostUserGPU {
     bool backend_blocked;
 } VhostUserGPU;
 
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
index f533d7d1b415..28006d6e8224 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -12,7 +12,7 @@ static void virtio_vga_base_invalidate_display(void *opaque)
     VirtIOGPUBase *g = vvga->vgpu;
 
     if (g->enable) {
-        virtio_gpu_ops.invalidate(g);
+        g->hw_ops->invalidate(g);
     } else {
         vvga->vga.hw_ops->invalidate(&vvga->vga);
     }
@@ -24,7 +24,7 @@ static void virtio_vga_base_update_display(void *opaque)
     VirtIOGPUBase *g = vvga->vgpu;
 
     if (g->enable) {
-        virtio_gpu_ops.gfx_update(g);
+        g->hw_ops->gfx_update(g);
     } else {
         vvga->vga.hw_ops->gfx_update(&vvga->vga);
     }
@@ -36,8 +36,8 @@ static void virtio_vga_base_text_update(void *opaque, console_ch_t *chardata)
     VirtIOGPUBase *g = vvga->vgpu;
 
     if (g->enable) {
-        if (virtio_gpu_ops.text_update) {
-            virtio_gpu_ops.text_update(g, chardata);
+        if (g->hw_ops->text_update) {
+            g->hw_ops->text_update(g, chardata);
         }
     } else {
         if (vvga->vga.hw_ops->text_update) {
@@ -51,8 +51,8 @@ static int virtio_vga_base_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
     VirtIOVGABase *vvga = opaque;
     VirtIOGPUBase *g = vvga->vgpu;
 
-    if (virtio_gpu_ops.ui_info) {
-        return virtio_gpu_ops.ui_info(g, idx, info);
+    if (g->hw_ops->ui_info) {
+        return g->hw_ops->ui_info(g, idx, info);
     }
     return -1;
 }
@@ -62,8 +62,8 @@ static void virtio_vga_base_gl_block(void *opaque, bool block)
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


