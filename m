Received: from eggs.gnu.org ([2001:4830:134:3::10]:43493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX6An-0006cJ-89
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX6Al-00074v-5z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX6Ak-00074c-Vi
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:34:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFF54356F6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:34:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 15:34:44 +0200
Message-Id: <20170717133444.16743-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] keymaps: fr-ca: more fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

Fixes: https://bugs.launchpad.net/qemu/+bug/533613
Cc: Thomas Huth <thuth@redhat.com>
Suggested-by: J=C3=A9r=C3=B4me Poulin <jeromepoulin@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/keymaps/fr-ca | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
index 030f56a78e..13a0306762 100644
--- a/pc-bios/keymaps/fr-ca
+++ b/pc-bios/keymaps/fr-ca
@@ -10,6 +10,7 @@ sterling 0x4 altgr
 cent 0x5 altgr
 currency 0x6 altgr
 notsign 0x7 altgr
+numbersign 0x29
 bar 0x29 shift
 twosuperior 0x9 altgr
 threesuperior 0xa altgr
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
@@ -47,6 +52,9 @@ asterisk 0x9 shift
 parenleft 0xa shift
 parenright 0xb shift
 underscore 0xc shift
-plus 0xd shift
 minus 0xc
+underscore 0xc shift
 equal 0xd
+plus 0xd shift
+semicolon 0x27
+colon 0x27 shift
--=20
2.9.3
