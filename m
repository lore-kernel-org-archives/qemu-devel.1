Received: from eggs.gnu.org ([2001:4830:134:3::10]:51313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7IGG-0000i4-Cs
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7IGC-0001HB-Er
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:46:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:41558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7IGC-0001Fu-6F
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:46:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7IG8-0005P3-PG
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:46:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 897772E80E1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:45:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 09:38:27 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1727259 <1727259@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150892430716.18436.10907121916690603983.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1727259] [NEW] qemu-io-test 58 segfaults when
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

Public bug reported:

Head is at 3d7196d43bfe12efe98568cb60057e273652b99b

Steps to re-produce:
1. git clone
./configure --enable-gcov --target-list=3Dppc64-softmmu
make
cd tests/qemu-iotests

2. export qemu binary, in my environment
export QEMU_PROG=3D/home/nasastry/qemu_gcov/ppc64-softmmu/qemu-system-ppc64

3. Run test 58 with format qcow2
./check -qcow2 58

QEMU          -- "/home/nasastry/qemu_gcov/ppc64-softmmu/qemu-system-ppc64"=
 -nodefaults -machine accel=3Dqtest
QEMU_IMG      -- "/home/nasastry/qemu_gcov/qemu-img"
QEMU_IO       -- "/home/nasastry/qemu_gcov/qemu-io"  --cache writeback -f q=
cow2
QEMU_NBD      -- "/home/nasastry/qemu_gcov/qemu-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64le zzfp365-lp1 4.13.0-4.rel.git49564cb.el7.cent=
os.ppc64le
TEST_DIR      -- /home/nasastry/qemu_gcov/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- /home/nasastry/qemu_gcov/tests/qemu-iotests/socket_scm=
_helper

058 1s ... - output mismatch (see 058.out.bad)
--- /home/nasastry/qemu_gcov/tests/qemu-iotests/058.out	2017-10-09 14:09:04=
.262726912 +0530
+++ /home/nasastry/qemu_gcov/tests/qemu-iotests/058.out.bad	2017-10-25 15:0=
0:52.037515025 +0530
@@ -19,16 +19,28 @@
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 =3D=3D verifying the exported snapshot with patterns, method 1 =3D=3D
-read 4096/4096 bytes at offset 4096
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4096/4096 bytes at offset 8192
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: line 66: 36255 Segmentation fault      (core dumped) ( if [ "=
${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D99=
 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+else
+    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+fi )
+./common.rc: line 66: 36262 Segmentation fault      (core dumped) ( if [ "=
${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D99=
 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+else
+    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+fi )

 =3D=3D verifying the exported snapshot with patterns, method 2 =3D=3D
-read 4096/4096 bytes at offset 4096
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4096/4096 bytes at offset 8192
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: line 66: 36274 Segmentation fault      (core dumped) ( if [ "=
${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D99=
 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+else
+    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+fi )
+./common.rc: line 66: 36282 Segmentation fault      (core dumped) ( if [ "=
${VALGRIND_QEMU}" =3D=3D "y" ]; then
+    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D99=
 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+else
+    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
+fi )

 =3D=3D verifying the converted snapshot with patterns, method 1 =3D=3D
 read 4096/4096 bytes at offset 4096
Failures: 058
Failed 1 of 1 tests

with out gcov configured this test case is pass.
# ./check -qcow2 58
QEMU          -- "/home/nasastry/qemu/ppc64-softmmu/qemu-system-ppc64" -nod=
efaults -machine accel=3Dqtest
QEMU_IMG      -- "/home/nasastry/qemu/qemu-img"
QEMU_IO       -- "/home/nasastry/qemu/qemu-io"  --cache writeback -f qcow2
QEMU_NBD      -- "/home/nasastry/qemu/qemu-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64le zzfp365-lp1 4.13.0-4.rel.git49564cb.el7.cent=
os.ppc64le
TEST_DIR      -- /home/nasastry/qemu/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- /home/nasastry/qemu/tests/qemu-iotests/socket_scm_help=
er

058 0s ...
Passed all 1 tests

** Affects: qemu
     Importance: Undecided
         Status: New

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
