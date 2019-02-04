Received: from eggs.gnu.org ([209.51.188.92]:38903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9T-0001Cp-GN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9N-0000HE-KB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:08 +1100
Message-Id: <20190204090124.26191-22-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/37] MAINTAINERS: XIVE is an interrupt
 controller, not a machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The "XIVE" section is currently listed in the "PowerPC Machines"
section, which is weird, since this is an interrupt controller
device. Move it to the "Devices" section instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 612692b284..d891e79faa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1041,14 +1041,6 @@ F: tests/libqos/*spapr*
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
@@ -1648,6 +1640,14 @@ F: tests/libqos/fw_cfg.c
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
2.20.1
