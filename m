Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F3FC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43611246B6
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43611246B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkmu-0001CZ-Jf
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 17:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmkfO-0005Gf-81
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:04:46 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:31473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmkfL-0001g8-8s
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:04:45 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2A2A1748DDF;
 Sat, 20 Jun 2020 23:04:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CEB7B748DC8; Sat, 20 Jun 2020 23:04:32 +0200 (CEST)
Message-Id: <b9ea5ef2d68583db9f3fb73a2b859abbd7c044a8.1592686588.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592686588.git.balaton@eik.bme.hu>
References: <cover.1592686588.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 4/9] sm501: Introduce variable for commonly used value for
 better readability
Date: Sat, 20 Jun 2020 22:56:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 17:04:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The bytes per pixel value can be calculated from format but it's used
freqently enough (and will be used more in subseqent patches) so store
it in a variable for better readabilty. Also drop some unneded 0x
prefix around where new variable is defined.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index ad5a62bfab..3ced2c42db 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -684,10 +684,11 @@ static void sm501_2d_operation(SM501State *s)
 {
     int cmd = (s->twoD_control >> 16) & 0x1F;
     int rtl = s->twoD_control & BIT(27);
-    int format = (s->twoD_stretch >> 20) & 0x3;
-    int rop_mode = (s->twoD_control >> 15) & 0x1; /* 1 for rop2, else rop3 */
+    int format = (s->twoD_stretch >> 20) & 3;
+    int bypp = 1 << format; /* bytes per pixel */
+    int rop_mode = (s->twoD_control >> 15) & 1; /* 1 for rop2, else rop3 */
     /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
-    int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
+    int rop2_source_is_pattern = (s->twoD_control >> 14) & 1;
     int rop = s->twoD_control & 0xFF;
     unsigned int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
     unsigned int dst_y = s->twoD_destination & 0xFFFF;
@@ -724,8 +725,8 @@ static void sm501_2d_operation(SM501State *s)
     }
 
     if (dst_base >= get_local_mem_size(s) ||
-        dst_base + (dst_x + width + (dst_y + height) * dst_pitch) *
-        (1 << format) >= get_local_mem_size(s)) {
+        dst_base + (dst_x + width + (dst_y + height) * dst_pitch) * bypp >=
+        get_local_mem_size(s)) {
         qemu_log_mask(LOG_GUEST_ERROR, "sm501: 2D op dest is outside vram.\n");
         return;
     }
@@ -750,8 +751,8 @@ static void sm501_2d_operation(SM501State *s)
         }
 
         if (src_base >= get_local_mem_size(s) ||
-            src_base + (src_x + width + (src_y + height) * src_pitch) *
-            (1 << format) >= get_local_mem_size(s)) {
+            src_base + (src_x + width + (src_y + height) * src_pitch) * bypp >=
+            get_local_mem_size(s)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "sm501: 2D op src is outside vram.\n");
             return;
@@ -763,8 +764,8 @@ static void sm501_2d_operation(SM501State *s)
             uint8_t *d = s->local_mem + dst_base;
 
             for (y = 0; y < height; y++) {
-                i = (dst_x + (dst_y + y) * dst_pitch) * (1 << format);
-                for (x = 0; x < width; x++, i += (1 << format)) {
+                i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
+                for (x = 0; x < width; x++, i += bypp) {
                     switch (format) {
                     case 0:
                         d[i] = ~d[i];
@@ -801,7 +802,7 @@ static void sm501_2d_operation(SM501State *s)
             de = db + width + height * (width + dst_pitch);
             if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
                 /* regions may overlap: copy via temporary */
-                int llb = width * (1 << format);
+                int llb = width * bypp;
                 int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
                 uint32_t *tmp = tmp_buf;
 
@@ -809,13 +810,13 @@ static void sm501_2d_operation(SM501State *s)
                     tmp = g_malloc(tmp_stride * sizeof(uint32_t) * height);
                 }
                 pixman_blt((uint32_t *)&s->local_mem[src_base], tmp,
-                           src_pitch * (1 << format) / sizeof(uint32_t),
-                           tmp_stride, 8 * (1 << format), 8 * (1 << format),
+                           src_pitch * bypp / sizeof(uint32_t),
+                           tmp_stride, 8 * bypp, 8 * bypp,
                            src_x, src_y, 0, 0, width, height);
                 pixman_blt(tmp, (uint32_t *)&s->local_mem[dst_base],
                            tmp_stride,
-                           dst_pitch * (1 << format) / sizeof(uint32_t),
-                           8 * (1 << format), 8 * (1 << format),
+                           dst_pitch * bypp / sizeof(uint32_t),
+                           8 * bypp, 8 * bypp,
                            0, 0, dst_x, dst_y, width, height);
                 if (tmp != tmp_buf) {
                     g_free(tmp);
@@ -823,9 +824,9 @@ static void sm501_2d_operation(SM501State *s)
             } else {
                 pixman_blt((uint32_t *)&s->local_mem[src_base],
                            (uint32_t *)&s->local_mem[dst_base],
-                           src_pitch * (1 << format) / sizeof(uint32_t),
-                           dst_pitch * (1 << format) / sizeof(uint32_t),
-                           8 * (1 << format), 8 * (1 << format),
+                           src_pitch * bypp / sizeof(uint32_t),
+                           dst_pitch * bypp / sizeof(uint32_t),
+                           8 * bypp, 8 * bypp,
                            src_x, src_y, dst_x, dst_y, width, height);
             }
         }
@@ -842,8 +843,8 @@ static void sm501_2d_operation(SM501State *s)
         }
 
         pixman_fill((uint32_t *)&s->local_mem[dst_base],
-                    dst_pitch * (1 << format) / sizeof(uint32_t),
-                    8 * (1 << format), dst_x, dst_y, width, height, color);
+                    dst_pitch * bypp / sizeof(uint32_t),
+                    8 * bypp, dst_x, dst_y, width, height, color);
         break;
     }
     default:
@@ -855,7 +856,7 @@ static void sm501_2d_operation(SM501State *s)
     if (dst_base >= get_fb_addr(s, crt) &&
         dst_base <= get_fb_addr(s, crt) + fb_len) {
         int dst_len = MIN(fb_len, ((dst_y + height - 1) * dst_pitch +
-                          dst_x + width) * (1 << format));
+                          dst_x + width) * bypp);
         if (dst_len) {
             memory_region_set_dirty(&s->local_mem_region, dst_base, dst_len);
         }
-- 
2.21.3


