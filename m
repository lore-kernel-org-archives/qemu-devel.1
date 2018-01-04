Received: from eggs.gnu.org ([2001:4830:134:3::10]:51200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXC0Z-0001bm-JZ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXC0V-0002EI-E2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:20:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:58524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eXC0V-0002DA-7M
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:20:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eXC0T-0005cy-1n
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 20:20:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 28CA92E8190
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 20:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jan 2018 20:14:38 -0000
From: =?utf-8?q?Murilo_Opsfelder_Ara=C3=BAjo?= <1727259@bugs.launchpad.net>
Reply-To: Bug 1727259 <1727259@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150892430716.18436.10907121916690603983.malonedeb@chaenomeles.canonical.com>
Message-Id: <151509687931.23749.6576953462825733343.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1727259] Re: qemu-io-test 58 segfaults when
 configured with gcov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'll work on this.

** Changed in: qemu
     Assignee: (unassigned) =3D> Murilo Opsfelder Ara=C3=BAjo (mopsfelder)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1727259

Title:
  qemu-io-test 58 segfaults when configured with gcov

Status in QEMU:
  New

Bug description:
  Head is at 3d7196d43bfe12efe98568cb60057e273652b99b

  Steps to re-produce:
  1. git clone
  ./configure --enable-gcov --target-list=3Dppc64-softmmu
  make
  cd tests/qemu-iotests

  2. export qemu binary, in my environment
  export QEMU_PROG=3D/home/nasastry/qemu_gcov/ppc64-softmmu/qemu-system-ppc=
64

  3. Run test 58 with format qcow2
  ./check -qcow2 58

  QEMU          -- "/home/nasastry/qemu_gcov/ppc64-softmmu/qemu-system-ppc6=
4" -nodefaults -machine accel=3Dqtest
  QEMU_IMG      -- "/home/nasastry/qemu_gcov/qemu-img"
  QEMU_IO       -- "/home/nasastry/qemu_gcov/qemu-io"  --cache writeback -f=
 qcow2
  QEMU_NBD      -- "/home/nasastry/qemu_gcov/qemu-nbd"
  IMGFMT        -- qcow2 (compat=3D1.1)
  IMGPROTO      -- file
  PLATFORM      -- Linux/ppc64le zzfp365-lp1 4.13.0-4.rel.git49564cb.el7.ce=
ntos.ppc64le
  TEST_DIR      -- /home/nasastry/qemu_gcov/tests/qemu-iotests/scratch
  SOCKET_SCM_HELPER -- /home/nasastry/qemu_gcov/tests/qemu-iotests/socket_s=
cm_helper

  058 1s ... - output mismatch (see 058.out.bad)
  --- /home/nasastry/qemu_gcov/tests/qemu-iotests/058.out	2017-10-09 14:09:=
04.262726912 +0530
  +++ /home/nasastry/qemu_gcov/tests/qemu-iotests/058.out.bad	2017-10-25 15=
:00:52.037515025 +0530
  @@ -19,16 +19,28 @@
   4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

   =3D=3D verifying the exported snapshot with patterns, method 1 =3D=3D
  -read 4096/4096 bytes at offset 4096
  -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  -read 4096/4096 bytes at offset 8192
  -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  +./common.rc: line 66: 36255 Segmentation fault      (core dumped) ( if [=
 "${VALGRIND_QEMU}" =3D=3D "y" ]; then
  +    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +else
  +    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +fi )
  +./common.rc: line 66: 36262 Segmentation fault      (core dumped) ( if [=
 "${VALGRIND_QEMU}" =3D=3D "y" ]; then
  +    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +else
  +    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +fi )

   =3D=3D verifying the exported snapshot with patterns, method 2 =3D=3D
  -read 4096/4096 bytes at offset 4096
  -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  -read 4096/4096 bytes at offset 8192
  -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  +./common.rc: line 66: 36274 Segmentation fault      (core dumped) ( if [=
 "${VALGRIND_QEMU}" =3D=3D "y" ]; then
  +    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +else
  +    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +fi )
  +./common.rc: line 66: 36282 Segmentation fault      (core dumped) ( if [=
 "${VALGRIND_QEMU}" =3D=3D "y" ]; then
  +    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +else
  +    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
  +fi )

   =3D=3D verifying the converted snapshot with patterns, method 1 =3D=3D
   read 4096/4096 bytes at offset 4096
  Failures: 058
  Failed 1 of 1 tests

  with out gcov configured this test case is pass.
  # ./check -qcow2 58
  QEMU          -- "/home/nasastry/qemu/ppc64-softmmu/qemu-system-ppc64" -n=
odefaults -machine accel=3Dqtest
  QEMU_IMG      -- "/home/nasastry/qemu/qemu-img"
  QEMU_IO       -- "/home/nasastry/qemu/qemu-io"  --cache writeback -f qcow2
  QEMU_NBD      -- "/home/nasastry/qemu/qemu-nbd"
  IMGFMT        -- qcow2 (compat=3D1.1)
  IMGPROTO      -- file
  PLATFORM      -- Linux/ppc64le zzfp365-lp1 4.13.0-4.rel.git49564cb.el7.ce=
ntos.ppc64le
  TEST_DIR      -- /home/nasastry/qemu/tests/qemu-iotests/scratch
  SOCKET_SCM_HELPER -- /home/nasastry/qemu/tests/qemu-iotests/socket_scm_he=
lper

  058 0s ...
  Passed all 1 tests

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1727259/+subscriptions
