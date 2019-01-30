Received: from eggs.gnu.org ([209.51.188.92]:44222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomPP-0002B6-E7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomPN-0004Yq-J4
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:43:51 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 10:43:04 +0100
Message-Id: <1548841387-7670-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1548841387-7670-1-git-send-email-thuth@redhat.com>
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 2/5] ppc: Express dependencies of the
 'prep' and '40p' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Select the required devices in hw/ppc/Kconfig instead, so that
ppc-softmmu.mak only contains the user-selectable PREP switch.
Plug-in devices like NE2000_ISA are pulled in automatically by the
Kconfig build system now.

Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc-softmmu.mak | 8 --------
 hw/ppc/Kconfig                  | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
index 05ba726..422f1b7 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -57,11 +57,3 @@ CONFIG_MAC_NEWWORLD=3Dy
=20
 # For PReP
 CONFIG_PREP=3Dy
-CONFIG_PREP_PCI=3Dy
-CONFIG_RS6000_MC=3Dy
-CONFIG_I82374=3Dy
-CONFIG_I82378=3Dy
-CONFIG_PCKBD=3Dy
-CONFIG_NE2000_ISA=3Dy
-CONFIG_PC87312=3Dy
-CONFIG_CS4231A=3Dy
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index b44e3bd..809830e 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -30,6 +30,14 @@ config SAM460EX
=20
 config PREP
     bool
+    select CS4231A
+    select PREP_PCI
+    select I82374
+    select I82378
+    select LSI_SCSI_PCI
+    select M48T59
+    select PC87312
+    select RS6000_MC
=20
 config RS6000_MC
     bool
--=20
1.8.3.1
