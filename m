Received: from eggs.gnu.org ([2001:4830:134:3::10]:39065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffVxK-0000Hn-3u
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffVxD-0006Lj-GJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:48:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ffVxD-0006L9-5X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:48:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6HJiOCU106342
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:48:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k9jsutb04-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:48:09 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 17 Jul 2018 13:48:08 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 17 Jul 2018 14:47:59 -0500
Message-Id: <153185687946.16660.17907329356171463299@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.0.0-rc1 is now available
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

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 3.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.0.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-3.0.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 3.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.0

Please add entries to the ChangeLog for the 3.0 release below:

  http://wiki.qemu.org/ChangeLog/3.0

Thank you to everyone involved!

Changes since rc0:

ea6abffa8a: Update version for v3.0.0-rc1 release (Peter Maydell)
dfaa7d50b0: Document command line options with single dash (BALATON Zoltan)
0c2f6e7ee9: opts: remove redundant check for NULL parameter (Daniel P. Berr=
ang=C3=A9)
f8da93a0ff: i386: only parse the initrd_filename once for multiboot modules=
 (Daniel P. Berrang=C3=A9)
6e3ad3f0e3: i386: fix regression parsing multiboot initrd modules (Daniel P=
. Berrang=C3=A9)
ccf02d73d1: hw/arm/xlnx-zynqmp: Fix crash when introspecting the "xlnx, zyn=
qmp" device (Thomas Huth)
fe04f0b4a1: hw/display/xlnx_dp: Move problematic code from instance_init to=
 realize (Paolo Bonzini)
a39ae81637: hw/arm/stm32f205_soc: Fix introspection problem with 'stm32f205=
-soc' device (Thomas Huth)
cf3fccfa8c: hw/arm/allwinner-a10: Fix introspection problem with 'allwinner=
-a10' (Thomas Huth)
32db1b58ca: hw/*/realview: Fix introspection problem with 'realview_mpcore'=
 & 'realview_gic' (Thomas Huth)
b2bc349822: hw/cpu/arm11mpcore: Fix introspection problem with 'arm11mpcore=
_priv' (Thomas Huth)
aac409c9b0: hw/arm/fsl-imx31: Fix introspection problem with the "fsl, imx3=
1" device (Thomas Huth)
51dd12ac0e: hw/arm/fsl-imx25: Fix introspection problem with the "fsl, imx2=
5" device (Thomas Huth)
f8bf4b6d38: hw/arm/fsl-imx7: Fix introspection problems with the "fsl, imx7=
" device (Thomas Huth)
e9e4d4d3e1: hw/arm/fsl-imx6: Fix introspection problems with the "fsl, imx6=
" device (Thomas Huth)
2ba486e7db: hw/cpu/a9mpcore: Fix introspection problems with the "a9mpcore_=
priv" device (Thomas Huth)
d473a0309c: hw/arm/msf2-soc: Fix introspection problem with the "msf2-soc" =
device (Thomas Huth)
fd31701214: hw/cpu/a15mpcore: Fix introspection problem with the a15mpcore_=
priv device (Thomas Huth)
955cbc6b17: hw/arm/armv7: Fix crash when introspecting the "iotkit" device =
(Thomas Huth)
14c520e335: hw/arm/bcm2836: Fix crash with device_add bcm2837 on unsupporte=
d machines (Thomas Huth)
046f370fb4: hw/core/sysbus: Add a function for creating and attaching an ob=
ject (Thomas Huth)
0210b39d0e: qom/object: Add a new function object_initialize_child() (Thoma=
s Huth)
d9c745c176: qga: fix file descriptor leak (Paolo Bonzini)
bb23a7362a: qga: fix 'driver' leak in guest-get-fsinfo (Marc-Andr=C3=A9 Lur=
eau)
3474c98a2a: accel/tcg: Assert that tlb fill gave us a valid TLB entry (Pete=
r Maydell)
b493ccf1fc: accel/tcg: Use correct test when looking in victim TLB for code=
 (Peter Maydell)
65e9f27f22: bcm2835_aux: Swap RX and TX interrupt assignments (Guenter Roec=
k)
cccf96c3d4: hw/arm/bcm2836: Mark the bcm2836 / bcm2837 devices with user_cr=
eatable =3D false (Thomas Huth)
7995206d05: hw/intc/arm_gic: Fix handling of GICD_ITARGETSR (Peter Maydell)
ee03cca88e: hw/intc/arm_gic: Check interrupt number in gic_deactivate_irq()=
 (Peter Maydell)
333b9c8a68: aspeed: Implement write-1-{set, clear} for AST2500 strapping (A=
ndrew Jeffery)
628fc75f3a: target/arm: Fix LD1W and LDFF1W (scalar plus vector) (Richard H=
enderson)
8449bcf949: virtio-scsi: fix hotplug ->reset() vs event race (Stefan Hajnoc=
zi)
25e8978817: qdev: add HotplugHandler->post_plug() callback (Stefan Hajnoczi)
f3575af130: hw/char/serial: retry write if EAGAIN (Marc-Andr=C3=A9 Lureau)
0147883450: PC Chipset: Improve serial divisor calculation (Calvin Lee)
9ee8a692f1: vhost-user-test: added proper TestServer *dest initialization i=
n test_migrate() (Emanuele Giuseppe Esposito)
e9688fabc3: hyperv: ensure VP index equal to QEMU cpu_index (Roman Kagan)
1b2013ea5d: hyperv: rename vcpu_id to vp_index (Roman Kagan)
696c706642: accel: Fix typo and grammar in comment (Stefan Weil)
46fac17dca: dump: add kernel_gs_base to QEMU CPU state (Viktor Prutyanov)
8720e63e09: monitor: Fix tracepoint crash on JSON syntax error (Markus Armb=
ruster)
b02c9bc35a: MAINTAINERS: New section "Incompatible changes", copy libvir-li=
st (Markus Armbruster)
44c67847e3: qemu-doc: Move appendix "Deprecated features" to its own file (=
Markus Armbruster)
361ac948a5: cli qmp: Mark --preconfig, exit-preconfig experimental (Markus =
Armbruster)
1f214ee1b8: qapi: Do not expose "allow-preconfig" in query-qmp-schema (Mark=
us Armbruster)
6730df0514: sm501: Fix warning about unreachable code (BALATON Zoltan)
3cc702d6aa: sam460ex: Correct use after free error (BALATON Zoltan)
fd8e3381a0: etsec: fix IRQ (un)masking (Michael Davidsaver)
b585395b65: ppc/xics: fix ICP reset path (Greg Kurz)
ccc2cef8b3: spapr: Correct inverted test in spapr_pc_dimm_node() (David Gib=
son)
593a1cdd66: sm501: Update screen on frame buffer address change (BALATON Zo=
ltan)
1d3d1b23e1: Zero out the host's `msg_control` buffer (Jonas Schievink)
dc18baaef3: linux-user: fix mmap_find_vma_reserved() (Laurent Vivier)
af8ab2bf22: linux-user: convert remaining fcntl() to safe_fcntl() (Laurent =
Vivier)
4a5457616d: linux-user: ppc64: use the correct values for F_*LK64s (Shivapr=
asad G Bhat)
9277d81f5c: docs: Grammar and spelling fixes (Ville Skytt=C3=A4)
8dcd3c9b91: qemu-img: align result of is_allocated_sectors (Peter Lieven)
740842c965: scsi-disk: Block Device Characteristics emulation fix (Daniel H=
enrique Barboza)
2d4cb49dda: iotests: add test 226 for file driver types (John Snow)
230ff73904: file-posix: specify expected filetypes (John Snow)
eb461485f4: qemu-img: Document copy offloading implications with -S and -c =
(Fam Zheng)
2f9d4083f7: iotests: nbd: Stop qemu-nbd before remaking image (Fam Zheng)
0e1a582750: iotests: 153: Fix dead code (Fam Zheng)
dc3c89d612: ui/cocoa.m: replace scrollingDeltaY with deltaY (John Arbuckle)
056de1e894: seccomp: allow sched_setscheduler() with SCHED_IDLE policy (Mar=
c-Andr=C3=A9 Lureau)
26c0ae5638: vfio/pci: do not set the PCIDevice 'has_rom' attribute (C=C3=A9=
dric Le Goater)
42eab8dbec: monitor: fix double-free of request error (Marc-Andr=C3=A9 Lure=
au)
78dcf512ef: error: Remove NULL checks on error_propagate() calls (Philippe =
Mathieu-Daud=C3=A9)
17f4566657: s390x/storage attributes: fix CMMA_BLOCK_SIZE usage (Claudio Im=
brenda)
