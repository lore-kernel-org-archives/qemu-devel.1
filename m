Received: from eggs.gnu.org ([2001:4830:134:3::10]:36277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fB5z6-0002Iq-B3
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fB5z1-0004GM-Ex
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:00:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fB5z1-0004Bq-91
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:00:19 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3OLxWKD104883
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 18:00:16 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hj96h89vf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 18:00:15 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 24 Apr 2018 18:00:15 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 16:59:26 -0500
Message-Id: <152460716629.27171.6282630298609252026@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 2.12.0 release. This release contains 2700+ commits from 204 =

authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/2.12

Highlights include:

 * Spectre/Meltdown mitigation support for x86/pseries/s390 guests. For
   more details see:
     https://www.qemu.org/2018/02/14/qemu-2-11-1-and-spectre-update/
 * Numerous block support improvements, including support for directly
   interacting with userspace NVMe driver, and general improvements to
   NBD server/client including more efficient reads of sparse files
 * Networking support for VMWare paravirtualized RDMA device (RDMA
   HCA and Soft-RoCE supported), CAN bus support via Linux SocketCAN and
   SJA1000-based PCI interfaces, and general improvements for dual-stack
   IPv4/IPv6 environments
 * GUI security/bug fixes, dmabufs support for GTK/Spice.
 * Better IPMI support for Platform Events and SEL logging in internal
   BMC emulation
 * SMBIOS support for "OEM Strings", which can be used for automating
   guest image activation without relying on network-based querying
 * KVM support for systems larger than 7.999TB
 * Disk cache information via virtio-balloon

 * ARM: AArch64 new instructions for FCMA/RDM and SIMD/FP16/crypto/complex
   number extensions
 * ARM: initial support for Raspberry Pi 3 machine type
 * ARM: Corex-M33/Armv8-M emulation via new mps2-an505 board and many
   other improvements for M profile emulation
 * HPPA: support for full machine emulation (hppa-softmmu)
 * PowerPC: PPC4xx emulation improvements, including I2C bus support
 * PowerPC: new Sam460ex machine type
 * PowerPC: significant TCG performance improvements
 * PowerPC: pseries: support for Spectre/Meltdown mitigations
 * RISC-V: new RISC-V target via "spike_v1.9.1", "spike_v1.10", and "virt"
   machine types
 * s390: non-virtual devices no longer require dedicated channel subsystem
   and guest support for multiple CSSs
 * s390: general PCI improvements, MSI-X support for virtio-pci devices
 * s390: improved TCG emulation support
 * SPARC: sun4u power device emulation
 * SPARC: improved trace-event support and emulation/debug fixes
 * Tricore: new instruction variants for JEQ/JNE and 64-bit MOV
 * x86: Intel IOMMU support for 48-bit addresses
 * Xtensa: backend now uses libisa for instruction decoding/disassebly
 * Xtensa: multi-threaded TCG support and noMMU configuration variants

 * and lots more...

Thank you to everyone involved!
