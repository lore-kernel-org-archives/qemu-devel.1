Received: from eggs.gnu.org ([2001:4830:134:3::10]:39968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d1Etl-0005U4-Bz
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d1Eth-0000rK-5G
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:25:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43938
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d1Etg-0000qq-Vv
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:25:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3KGNv6G111414
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 12:25:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29xvy1v186-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 12:25:30 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 20 Apr 2017 12:25:29 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 20 Apr 2017 11:25:20 -0500
Message-Id: <149270552086.2252.8482717579448766252@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 2.9.0 release. This release contains 2300+ commits from 199
authors.

You can grab the tarball from our download page here:

  http://www.qemu.org/download/#source

The full list of changes are available at:

  http://wiki.qemu.org/ChangeLog/2.9

Highlights include:

 * I/O-polling support for virtio-blk (and virtio-scsi experimentally), whi=
ch
   can improve I/O-heavy workloads by as much as 10-20%
 * Core support for MTTCG (multi-threaded TCG emulation), now enabled by
   default for Alpha and ARM on x86 machines
 * Hardware-acceleration support for x86 guests on Windows via HAXM =

 * Hotplug and HMAC algorithm support for virtio-crypto devices
 * vhost support for virtio-pci devices behind a guest IOMMU
 * Many stability fixes for XHCI emulation
 * Significant security improvements and I/O throttling support for
   virtfs/virtio-9p
 * Texinfo documentation for all QMP commands and events
 * Postcopy migration can now by used for guests using hugetlbfs-backed mem=
ory

 * ARM: support for MTTCG (see above)
 * ARM: support for hardware RNG, BCM2835 SD card controller, and GPIO
   controller when emulating Raspberry Pi board.
 * MIPS: support for MIPS Boston board on MIPS64EL =

 * Nios2: Initial support for Nios-II R1 boards, emulating 10M50 development
   kit with Nios2 GHRD loaded in the FPGA
 * OpenRISC: Lots of fixes and new instructions
 * PowerPC: support for many new POWER9 instructions via TCG emulation, new
   "40p" machine type, and pseries support for H_SIGNAL_SYS_RESET hypercall
 * s390: support for multiple buses for zPCI, virtio-crypto, and booting via
   network.
 * SPARC: rewritten support for Niagara
 * Tricore: support for many additional instructions
 * x86: support for 5-level paging under TCG emulation, caching mode support
   for emulation guest IOMMU, and SMI feature negotiation for q35 machines.
 * Xtensa: support for -icount

 * and lots more...

Thank you to everyone involved!
