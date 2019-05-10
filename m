Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E21F21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjVS2ET6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E21F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46577 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8aU-0002J3-Ev
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:41:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hP8Ni-0008RD-O2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hP8Nh-0003BP-G4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:28:22 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:40795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hP8Nh-0003B6-BP
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:28:21 -0400
Received: by mail-qk1-x741.google.com with SMTP id w20so4014223qka.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pajFOVN2jwVk6oanPLNaIV/SoTrhlAKI9cBxsW51JCM=;
	b=XjVS2ET6auZxKldc/TYTgyW/lbxv7KyjesbQhi4OxIRJz0O+B+HRKeYJW8/lnSkfSj
	yfqkvQsDQZmXf7Z9VJrrewi6dL13F4bbknjQZbW96N32ZfawbScFxQ/hSZvsjvVtrbs0
	xEJkAXuGeskl1cjhu0DVKyyy+QPIe2ies7ulzX/W2oHYsrGgn5memWl8vkmtavu1cE1b
	2FXkLikDLsJCQLElaFWwYxE4wJhR9DAQzVP6aYTRz20VnaQVqHV5BH+IANIVGlI2rW1l
	MXchmGM2WhrTmGx0DUWJ6NmwsIYYckhxosvV+2TF382r6wxz5KfLDUGhu1RSf4TclSBq
	zj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pajFOVN2jwVk6oanPLNaIV/SoTrhlAKI9cBxsW51JCM=;
	b=dzR1nuZJTNYDHKTtSXMdSWA4oRNvRBk6ywEMSpqxEvPa6EFLttbvqNai0GejMkFWIt
	nqRM0lLcLuTo0oavFFSuizbi6U7BoKL14e6ga7NdskvfOythk2kIVZHAYXPnyd69cAZZ
	Bz8f+LISJo5+WAsD1LDqIPXeuA3DxRCDIA8rjbHhiDAJy8/Fvy3TOWn4PmTUyWnF1k8Y
	aX7XRvMRUAXmQ/vsUKK/cphwI6pTnVWH9rqWceQtxL3PgApaujYL/NOCroHY4qdPoPJa
	YWkaq1QiXSE9PavBh64AuYPJJPlr9jSR4Kt5keRZVBClna1zrsiW2HIH313MPPf+aVvG
	niPQ==
X-Gm-Message-State: APjAAAV0UsjP8dpQBJ9hiioDemwpomp0uRT3v3tS32dnD+DHEqeOgrpd
	N0Ste9sU97GKhuPQhHyT4FBqnPKHBXKY5Egx9qTqn9Hi
X-Google-Smtp-Source: APXvYqzuishv7O28/B2wbm0CWJ1A/w4gMRShYT2jDWX19anghzDGU8TJZPdhkfdnkfb9hQ3ZZ5MS/sNPFQTwKcMvuLE=
X-Received: by 2002:a37:9587:: with SMTP id x129mr9914122qkd.9.1557505699768; 
	Fri, 10 May 2019 09:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
	<b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
	<CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
	<3e619b5c-8fb3-2655-2d92-37598db098d8@gmail.com>
	<20190510085947.y62lttdtrg5cxx6b@sirius.home.kraxel.org>
	<3fb8b79d-9f68-2342-d3ae-3aefa873109b@gmail.com>
	<20190510103900.botgnbbo2ii4jxgo@sirius.home.kraxel.org>
	<01de4824-5c19-6b6c-5b75-fa54a883ab4a@gmail.com>
In-Reply-To: <01de4824-5c19-6b6c-5b75-fa54a883ab4a@gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Sat, 11 May 2019 00:28:04 +0800
Message-ID: <CABSdmrnVzi5ZTF58tnt8T8=gsVe2ZNqtZKCBcbZQ9Lb+CCCkdg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::741
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH v2 1/3] hw/display/ramfb: fix guest memory
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pulled back the `qemu_create_displaysurface_guestmem` function to create
the display surface so that the guest memory gets properly unmapped.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
---
 hw/display/ramfb.c | 53 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 25c8ad7..98703f7 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -32,33 +32,60 @@ struct RAMFBState {
     struct RAMFBCfg cfg;
 };

+static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
+                                               void *unused)
+{
+    void *data = pixman_image_get_data(image);
+    uint32_t size = pixman_image_get_stride(image) *
+        pixman_image_get_height(image);
+    cpu_physical_memory_unmap(data, size, 0, 0);
+}
+
+static DisplaySurface *qemu_create_displaysurface_guestmem(
+    int width, int height,
+    pixman_format_code_t format,
+    int linesize, uint64_t addr)
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
+    surface = qemu_create_displaysurface_from
+        (width, height, format, linesize, data);
+    pixman_image_set_destroy_function
+        (surface->image, qemu_unmap_displaysurface_guestmem, NULL);
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
+    s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
+                                                format, stride, addr);
 }

 void ramfb_display_update(QemuConsole *con, RAMFBState *s)
-- 
2.17.1
