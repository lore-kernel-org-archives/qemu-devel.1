Received: from eggs.gnu.org ([2001:4830:134:3::10]:41969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fV28I-0005Ty-I4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fV28F-00064l-Bw
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:56:18 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Mon, 18 Jun 2018 23:56:01 +0200
Message-Id: <20180618215601.8974-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, thuth@redhat.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org

Drivers for this card exists on PPC-based AmigaOS guests so it is useful to
allow users to emulate the graphics card for PPC machines.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
---
 default-configs/ppc-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 860de80a27..218b14779c 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -29,6 +29,7 @@ CONFIG_IDE_SII3112=y
 CONFIG_I2C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_M41T80=y
+CONFIG_VGA_CIRRUS=y
 
 # For Macs
 CONFIG_MAC=y
-- 
2.17.1
