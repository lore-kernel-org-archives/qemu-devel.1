Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E09C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95EF208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95EF208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsWh-0008Vo-De
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iAsSg-0003r8-Du
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iAsSe-0003RA-3u
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iAsSd-0003QT-Sb
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB4D2307D853
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:10:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3639819C6A;
 Thu, 19 Sep 2019 09:10:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 862CD17538; Thu, 19 Sep 2019 11:10:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 11:10:43 +0200
Message-Id: <20190919091043.24503-3-kraxel@redhat.com>
In-Reply-To: <20190919091043.24503-1-kraxel@redhat.com>
References: <20190919091043.24503-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 19 Sep 2019 09:10:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] ati: use vga_read_byte in ati_cursor_define
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes sure reads are confined to vga video memory.

v3: use uint32_t, fix cut+paste bug.
v2: fix ati_cursor_draw_line too.

Reported-by: xu hang <flier_m@outlook.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190917111441.27405-3-kraxel@redhat.com
---
 hw/display/ati.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8f940eee221a..db3b2543163f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "ati_int.h"
 #include "ati_regs.h"
+#include "vga-access.h"
 #include "hw/qdev-properties.h"
 #include "vga_regs.h"
 #include "qemu/log.h"
@@ -135,19 +136,19 @@ static void ati_vga_switch_mode(ATIVGAState *s)
 static void ati_cursor_define(ATIVGAState *s)
 {
     uint8_t data[1024];
-    uint8_t *src;
+    uint32_t srcoff;
     int i, j, idx =3D 0;
=20
     if ((s->regs.cur_offset & BIT(31)) || s->cursor_guest_mode) {
         return; /* Do not update cursor if locked or rendered by guest *=
/
     }
     /* FIXME handle cur_hv_offs correctly */
-    src =3D s->vga.vram_ptr + s->regs.cur_offset -
-          (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) *=
 16;
+    srcoff =3D s->regs.cur_offset -
+        (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 1=
6;
     for (i =3D 0; i < 64; i++) {
         for (j =3D 0; j < 8; j++, idx++) {
-            data[idx] =3D src[i * 16 + j];
-            data[512 + idx] =3D src[i * 16 + j + 8];
+            data[idx] =3D vga_read_byte(&s->vga, srcoff + i * 16 + j);
+            data[512 + idx] =3D vga_read_byte(&s->vga, srcoff + i * 16 +=
 j + 8);
         }
     }
     if (!s->cursor) {
@@ -189,7 +190,7 @@ static void ati_cursor_invalidate(VGACommonState *vga=
)
 static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int sc=
r_y)
 {
     ATIVGAState *s =3D container_of(vga, ATIVGAState, vga);
-    uint8_t *src;
+    uint32_t srcoff;
     uint32_t *dp =3D (uint32_t *)d;
     int i, j, h;
=20
@@ -199,13 +200,13 @@ static void ati_cursor_draw_line(VGACommonState *vg=
a, uint8_t *d, int scr_y)
         return;
     }
     /* FIXME handle cur_hv_offs correctly */
-    src =3D s->vga.vram_ptr + s->cursor_offset + (scr_y - vga->hw_cursor=
_y) * 16;
+    srcoff =3D s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
     dp =3D &dp[vga->hw_cursor_x];
     h =3D ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
     for (i =3D 0; i < 8; i++) {
         uint32_t color;
-        uint8_t abits =3D src[i];
-        uint8_t xbits =3D src[i + 8];
+        uint8_t abits =3D vga_read_byte(vga, srcoff + i);
+        uint8_t xbits =3D vga_read_byte(vga, srcoff + i + 8);
         for (j =3D 0; j < 8; j++, abits <<=3D 1, xbits <<=3D 1) {
             if (abits & BIT(7)) {
                 if (xbits & BIT(7)) {
--=20
2.18.1


