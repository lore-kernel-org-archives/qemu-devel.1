Received: from eggs.gnu.org ([209.51.188.92]:59593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmu-00021P-58
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmt-0006Th-DP
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:52 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 31 Jan 2019 14:53:27 +0100
Message-Id: <1548942810-22942-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1548942810-22942-1-git-send-email-thuth@redhat.com>
References: <1548942810-22942-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/5] ppc: Express dependencies of the 'prep'
 and '40p' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yang.zhong@intel.com, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

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
index 4dbf866..b1c3a30 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -33,6 +33,14 @@ config SAM460EX
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
