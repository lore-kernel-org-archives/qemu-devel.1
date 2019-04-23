Received: from eggs.gnu.org ([209.51.188.92]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hJ2PN-0003gK-Cn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hJ2PJ-00052o-GB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:52:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36030
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hJ2PF-0004st-Nf
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:52:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3NKnXRW136857
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:52:36 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s28whu2tt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:52:36 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 23 Apr 2019 21:52:35 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2019 15:52:22 -0500
Message-Id: <155605274242.20501.8592407664900944363@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0 is now available
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
the QEMU 4.0.0 release. This release contains 3100+ commits from 220
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/4.0

Highlights include:

 * ARM: ARMv8+ extensions for SB, PredInv, HPD, LOR, FHM, AA32HPD,
   PAuth, JSConv, CondM, FRINT, and BTI
 * ARM: new emulation support for "Musca" and "MPS2" development boards
 * ARM: virt: support for >255GB of RAM and u-boot "noload" image types
 * ARM: improved emulation of ARM PMU
 * HPPA: support for TLB protection IDs and TLB trace events
 * MIPS: support for multi-threaded TCG emulation
 * MIPS: emulation support for I7200 I6500 CPUs, QMP-base querying of
   CPU types, and improved support for SAARI and SAAR configuration registe=
rs
 * MIPS: improvements to Interthread Communication Unit, Fulong 2E
   machine types, and end-user documentation.
 * PowerPC: pseries/powernv: support for POWER9 large decrementer
 * PowerPC: pseries: emulation support for XIVE interrupt controller
 * PowerPC: pseries: support for hotplugging PCI host bridges (PHBs)
 * PowerPC: pseries: Spectre/Meltdown mitigations enabled by default,
   additional support for count-cache-flush mitigation
 * RISC-V: virt: support for PCI and USB
 * RISC-V: support for TSR, TW, and TVM fields of mstatus, FS field now
   supports three stats (dirty, clean, and off)
 * RISC-V: built-in gdbserver supports register lists via XML files
 * s390: support for z14 GA 2 CPU model, Multiple-epoch and PTFF
   features now enabled in z14 CPU model by default
 * s390: vfio-ap: now supports hot plug/unplug, and no longer inhibits memo=
ry
   ballooning
 * s390: emulation support for floating-point extension facility and
   vector support instructions
 * x86: HAX accelerator now supported POSIX hosts other than Darwin,
   including Linux and NetBSD
 * x86: Q35: advertised PCIe root port speeds will now optimally default
   to maximum link speed (16GT/s) and width (x32) provided by PCIe 4.0 for
   QEMU 4.0+ machine types; older machine types will retain 2.5GT/x1
   defaults for compatibility.
 * x86: Xen PVH images can now be booted with "-kernel" option
 * Xtensa: xtfpga: improved SMP support for linux (interrupt
   distributor, IPI, and runstall) and new SMP-capable test_mmuhifi_c3
   core configuration
 * Xtensa: support for Flexible length instructions extension (FLIX)

 * GUI: new '-display spice-app' to configure/launch a Spice client GUI with
   a similar UI to QEMU GTK. VNC server now supports access controls via
   tls-authz/sasl-authz options
 * QMP: support for "out-of-band" command execution, can be useful for
   postcopy migration recovery. Additional QMP commands for working with
   block devices and dirty bitmaps
 * VFIO: EDID interface for supported mdev (Intel vGPU for kernel 5.0+),
   allows resolution setting via xres/yres options.
 * Xen: new 'xen-disk' device which can create a Xen PV disk backend,
   and performance improvements for Xen PV disk backend.
 * Network Block Device: improved tracing and error diagnostics, improved
   client compatibility with buggy NBD server implementations, new
   --bitmap, --list, --tls-authz options for qemu-nbd
 * virtio-blk now supports DISCARD and WRITE_ZEROES
 * pvrdma device now supports RDMA Management Datagram services (MAD)

 * and lots more...

Thank you to everyone involved!
