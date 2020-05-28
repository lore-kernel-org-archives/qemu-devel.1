Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18255C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D084F206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoDBnqZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D084F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHsB-0006xZ-0x
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlx-0001nN-CY
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29032
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlr-0005CI-Jw
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=U+5RcqhQF93azu6HDbQUS5nmpDhF+70aIhMKbYU+HeM=;
 b=GoDBnqZJ6rtBT1Qw+UBvB0yYd2bGxbH/XRTWXf9cl0FHmMtXKxuIbiKaGnvHMSLeHJ7De7
 FXAOtpkopv07BEXPjBPKsvrQ7/22GAQbgT7g4OZyjZdlkU0oKykIpxnWgOHcCFNgIUg1Z0
 GTkbHLohYXI+xCLNqqtBbh4NnOMIesc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-VC4AfOvgMHetBxeGS40qpQ-1; Thu, 28 May 2020 08:36:21 -0400
X-MC-Unique: VC4AfOvgMHetBxeGS40qpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D2B2107ACF7;
 Thu, 28 May 2020 12:36:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5555A10013C0;
 Thu, 28 May 2020 12:36:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EC7C09D68; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] sm501: Shorten long variable names in sm501_2d_operation
Date: Thu, 28 May 2020 14:36:04 +0200
Message-Id: <20200528123609.27362-17-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

This increases readability and cleans up some confusing naming.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: b9b67b94c46e945252a73c77dfd117132c63c4fb.1590089984.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index bd3ccfe311c8..f42d05e1e4b2 100644
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
2.18.4


