Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A1C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCEB21019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK7A7uGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCEB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49921 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOdxx-00011K-W2
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 03:59:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdwP-00007T-Hq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdwO-00036Z-7N
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:09 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:41260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hOdwO-00036H-2L
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:08 -0400
Received: by mail-qt1-x841.google.com with SMTP id c13so1446321qtn.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=x2nznhY9vQko+bfMP59c4hRb1YfaP0kVJDDPPWYk4gM=;
	b=IK7A7uGFQ+0Jc+da3/2rBFosqYMTbusjvWFDlYWC2Jlbpbah1fQQyJ7r2oBfcAOeVy
	R5WJQ4OGvmCBH3jIDUEoBU4iTPhWXQqchjM5RK8810OjrUO17SZ7h8hSFUJJVE1Cq3Ma
	Gty0y73dck3exlbD3DYLUg+lcFa4VFGmMWmQ8RRzkEPWfQ591w1YI23QLceizDyNiUPz
	B2B+JAyVmy7spBINHLsA/d/ZcaE5x9iaSql0wzjwvLKFQZYGANBse2TcAqN9PTYW6EJt
	tIOu6qw14Xv56HrJ21Hg8/0no0Q5dyQKOjH34OXgdKoNsEoSj6vtqLouLJjGnA/BtCGV
	Tryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=x2nznhY9vQko+bfMP59c4hRb1YfaP0kVJDDPPWYk4gM=;
	b=oyAFBrDTBQj9xP+idXnUMKQ45bQkvKA+EZqoazN8nWJ4Bfor9tOk1W65CstCbAZMcy
	EwbZ4mRafOUIHxViPD9y258ro5yyITAntfa9Qz51PDujMfAEwk4xKn+tu2tlgWvTiEuJ
	vBmmKA0QQUQSpFWLazevJYfbFmzd374TDaUc3tiD/5DTV6pR+MUyIi4V5SZYta9O6nXk
	sZUFN0NCk6Fx1aIQQuTjEF4/RI9dcsDf5jQEFcFtosZm5mF+88YLqrDRtwb4iSDvxp+m
	q9z2lYjoilYYucsAUiaFoBS+vwYjKvdREeI5bkLJjajtKQaR87pnAI0I8vi1uAoAHLLU
	yzGg==
X-Gm-Message-State: APjAAAXKOTJOu3rkSA6jYLy+7xADteOm2v9GZOQF4QNbyi9qPZODbqkL
	HFjqNXU+fqqDJO/QjJQHrnx5jKcondmxm/4I0UIFvQbI
X-Google-Smtp-Source: APXvYqzWdancuyxwZM8TcLFCe3yuK9TRz0+f4vFN7RLL9Y+Z/mwwTBH0u5XOH+0neeiW7ahVMjFyt67Fgl7qXDLvQic=
X-Received: by 2002:aed:224d:: with SMTP id o13mr2298495qtc.56.1557388687333; 
	Thu, 09 May 2019 00:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
In-Reply-To: <CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Thu, 9 May 2019 15:57:24 +0800
Message-ID: <CABSdmr=fCjBCVvDPGd+B9yGXFsCak3Z+0rOXYmxRLHNZMxcxAQ@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::841
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH 1/3] ramfb enhancement
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
the display surface so that the guest memory gets properly unmaped.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
---
 hw/display/ramfb.c | 53 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 25c8ad7..c27fcc7 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -29,13 +29,50 @@ struct QEMU_PACKED RAMFBCfg {
 struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
+    hwaddr addr, length;
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
     hwaddr stride, addr, length;

@@ -49,16 +86,10 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset,
size_t len)

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
+    s->addr = addr;
+    s->length = length;
+    s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
+                                                format, stride, s->addr);
 }

 void ramfb_display_update(QemuConsole *con, RAMFBState *s)
-- 
2.17.1
