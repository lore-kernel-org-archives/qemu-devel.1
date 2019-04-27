Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D80C43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 18:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0605F2087C
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 18:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0605F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKSAM-00017q-8g
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 14:35:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKS8e-0000Gv-8r
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKS8d-0005A4-1R
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:28 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:40794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKS8c-00058x-M8
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 56C1FA488;
	Sat, 27 Apr 2019 20:33:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95xXsz479cxW; Sat, 27 Apr 2019 20:33:24 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id D82DF9E68;
	Sat, 27 Apr 2019 20:33:23 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKS8M-0003LC-V2; Sat, 27 Apr 2019 20:33:10 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org
Date: Sat, 27 Apr 2019 20:33:07 +0200
Message-Id: <20190427183307.12796-3-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190427183307.12796-1-samuel.thibault@ens-lyon.org>
References: <20190427183307.12796-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: [Qemu-devel] [PATCHv4 2/2] ui/curses: manipulate cchar_t with
 standard curses functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kamil@netbsd.org,
	Kamil Rytarowski <n54@gmx.com>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190427183307.IY_HrSvNxzR1bmaol5PMZviNqtGy0NWboVJpr9_hdxU@z>

The chars/attr fields are curses internals, setcchar and getcchar have
to be used instead.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Kamil Rytarowski <n54@gmx.com>
---
 ui/curses.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 81d419879e..1f3fcabb00 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -66,20 +66,22 @@ static void curses_update(DisplayChangeListener *dcl,
 {
     console_ch_t *line;
     cchar_t curses_line[width];
+    wchar_t wch[CCHARW_MAX];
+    attr_t attrs;
+    short colors;
+    int ret;
=20
     line =3D screen + y * width;
     for (h +=3D y; y < h; y ++, line +=3D width) {
         for (x =3D 0; x < width; x++) {
             chtype ch =3D line[x] & 0xff;
             chtype at =3D line[x] & ~0xff;
-            if (vga_to_curses[ch].chars[0]) {
-                curses_line[x] =3D vga_to_curses[ch];
-            } else {
-                curses_line[x] =3D (cchar_t) {
-                    .chars[0] =3D ch,
-                };
+            ret =3D getcchar(&vga_to_curses[ch], wch, &attrs, &colors, N=
ULL);
+            if (ret =3D=3D ERR || wch[0] =3D=3D 0) {
+                wch[0] =3D ch;
+                wch[1] =3D 0;
             }
-            curses_line[x].attr |=3D at;
+            setcchar(&curses_line[x], wch, at, 0, NULL);
         }
         mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
     }
@@ -412,7 +414,7 @@ static void curses_atexit(void)
 static void convert_ucs(unsigned char fch, uint16_t uch, iconv_t conv)
 {
     char mbch[MB_LEN_MAX];
-    wchar_t wch;
+    wchar_t wch[2];
     char *puch, *pmbch;
     size_t such, smbch;
     mbstate_t ps;
@@ -430,20 +432,22 @@ static void convert_ucs(unsigned char fch, uint16_t=
 uch, iconv_t conv)
     }
=20
     memset(&ps, 0, sizeof(ps));
-    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) =3D=3D -1) {
+    if (mbrtowc(&wch[0], mbch, sizeof(mbch) - smbch, &ps) =3D=3D -1) {
         fprintf(stderr, "Could not convert 0x%04x "
                         "from a multibyte character to wchar_t: %s\n",
                         uch, strerror(errno));
         return;
     }
-    vga_to_curses[fch].chars[0] =3D wch;
+
+    wch[1] =3D 0;
+    setcchar(&vga_to_curses[fch], wch, 0, 0, NULL);
 }
=20
 /* Setup wchar glyph for one font character */
 static void convert_font(unsigned char fch, iconv_t conv)
 {
     char mbch[MB_LEN_MAX];
-    wchar_t wch;
+    wchar_t wch[2];
     char *pfch, *pmbch;
     size_t sfch, smbch;
     mbstate_t ps;
@@ -461,13 +465,15 @@ static void convert_font(unsigned char fch, iconv_t=
 conv)
     }
=20
     memset(&ps, 0, sizeof(ps));
-    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) =3D=3D -1) {
+    if (mbrtowc(&wch[0], mbch, sizeof(mbch) - smbch, &ps) =3D=3D -1) {
         fprintf(stderr, "Could not convert font glyph 0x%02x "
                         "from a multibyte character to wchar_t: %s\n",
                         fch, strerror(errno));
         return;
     }
-    vga_to_curses[fch].chars[0] =3D wch;
+
+    wch[1] =3D 0;
+    setcchar(&vga_to_curses[fch], wch, 0, 0, NULL);
 }
=20
 /* Convert one wchar to UCS-2 */
@@ -592,7 +598,16 @@ static void font_setup(void)
     if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
         /* Non-Unicode capable, use termcap equivalents for those availa=
ble */
         for (i =3D 0; i <=3D 0xFF; i++) {
-            switch (get_ucs(vga_to_curses[i].chars[0], nativecharset_to_=
ucs2)) {
+            wchar_t wch[CCHARW_MAX];
+            attr_t attr;
+            short color;
+            int ret;
+
+            ret =3D getcchar(&vga_to_curses[i], wch, &attr, &color, NULL=
);
+            if (ret =3D=3D ERR)
+                continue;
+
+            switch (get_ucs(wch[0], nativecharset_to_ucs2)) {
             case 0x00a3:
                 vga_to_curses[i] =3D *WACS_STERLING;
                 break;
--=20
2.20.1


