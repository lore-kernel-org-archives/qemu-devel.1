Received: from eggs.gnu.org ([2001:4830:134:3::10]:55423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX40V-0007yi-F2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX40R-0006t6-8s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:16:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX40R-0006sb-2L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:16:03 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 13:15:49 +0200
Message-Id: <20170717111549.31511-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] keymaps: fr-ca: more fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 533613@bugs.launchpad.net, Thomas Huth <thuth@redhat.com>

Cc: 533613@bugs.launchpad.net
Cc: Thomas Huth <thuth@redhat.com>
Suggested-by: J=C3=A9r=C3=B4me Poulin
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/keymaps/fr-ca | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
index 030f56a78e..2e540d596c 100644
--- a/pc-bios/keymaps/fr-ca
+++ b/pc-bios/keymaps/fr-ca
@@ -3,6 +3,8 @@
 include common
 map 0xc0c
=20
+numbersign 0x29
+bar 0x29
 backslash 0x29 altgr
 plusminus 0x2 altgr
 at 0x3 altgr
@@ -10,7 +12,6 @@ sterling 0x4 altgr
 cent 0x5 altgr
 currency 0x6 altgr
 notsign 0x7 altgr
-bar 0x29 shift
 twosuperior 0x9 altgr
 threesuperior 0xa altgr
 onequarter 0xb altgr
@@ -38,6 +39,10 @@ dead_cedilla 0x1b
 dead_diaeresis 0x1b shift
 exclam 0x2 shift
 quotedbl 0x3 shift
+comma 0x33
+apostrophe 0x33 shift
+period 0x34
+period 0x34 shift
 slash 0x4 shift
 dollar 0x5 shift
 percent 0x6 shift
@@ -48,5 +53,8 @@ parenleft 0xa shift
 parenright 0xb shift
 underscore 0xc shift
 plus 0xd shift
-minus 0xc
-equal 0xd
+minus 0x0c
+underscore 0x0c shift
+equal 0x0d
+semicolon 0x27
+colon 0x27 shift
--=20
2.9.3
