Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3224AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F395220665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QaJXbmoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F395220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcrg-00056w-4a
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBcoA-0004Sl-7d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:44:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:32941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBco8-0004ug-7H
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598615066;
 bh=oxXS0uLCGhDa3XkMLezeWNX6IWsnVqHs90zkM3VJ5HU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=QaJXbmoI8E/YtLuiiT0ERWEGhIgVzhcRcn4bNz8A+oZZD12sPKj6TeQvlhxn3uneZ
 2Y9MnnVHv6Gpyn+gizVQ2vvfKO/3HOF+C7wcDqtoilESBR5C+GIsPhg8UcdiONKFMQ
 O/PAGvKxnRWSFqtO/y4BuDfPtdVR2mUHT05O+BPc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.181.17]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1kiTeD3P56-00bbG9; Fri, 28
 Aug 2020 13:44:25 +0200
Date: Fri, 28 Aug 2020 13:44:23 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH] hw/display/artist: Fix artist screen resolution
Message-ID: <20200828114423.GA17650@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:PD8VA0DGBwskJxx9/NORBW/aNLiHdqMrBD9hGZwzY2yl59UHeME
 GIZtyqe5u5Gibuyja+QsT2qxiyQugoVFSglcyarGhiqLXnkEzK3E1iVS+maaKYtTmNoy9u5
 UgSt+hbwQ1UdT36t+/zZGIqG9ATGepEz+d/pYwaCgVs7QWn9/XBUfcy1AsT5TyVudkxMAoP
 wKDNf5QUTzrKrYyKpS59g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ouZIApbYToE=:itbu8omB5pD9FigSrpsED7
 knLFSWA0FoZSFlNV4cawKUh3L7wFd5SBwiVo0PTmJgbiaj4PL3mq5X9J24GhmmIFRclIKCh8q
 UaZzh4K9thvxmfCf/gW1xJZpgFbtne9PZJ3VvDkN+2B0DjHs96bb3lyttCqgnB5cSvLiL78hh
 9jvCWp74fSItXuuxy7h3hEfgVU93fC3vwbWSAorfCw2+lq5WVGsHUvoJidWgeEMQ7MGEXl9iC
 lAjg4XwiiVj55HflTXdAtjU54EHwMRzxDcBVbl9HprovSmSZ0RBgCmHDVJo531H8l5Ad219QV
 pmDpxfO/Nycc2cb8PWtR5EFL3ybDnadew1dumHAveYxx0iytdkj0G51RZRf84YFVcZFfic9WN
 pPvssS/3A3O4FKHwInGmhsPWlUZE3NpidQaiXdu9b9X3zsauRRsBzXCdItgkld4EAA4BrcBBI
 KQhQkv4bfCr/0YHxRpSzj1nsxKUqn8OUj9c7d+hB3gXy2nJ5NzXHcauwyqYS3/FWcrqBEHYs1
 1p+LXQge9y88SAWGu0UhPwIHS3MglvTi/U/+JYhdQpYpdOYVffPo+5MDuJ9JMScd3UBXPrQFu
 KM+bM1aNRUsj5ItHyKMP4eVQ7Lp4V1aIMOOLzFqjWCuZW3zXGgljCzgOVjzZY9/PNUCcZ5vDp
 Vs8D3gR87udDISuMWWmHyQ6FiGs2zNSwouTe4+utDCb5U8Id8JhBmyMtRhxhNhHzCy/IOkIYz
 4jmAVnLSuH81jfURtsyCKdnH2yndVDD23Quexnz2kyfPjYakAr/vsDhuVwnpVda0orXrUjUkt
 KJwhF9+8XQvkhxzaPust+8+IBQvYJaGHKxLP+quZkJLDde7A6rWeRnYZ336OqFhekxD52nDcE
 v3yk5PUEiM4H6xlERnSdUx6iGw0//GceiA5tZ1tsVjjZSrDSwi0JenD6LRHpE+0LsLVUEYwct
 ukU+g38HihII+tFsgd4M6Zu2cxv7t1lCRvn9toVo3VDWfZgFeY0McPX7Z9FE0T7FT/KUqx57d
 gvTVahVkbRW0Ul9bShLuDIGoB98wZsRCyKUpgZn3hOySubqOtt6LP8Tw0RpMYw8AYw8RZq9AU
 +AK3xnSqZVSbBWjlE47unfKU7il5fFfL0SVBwUujcobBr6EPM/1PVantmhi/WA5hoEahtPBDr
 wSGiyKpcn6eruySZMlQXe+9pNOl5CYK0bPwkT7ORIwqizc2nr4E0r985XfDfbOvqvVZ4OiIyN
 OtvXg7/6oXXDnuF36
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 07:44:32
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
Cc: Sven Schnelle <svens@stackframe.org>
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


