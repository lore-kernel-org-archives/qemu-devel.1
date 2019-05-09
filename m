Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C32C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4DD21019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Idm40ZQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4DD21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49923 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOdyD-0001AA-8w
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:00:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdwY-0000E1-GE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdwX-0003Jj-0o
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:18 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:46633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hOdwW-0003I0-Re
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:58:16 -0400
Received: by mail-qt1-x842.google.com with SMTP id i31so1410610qti.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ofYZnXkq9AIzxx6Z+rKf+A5KazjB+BX5nLM6FV2QKxs=;
	b=Idm40ZQVCMsNOHl/spdS3iSXU5WBJHJiTPMoMnjQsrNaFsR0LkwiudHFdEWZDZJFH0
	sGTb8kgn6iXOwOFswJTtyek/jArYqcm1OEbHSBFNQnZqbA4XgGTwsi+Gf03nFSxT1fEk
	8Xq9xaLkP2eVSRWplZa5qnrmlzGqMWANV/aoRHx8i2VmS2aqeGUKK7/AGbvCU9NXks2t
	ePpH9jP6DXCuqAKAT1eTAlbVPR+1Q6Onesw5slOnLazAqsSiIfBsYYrYkYH2vdKcTgfk
	JyAJ95qfmh/cU15PGCHQABAtFNhkr9Kg3w+YrTeIHPx3zA7PwlaLVt3A/t+DyyrkRYhN
	dPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ofYZnXkq9AIzxx6Z+rKf+A5KazjB+BX5nLM6FV2QKxs=;
	b=EDQQ2dFfqcOg3p5O6zF+9xBB/fFQ7A1lLPs7n9ZJKPD4IPVlCtQnPvNzl4Xn0wDyzh
	5pfmktsFAgu9BJegGVOrEKPrUk7Lvuel0Wr87KXCC0Ys6w9KdVHjA95Q0hVTcA12ObW0
	koHHDhExwG68/vD9Lcq6dVAaP1sBNS89fKm22u/WgliDIHe008qZ4gV9y/F1OyPeVH4T
	AevrIEPXE9INlrgla3IVmnPN0f8y4Ad7yvYM8hiXHs7IvnaALi0Y1PL2prYtaVDoItpw
	UdE4qb5APOzT+1JX2xE3l8lzdEOVGdN21iAEUDp8QDekwSifuak7DGc0TDD51RhVScNV
	3T3Q==
X-Gm-Message-State: APjAAAXAgBr91YsQurpWtVTvxTN+SixN7lr++GUySFpBsynBJGdRfBJL
	dlgNu3P9RpfkpKD7SGO0mHPCKvHuJVsYyCDZJ0OF/xzE
X-Google-Smtp-Source: APXvYqzh8+GQV3dOX0L/CwBBJyeEqFQWADQyyhUB+cLFJC4Xpr//INIqZlKQbEAQPhQUg6Y2SPgMigOmissSNGC39cM=
X-Received: by 2002:a0c:b64c:: with SMTP id q12mr2370107qvf.50.1557388696225; 
	Thu, 09 May 2019 00:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
In-Reply-To: <CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Thu, 9 May 2019 15:58:02 +0800
Message-ID: <CABSdmrn073Y6UTbbgs00y5-DCdF1ROK9zAg5JURD4SoUZAk2Mw@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] [PATCH 2/3] ramfb enhancement
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
index c27fcc7..fa6296b 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -31,6 +31,7 @@ struct RAMFBState {
     uint32_t width, height;
     hwaddr addr, length;
     struct RAMFBCfg cfg;
+    bool locked;
 };

 static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
@@ -73,11 +74,11 @@ static DisplaySurface
*qemu_create_displaysurface_guestmem(
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s = dev;
-    uint32_t fourcc, format;
+    uint32_t fourcc, format, width, height;
     hwaddr stride, addr, length;

-    s->width  = be32_to_cpu(s->cfg.width);
-    s->height = be32_to_cpu(s->cfg.height);
+    width     = be32_to_cpu(s->cfg.width);
+    height    = be32_to_cpu(s->cfg.height);
     stride    = be32_to_cpu(s->cfg.stride);
     fourcc    = be32_to_cpu(s->cfg.fourcc);
     addr      = be64_to_cpu(s->cfg.addr);
@@ -85,9 +86,16 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset,
size_t len)
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
     s->addr = addr;
     s->length = length;
+    s->width = width;
+    s->height = height;
     s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
                                                 format, stride, s->addr);
 }
@@ -107,6 +115,13 @@ void ramfb_display_update(QemuConsole *con, RAMFBState
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
@@ -119,9 +134,12 @@ RAMFBState *ramfb_setup(Error **errp)

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
