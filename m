Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC8C04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6C2217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4eiruZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6C2217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8Xs-0008VO-2n
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:38:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hP8Or-00010d-K6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hP8Oq-0003iR-4H
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:29:33 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:46331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hP8Op-0003hQ-U0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:29:32 -0400
Received: by mail-qt1-x843.google.com with SMTP id i31so7218775qti.13
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=w8JGVpuHGo+uhEjuFvHrCYkHRVhdiYlJuc2gGsqrCIA=;
	b=f4eiruZuoJLKSAbD7mZD0KnDay4EkbSaQA2/fIltAp0xDNmXVK6YNNNXcma41wIL8k
	W9B5rMw5IB7A+kqC86yheyJuoTOEwRThBgLRBJuRvpvs12MjFtVKO9WcKoRc5+9I9o/j
	zadZd5ubAMP0eCPtllBUYnzDKZBWnOcQ0Z2TfnmXmfNjZ+LxAKaHefMX0joEa+BjYVf6
	6dza8xQ/B/ES8Pmu4a88QNjqcfo7DMnMnxZuMU2Yj2BVsUU7qx/8ZPKViTEwwXr1IB0G
	UQ2yXa7nnmASO5U+XSCDeIx6yS7KcTg74qtCHQNhllgyiolQEHwl2CrmSTuhHwvbsZY/
	yp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=w8JGVpuHGo+uhEjuFvHrCYkHRVhdiYlJuc2gGsqrCIA=;
	b=YymsJz3wD8w+BfsqWWdzjG3otcIekIxrVCvAzM/7Y1la570n/2fACkKlS5WaLYk3pS
	oYmzfYr/D0t0R0M2ndqjuEjcoPIisVpx3Vs2iu7bcx0pwVlfbTWJU/zFbR3o410hYwHZ
	a204PXIdc505icC5LhFz68rkFsl1vgE1pB9y8kqY1dr1Qih8AkURBpVtgF5EqzDeoPrr
	38+Eh1Z/ULWh+WEjmg7++46KaKqPhKa9hbPusf4dhwrdA9xNp/ji99b62xCGkgSYxIVc
	G3cOxvY2NY47YbAt+SiLUbK/1kl5Dzk9KuSfMCipvd0iBfg2UA6+oU1OZkmtB6zxBiki
	WVsA==
X-Gm-Message-State: APjAAAUDYfuYGFAsWydMU9VI5P0ofI/JVjPp4v44L8Hd0zKKr2fEcWgH
	axFXdVF9R5P/DCxC8dvi/EieFMOIZASHJayFFsLOcjzj
X-Google-Smtp-Source: APXvYqz/46wYvi86q3FnjQobiOJ4keKOwdOIUyeyowyW2BtstNboCoSZK+pyT2oynSjk7WZ3pjHpEmXMvUsgw+MqKXs=
X-Received: by 2002:aed:224d:: with SMTP id o13mr10291759qtc.56.1557505768608; 
	Fri, 10 May 2019 09:29:28 -0700 (PDT)
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
	<CABSdmrnVzi5ZTF58tnt8T8=gsVe2ZNqtZKCBcbZQ9Lb+CCCkdg@mail.gmail.com>
In-Reply-To: <CABSdmrnVzi5ZTF58tnt8T8=gsVe2ZNqtZKCBcbZQ9Lb+CCCkdg@mail.gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Sat, 11 May 2019 00:29:00 +0800
Message-ID: <CABSdmrmesDkUH0ALpM-8cGtyG5qD6Rn-=6f8=7L5zX-ae8PO7w@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::843
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH v2 2/3] hw/display/ramfb: lock guest resolution
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only allow one resolution change per guest boot, which prevents a
crash when the guest writes garbage to the configuration space (e.g.
when rebooting).

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
---
 hw/display/ramfb.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 98703f7..d255ddc 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -30,6 +30,7 @@ struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
     struct RAMFBCfg cfg;
+    bool locked;
 };

 static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
@@ -72,18 +73,25 @@ static DisplaySurface
*qemu_create_displaysurface_guestmem(
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
+        fprintf(stderr, "%s: resolution locked, change rejected\n",
__func__);
+        return;
+    }
+    s->locked = true;
+    s->width = width;
+    s->height = height;
     s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
                                                 format, stride, addr);
 }
@@ -103,6 +111,13 @@ void ramfb_display_update(QemuConsole *con, RAMFBState
*s)
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
@@ -115,9 +130,12 @@ RAMFBState *ramfb_setup(Error **errp)

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
