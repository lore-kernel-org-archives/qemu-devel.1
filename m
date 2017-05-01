Received: from eggs.gnu.org ([2001:4830:134:3::10]:39005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5Bca-0006XT-Pk
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5BcX-0002Ja-NJ
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:44:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  1 May 2017 14:43:30 +0100
Message-Id: <1493646214-3342-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/5] Add QemuMacDrivers as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

The QemuMacDrivers project provides virtualisation drivers for PPC MacOS
guests.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 .gitmodules         |    3 +++
 pc-bios/README      |    3 +++
 roms/QemuMacDrivers |    1 +
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
1.7.10.4
