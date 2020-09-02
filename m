Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55622C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C66020758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fahnCZbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C66020758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDafN-0006wE-5B
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDacF-0005vS-HZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:48:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:33447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDacC-00020r-My
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599083301;
 bh=7BC6j1/fLzpzWUirfh8NgvqShuofmhmQdYckGQCHgjo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fahnCZbMhgLJR0j8qVOwkglgA7z8X6D6S8pQYk65k6AqoRSzb901+gAwmPt4qzFRR
 D16ANDj6rTQhlyFy3WaRAgfvHC1QwgpAr4Nwg9yGvu5mIB/UWEiCBDEKY/NPDLDij5
 67U6akZtufkJ1xX+T8hLMf6RFCXQMec+oaJRb1II=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1k1a4H0K4i-00VyZU; Wed, 02
 Sep 2020 23:48:21 +0200
Date: Wed, 2 Sep 2020 23:48:19 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
Message-ID: <20200902214819.GA2424@ls3530.fritz.box>
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-7-deller@gmx.de>
 <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
X-Provags-ID: V03:K1:wkW0M/RBr1XYRxcvkYTe5Tv0Co20pwUmBVGOPo7mxR7opeDl7in
 pbT2X3ucGBNopCRLnNylrqG9ZXDh82NSpNM6A9KT/mVZ8XedWyEMeyxs0rebMyX09/Ty78q
 Uu9EXiKqaSakD+jy4P/BnuFQHLwLlUt1QwQglOUwI5yFt4ZBAi0ZHwPizLk0ARftg87p/IC
 EnL+jzZo+8TDSX2uJZCAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u9+eQBm/DTE=:/WK38lbTV7rtfHlEeE4uKu
 cQxcKh0Wxfcwp5h2u9uKNuByZB/Sfy+Kot//u+MExdeQ69Qk1wQ/yuOFTd2IIhLgXiUtGequa
 zcpmoFLUPiw471214gjZu6CPXVWtfGzytvsEl7M/ZI6B0VrmCPKKPGsjV4vC9wdt9rbXC1ZIM
 2M9ySPkaTn+yXRjuWcW6aLYWMI0t+nGz/WOUSRDsFnq3gXOs9oPn1BQqTE6gA6vY7oP3hfX/N
 as7ZYlcipJPrzJoCH30+KH22AaCeaSug7bo+umZ6V1xuowCsq76r7bQafmSF1qXd0gq8705T6
 XsqwmGs46NdHVtYXYtt4otLFnGTiIAhklB3R59DnUpqNem1SZOpwTen0PPFgIv+mGL9g3eoiZ
 EF/qhoy2MLV6r6CA4YyNcl/hOcHqvlfyRm9UjNOaYFf43BxK8Y4U8aBVt8uLxg9Fel8VziyYP
 XnLWHqtcl8kI1SpsBJ72T7pCE7vB8rUejSpNrxwvl5kutY9svG1yc7EYTxGtI4KbGFHcIBsO3
 QADZasGcKRIjnjcY4tjmLYvmDrPMbf3RWnL59lHsVkIRbaRIbtTjC74qXNrWM3hdDuOe4tBbD
 hMsAJyPJo8tgCZDertkZYxhS791XxznWI5YRsHL0ptwuZYzln04zTDVuS7Tnu96wmRih1JWzq
 dHApk7acIeFuJkLzMkesvt3t6yB1Ye6if3WPxaYrE40L+7wJ5fm/kCfOppR97a9riThilN6Yd
 HIToJnNdif7BBxHtN6s06zrOxgH5DEqQzCyonxMqE/iYq1kyRsm82eMfpblWKM2xqkZCKhX5y
 nMT+/oIZAoav8Rl2aeIrZs7dCu2gzSw2LfuCl4fXE6HxCdV+CDWLfAyM5A+Y3w/JOaLEAE1wp
 K4NYdGa2nxrcdWp6jLqvULnjNzSEdrSBNB1WwmC/feK/tpEdn0hk43E7CQnMKCwWs61uEuY2u
 FppONSV1L8EpYDHwt6PF/ANHjNk7//VL5F1EYkP7nmsQ+d+Z0mj4LtVvenJfd1K4mHcZ86Brr
 clIZv9KZBQw1FrxvqIPMm1DkDcQqtuIYeVZ/1ZGNOGxTr8imN415FOXTaSmpnNgAj0W4gZFSU
 JVJd3nns6a08uiGor6nJaMMl1w/mYedwmk9SCn2iGKd05SGU6OQYaz0xfw7wXXnCpSJRXRKqX
 PLWcVL8W7H4Ue57fBJK6vpouatqbJD2LmtNsXXAgsi3lTY45wK6eP55VBaqUfGCCEU6NzmPhN
 P+rhQ6EYp0Ndr62XB
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:48:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Richard Henderson <richard.henderson@linaro.org>:
> On 9/1/20 11:34 AM, Helge Deller wrote:
> > Artist screen size is limited to 2048 x 2048 pixels and x/y coordinati=
on
> > addressing needs to be done by OS via an uint32 value which is based o=
n
> > a 2048 byte line length, independend of the real screen size.
> >
> > Since HP-UX seems to ideally need at least 640 pixels in width, this
> > patch ensures that the screen size stays between 640x480 and 2048x2048
> > pixels and fixes some pixel glitches were visible before on STI text
> > consoles due to the 2048 line length limitation.
> >
> > Cc: Sven Schnelle <svens@stackframe.org>
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > ---
> >  hw/display/artist.c | 37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/display/artist.c b/hw/display/artist.c
> > index 71982559c6..98bee6d61c 100644
> > --- a/hw/display/artist.c
> > +++ b/hw/display/artist.c
> > @@ -192,6 +192,10 @@ static const char *artist_reg_name(uint64_t addr)
> >  }
> >  #undef REG_NAME
> >
> > +/* artist has a fixed line length of 2048 bytes. */
> > +#define ADDR_TO_Y(addr) (((addr) >> 11) & 0x7ff)
> > +#define ADDR_TO_X(addr) ((addr) & 0x7ff)
>
> extract32()

fixed.

> > @@ -366,6 +370,8 @@ static void vram_bit_write(ARTISTState *s, int pos=
x, int posy, bool incr_x,
> >      if (s->cmap_bm_access) {
> >          offset =3D s->vram_pos;
> >      } else {
> > +        posx =3D ADDR_TO_X(s->vram_pos >> 2);
> > +        posy +=3D ADDR_TO_Y(s->vram_pos >> 2);
>
> Do you in fact want to fold the >> 2 into the ADDR_TO_X/Y, like
> #define ADDR_TO_X(POS)  extract32(POS, 2, 11)

Yes.
Basically this block was simply moved up to inside the function.
See in removed chunk below, there is the "s->vram_pos >> 2".

> > @@ -881,16 +886,12 @@ static void artist_reg_write(void *opaque, hwadd=
r addr, uint64_t val,
> >          break;
> >
> >      case VRAM_WRITE_INCR_Y:
> > -        posx =3D (s->vram_pos >> 2) & 0x7ff;
> > -        posy =3D (s->vram_pos >> 13) & 0x3ff;
> ...
> >      case VRAM_WRITE_INCR_X:
> >      case VRAM_WRITE_INCR_X2:
> > -        posx =3D (s->vram_pos >> 2) & 0x7ff;
> > -        posy =3D (s->vram_pos >> 13) & 0x3ff;
> ...
> > -    int posy =3D (addr >> 11) & 0x3ff;
>
> Is it a bug that these Y were using 0x3ff and not 0x7ff?
> Because it's pretty consistent...

I'm not sure if was intentional, a bug or just initial coding by Sven.
The old code was limiting to 1024 lines.
I assume that there doesn't exist any real hardware with > 1024 lines,
so it's more theoretical.
I tested the code, and it seems to work with > 1024 at least.
So, I think to use 0x7ff is probably more correct - at least if we
allow more lines.

> You should make that a separate change, for sure.

I'd prefer to keep it in one patch.
It's simply moving code around and reuse a macro.

> > @@ -1374,6 +1377,12 @@ static void artist_realizefn(DeviceState *dev, =
Error **errp)
> >      struct vram_buffer *buf;
> >      hwaddr offset =3D 0;
> >
> > +    /* Screen on artist can not be greater than 2048x2048 pixels. */
> > +    s->width =3D MAX(s->width, 640);
> > +    s->width =3D MIN(s->width, 2048);
> > +    s->height =3D MAX(s->height, 480);
> > +    s->height =3D MIN(s->height, 2048);
>
> Was the original values chosen by the user?

Yes, can bet set by user via
-global -global artist.width=3D800 -global artist.height=3D600

> Should we be giving some sort of error for out-of-range values?

I had a warning there, but then removed it again. Most users will
probably use the default values anyway. If you really want, I will add a
warning. I'm not a fan of errors. Errors usually abort, but we can
adjust and simply continue here.

Updated patch below.

Helge

=2D---------------------------------

[PATCH] hw/display/artist: Fix artist screen resolution

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
index 71982559c6..71f527c0e1 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -192,6 +192,10 @@ static const char *artist_reg_name(uint64_t addr)
 }
 #undef REG_NAME

+/* artist has a fixed line length of 2048 bytes. */
+#define ADDR_TO_Y(addr) extract32(addr, 11, 11)
+#define ADDR_TO_X(addr) extract32(addr, 0, 11)
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


