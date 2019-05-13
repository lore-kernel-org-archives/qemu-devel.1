Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D65CC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A436208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYUJE4JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A436208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9cF-0004hp-8B
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:59:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aO-0003XL-UB
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aN-0001Ry-T8
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hQ9aN-0001RL-Mn
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id o4so14949734wra.3
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Nnd8FYZPm/MLulz3Akv9891/p6EUv5PIMcaH5c6XG9k=;
	b=bYUJE4JPlOZnPo0KYhnqkF9fn+yBVwhdAcRerhGa9IAAYMEyxgdAq1ZhuPDwxZqyH6
	f85SHsvGvt+V0zG44R9A1CyrGeS6knlshZr0dl384JgPp3EU8t+V9+ilK/71yyt17ovo
	1oZo6StGYsSjuLlC3ZzDOtl9ZUkYj662/vYkige9ANiTySc9vclXxbpFRNVlNO6hwf6B
	ZV7onw8X4b64PkKKL49QZSb4rSGdUwoaUEelkluicFEbUvrHMgJfwnpEP8sB4FGYntf3
	qwrSEpdrTsWByEsbtpYbsp4rgQRROZsxKNIEntYwkb3Yn4dPJnGClPfj8ygtlo8X93gK
	xAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Nnd8FYZPm/MLulz3Akv9891/p6EUv5PIMcaH5c6XG9k=;
	b=dfCHyWZepWbOWVf8Y4xiau5VGbClaySehQjaFoUBbvGpLlc1EUy5vcALPTxFOAMH8E
	ZQ4axDXNtaUqnLJ9hQ40zla/Inv54pOXcgE8mQJ4Q8VIfbH4jD6LnwnWoZ6ZwHVuledr
	QEhynbtnAO5evTJdLiIP+Pa62wCTC/cqCRZYTefK5aVRNumHYpnoZWq/OGkX1s/ufHXQ
	YRHQdVOT8oXMN4tgK1UhBQrE6lpi4U9GANAUoInsvbmuIOqiDoLHtS46RlwYgPY+Yz9X
	bFZ2b78T5kGbRmS1BewDWVdESsDUoMplXZJL3a6H7AnRDp24DS3k5M3GeZITTNea5kC/
	xo9g==
X-Gm-Message-State: APjAAAWlm58GQXgkI932Ol5RCT4IAGItT0QRH8f0s9WoGl6QA3xT7MaX
	KqzVQcTY4tLu0OhEj0bVNdBvV+Ef
X-Google-Smtp-Source: APXvYqwZiOmKbkkNsp/7A+fQ/jMH4LL2MS5zEwSCV0rHlGrgvyrTZjQnn4+DqKir17z6lP+a9xhxaQ==
X-Received: by 2002:a5d:4f88:: with SMTP id d8mr2847906wru.34.1557748658455;
	Mon, 13 May 2019 04:57:38 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id z5sm5238554wmi.34.2019.05.13.04.57.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 04:57:37 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:57:30 +0300
Message-Id: <20190513115731.17588-3-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
References: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH V3 2/3] hw/display/ramfb: lock guest resolution
 after it's set
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

Only allow one resolution change per guest boot, which prevents a
crash when the guest writes garbage to the configuration space (e.g.
when rebooting).

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
[fixed malformed patch]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/display/ramfb.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 1955b048dd..0fe79aa856 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -30,6 +30,7 @@ struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
     struct RAMFBCfg cfg;
+    bool locked;
 };
 
 static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
@@ -70,18 +71,25 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s = dev;
-    uint32_t fourcc, format;
+    uint32_t fourcc, format, width, height;
     hwaddr stride, addr;
 
-    s->width  = be32_to_cpu(s->cfg.width);
-    s->height = be32_to_cpu(s->cfg.height);
+    width     = be32_to_cpu(s->cfg.width);
+    height    = be32_to_cpu(s->cfg.height);
     stride    = be32_to_cpu(s->cfg.stride);
     fourcc    = be32_to_cpu(s->cfg.fourcc);
     addr      = be64_to_cpu(s->cfg.addr);
     format    = qemu_drm_format_to_pixman(fourcc);
 
     fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
-            s->width, s->height, addr);
+            width, height, addr);
+    if (s->locked) {
+        fprintf(stderr, "%s: resolution locked, change rejected\n", __func__);
+        return;
+    }
+    s->locked = true;
+    s->width = width;
+    s->height = height;
     s->ds = ramfb_create_display_surface(s->width, s->height,
                                          format, stride, addr);
 }
@@ -101,6 +109,13 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
     dpy_gfx_update_full(con);
 }
 
+static void ramfb_reset(void *opaque)
+{
+    RAMFBState *s = (RAMFBState *)opaque;
+    s->locked = false;
+    memset(&s->cfg, 0, sizeof(s->cfg));
+}
+
 RAMFBState *ramfb_setup(Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
@@ -113,9 +128,12 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
+    s->locked = false;
+
     rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
                              &s->cfg, sizeof(s->cfg), false);
+    qemu_register_reset(ramfb_reset, s);
     return s;
 }
-- 
2.17.1


