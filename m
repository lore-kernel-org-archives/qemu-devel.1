Received: from eggs.gnu.org ([2001:4830:134:3::10]:60500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fphF4-0000ag-4W
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 17:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fphF1-00064d-2l
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 17:52:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fphF0-00064K-QT
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 17:52:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7ELYZGo018224
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 17:52:36 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kv3cst51y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 17:52:36 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 14 Aug 2018 15:52:35 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 14 Aug 2018 16:52:17 -0500
Message-Id: <153428353710.9044.92160100129350893@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.0.0 is now available
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
the QEMU 3.0.0 release. This release contains 2300+ commits from 169
authors.

A note from the maintainer:

  Why 3.0? Well, we felt that our version numbers were getting a bit
  unwieldy, and since this year is QEMU's 15th birthday it seemed like
  a good excuse to roll over the major digit. Going forward we plan to
  increment the major version once a year, for the first release of the
  year. Don't read too much into it: it doesn't imply a drastic
  compatibility break.

  Rumours of our triskaidekaphobia have been greatly exaggerated :-)

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/3.0

Highlights include:

 * Support for additional x86/AMD mitigations against Speculative
   Store Bypass (Spectre Variant 4, CVE-2018-3639)
 * Improved support for nested KVM guests running on Hyper-V
 * Block device support for active disk-mirroring, which avoids
   convergence issues which may arise when doing passive/background
   mirroring of busy devices.
 * Improved support for AHCI emulation, SCSI emulation, and persistent
   reservations / cluster management.
 * OpenGL ES support for SDL front-end, additional framebuffer
   device options for early boot display without using legacy VGA
   emulation
 * Live migration support for TPM TIS devices, capping bandwidth
   usage during post-copy migration, and recovering from a failed
   post-copy migration
 * Improved latency when using user-mode networking / SLIRP

 * ARM: support for SMMUv3 IOMMU when using 'virt' machine type
 * ARM: v8M extensions for VLLDM and VLSTM floating-point instructions,
   and improved support for AArch64 v8.2 FP16 extensions
 * ARM: support for Scalable Vector Extensions in linux-user mode
 * Microblaze: support for 64-bit address sizes and translation bug
   fixes
 * PowerPC: PMU support for mac99 machine type and improvements for
   Uninorth PCI host bridge emulation for Mac machine types
 * PowerPC: preliminary support for emulating POWER9 hash MMU mode when
   using powernv machine type.
 * RISC-V: improvement for privileged ISA emulation
 * s390: support for z14 ZR1 CPU model
 * s390: bpb/ppa15 Spectre mitigations enabled by default for z196 and
   later CPU models
 * s390: support for configuring consoles via -serial options

 * and lots more...

Thank you to everyone involved!
