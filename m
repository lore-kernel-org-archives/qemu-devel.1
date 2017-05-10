Received: from eggs.gnu.org ([2001:4830:134:3::10]:42515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lco-0002Qk-E9
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcm-0007mo-1R
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:01:03 +1000
Message-Id: <20170510070115.13063-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/22] Add QemuMacDrivers as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The QemuMacDrivers project provides virtualisation drivers for PPC MacOS
guests.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 .gitmodules         | 3 +++
 pc-bios/README      | 3 +++
 roms/QemuMacDrivers | 1 +
 3 files changed, 7 insertions(+)
 create mode 160000 roms/QemuMacDrivers

diff --git a/.gitmodules b/.gitmodules
index ca323b4..5b0c212 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -34,3 +34,6 @@
 [submodule "roms/skiboot"]
 	path = roms/skiboot
 	url = git://git.qemu.org/skiboot.git
+[submodule "roms/QemuMacDrivers"]
+	path = roms/QemuMacDrivers
+	url = git://git.qemu.org/QemuMacDrivers.git
diff --git a/pc-bios/README b/pc-bios/README
index dcead36..ebc699d 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -47,3 +47,6 @@
   (OpenPower Abstraction Layer) firmware for OpenPOWER systems. It can
   run an hypervisor OS or simply a host OS on the "baremetal"
   platform, also known as the PowerNV (Non-Virtualized) platform.
+
+- QemuMacDrivers (https://github.com/ozbenh/QemuMacDrivers) is a project to
+  provide virtualised drivers for PPC MacOS guests.
diff --git a/roms/QemuMacDrivers b/roms/QemuMacDrivers
new file mode 160000
index 0000000..d4e7d7a
--- /dev/null
+++ b/roms/QemuMacDrivers
@@ -0,0 +1 @@
+Subproject commit d4e7d7ac663fcb55f1b93575445fcbca372f17a7
-- 
2.9.3
