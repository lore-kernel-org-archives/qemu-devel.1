Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23234C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA28A20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA28A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrHL-0003vC-0j
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGP-0002D1-9F
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:40489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGM-0007ac-SK
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AC0E0748DCD;
 Thu, 21 May 2020 21:53:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 613C9748DCA; Thu, 21 May 2020 21:53:43 +0200 (CEST)
Message-Id: <ae59f8138afe7f6a5a4a82539d0f61496a906b06.1590089984.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1590089984.git.balaton@eik.bme.hu>
References: <cover.1590089984.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 4/7] sm501: Clean up local variables in sm501_2d_operation
Date: Thu, 21 May 2020 21:39:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make variables local to the block they are used in to make it clearer
which operation they are needed for.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/display/sm501.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 97660090bb..5ed57703d8 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -699,28 +699,19 @@ static inline void hwc_invalidate(SM501State *s, int crt)
 
 static void sm501_2d_operation(SM501State *s)
 {
-    /* obtain operation parameters */
     int cmd = (s->twoD_control >> 16) & 0x1F;
     int rtl = s->twoD_control & BIT(27);
-    int src_x = (s->twoD_source >> 16) & 0x01FFF;
-    int src_y = s->twoD_source & 0xFFFF;
-    int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
-    int dst_y = s->twoD_destination & 0xFFFF;
-    int width = (s->twoD_dimension >> 16) & 0x1FFF;
-    int height = s->twoD_dimension & 0xFFFF;
-    uint32_t color = s->twoD_foreground;
     int format = (s->twoD_stretch >> 20) & 0x3;
     int rop_mode = (s->twoD_control >> 15) & 0x1; /* 1 for rop2, else rop3 */
     /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
     int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
     int rop = s->twoD_control & 0xFF;
-    uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
+    int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
+    int dst_y = s->twoD_destination & 0xFFFF;
+    int width = (s->twoD_dimension >> 16) & 0x1FFF;
+    int height = s->twoD_dimension & 0xFFFF;
     uint32_t dst_base = s->twoD_destination_base & 0x03FFFFFF;
-
-    /* get frame buffer info */
-    uint8_t *src = s->local_mem + src_base;
     uint8_t *dst = s->local_mem + dst_base;
-    int src_pitch = s->twoD_pitch & 0x1FFF;
     int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
@@ -758,6 +749,13 @@ static void sm501_2d_operation(SM501State *s)
 
     switch (cmd) {
     case 0x00: /* copy area */
+    {
+        int src_x = (s->twoD_source >> 16) & 0x01FFF;
+        int src_y = s->twoD_source & 0xFFFF;
+        uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
+        uint8_t *src = s->local_mem + src_base;
+        int src_pitch = s->twoD_pitch & 0x1FFF;
+
 #define COPY_AREA(_bpp, _pixel_type, rtl) {                                   \
         int y, x, index_d, index_s;                                           \
         for (y = 0; y < height; y++) {                              \
@@ -793,8 +791,11 @@ static void sm501_2d_operation(SM501State *s)
             break;
         }
         break;
-
+    }
     case 0x01: /* fill rectangle */
+    {
+        uint32_t color = s->twoD_foreground;
+
 #define FILL_RECT(_bpp, _pixel_type) {                                      \
         int y, x;                                                           \
         for (y = 0; y < height; y++) {                            \
@@ -819,7 +820,7 @@ static void sm501_2d_operation(SM501State *s)
             break;
         }
         break;
-
+    }
     default:
         qemu_log_mask(LOG_UNIMP, "sm501: not implemented 2D operation: %d\n",
                       cmd);
-- 
2.21.3


