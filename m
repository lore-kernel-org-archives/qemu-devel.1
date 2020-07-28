Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B18207F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WcL3QMmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B18207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0VWq-0005PU-DP
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 15:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VOO-0001Fg-SI
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:56733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VON-0005i6-1N
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595964955;
 bh=9cHFcYkhREm/XKFlpMeM2pJowRIOAkKoOTQvH5tpvRQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WcL3QMmdq/toVX/XFR74B7CnI4w41g9EyiWLrVJdG2tbMAUcCsvNHSHaAfWhwvATu
 zhOkW/kMM/P0Q3XuKu2qp6p9HaB1uiQSBS/10FXBGt9AEQnQUqVUq65TdZt9OgzuY2
 LBtTcNXNX6jA9LcxOYNdZ5OlrD/WVQ9VX8rU7B/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.108]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1kg8vl3MQB-00fl0A; Tue, 28
 Jul 2020 21:35:54 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 4/4] hw/display/artist.c: fix out of bounds check
Date: Tue, 28 Jul 2020 21:35:50 +0200
Message-Id: <20200728193550.3578-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200728193550.3578-1-deller@gmx.de>
References: <20200728193550.3578-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LGaJml0GLvbGQRMhjogaFfwQp4ZT/JuBFoBlq9WFE5xvGkeBwfb
 s6DJEw4PL/wM2NweBNZ9FbfuIZry7DgczD0VgDEXsgnFTRTFn7slj2vFgrOL7Pdbg79A1eO
 /7NmPqYDWLRx/yEpBBJKz0qwuhkxSSdN/YJAmc1UosGoFse9xxMfWtZQaugLfvy16Xn+i5P
 y35QKtkhcdHkmoa4UAbQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqfOICqRK5o=:rGY3Lg7KDMynLjul0ainlw
 l8X3Wa+hj66CulPIr1LAXtZ1/qv/Nd5VBj7wpzGyD+vaVS4KAJA1M7t2+IYyei6VNpBp7WPwO
 aoIcWX1SS3HGD1U1i8C337FH65s9dP+6JuNa9+5HGIoJIil9uv6im8GVbIc1UHS+fvsNInc1e
 PRvHcyRAd6+551oju1EOA2TSV03Pek/YcQTOMO1MuyGtqtzLt41eJx6pbUMznVKREtfcGkg4M
 kpkJ0s54GiD344KIEpYbl8moZitqR8vqul2LHNCjntoliFJEWPThhI0sdwTEE4mgJ8RG5LNPM
 5fJDTldrqFBllRuAaFLMw5zBuBGoDGWyhZ0axtTDOVLPU4oRhuBzts21+4knfYgyAiDv91Zn7
 aEf2NHgKF90DYk0MIeO5jlHrR6b9IkvFxax93f8eqUHTMto6u0SKPAZnKrveMhJ0Vbn0c8MdP
 EO3UwwSeWqEICVlgWgdl7IT2odrPnFvS+StL5yuBFeJ79mQ40pHzfj/tJsdSxQKr1qE256cjU
 KyByl42/81E8xXIv8XmguL0a6eAdLUR2yPuMA+QNR0ag1rlM1Y3rffiiKsCkzeUv+X3Yv6gip
 CkhR78Ply5IO+wE65hJ/YyNb+5yY+drPRQk9Jh+l7Mx5vbr07cbwp9TQA8aF02hMb49jwN0/L
 eUUmG5jwQWAPWn6qYyx+HdooCGnHhUkiflhkN4ujvsTOq/YmaVhdoxUYtK5iZiPAvkJwEPVzk
 mFhUJIEvzoqdYQyttWZClc2fIXndlu+6PxYUEtDZZfyG0KBlykLFj2BadypjYinhYNxaMFjkM
 e9D9I2GgUCLhv0zTf2Xdll7UDdKj4jtnCiJ9y7w3l70hRpssC0UZLEP2h2HuL7Ih7cH5GHPHK
 89XtcRRSCfTdLU1FYDqVEHTcF6BbwsV6V/Fmw+/XX5APtv9trz0hbZripnuDE3sgy9y5CysZ7
 Q6YT4qPfwcrnQ4omyJK/01zf3MXQSERiGKkMPYdU9w0vX0alya4lHS5K6QRr7lzbVmltm0l+L
 15V6BlptfeUqZsm2WJbUCXmefs6EmEX+WAZeGvCZbVqjI11TjY2oNLa2nJ6fdZHZjGTAIsQFM
 2bcv5D/QAKduGm8nol6tZPRHFSovEgOwcCYQkJnKt1eT/hKxCtQHknHTFurGGy9CQwPkkNXJw
 Mk0K301DtgTKysnQJRqLgFJWQjB3gKVAwhuVttbl/BY9qb29ogzbCIySeM3zPYBDJVjc+PkCs
 1j4KxzcAF2PIzr2Jc
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 15:35:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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


