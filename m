Received: from eggs.gnu.org ([2001:4830:134:3::10]:46860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC0hA-00039P-3t
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC0go-0005rP-Pr
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:01:24 -0500
Received: from indium.canonical.com ([91.189.90.7]:44948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC0go-0005pe-H5
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:01:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC0gm-0005K3-JJ
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 10:01:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 90BC72E80CB
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 10:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 09:47:35 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1713434 <1713434@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150391152035.18876.7874968547091336063.malonedeb@chaenomeles.canonical.com>
Message-Id: <151004805599.4519.13564216444967898463.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1713434] Re: prom-env-test test aborted and core
 dumped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Similar failure seen with the following test too.

# make check-qtest-sparc64 V=3D1
(cd /home/nasastry/qemu; printf '#define QEMU_PKGVERSION '; if test -n ""; =
then printf '""\n'; else if test -d .git; then printf '" ('; git describe -=
-match 'v*' 2>/dev/null | tr -d '\n'; if ! git diff-index --quiet HEAD &>/d=
ev/null; then printf -- '-dirty'; fi; printf ')"\n'; else printf '""\n'; fi=
; fi) > qemu-version.h.tmp
if ! cmp -s qemu-version.h qemu-version.h.tmp; then mv qemu-version.h.tmp q=
emu-version.h; else rm qemu-version.h.tmp; fi
make -C /home/nasastry/qemu/capstone CAPSTONE_SHARED=3Dno BUILDDIR=3D"/home=
/nasastry/qemu/capstone" CC=3D"cc" AR=3D"ar" LD=3D"ld" CFLAGS=3D"-fprofile-=
arcs -ftest-coverage -g -g -I/usr/include/pixman-1 -DHAS_LIBSSH2_SFTP_FSYNC=
 -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -pthread -I=
/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -DNCURSES_WIDECHAR -fPI=
E -DPIE -m64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fn=
o-strict-aliasing -fno-common -fwrapv -fstack-protector-strong -I/usr/inclu=
de/p11-kit-1 -I/usr/include/libpng15 -I/home/nasastry/qemu/capstone/include=
 -I/home/nasastry/qemu/tests -DCAPSTONE_USE_SYS_DYN_MEM -DCAPSTONE_HAS_ARM =
-DCAPSTONE_HAS_ARM64 -DCAPSTONE_HAS_POWERPC -DCAPSTONE_HAS_X86"  BUILD_DIR=
=3D/home/nasastry/qemu /home/nasastry/qemu/capstone/libcapstone.a
make[1]: Entering directory `/home/nasastry/qemu/capstone'
make[1]: `/home/nasastry/qemu/capstone/libcapstone.a' is up to date.
make[1]: Leaving directory `/home/nasastry/qemu/capstone'
make  BUILD_DIR=3D/home/nasastry/qemu -C sparc64-softmmu V=3D"1" TARGET_DIR=
=3D"sparc64-softmmu/" all
make[1]: Entering directory `/home/nasastry/qemu/sparc64-softmmu'
make[1]: Leaving directory `/home/nasastry/qemu/sparc64-softmmu'
QTEST_QEMU_BINARY=3Dsparc64-softmmu/qemu-system-sparc64 QTEST_QEMU_IMG=3Dqe=
mu-img MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} g=
tester -k --verbose -m=3Dquick tests/endianness-test tests/prom-env-test te=
sts/qmp-test tests/device-introspect-test tests/qom-test tests/test-hmp
TEST: tests/endianness-test... (pid=3D72117)
  /sparc64/endianness/sun4u:                                           OK
  /sparc64/endianness/split/sun4u:                                     OK
  /sparc64/endianness/combine/sun4u:                                   OK
PASS: tests/endianness-test
TEST: tests/prom-env-test... (pid=3D72128)
  /sparc64/prom-env/sun4u:                                             **
ERROR:tests/prom-env-test.c:42:check_guest_memory: assertion failed (signat=
ure =3D=3D MAGIC): (0x00000000 =3D=3D 0xcafec0de)
FAIL
GTester: last random seed: R02S54a8565ad2895d49d8d1b0dc99da7044
(pid=3D74068)
FAIL: tests/prom-env-test
TEST: tests/qmp-test... (pid=3D74069)
  /sparc64/qmp/protocol:                                               OK
  /sparc64/qmp/qom-list-types:                                         OK
  /sparc64/qmp/query-acpi-ospm-status:                                 OK
  /sparc64/qmp/query-balloon:                                          OK
  /sparc64/qmp/query-block:                                            OK
  /sparc64/qmp/query-block-jobs:                                       OK
  /sparc64/qmp/query-blockstats:                                       OK
  /sparc64/qmp/query-chardev:                                          OK
  /sparc64/qmp/query-chardev-backends:                                 OK
  /sparc64/qmp/query-command-line-options:                             OK
  /sparc64/qmp/query-commands:                                         OK
  /sparc64/qmp/query-cpus:                                             OK
  /sparc64/qmp/query-dump:                                             OK
  /sparc64/qmp/query-dump-guest-memory-capability:                     OK
  /sparc64/qmp/query-events:                                           OK
  /sparc64/qmp/query-fdsets:                                           OK
  /sparc64/qmp/query-hotpluggable-cpus:                                OK
  /sparc64/qmp/query-iothreads:                                        OK
  /sparc64/qmp/query-kvm:                                              OK
  /sparc64/qmp/query-machines:                                         OK
  /sparc64/qmp/query-memdev:                                           OK
  /sparc64/qmp/query-memory-devices:                                   OK
  /sparc64/qmp/query-memory-size-summary:                              OK
  /sparc64/qmp/query-mice:                                             OK
  /sparc64/qmp/query-migrate:                                          OK
  /sparc64/qmp/query-migrate-cache-size:                               OK
  /sparc64/qmp/query-migrate-capabilities:                             OK
  /sparc64/qmp/query-migrate-parameters:                               OK
  /sparc64/qmp/query-name:                                             OK
  /sparc64/qmp/query-named-block-nodes:                                OK
  /sparc64/qmp/query-qmp-schema:                                       OK
  /sparc64/qmp/query-rx-filter:                                        OK
  /sparc64/qmp/query-spice:                                            OK
  /sparc64/qmp/query-status:                                           OK
  /sparc64/qmp/query-target:                                           OK
  /sparc64/qmp/query-tpm:                                              OK
  /sparc64/qmp/query-tpm-models:                                       OK
  /sparc64/qmp/query-tpm-types:                                        OK
  /sparc64/qmp/query-uuid:                                             OK
  /sparc64/qmp/query-version:                                          OK
  /sparc64/qmp/query-vm-generation-id:                                 OK
  /sparc64/qmp/query-vnc:                                              OK
  /sparc64/qmp/query-vnc-servers:                                      OK
  /sparc64/qmp/query-xen-replication-status:                           OK
PASS: tests/qmp-test
TEST: tests/device-introspect-test... (pid=3D74165)
  /sparc64/device/introspect/list:                                     OK
  /sparc64/device/introspect/list-fields:                              OK
  /sparc64/device/introspect/none:                                     OK
  /sparc64/device/introspect/abstract:                                 OK
  /sparc64/device/introspect/concrete:                                 OK
  /sparc64/device/introspect/abstract-interfaces:                      OK
PASS: tests/device-introspect-test
TEST: tests/qom-test... (pid=3D74181)
  /sparc64/qom/sun4v:                                                  OK
  /sparc64/qom/none:                                                   OK
  /sparc64/qom/sun4u:                                                  OK
  /sparc64/qom/niagara:                                                OK
PASS: tests/qom-test
TEST: tests/test-hmp... (pid=3D74199)
  /sparc64/hmp/sun4v:                                                  OK
  /sparc64/hmp/none:                                                   OK
  /sparc64/hmp/sun4u:                                                  OK
  /sparc64/hmp/niagara:                                                OK
  /sparc64/hmp/none+2MB:                                               OK
PASS: tests/test-hmp
make: *** [check-qtest-sparc64] Error 1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1713434

Title:
  prom-env-test test aborted and core dumped

Status in QEMU:
  In Progress

Bug description:
  On ppc64le architecture machine the following test case Aborted and
  Core dumped.

  # tests/prom-env-test --quiet --keep-going -m=3Dquick --GTestLogFD=3D6
  **
  ERROR:tests/libqtest.c:628:qtest_get_arch: assertion failed: (qemu !=3D N=
ULL)
  Aborted (core dumped)

  Steps to re-produce:
  clone from the git
  configure & compile =

  run the unit tests by 'make check'

  (gdb) bt
  #0  0x00003fff9d60eff0 in raise () from /lib64/libc.so.6
  #1  0x00003fff9d61136c in abort () from /lib64/libc.so.6
  #2  0x00003fff9de1aa04 in g_assertion_message () from /lib64/libglib-2.0.=
so.0
  #3  0x00003fff9de1ab0c in g_assertion_message_expr () from /lib64/libglib=
-2.0.so.0
  #4  0x000000001000cc30 in qtest_get_arch () at tests/libqtest.c:628
  #5  0x00000000100048f0 in main (argc=3D5, argv=3D0x3ffff2145538) at tests=
/prom-env-test.c:82
  (gdb) i r
  r0             0xfa	250
  r1             0x3ffff2144d30	70368510627120
  r2             0x3fff9d7b9900	70367091333376
  r3             0x0	0
  r4             0x12a7	4775
  r5             0x6	6
  r6             0x8	8
  r7             0x1	1
  r8             0x0	0
  r9             0x0	0
  r10            0x0	0
  r11            0x0	0
  r12            0x0	0
  r13            0x3fff9dfa1950	70367099623760
  r14            0x0	0
  r15            0x0	0
  r16            0x0	0
  r17            0x0	0
  r18            0x0	0
  r19            0x0	0
  r20            0x0	0
  r21            0x0	0
  r22            0x0	0
  r23            0x0	0
  r24            0x0	0
  r25            0x0	0
  r26            0x0	0
  r27            0x100287f8	268601336
  r28            0x16841b40	377756480
  r29            0x4c	76
  r30            0x3ffff2144de8	70368510627304
  r31            0x6	6
  pc             0x3fff9d60eff0	0x3fff9d60eff0 <raise+96>
  msr            0x900000000280f033	10376293541503627315
  cr             0x42000842	1107298370
  lr             0x3fff9d61136c	0x3fff9d61136c <abort+396>
  ctr            0x0	0
  xer            0x0	0
  orig_r3        0x12a7	4775
  trap           0xc00	3072

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1713434/+subscriptions
