Received: from eggs.gnu.org ([2001:4830:134:3::10]:36825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gWnLc-0004WC-N9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gWnLY-0005ws-JM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:05:36 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:41230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gWnLY-0005uN-53
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:05:32 -0500
Received: by mail-oi1-x22d.google.com with SMTP id j21so12915580oii.8
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:05:30 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <154455512153.28741.3157946439353911526@sif>
Date: Tue, 11 Dec 2018 13:05:21 -0600
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.1.0 is now available
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
the QEMU 3.1.0 release. This release contains 1900+ commits from 189
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/3.1

Highlights include:

 * ARM: emulation support for microbit and Xilinx Versal machine models
 * ARM: support for ARMv6M architecture and Cortex-M0 CPU model
 * ARM: support for Cortex-A72 CPU model
 * ARM: virt/xlnx-zynqmp: virtualization extensions for GICv2 interrupt
   controller
 * ARM: emulation of AArch32 virtualization/hypervisor mode now supported
   for Cortex-A7 and Corex-A15
 * MIPS: emulation support for nanoMIPS I7200
 * MIPS: emulation support for MXU SIMD instructions for MIPS32
 * PowerPC: pseries: enablement of nested virtualization via KVM-HV
 * PowerPC: prep: deprecated in favor of 40p machine model
 * Powerpc: 40p: IRQ routing fixes, switch from Open HackWare to OpenBIOS
 * PowerPC: g3beige/mac99: support for booting from virtio-blk-pci
 * s390: VFIO passthrough support for crypto devices (vfio-ap)
 * s390: KVM support for backing guests with huge pages
 * SPARC: sun4u: support for booting from virtio-blk-pci
 * x86: multi-threaded TCG support
 * x86: KVM support for Enlightened VMCS (improved perf for Hyper-V on KVM)
 * x86: KVM support for Hyper-V IPI enlightenments
 * Xtensa: support for input from chardev consoles

 * Support for AMD IOMMU interrupt remapping and guest virtual APIC mode
 * XTS cipher mode is now ~2x faster
 * stdvga and bocks-display devices can expose EDID information to guest,
   (for use with xres/yres resolution options)
 * qemu-img tool can now generate LUKS-encrypted files through 'convert' co=
mmand

 * and lots more...

Thank you to everyone involved!
