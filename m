Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FE2C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219FA20989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObM3p8NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219FA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9gf-0008Vs-9f
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:04:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aN-0003WC-CS
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aM-0001Qy-AO
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hQ9aM-0001QU-40
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id 7so7385814wmo.2
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=RRxHfRV+Nkj7T9UQbflCHFwgeYBhi6zGD4PURH16caQ=;
	b=ObM3p8NR3XUkME4KrKzX97ce3DeISoRGewIytawGsJiDu4HKVFKzigLi7Cm9vTBhkt
	qSCxrxvt8sy3qCFkXjK1vUmBedn1XSRIrnmqTuP2tTWQ3Spm71KcMcXRgjSxGAWklVd5
	FW/V94XZL+X8Kf7QUjLEid6mBjNClJexcwN5yXvYxLWkIaGxjiEDty7vF8HpUZJP8v5p
	bCk0OFgsDrhHFX/u2XjbeFn09aiVbozGG5tReIZEb+f7/APT4wuuJvNzvY90YOnTIYCr
	Hd83C6kjcTtHZXTNPNePb4rQyOn/lEvD8eczM47THeg2Oua0fmF1IL5bacCBSEpK/l+Z
	/syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=RRxHfRV+Nkj7T9UQbflCHFwgeYBhi6zGD4PURH16caQ=;
	b=U9gfegPP2EMs4CqQyA/o4hbs9mXk1w7HFcV2vBW4F++BZ1VgFMWSQJwliZQzRHXVTL
	QdgEqV5/WfQjLuOktruheQQ7Z2JYhfyS1y5RE4j9e/z4RpdyfiDbo6Rx5KJvspw1syrM
	hGYe4clYz8NkBFh+MkoQJQ9nK8n/HGcbIFYbgGcaw2Vw9acVXunrExnT6OWgYoCy2c1o
	kf1Srn2+9BZXL+lvxpFNrISD4/9yVObKtogj7jrZruq9nJVLR1YfBwT4gSmesX/VdJfE
	XsOcNDrDuzZQ3tGN2cim3fdHMcndUEmnywCrOGlbmWtGhpuAG8/OEsKIZYSQ6Hlhc0VJ
	HDpg==
X-Gm-Message-State: APjAAAW9P9y4haYAV/Qya+aEwiB7lKXoC5+bYAnubfVLbFasEEX9A5w1
	XChggL7fdvU3F6TKd/2kNvVL7jjF
X-Google-Smtp-Source: APXvYqyIoIvrqoIw2lGEZ5Hzf26BKPmk0OkIINBe6lgaodB/JeMZr5jBWnVXlc+4VZ6f1XvGRStvdQ==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr16295012wmi.9.1557748656762;
	Mon, 13 May 2019 04:57:36 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id z5sm5238554wmi.34.2019.05.13.04.57.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 04:57:35 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:57:29 +0300
Message-Id: <20190513115731.17588-2-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
References: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH V3 1/3] hw/display/ramfb: fix guest memory
 un-mapping
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
Cc: alex.williamson@redhat.com, kraxel@redhat.com, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Qiming <hqm03ster@gmail.com>

Pulled back the `qemu_create_displaysurface_guestmem` function to create
the display surface so that the guest memory gets properly unmapped.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
[rename the new functions and use QEMU coding style]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/display/ramfb.c | 51 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 25c8ad7c25..1955b048dd 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -32,33 +32,58 @@ struct RAMFBState {
     struct RAMFBCfg cfg;
 };
 
+static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
+{
+    void *data = pixman_image_get_data(image);
+    uint32_t size = pixman_image_get_stride(image) *
+        pixman_image_get_height(image);
+    cpu_physical_memory_unmap(data, size, 0, 0);
+}
+
+static DisplaySurface *ramfb_create_display_surface(int width, int height,
+                                                    pixman_format_code_t format,
+                                                    int linesize, uint64_t addr)
+{
+    DisplaySurface *surface;
+    hwaddr size;
+    void *data;
+
+    if (linesize == 0) {
+        linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
+    }
+
+    size = (hwaddr)linesize * height;
+    data = cpu_physical_memory_map(addr, &size, 0);
+    if (size != (hwaddr)linesize * height) {
+        cpu_physical_memory_unmap(data, size, 0, 0);
+        return NULL;
+    }
+
+    surface = qemu_create_displaysurface_from(width, height,
+                                              format, linesize, data);
+    pixman_image_set_destroy_function(surface->image,
+                                      ramfb_unmap_display_surface, NULL);
+
+    return surface;
+}
+
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s = dev;
-    void *framebuffer;
     uint32_t fourcc, format;
-    hwaddr stride, addr, length;
+    hwaddr stride, addr;
 
     s->width  = be32_to_cpu(s->cfg.width);
     s->height = be32_to_cpu(s->cfg.height);
     stride    = be32_to_cpu(s->cfg.stride);
     fourcc    = be32_to_cpu(s->cfg.fourcc);
     addr      = be64_to_cpu(s->cfg.addr);
-    length    = stride * s->height;
     format    = qemu_drm_format_to_pixman(fourcc);
 
     fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
             s->width, s->height, addr);
-    framebuffer = address_space_map(&address_space_memory,
-                                    addr, &length, false,
-                                    MEMTXATTRS_UNSPECIFIED);
-    if (!framebuffer || length < stride * s->height) {
-        s->width = 0;
-        s->height = 0;
-        return;
-    }
-    s->ds = qemu_create_displaysurface_from(s->width, s->height,
-                                            format, stride, framebuffer);
+    s->ds = ramfb_create_display_surface(s->width, s->height,
+                                         format, stride, addr);
 }
 
 void ramfb_display_update(QemuConsole *con, RAMFBState *s)
-- 
2.17.1


