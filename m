Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FFDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C84F20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C84F20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrHL-0003uh-Ea
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGO-0002D7-Rh
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:57709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGM-0007ah-Dq
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DBDDA748DD9;
 Thu, 21 May 2020 21:53:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 58A6774633F; Thu, 21 May 2020 21:53:43 +0200 (CEST)
Message-Id: <b9b67b94c46e945252a73c77dfd117132c63c4fb.1590089984.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1590089984.git.balaton@eik.bme.hu>
References: <cover.1590089984.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 2/7] sm501: Shorten long variable names in
 sm501_2d_operation
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

This increases readability and cleans up some confusing naming.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index bd3ccfe311..f42d05e1e4 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -700,17 +700,16 @@ static inline void hwc_invalidate(SM501State *s, int crt)
 static void sm501_2d_operation(SM501State *s)
 {
     /* obtain operation parameters */
-    int operation = (s->twoD_control >> 16) & 0x1f;
+    int cmd = (s->twoD_control >> 16) & 0x1F;
     int rtl = s->twoD_control & 0x8000000;
     int src_x = (s->twoD_source >> 16) & 0x01FFF;
     int src_y = s->twoD_source & 0xFFFF;
     int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
     int dst_y = s->twoD_destination & 0xFFFF;
-    int operation_width = (s->twoD_dimension >> 16) & 0x1FFF;
-    int operation_height = s->twoD_dimension & 0xFFFF;
+    int width = (s->twoD_dimension >> 16) & 0x1FFF;
+    int height = s->twoD_dimension & 0xFFFF;
     uint32_t color = s->twoD_foreground;
-    int format_flags = (s->twoD_stretch >> 20) & 0x3;
-    int addressing = (s->twoD_stretch >> 16) & 0xF;
+    int format = (s->twoD_stretch >> 20) & 0x3;
     int rop_mode = (s->twoD_control >> 15) & 0x1; /* 1 for rop2, else rop3 */
     /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
     int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
@@ -721,12 +720,12 @@ static void sm501_2d_operation(SM501State *s)
     /* get frame buffer info */
     uint8_t *src = s->local_mem + src_base;
     uint8_t *dst = s->local_mem + dst_base;
-    int src_width = s->twoD_pitch & 0x1FFF;
-    int dst_width = (s->twoD_pitch >> 16) & 0x1FFF;
+    int src_pitch = s->twoD_pitch & 0x1FFF;
+    int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
 
-    if (addressing != 0x0) {
+    if ((s->twoD_stretch >> 16) & 0xF) {
         qemu_log_mask(LOG_UNIMP, "sm501: only XY addressing is supported.\n");
         return;
     }
@@ -758,20 +757,20 @@ static void sm501_2d_operation(SM501State *s)
         return;
     }
 
-    switch (operation) {
+    switch (cmd) {
     case 0x00: /* copy area */
 #define COPY_AREA(_bpp, _pixel_type, rtl) {                                   \
         int y, x, index_d, index_s;                                           \
-        for (y = 0; y < operation_height; y++) {                              \
-            for (x = 0; x < operation_width; x++) {                           \
+        for (y = 0; y < height; y++) {                              \
+            for (x = 0; x < width; x++) {                           \
                 _pixel_type val;                                              \
                                                                               \
                 if (rtl) {                                                    \
-                    index_s = ((src_y - y) * src_width + src_x - x) * _bpp;   \
-                    index_d = ((dst_y - y) * dst_width + dst_x - x) * _bpp;   \
+                    index_s = ((src_y - y) * src_pitch + src_x - x) * _bpp;   \
+                    index_d = ((dst_y - y) * dst_pitch + dst_x - x) * _bpp;   \
                 } else {                                                      \
-                    index_s = ((src_y + y) * src_width + src_x + x) * _bpp;   \
-                    index_d = ((dst_y + y) * dst_width + dst_x + x) * _bpp;   \
+                    index_s = ((src_y + y) * src_pitch + src_x + x) * _bpp;   \
+                    index_d = ((dst_y + y) * dst_pitch + dst_x + x) * _bpp;   \
                 }                                                             \
                 if (rop_mode == 1 && rop == 5) {                              \
                     /* Invert dest */                                         \
@@ -783,7 +782,7 @@ static void sm501_2d_operation(SM501State *s)
             }                                                                 \
         }                                                                     \
     }
-        switch (format_flags) {
+        switch (format) {
         case 0:
             COPY_AREA(1, uint8_t, rtl);
             break;
@@ -799,15 +798,15 @@ static void sm501_2d_operation(SM501State *s)
     case 0x01: /* fill rectangle */
 #define FILL_RECT(_bpp, _pixel_type) {                                      \
         int y, x;                                                           \
-        for (y = 0; y < operation_height; y++) {                            \
-            for (x = 0; x < operation_width; x++) {                         \
-                int index = ((dst_y + y) * dst_width + dst_x + x) * _bpp;   \
+        for (y = 0; y < height; y++) {                            \
+            for (x = 0; x < width; x++) {                         \
+                int index = ((dst_y + y) * dst_pitch + dst_x + x) * _bpp;   \
                 *(_pixel_type *)&dst[index] = (_pixel_type)color;           \
             }                                                               \
         }                                                                   \
     }
 
-        switch (format_flags) {
+        switch (format) {
         case 0:
             FILL_RECT(1, uint8_t);
             break;
@@ -824,14 +823,14 @@ static void sm501_2d_operation(SM501State *s)
 
     default:
         qemu_log_mask(LOG_UNIMP, "sm501: not implemented 2D operation: %d\n",
-                      operation);
+                      cmd);
         return;
     }
 
     if (dst_base >= get_fb_addr(s, crt) &&
         dst_base <= get_fb_addr(s, crt) + fb_len) {
-        int dst_len = MIN(fb_len, ((dst_y + operation_height - 1) * dst_width +
-                           dst_x + operation_width) * (1 << format_flags));
+        int dst_len = MIN(fb_len, ((dst_y + height - 1) * dst_pitch +
+                          dst_x + width) * (1 << format));
         if (dst_len) {
             memory_region_set_dirty(&s->local_mem_region, dst_base, dst_len);
         }
-- 
2.21.3


