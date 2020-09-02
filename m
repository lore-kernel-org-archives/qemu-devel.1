Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC480C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78882207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UKOv8DCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78882207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYzN-0002hD-GX
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXe-000660-Kn
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:60495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXM-0002oW-Eo
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075301;
 bh=dAT+xmixHlyCM5vhxOQn/199sB671mBOmKjg6wYsGFc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UKOv8DCd3PddIWDVfzklvUGMMZu5Wns9sq+5E6Jum7sffiQ1OQvq0AB/yG2Lp/7ht
 NAc+sZDn194bWQjTZlqFFs5zA0UNAfohWK9UuQ99NkLD+Dg/s6wIGhMU+s+F/72Pki
 iGHaGNPvS7CUQqzTdRQdEyye/GGpnKxKdZT/l72g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1kDHPw2449-000NkZ; Wed, 02
 Sep 2020 21:35:01 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] hw/display/artist: Fix artist screen resolution
Date: Wed,  2 Sep 2020 21:34:55 +0200
Message-Id: <20200902193456.29844-8-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200902193456.29844-1-deller@gmx.de>
References: <20200902193456.29844-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KvOKN0dbeCHv0A8n8dw6wiHw4A4pmBgI7v09TM2k7c6muTR/MJG
 y/YrpfQUdDplmNATOWTXdv3WsIkRPlr4ks/oEyJYvmGKzLw5YFlqaBaD35en79KY2yXVRCI
 Kowa9b6o6miFexWca8H5c0DiNY6aL3k1gvw3/6K4K38AMJARdqeTbpkT2Pa8O2nAS6RsoBP
 8AEQYGqgcIJrmYJutKnBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8cGkGN/Q+w=:4FGW+WLxhePidVyzWaTCtO
 SD2d3SNvtrVVNWkeSeCGSTqbhlr+Fm3PDD6c/p2dX8vWQhlTangHCGyBlNRok/DBYxMuwMqj0
 McTlYw+MHYI9aAMicxZ+33nqHgftwBL55xpvRaZX0/pZO1nRNXZNsCkmdOmUEgycUczhJz4Ie
 a6xPnw8SfwHudSKkGbJ/YXRyzqFmZi0rHj7L+5Dbo/0QUlEPTl6DhlAeSeh0ofC2A+YUIfSyj
 e5qGNe4fMJV99jyMbfRBT1Ii0R1yFZmrg+lv078W/ootmVvt+Sd7XhC3qvdI99ye8J6oaVG88
 +HNC2csbSyaXZtYQ/Y4kNRxDibYtvC8oyUXUDsRmZ3Cwvm4znHy+zutEeVXEt/fWo7Sd9L1kg
 y/dHBRHVDx1VkSqdQvoHyKhpqMa3rVoJI0Xg/ppzlJNi7xFsgZeP6mAsqRluWWQJRazPDA7Rm
 Gf6ohh7Cr/F0JnKpJfTfE0WUI2MbGQWDxCcakRLv2AZnN3N2or7xj+7vAkmC4dvPZfa4TG8NA
 M+Hzb8g8Yt8TQwAN6yhagD0WG4culijyEXLd/UroyEL6hn729XodbqHMyM6x5hNLS9QEHx4pZ
 8fQgjN3l5WzHY/alKl2C5FAekRpZ3LR3TZxKeHrLH0fxiE1p+lt4JoARTNucIdYl5lY/URMQG
 Uy+mFVoA9xkXkgEWoIQyfqYWA4CH6LONRUzg8UEdI+TO0pQ87T6bmQyyMBIb9kMFqt939jIPK
 UPyx9IxSQslOa80haaWK6hv/qK8ULSvHVtO2a0AMkHQucO9cy2nWB5qh2P1ZWxt+zuikEb6kr
 iX3iz+3/tceES3FMNnOeZlyl9J6dkp7HJNvOXvuHQF35O8v4d04jELLepRz0mxD6r1QggeKRb
 IfhPVa5ur2aRB8T1HSVj3e9gLmsaQa3QmcLKf//Htlj+FrfCTY8U54Bq/G4YHOogOPLQEkgDo
 /FPhB/vedzeRKlEgu1Y0HSoynzvXbY1ULdYPu1VfIY9YhFAS3NR+H9EtNegSddLkJjAXqDneN
 borsEA37S4EBo3DawHG4+NwMWKdw1bmwhtiyuNO3OPJ+WXN9/A3ceqKa88Cu+qHdFsEK9HC9Y
 raKauv6Fysq2/j8isHzCarQuEnvrWBJAzBrcSYoa5/Z43ZU/Ajp9B2D6FRTnDzk25QvphZrxZ
 AWYUe4Kb9JDegknAka35oIPfFJXWf6IsAPLm58OPAkpoqEOLd9i/aG5yVNo8V/TycljRshevY
 3fLKKnzuHeHhvxlo0
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Artist screen size is limited to 2048 x 2048 pixels and x/y coordination
addressing needs to be done by OS via an uint32 value which is based on
a 2048 byte line length, independend of the real screen size.

Since HP-UX seems to ideally need at least 640 pixels in width, this
patch ensures that the screen size stays between 640x480 and 2048x2048
pixels and fixes some pixel glitches were visible before on STI text
consoles due to the 2048 line length limitation.

Cc: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 71982559c6..98bee6d61c 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -192,6 +192,10 @@ static const char *artist_reg_name(uint64_t addr)
 }
 #undef REG_NAME

+/* artist has a fixed line length of 2048 bytes. */
+#define ADDR_TO_Y(addr) (((addr) >> 11) & 0x7ff)
+#define ADDR_TO_X(addr) ((addr) & 0x7ff)
+
 static int16_t artist_get_x(uint32_t reg)
 {
     return reg >> 16;
@@ -348,13 +352,13 @@ static void artist_invalidate_cursor(ARTISTState *s)
                             y, s->cursor_height);
 }

-static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_=
x,
+static void vram_bit_write(ARTISTState *s, int posy, bool incr_x,
                            int size, uint32_t data)
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask =3D s->vram_bitmask;
     int mask, i, pix_count, pix_length;
-    unsigned int offset, width;
+    unsigned int posx, offset, width;
     uint8_t *data8, *p;

     pix_count =3D vram_write_pix_per_transfer(s);
@@ -366,6 +370,8 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
     if (s->cmap_bm_access) {
         offset =3D s->vram_pos;
     } else {
+        posx =3D ADDR_TO_X(s->vram_pos >> 2);
+        posy +=3D ADDR_TO_Y(s->vram_pos >> 2);
         offset =3D posy * width + posx;
     }

@@ -858,7 +864,6 @@ static void artist_reg_write(void *opaque, hwaddr addr=
, uint64_t val,
                              unsigned size)
 {
     ARTISTState *s =3D opaque;
-    int posx, posy;
     int width, height;

     trace_artist_reg_write(size, addr, artist_reg_name(addr & ~3ULL), val=
);
@@ -881,16 +886,12 @@ static void artist_reg_write(void *opaque, hwaddr ad=
dr, uint64_t val,
         break;

     case VRAM_WRITE_INCR_Y:
-        posx =3D (s->vram_pos >> 2) & 0x7ff;
-        posy =3D (s->vram_pos >> 13) & 0x3ff;
-        vram_bit_write(s, posx, posy + s->vram_char_y++, false, size, val=
);
+        vram_bit_write(s, s->vram_char_y++, false, size, val);
         break;

     case VRAM_WRITE_INCR_X:
     case VRAM_WRITE_INCR_X2:
-        posx =3D (s->vram_pos >> 2) & 0x7ff;
-        posy =3D (s->vram_pos >> 13) & 0x3ff;
-        vram_bit_write(s, posx, posy + s->vram_char_y, true, size, val);
+        vram_bit_write(s, s->vram_char_y, true, size, val);
         break;

     case VRAM_IDX:
@@ -1156,8 +1157,7 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
 {
     ARTISTState *s =3D opaque;
     struct vram_buffer *buf;
-    int posy =3D (addr >> 11) & 0x3ff;
-    int posx =3D addr & 0x7ff;
+    unsigned int posy, posx;
     unsigned int offset;
     trace_artist_vram_write(size, addr, val);

@@ -1170,6 +1170,9 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
     }

     buf =3D vram_write_buffer(s);
+    posy =3D ADDR_TO_Y(addr);
+    posx =3D ADDR_TO_X(addr);
+
     if (!buf->size) {
         return;
     }
@@ -1212,7 +1215,7 @@ static uint64_t artist_vram_read(void *opaque, hwadd=
r addr, unsigned size)
     ARTISTState *s =3D opaque;
     struct vram_buffer *buf;
     uint64_t val;
-    int posy, posx;
+    unsigned int posy, posx;

     if (s->cmap_bm_access) {
         buf =3D &s->vram_buffer[ARTIST_BUFFER_CMAP];
@@ -1229,8 +1232,8 @@ static uint64_t artist_vram_read(void *opaque, hwadd=
r addr, unsigned size)
         return 0;
     }

-    posy =3D (addr >> 13) & 0x3ff;
-    posx =3D (addr >> 2) & 0x7ff;
+    posy =3D ADDR_TO_Y(addr);
+    posx =3D ADDR_TO_X(addr);

     if (posy > buf->height || posx > buf->width) {
         return 0;
@@ -1374,6 +1377,12 @@ static void artist_realizefn(DeviceState *dev, Erro=
r **errp)
     struct vram_buffer *buf;
     hwaddr offset =3D 0;

+    /* Screen on artist can not be greater than 2048x2048 pixels. */
+    s->width =3D MAX(s->width, 640);
+    s->width =3D MIN(s->width, 2048);
+    s->height =3D MAX(s->height, 480);
+    s->height =3D MIN(s->height, 2048);
+
     memory_region_init(&s->mem_as_root, OBJECT(dev), "artist", ~0ull);
     address_space_init(&s->as, &s->mem_as_root, "artist");

=2D-
2.21.3


