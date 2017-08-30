Received: from eggs.gnu.org ([2001:4830:134:3::10]:49418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dn93v-0004de-92
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dn93s-00049C-7Z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:54:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dn93r-00048S-UC
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:54:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UJrwUu121982
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 15:54:00 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cny3c9ajv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 15:54:00 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 15:53:56 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 14:53:44 -0500
Message-Id: <150412282458.23002.14698600796895856506@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0 is now available
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
the QEMU 2.10.0 release. This release contains 2600+ commits from 208 =

authors.

You can grab the tarball from our download page here:

  http://www.qemu.org/download/#source

The full list of changes are available at:

  http://wiki.qemu.org/ChangeLog/2.10

Highlights include:

 * Support for ACPI NUMA distance info and control over CPU NUMA
   assignments via '-numa cpu' parameters
 * Support for LUKS encryption format in qcow2 images
 * Monitor/Management interface improvments: additional debug
   information available through 'info ramblock/cmma/register/qtree',
   support for viewing connected clients via 'info vnc', improved
   parsing support for QMP protocol, and other additional commands
 * QXL and virtio-gpu support for controlling default display resolution
 * Support for vhost-user-scsi devices
 * NVMe emulation support for Write Zeroes command and Controller
   Memory Buffers
 * Guest agent support for querying guest hostname, users, timezone, and
   OS version/release information

 * ARM: KVM support for Raspberry Pi 3
 * ARM: emulation support for MPS2/MPS2+ FPGA-based dev boards
 * ARM: zynq: SPIPS flash support
 * ARM: exynos4210: hardware PRNG device, SDHCI, and system poweroff
 * Microblaze: support for CPU versions 9.4, 9.5, 9.6, and 10.0
 * MIPS: support for Enhanced Virtual Addressing (EVA)
 * MIPS: initrd support for kaslr-enabled kernels
 * OpenRISC: support for shadow registers, idle states, and
   numcores/coreid/EVAR/EPH registers
 * PowerPC: Multi-threaded TCG emulation support
 * PowerPC: OpenBIOS VGA driver for MacOS guests
 * PowerPC: pseries: KVM and emulation support for POWER9 guests
 * PowerPC: pseries: support for hash page table resizing
 * s390: channel device passthrough support via vfio-ccw
 * s390: support for channel-attached 3270 "green screen" devices for
   use as guest consoles or additional TTYs
 * s390: improved support for PCI (AEN, AIS, and zPCI)
 * s390: support for z14 CPU models and netboot/TFTP via CCW BIOS, =

 * s390: TCG support for atomic "LOAD AND x" and "COMPARE SWAP"
   operations, LOAD PROGRAM PARAMETER, extended facilities, CPU type,
   and many more less-common instructions.
 * SH: TCG support for host atomic instructions for emulating tas.b and
   gUSA (user-space atomics), and support for fpchg/fsrra instructions
 * SPARC: fixes for booting Solaris 2.6 on sun4m/OpenBIOS machines
 * x86: Q35 MCH supports TSEG higher than 8MB
 * x86: SSE register access via gdbstub
 * Xen: support for multi-page shared rings, and 9pfs/virtfs backend
 * Xtensa: sim machine console can be directed to chardev via -serial

 * and lots more...

Thank you to everyone involved!
