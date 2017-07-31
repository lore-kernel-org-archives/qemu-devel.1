Received: from eggs.gnu.org ([2001:4830:134:3::10]:60674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Nx-0004tJ-Kb
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Nt-0004iC-JE
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:17 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:43 +0300
Message-Id: <f31fd5cfd7cc4291ec5dd7d31bdce72cea69144f.1501496350.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/25] docs: fix broken paths to
 docs/config/ich9-ehci-uhci.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

With the move of some docs/ to docs/devel/ on ac06724a71,
a reference path was not updated.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/usb2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/usb2.txt b/docs/usb2.txt
index b9e7548073..09df45b5b1 100644
--- a/docs/usb2.txt
+++ b/docs/usb2.txt
@@ -50,7 +50,7 @@ companion controllers with two ports each.
 There is a config file in docs which will do all this for you, just
 try ...
=20
-    qemu -readconfig docs/ich9-ehci-uhci.cfg
+    qemu -readconfig docs/config/ich9-ehci-uhci.cfg
=20
 ... then use "bus=3Dehci.0" to assign your usb devices to that bus.
=20
--=20
2.11.0
