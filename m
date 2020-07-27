Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069FC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A8F20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dKDGM8dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A8F20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0B0Q-00027v-TG
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Awu-0000Ro-IC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:55295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Aws-0002nP-Iy
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595886372;
 bh=9cHFcYkhREm/XKFlpMeM2pJowRIOAkKoOTQvH5tpvRQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dKDGM8dY17TnYWBFIJ5jvhI0Mpy+Asbev/cwafne8vJCw/WbdxgY/B0j3LsaIo0S5
 KWF2iFYIfSCAxX8AhRl/eCWGCcXiEXJfNIn9h2LEhs6KpT//DIvb39IM7na/SKmRrI
 s6qbDhLU2usqQiMMXj8s37LGVm/aNOjSsIuFWRAc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.179.161]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1kaNlx0d0X-00qF0e; Mon, 27
 Jul 2020 23:46:12 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/display/artist.c: fix out of bounds check
Date: Mon, 27 Jul 2020 23:46:08 +0200
Message-Id: <20200727214608.32710-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200727214608.32710-1-deller@gmx.de>
References: <20200727214608.32710-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lP/RZ4XX16avRDKvZJEn/6qapwKvzw49U47eULi0EvIYyUImDtl
 vTgXq4X45tNFseouhuJYLg65dWOospRofQ7l84p0i0nsQzr/zB9GQkjMSPRd6RE9mBiL8mA
 1Vm/Kqp8ID5Lc+S1/0lcZQbwF/P8nam4KRrFISOb9yC4Hpbs8ks7wbVRvGGkYvQDNfaGVN/
 fu3m/1HjfrMi0esTPsofg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MDcp427P/5E=:TatDF61MFOTSICfcJCayhN
 LDxd/JnoJ/fwIbb+H89LXr3K1xRP/JXduWJm8G7J8VDlUgc9kEeaNPR8E5xrY8wy+yzWTPXgs
 O7cckaceVb6qf+Vu1i4FVVGpRIgsAaAjNre4QkkyW46LR0LtjhOEEvGkGvGqgtLhLNim5+Ewk
 QWMyq+TkQrosjOiXR1WB5NGONXzBFWoezuykEYXB/4VZb9WKnz6bEhXBLnVzJPFy41mNjHpXk
 vgL24PHWmIyVbhGyxN+f0VCFswIGcquicnTZI+5waQjb+e/aloA7bsHKjtGxbTBGN7nMgE6ZH
 efYvCcM0MMXmawT4XytZUPpLzYZ7rrX28nTcaE89bM5T0jfWqLivMeJbyM/an7ggVvVuRIoVr
 OHGBgLjoaqiY7FWLeOzs8b+sfQf4ojnsRj0yFzFZ7pF4GR2IAjHZhZXUgMXGpKh8oXIeRoP8k
 eKNjmLdr0QoZ8WOIOC18xYyiAjAemlWXu7zkQwB5/XzG9WRBBJKkNfFc7jgAQ50lqcPFONmc+
 TFGE7U4JS8Hpoy3yclGgkjoxsucx6OmCYiJ4SSyrJ6hByy/fmV4fhYMY925SPWjRTydjIcVnu
 MOROp39hjX/wOiC7g5CEixkM4hRak/jPe+1VI8CcjDr+VOuEiIZIdQnzm3G0Gw4oCJk4jWP+5
 KScHHwsy+PphsqE2DuxY/G9nRMqJYQ7EWAwYuZp/SKZeBePBXihvC5oF8G0g5jeJVH8mlMsSs
 dBoGwR1JUb4P+CnccsqJ7HzXzGrRlX084GW3qhn+hP30JNakjnZO3iwWDUq/qFq1m3OGtLlVv
 tCcGbVpUXca71YXWBbB1D3GWzpSN9K6VL+NA1A3whkR7ZcJNG2BXUZqLfol/ZDgj86kswVqsU
 azfDZlWT4bC9Vh3SAMK50W5iT8K3mEDVzO2V1rZCdffBq6QBErtly/jw4uAVk1NHiZiQkt6M/
 SO3h5gT1oQEt1HYw5KWyYRB9K8PbhxTpuFKeqsnbOm1kxNzcevESkyHlMfOh2Ik3lYLosgW7O
 +uCYxvSSSxEqwYB+F8U1O0D4twEFmtlocBgqMLPZ/3wJqNw73JLR1eSd+UFkgJXaxiGLIGVRn
 aQNwuVqhZmNVOFXKAmd00eJLfLNRPkFDZAiOQoYkicgjnRTPwjaBaa4FeedjvQ6t2GlBnf1yv
 woKMpQr/atk2UFImFWlVgQXMAHtG6+3vjTch5Xv1MARZf00AQYc1Zu2G/y3MEJH7mToR2hND4
 mq8Fxf4skrBvdMvW6
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 17:46:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sven Schnelle <svens@stackframe.org>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 6261bfe65b..46043ec895 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -340,14 +340,13 @@ static void vram_bit_write(ARTISTState *s, int posx,=
 int posy, bool incr_x,
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask =3D s->vram_bitmask;
-    int mask, i, pix_count, pix_length, offset, height, width;
+    int mask, i, pix_count, pix_length, offset, width;
     uint8_t *data8, *p;

     pix_count =3D vram_write_pix_per_transfer(s);
     pix_length =3D vram_pixel_length(s);

     buf =3D vram_write_buffer(s);
-    height =3D buf->height;
     width =3D buf->width;

     if (s->cmap_bm_access) {
@@ -367,20 +366,13 @@ static void vram_bit_write(ARTISTState *s, int posx,=
 int posy, bool incr_x,
         pix_count =3D size * 8;
     }

-    if (posy * width + posx + pix_count > buf->size) {
-        qemu_log("write outside bounds: wants %dx%d, max size %dx%d\n",
-                 posx, posy, width, height);
-        return;
-    }
-
-
     switch (pix_length) {
     case 0:
         if (s->image_bitmap_op & 0x20000000) {
             data &=3D vram_bitmask;
         }

-        for (i =3D 0; i < pix_count; i++) {
+        for (i =3D 0; i < pix_count && offset + i < buf->size; i++) {
             artist_rop8(s, p + offset + pix_count - 1 - i,
                         (data & 1) ? (s->plane_mask >> 24) : 0);
             data >>=3D 1;
@@ -398,7 +390,9 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
         for (i =3D 3; i >=3D 0; i--) {
             if (!(s->image_bitmap_op & 0x20000000) ||
                 s->vram_bitmask & (1 << (28 + i))) {
-                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
+                if (offset + 3 - i < buf->size) {
+                    artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)])=
;
+                }
             }
         }
         memory_region_set_dirty(&buf->mr, offset, 3);
@@ -420,7 +414,7 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
             break;
         }

-        for (i =3D 0; i < pix_count; i++) {
+        for (i =3D 0; i < pix_count && offset + i < buf->size; i++) {
             mask =3D 1 << (pix_count - 1 - i);

             if (!(s->image_bitmap_op & 0x20000000) ||
=2D-
2.21.3


