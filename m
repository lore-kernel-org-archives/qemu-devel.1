Received: from eggs.gnu.org ([2001:4830:134:3::10]:56635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7IPx-0000qu-Aa
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7IPu-0004LN-2T
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:56:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:44586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7IPt-0004K7-PZ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:56:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7IPq-0006vE-NB
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:56:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 09FBD2E80CE
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:55:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 09:45:21 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1727250 <1727250@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150892252192.18283.8177817026945520523.malonedeb@chaenomeles.canonical.com>
Message-Id: <150892472134.28011.8623623369664241925.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1727250] Re: qemu-io-test 147 segfaults when
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

qemu-iotest 194 also fails in the similar stack trace.

# ./check -qcow2 194
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

194 1s ... [failed, exit status 1] - output mismatch (see 194.out.bad)
--- /home/nasastry/qemu_gcov/tests/qemu-iotests/194.out	2017-10-09 14:09:04=
.272726282 +0530
+++ /home/nasastry/qemu_gcov/tests/qemu-iotests/194.out.bad	2017-10-25 15:1=
3:26.630139740 +0530
@@ -1,18 +1,18 @@
+WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-soft=
mmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu_g=
cov/tests/qemu-iotests/scratch/qemusource-38326-monitor.sock -mon chardev=
=3Dmon,mode=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasa=
stry/qemu_gcov/tests/qemu-iotests/scratch/qemusource-38326-qtest.sock -mach=
ine accel=3Dqtest -nodefaults -machine accel=3Dqtest -drive if=3Dvirtio,id=
=3Ddrive0,file=3D/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/38326-=
source.img,format=3Dqcow2,cache=3Dwriteback
 Launching VMs...
 Launching NBD server on destination...
 {u'return': {}}
 {u'return': {}}
 Starting `drive-mirror` on source...
-{u'return': {}}
+None
 Waiting for `drive-mirror` to complete...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u=
'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 10737418=
24, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
-Starting migration...
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u=
'status': u'setup'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u=
'status': u'active'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u=
'status': u'completed'}, u'event': u'MIGRATION'}
-Gracefully ending the `drive-mirror` job on source...
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u=
'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 10737418=
24, u'offset': 1073741824}, u'event': u'BLOCK_JOB_COMPLETED'}
-Stopping the NBD server on destination...
-{u'return': {}}
+Traceback (most recent call last):
+  File "194", line 60, in <module>
+    iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
+  File "/home/nasastry/qemu_gcov/tests/qemu-iotests/../../scripts/qemu.py"=
, line 319, in event_wait
+    event =3D self._qmp.pull_event(wait=3Dtimeout)
+  File "/home/nasastry/qemu_gcov/tests/qemu-iotests/../../scripts/qmp/qmp.=
py", line 216, in pull_event
+    self.__get_events(wait)
+  File "/home/nasastry/qemu_gcov/tests/qemu-iotests/../../scripts/qmp/qmp.=
py", line 128, in __get_events
+    raise QMPConnectError("Error while reading from socket")
+qmp.qmp.QMPConnectError: Error while reading from socket
Failures: 194
Failed 1 of 1 tests

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1727250

Title:
  qemu-io-test 147 segfaults when configured with gcov

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

  3. Run test 147 with format qcow2
  ./check -qcow2 147

  QEMU          -- "/home/nasastry/qemu_gcov/ppc64-softmmu/qemu-system-ppc6=
4" -nodefaults -machine accel=3Dqtest
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

  147 0s ... [failed, exit status 1] - output mismatch (see 147.out.bad)
  --- /home/nasastry/qemu/tests/qemu-iotests/147.out	2017-10-25 14:04:54.97=
8600753 +0530
  +++ /home/nasastry/qemu/tests/qemu-iotests/147.out.bad	2017-10-25 14:09:5=
3.769783770 +0530
  @@ -1,5 +1,95 @@
  -......
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +FFFFFF
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_fd (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 203, in test_fd
  +    self.client_test(filename, flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_inet (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 146, in test_inet
  +    flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_inet6 (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 171, in test_inet6
  +    self.client_test(filename, flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_unix (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 179, in test_unix
  +    flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_inet (__main__.QemuNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 96, in test_inet
  +    flatten_sock_addr(address))
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_unix (__main__.QemuNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 103, in test_unix
  +    flatten_sock_addr(address))
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
   ----------------------------------------------------------------------
   Ran 6 tests

  -OK
  +FAILED (failures=3D6)
  Failures: 147
  Failed 1 of 1 tests

  With out gcov configured, the above test get pass.
  export QEMU_PROG=3D/home/nasastry/qemu/ppc64-softmmu/qemu-system-ppc64
  ./check -qcow2 147
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

  147
  Passed all 1 tests

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1727250/+subscriptions
