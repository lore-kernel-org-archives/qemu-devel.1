Received: from eggs.gnu.org ([2001:4830:134:3::10]:48756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBBN8-0005Aq-Hb
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBBN3-0003RE-LD
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:45:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBBN3-0003R5-Dp
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:45:29 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Apr 2018 05:45:18 +0200
Message-Id: <1524627918-9661-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] Add a blog post about the release of
 version 2.12.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Based on the contents of Michael Roth's announce e-mail for 2.12.0.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _posts/2018-04-25-qemu-2-12-0.md | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 _posts/2018-04-25-qemu-2-12-0.md

diff --git a/_posts/2018-04-25-qemu-2-12-0.md b/_posts/2018-04-25-qemu-2-12-0.md
new file mode 100644
index 0000000..fdc4aea
--- /dev/null
+++ b/_posts/2018-04-25-qemu-2-12-0.md
@@ -0,0 +1,58 @@
+---
+layout: post
+title:  "QEMU version 2.12.0 released"
+date:   2018-04-25 05:30:00 +0200
+categories: [releases, 'qemu 2.12']
+---
+We'd like to announce the availability of the QEMU 2.12.0 release.
+This release contains 2700+ commits from 204 authors.
+
+You can grab the tarball from our 
+[download page](https://www.qemu.org/download/#source).
+The full list of changes are available
+[in the Wiki](https://wiki.qemu.org/ChangeLog/2.12).
+
+Highlights include:
+
+ * Spectre/Meltdown mitigation support for x86/pseries/s390 guests. For
+   more details see:
+     https://www.qemu.org/2018/02/14/qemu-2-11-1-and-spectre-update/
+ * Numerous block support improvements, including support for directly
+   interacting with userspace NVMe driver, and general improvements to
+   NBD server/client including more efficient reads of sparse files
+ * Networking support for VMWare paravirtualized RDMA device (RDMA
+   HCA and Soft-RoCE supported), CAN bus support via Linux SocketCAN and
+   SJA1000-based PCI interfaces, and general improvements for dual-stack
+   IPv4/IPv6 environments
+ * GUI security/bug fixes, dmabufs support for GTK/Spice.
+ * Better IPMI support for Platform Events and SEL logging in internal
+   BMC emulation
+ * SMBIOS support for "OEM Strings", which can be used for automating
+   guest image activation without relying on network-based querying
+ * Disk cache information via virtio-balloon
+ * ARM: AArch64 new instructions for FCMA/RDM and SIMD/FP16/crypto/complex
+   number extensions
+ * ARM: initial support for Raspberry Pi 3 machine type
+ * ARM: Corex-M33/Armv8-M emulation via new mps2-an505 board and many
+   other improvements for M profile emulation
+ * HPPA: support for full machine emulation (hppa-softmmu)
+ * PowerPC: PPC4xx emulation improvements, including I2C bus support
+ * PowerPC: new Sam460ex machine type
+ * PowerPC: significant TCG performance improvements
+ * PowerPC: pseries: support for Spectre/Meltdown mitigations
+ * RISC-V: new RISC-V target via "spike_v1.9.1", "spike_v1.10", and "virt"
+   machine types
+ * s390: non-virtual devices no longer require dedicated channel subsystem
+   and guest support for multiple CSSs
+ * s390: general PCI improvements, MSI-X support for virtio-pci devices
+ * s390: improved TCG emulation support
+ * s390: KVM support for systems larger than 7.999TB
+ * SPARC: sun4u power device emulation
+ * SPARC: improved trace-event support and emulation/debug fixes
+ * Tricore: new instruction variants for JEQ/JNE and 64-bit MOV
+ * x86: Intel IOMMU support for 48-bit addresses
+ * Xtensa: backend now uses libisa for instruction decoding/disassebly
+ * Xtensa: multi-threaded TCG support and noMMU configuration variants
+ * and lots more...
+
+Thank you to everyone involved!
-- 
1.8.3.1
