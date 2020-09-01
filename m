Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5270C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5E92078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BNIrVNMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5E92078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBBN-0003c4-Il
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7i-0001e4-9E
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:36103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7b-0008CP-Ey
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598985297;
 bh=dAT+xmixHlyCM5vhxOQn/199sB671mBOmKjg6wYsGFc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BNIrVNMJ6wnxIulQTX+LLBmClOBBZwo1u9egz4X6rGDq8kHhU4xBdVlcdlDV2wsUb
 046ISOVQXT9RDsoJHtwDSTiunz2uJFa+5KsesEo6UnSiq7wCmiFMLQI0fVZz6RCSys
 fpDa3yWVoOL/wM6KiJ5Or8oF9XMtVh5HxLRxjAfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1kbcy13y8X-012J6w; Tue, 01
 Sep 2020 20:34:57 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
Date: Tue,  1 Sep 2020 20:34:51 +0200
Message-Id: <20200901183452.24967-7-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200901183452.24967-1-deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QA/XWFrhY3a0zklzJCehqmzYYzDQgaP6wYVCkOKyc8D1qYm22CP
 2Ubw/3KSwth07+KkeFeSOfR75Cm0axkF8NwRHzAaHZVTM7KhWHxF/eBZgEQ72z8/GKxYHqh
 axs+BRJK85Br33pC4nzW0YnlLcqFDl5/vFvLmunNKtVY040/Fu7A7n/B1D1vV3gLttuJjcu
 fiR0Kx7DVdkNQVIb4Bsug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jcd+H3OP0II=:rhqhRHTlDTIMfWAdiyznAy
 i+59PZ36kl5F53nmF2Bp2STp+UwkliZgN8fifIUdlr0M4iaX2iLY9HY+GlUFAOik2XwYRnvqI
 dfgZ5htaPNUA3TlPCbxCQYVV8x090EMvxK5RGwYifjGn+KuJDd1bPBRVAO5y9LNXnl5gG0p8Y
 dQzl+8h5//ZvQeZt5Aoh0GYWxzB2sYZrt0BNQzaDrYcMeFjbnTjuKOtAzga9P2072h1rh/ElC
 VKgeehR+TvED+pE9uOZ0zq4j7pbe0HXgp0MZ4eKF48WWwCTeEVujYA5MmRIgS72Ge4UF3ep/g
 ufXdjkNBkE1hzMWU10Nl8+qf85Wf/1KxMmUHCtTW5gnblJHZ+KJLSdvEwNpFr+g+l+mceSBvP
 L+P63/aks0RndBuRzYfgGkv+i7JiRa8Hk9AMDJk/YSLCDa8H50Pstp4iH3PyOBaCP6vpZhaqq
 SDcLEdZ0GpapLKHNIq6Tesdi3to+NGHEfMRwtZqQ26BfaXOGsxFJhvn4RilcT37KHum/SlTyt
 2GzFyFjUPcMHQgYhJJ/j42gIpNkFYoqAf1R2NzH/m4Yfv3ayJ7pFyc5QW8iYGn+ZhNpv7mRIw
 g+hu3kk20UvKqZflDRhl3pmC7++YgIvsuruGmSjlLdLBFQi+4BvHO/hhSig5OHhhknk+aY5rn
 z6MnbSeXsZTwHzMQ2gLBBJNOjJnje9uckNWDLMtxHJSdcoT3C3BD0SvgHvmMOOg0rlCJ6oZZl
 9TX5UHgk/memOyQnYDfqIOeyfPFVoxDBFC2ZrG8/wsFVwlbEnWcOWAGYtFCKJhStr0kPnZkxS
 KfZYgvW8IQ9ZrbGQTFoQ6B+fynZriM6Ee/wNQ7NY3hEpmrGAyDqVYZPY5W5cNhNsJcmeeFxDR
 8okk+qolAfBlZQ9nXimx/EdpIBcYXLbN/I1yDTauBYrlQ7//KrWw/DzIkm2Lo7eg3wPolnpm5
 eLv5liidIcNFMcv/O22OwKe3B2ElKRNGzbrAhuDiG0tIvg2FvVWnX+fI+B0MS/jtXIVSrRAnn
 VFJPkQ6gHUz3GA9vPSYFY+bDD6B0xg7GGuF8Z9Z7ATOWOB/uL2qIU5pbf4NpVXIix1+GQw3Gp
 kWOAJfJ5OYKVL/jlwkIbR8XMYm4VGGffO8iOfQ4V3VY9uanh+aSmkXc1UHAV5XDw102BnSlWP
 VyWtZa4EqgHqqC2I0xV3X9H17wOctleBImzTC7937nCmTrToWUth3BmQArzk6F5dgqflPyMg9
 nJKhGTh4rITaOX7Vk
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 13:37:41
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


