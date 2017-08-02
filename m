Received: from eggs.gnu.org ([2001:4830:134:3::10]:38319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dczdE-0002I3-3F
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 15:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dczd9-0002Be-Nv
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 15:48:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dczd9-0002Ao-2Y
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 15:48:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v72JjDg7129919
	for <qemu-devel@nongnu.org>; Wed, 2 Aug 2017 15:48:29 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c3h6qv654-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 15:48:29 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 2 Aug 2017 15:48:27 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <150170194851.27115.7749410999055362925@loki>
References: <150170194851.27115.7749410999055362925@loki>
Date: Wed, 02 Aug 2017 14:48:20 -0500
Message-Id: <150170330073.27115.18126877482339553709@loki>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc1 is now available
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

Quoting Michael Roth (2017-08-02 14:25:48)
> Hello,
> =

> On behalf of the QEMU Team, I'd like to announce the availability of the
> second release candidate for the QEMU 2.10 release.  This release is meant
> for testing purposes and should not be used in a production environment.
> =

>   http://download.qemu-project.org/qemu-2.10.0-rc1.tar.xz
>   http://download.qemu-project.org/qemu-2.10.0-rc1.tar.xz.sig
> =

> You can help improve the quality of the QEMU 2.10 release by testing this
> release and reporting bugs on Launchpad:
> =

>   https://bugs.launchpad.net/qemu/
> =

> The release plan, as well a documented known issues for release
> candidates, are available at:
> =

>   http://wiki.qemu.org/Planning/2.10
> =

> Please add entries to the ChangeLog for the 2.10 release below:
> =

>   http://wiki.qemu.org/ChangeLog/2.10
> =

> =


Changes since rc0:

aaaec6a: Update version for v2.10.0-rc1 release (Peter Maydell)
bbcee37: tests/hmp: Fix typo in the 'chardev-send-break' test (Thomas Huth)
8bd9c4e: io: fix qio_channel_socket_accept err handling (Peter Xu)
2dfaf12: migration: fix comment disorder in RAMState (Peter Xu)
b91bf5e: migration: fix small leaks (Marc-Andr=C3=A9 Lureau)
3a3fcc7: pc: acpi: force FADT rev1 for 440fx based machine types (Igor Mamm=
edov)
208fa0e: pc: make 'pc.rom' readonly when machine has PCI enabled (Igor Mamm=
edov)
41d4e5e: vhost-user: fix watcher need be removed when vhost-user hotplug (Y=
unjian Wang)
91c38e0: tests/bios-tables-test: Compiler warning fix (Dr. David Alan Gilbe=
rt)
2f6b38d: accel: cleanup error output (Laurent Vivier)
07f7b73: intel_iommu: use access_flags for iotlb (Peter Xu)
892721d: intel_iommu: fix iova for pt (Peter Xu)
5df04f1: vhost-user: fix legacy cross-endian configurations (Felipe Francio=
si)
08b9e0b: vhost: fix a memory leak (Peng Hao)
2cef91c: tests: switch pxe and vm gen id tests to use kvm (Michael S. Tsirk=
in)
8e8eb0a: block/qapi: Remove redundant NULL check to silence Coverity (Kevin=
 Wolf)
59fa68f: qemu-iotests/059: Fix leaked image files (Kevin Wolf)
1803f3f: qemu-iotests/063: Fix leaked image (Kevin Wolf)
a8e9c84: qemu-iotests/162: Fix leaked temporary files (Kevin Wolf)
6a1e909: qemu-iotests/153: Fix leaked scratch images (Kevin Wolf)
0a1505d: qemu-iotests/141: Fix image cleanup (Kevin Wolf)
0e59607: qemu-iotests: Remove blkdebug.conf after tests (Kevin Wolf)
db11d1e: qemu-iotests/041: Fix leaked scratch images (Kevin Wolf)
180ca19: block: fix leaks in bdrv_open_driver() (Manos Pitsidianakis)
998cbd6: block: fix dangling bs->explicit_options in block.c (Manos Pitsidi=
anakis)
b81b74b: iotests: Add test of recent fix to 'qemu-img measure' (Eric Blake)
1e2b1f6: iotests: Check dirty bitmap statistics in 124 (Eric Blake)
c09bd34: iotests: Redirect stderr to stdout in 186 (Max Reitz)
645acdc: iotests: Fix test 156 (Max Reitz)
33f21e4: mc146818rtc: implement UIP latching as intended (Paolo Bonzini)
6a51d83: mc146818rtc: simplify check_update_timer (Paolo Bonzini)
da3a392: rtc-test: introduce more update tests (Paolo Bonzini)
bc706fa: rtc-test: cleanup register_b_set_flag test (Paolo Bonzini)
fafeb41: hw/scsi/vmw_pvscsi: Convert to realize (Mao Zhongyi)
dfaea0c: hw/scsi/vmw_pvscsi: Remove the dead error handling (Mao Zhongyi)
1931076: migration: optimize the downtime (Jay Zhou)
8bfce83: qemu-options: document existance of versioned machine types (Danie=
l P. Berrange)
393c13b: bt: stop the sdp memory allocation craziness (Paolo Bonzini)
f5aa69b: exec: Add lock parameter to qemu_ram_ptr_length (Anthony PERARD)
4fadfa0: target-i386: kvm_get/put_vcpu_events don't handle sipi_vector (Pen=
g Hao)
eb22aec: docs: document deprecation policy & deprecated features in appendi=
x (Daniel P. Berrange)
0ec846b: char: don't exit on hmp 'chardev-add help' (Anton Nefedov)
4db0db1: char-fd: remove useless chr pointer (Marc-Andr=C3=A9 Lureau)
d73f024: accel: cleanup error output (Laurent Vivier)
f70d345: cpu_physical_memory_sync_dirty_bitmap: Fix alignment check (Dr. Da=
vid Alan Gilbert)
452589b: vl.c/exit: pause cpus before closing block devices (Dr. David Alan=
 Gilbert)
bd6952a: monitor: Reduce handle_qmp_command() tracing overhead (Denis V. Lu=
nev)
8908eb1: trace-events: fix code style: print 0x before hex numbers (Vladimi=
r Sementsov-Ogievskiy)
c3e5875: checkpatch: check trace-events code style (Vladimir Sementsov-Ogie=
vskiy)
db73ee4: trace-events: fix code style: %# -> 0x% (Vladimir Sementsov-Ogievs=
kiy)
44c6d63: coding_style: add point about 0x in trace-events (Vladimir Sements=
ov-Ogievskiy)
d87aa13: trace: add trace_event_get_state_backends() (Stefan Hajnoczi)
3932ef3: trace: add TRACE_<event>_BACKEND_DSTATE() (Stefan Hajnoczi)
ea1ff54: trace: ensure unique function / variable names per .stp file (Dani=
el P. Berrange)
ed86505: trace: ensure .stp files are rebuilt if trace tool source changes =
(Daniel P. Berrange)
bdf211f: Revert "syscall: fix dereference of undefined pointer" (Peter Mayd=
ell)
89cbc37: hw/mps2_scc: fix incorrect properties (Philippe Mathieu-Daud=C3=A9)
f1a4694: target/arm: Migrate MPU_RNR register state for M profile cores (Pe=
ter Maydell)
69ceea6: target/arm: Move PMSAv7 reset into arm_cpu_reset() so M profile MP=
Us get reset (Peter Maydell)
8531eb4: target/arm: Rename cp15.c6_rgnr to pmsav7.rnr (Peter Maydell)
bf446a1: target/arm: Don't allow guest to make System space executable for =
M profile (Peter Maydell)
38aaa60: target/arm: Don't do MPU lookups for addresses in M profile PPB re=
gion (Peter Maydell)
709e440: target/arm: Correct MPU trace handling of write vs execute (Peter =
Maydell)
25e11d8: docs: fix broken paths to docs/specs/ivshmem-spec.txt (Philippe Ma=
thieu-Daud=C3=A9)
f31fd5c: docs: fix broken paths to docs/config/ich9-ehci-uhci.cfg (Philippe=
 Mathieu-Daud=C3=A9)
87e0331: docs: fix broken paths to docs/devel/tracing.txt (Philippe Mathieu=
-Daud=C3=A9)
b208ac0: docs: fix broken paths to docs/devel/atomics.txt (Philippe Mathieu=
-Daud=C3=A9)
b3125e7: docs: fix broken paths to docs/devel/qapi-code-gen.txt (Philippe M=
athieu-Daud=C3=A9)
f3fdeb9: docs: fix broken paths to docs/interop/qcow2.txt (Philippe Mathieu=
-Daud=C3=A9)
cfb41b8: docs: fix broken paths to docs/interop dir (Cleber Rosa)
a44af72: thunk: assert nb_fields is valid (Philippe Mathieu-Daud=C3=A9)
b929f7e: syscall: check inotify() and eventfd() return value (Philippe Math=
ieu-Daud=C3=A9)
6860710: syscall: fix use of uninitialized values (Philippe Mathieu-Daud=C3=
=A9)
bc658e4: syscall: fix dereference of undefined pointer (Philippe Mathieu-Da=
ud=C3=A9)
72cd500: linux-user/sh4: fix incorrect memory write (Philippe Mathieu-Daud=
=C3=A9)
4b5660e: m68k/translate: fix incorrect copy/paste (Philippe Mathieu-Daud=C3=
=A9)
b2caa3b: net/eth: fix incorrect check of iov_to_buf() return value (Philipp=
e Mathieu-Daud=C3=A9)
9f26f32: ui/vnc: fix leak of SocketAddress ** (Philippe Mathieu-Daud=C3=A9)
f80ac75: qcow2: fix null pointer dereference (Philippe Mathieu-Daud=C3=A9)
b7b1e9d: ivshmem: fix incorrect error handling in ivshmem_recv_msg() (Phili=
ppe Mathieu-Daud=C3=A9)
2a4e2e4: loader: check get_image_size() return value (Philippe Mathieu-Daud=
=C3=A9)
b94b330: tests: add missing dependency to build QTEST_QEMU_BINARY (Philippe=
 Mathieu-Daud=C3=A9)
b190f47: qemu-system-tricore: segfault when entering "x 0" on the monitor (=
Eduardo Otubo)
7a0b7eb: build-sys: there is no qemu-ga.c (Marc-Andr=C3=A9 Lureau)
d616c12: tests: test-netfilter && pxe-test require slirp (Marc-Andr=C3=A9 L=
ureau)
1b61270: MAINTAINERS: Improve the NetBSD regex pattern (Thomas Huth)
36bed54: fix qemu-system-unicore32 crashing when calling without -kernel (E=
duardo Otubo)
80792eb: tests: check-qom-proplist: fix leak (Marc-Andr=C3=A9 Lureau)
fc7e076: Revert "spapr: populate device tree depending on XIVE_EXPLOIT opti=
on" (David Gibson)
bf26ae3: spapr_drc: fix realize and unrealize (Greg Kurz)
158b9aa: nbd: fix memory leak in nbd_opt_go() (Philippe Mathieu-Daud=C3=A9)
665df90: Revert "elf-loader: warn about invalid endianness" (Alexey Kardash=
evskiy)
3ee3122: hw/mips: load_elf_strerror to report kernel loading failure (Aurel=
ien Jarno)
ef58430: ui: add pause key to linux_to_qcode (Gerd Hoffmann)
103dce8: ui: drop ac_search and ac_stop (Gerd Hoffmann)
e92316a: ui: correctly detect spice PAUSE scancode sequence (Daniel P. Berr=
ange)
4add0da: s390x/css: fix bits must be zero check for TIC (Halil Pasic)
198c0d1: s390x/css: check ccw address validity (Halil Pasic)
98987d3: target/s390x: fix pgm irq ilen in translate_pages() (David Hildenb=
rand)
031631c: target/s390x: fix pgm irq ilen for stsi (David Hildenbrand)
7c388db: ps2: fix sending of PAUSE/BREAK scancodes (Daniel P. Berrange)
912092b: ui: drop altgr and altgr_r QKeyCodes (Gerd Hoffmann)
0500cb1: ps2: enable multimedia keys (Gerd Hoffmann)
37810e8: ui: add multimedia keys (Gerd Hoffmann)
9ade775: ui: update keymaps (Gerd Hoffmann)
606eb0c: ui: move qemu_input_linux_to_qcode() (Gerd Hoffmann)
d52a1a9: ui: add next and prior keysyms (Gerd Hoffmann)
bd18202: target/i386: Don't use x86_cpu_load_def() on "max" CPU model (Edua=
rdo Habkost)
7d8050b: target/i386: Define CPUID_MODEL_ID_SZ macro (Eduardo Habkost)
bfef624: target/i386: Use host_vendor_fms() in max_x86_cpu_initfn() (Eduard=
o Habkost)
96d2c2c: vfio/pci: fix use of freed memory (Philippe Mathieu-Daud=C3=A9)
418c698: vfio/platform: fix use of freed memory (Philippe Mathieu-Daud=C3=
=A9)
