Received: from eggs.gnu.org ([209.51.188.92]:44167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gos3m-0001Rq-4Y
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gos3l-0001P2-7t
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:45:54 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 16:45:40 +0100
Message-Id: <1548863140-31975-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: XIVE is an interrupt controller,
 not a machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org

The "XIVE" section is currently listed in the "PowerPC Machines"
section, which is weird, since this is an interrupt controller
device. Move it to the "Devices" section instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b334b53..eac36b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1038,14 +1038,6 @@ F: tests/libqos/*spapr*
 F: tests/rtas*
 F: tests/libqos/rtas*
=20
-XIVE
-M: David Gibson <david@gibson.dropbear.id.au>
-M: C=C3=A9dric Le Goater <clg@kaod.org>
-L: qemu-ppc@nongnu.org
-S: Supported
-F: hw/*/*xive*
-F: include/hw/*/*xive*
-
 virtex_ml507
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: qemu-ppc@nongnu.org
@@ -1645,6 +1637,14 @@ F: tests/libqos/fw_cfg.c
 F: tests/fw_cfg-test.c
 T: git https://github.com/philmd/qemu.git fw_cfg-next
=20
+XIVE
+M: David Gibson <david@gibson.dropbear.id.au>
+M: C=C3=A9dric Le Goater <clg@kaod.org>
+L: qemu-ppc@nongnu.org
+S: Supported
+F: hw/*/*xive*
+F: include/hw/*/*xive*
+
 Subsystems
 ----------
 Audio
--=20
1.8.3.1
