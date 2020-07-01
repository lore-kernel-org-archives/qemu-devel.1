Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23320C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EAC206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7KlvTlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EAC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeP8-0006VG-5G
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHy-0003L9-Ew
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHt-0001Bw-T1
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=s9lpJ0X/aEDgG6zO8jjDhK3MgGP15i17mBr3cXrA6fE=;
 b=I7KlvTlClNa4RFeN8dF3WvG/xpA78pC1zTBhJ5G0SLPhMOjiDRZTNWP95wUJgMSlIqiin0
 Of5+7SIMRQlypbqSF36XgBX9l0rd6O0QlcBCp11/5r+PwnlRBoF318ZcwTKaPMe+F3YdGA
 Jir0/uGbLNCdBOhBgtUZJXJ10drvnH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-XcFhm0bFNd6yRB7GfXDEPw-1; Wed, 01 Jul 2020 11:04:33 -0400
X-MC-Unique: XcFhm0bFNd6yRB7GfXDEPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D886B7BAD;
 Wed,  1 Jul 2020 15:04:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B72610013C0;
 Wed,  1 Jul 2020 15:04:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6B9AA45BD; Wed,  1 Jul 2020 17:04:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] sm501: Introduce variable for commonly used value for
 better readability
Date: Wed,  1 Jul 2020 17:04:16 +0200
Message-Id: <20200701150425.13739-5-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
References: <20200701150425.13739-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

The bytes per pixel value can be calculated from format but it's used
freqently enough (and will be used more in subseqent patches) so store
it in a variable for better readabilty. Also drop some unneded 0x
prefix around where new variable is defined.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: b9ea5ef2d68583db9f3fb73a2b859abbd7c044a8.1592686588.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index ad5a62bfab1b..3ced2c42db3a 100644
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
2.18.4


