Received: from eggs.gnu.org ([209.51.188.92]:38765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmKlx-0001ez-3t
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmKlu-0008M1-Ay
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:48:59 -0500
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
Date: Wed, 23 Jan 2019 16:48:49 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e5HSHuadfPpOw1o0O9W9FgXW0t5uPIqSs"
Subject: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Luiz Capitulino <lcapitulino@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e5HSHuadfPpOw1o0O9W9FgXW0t5uPIqSs
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
Subject: Aborts in iotest 169
Content-Type: multipart/mixed;
 boundary="------------C8016B7E4A4305E1A99BBECE"

--------------C8016B7E4A4305E1A99BBECE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

When running 169 in parallel (e.g. like so:

$ while TEST_DIR=3D/tmp/t0 ./check -T -qcow2 169; do; done
$ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 169; do; done
$ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 169; do; done
$ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 169; do; done

in four different shells), I get aborts:

(Often I get segfaults, but that's because of
http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html --
feel free to apply the attached patch to make them go away)


WARNING:qemu:qemu received signal 6:
build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
-chardev socket,id=3Dmon,path=3D/tmp/t0/tmpbX30XU/qemua-25745-monitor.soc=
k
-mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
unix:path=3D/tmp/t0/qemua-25745-qtest.sock -machine accel=3Dqtest
-nodefaults -machine accel=3Dqtest -drive
if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t0/disk_a,format=3Dqcow2,cache=3Dwrit=
eback
=2E................E..
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR:
test_do_test_migration_resume_source_not_persistent__not_migbitmap
(__main__.TestDirtyBitmapMigration)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "169", line 206, in <lambda>
    setattr(klass, 'test_' + method + name, lambda self: mc(self))
  File "169", line 113, in do_test_migration_resume_source
    self.check_bitmap(self.vm_a, sha256)
  File "169", line 72, in check_bitmap
    node=3D'drive0', name=3D'bitmap0')
  File "tests/qemu-iotests/../../scripts/qemu.py", line 369, in qmp
    return self._qmp.cmd(cmd, args=3Dqmp_args)
  File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 191, in cmd
    return self.cmd_obj(qmp_cmd)
  File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 174, in cmd_ob=
j
    resp =3D self.__json_read()
  File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 82, in
__json_read
    data =3D self.__sockfile.readline()
  File "/usr/lib64/python2.7/socket.py", line 451, in readline
    data =3D self._sock.recv(self._rbufsize)
error: [Errno 104] Connection reset by peer

----------------------------------------------------------------------
Ran 20 tests

FAILED (errors=3D1)


Or:

WARNING:qemu:qemu received signal 6:
build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
-chardev socket,id=3Dmon,path=3D/tmp/t3/tmp0pllWD/qemua-3445-monitor.sock=

-mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
unix:path=3D/tmp/t3/qemua-3445-qtest.sock -machine accel=3Dqtest -nodefau=
lts
-machine accel=3Dqtest -drive
if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t3/disk_a,format=3Dqcow2,cache=3Dwrit=
eback
WARNING:qemu:qemu received signal 6:
build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
-chardev socket,id=3Dmon,path=3D/tmp/t3/tmp0pllWD/qemua-3445-monitor.sock=

-mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
unix:path=3D/tmp/t3/qemua-3445-qtest.sock -machine accel=3Dqtest -nodefau=
lts
-machine accel=3Dqtest -drive
if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t3/disk_a,format=3Dqcow2,cache=3Dwrit=
eback

=2E..................F
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
FAIL: test_do_test_migration_resume_source_persistent__not_migbitmap
(__main__.TestDirtyBitmapMigration)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "169", line 206, in <lambda>
    setattr(klass, 'test_' + method + name, lambda self: mc(self))
  File "169", line 125, in do_test_migration_resume_source
    self.assertEqual(log, '')
AssertionError: "qemu-system-x86_64: invalid runstate transition:
'running' -> 'postmigrate'\n" !=3D ''

----------------------------------------------------------------------
Ran 20 tests

FAILED (failures=3D1)


The backtrace always goes like this:

(gdb) bt
#0  0x00007f0acf5cc53f in raise () at /lib64/libc.so.6
#1  0x00007f0acf5b6895 in abort () at /lib64/libc.so.6
#2  0x000055a46ebbb1a6 in runstate_set (new_state=3DRUN_STATE_POSTMIGRATE=
)
at vl.c:742
#3  0x000055a46ebbb1a6 in runstate_set
(new_state=3Dnew_state@entry=3DRUN_STATE_POSTMIGRATE) at vl.c:730
#4  0x000055a46ed39129 in migration_iteration_finish (s=3D0x55a4708be000)=

at migration/migration.c:2972
#5  0x000055a46ed39129 in migration_thread
(opaque=3Dopaque@entry=3D0x55a4708be000) at migration/migration.c:3130
#6  0x000055a46eea665a in qemu_thread_start (args=3D<optimized out>) at
util/qemu-thread-posix.c:502


#7  0x00007f0acf76258e in start_thread () at /lib64/libpthread.so.0
#8  0x00007f0acf6916a3 in clone () at /lib64/libc.so.6
(gdb) frame 2
#2  0x000055a46ebbb1a6 in runstate_set (new_state=3DRUN_STATE_POSTMIGRATE=
)
at vl.c:742
742             abort();
(gdb) print current_run_state
$1 =3D RUN_STATE_RUNNING


Neither of migration or runstates are my strong suite, so I thought I'd
report it before diving into it.

Max

--------------C8016B7E4A4305E1A99BBECE
Content-Type: text/x-patch;
 name="0001-Hack-to-fix-race-in-tcp_chr_disconnect.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-Hack-to-fix-race-in-tcp_chr_disconnect.patch"

=46rom 4f141f42f2ae8cf509495ee0962fd45e160f33af Mon Sep 17 00:00:00 2001
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 16:48:07 +0100
Subject: [PATCH] Hack to fix race in tcp_chr_disconnect()

---
 chardev/char-socket.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index eaa8e8b68f..9c326dcbf3 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -124,7 +124,12 @@ static void tcp_chr_accept(QIONetListener *listener,=

                            void *opaque);
=20
 static int tcp_chr_read_poll(void *opaque);
-static void tcp_chr_disconnect(Chardev *chr);
+static void tcp_chr_do_disconnect(Chardev *chr, bool locked);
+
+static void tcp_chr_disconnect(Chardev *chr)
+{
+    tcp_chr_do_disconnect(chr, false);
+}
=20
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
@@ -148,7 +153,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
=20
         if (ret < 0 && errno !=3D EAGAIN) {
             if (tcp_chr_read_poll(chr) <=3D 0) {
-                tcp_chr_disconnect(chr);
+                tcp_chr_do_disconnect(chr, true);
                 return len;
             } /* else let the read handler finish it properly */
         }
@@ -444,8 +449,12 @@ static void update_disconnected_filename(SocketChard=
ev *s)
  * reached, due to TLS or telnet initialization failure,
  * so can *not* assume s->connected =3D=3D true
  */
-static void tcp_chr_disconnect(Chardev *chr)
+static void tcp_chr_do_disconnect(Chardev *chr, bool locked)
 {
+    if (!locked) {
+        qemu_mutex_lock(&chr->chr_write_lock);
+    }
+
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     bool emit_close =3D s->connected;
=20
@@ -462,6 +471,10 @@ static void tcp_chr_disconnect(Chardev *chr)
     if (s->reconnect_time) {
         qemu_chr_socket_restart_timer(chr);
     }
+
+    if (!locked) {
+        qemu_mutex_unlock(&chr->chr_write_lock);
+    }
 }
=20
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
--=20
2.20.1


--------------C8016B7E4A4305E1A99BBECE--

--e5HSHuadfPpOw1o0O9W9FgXW0t5uPIqSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIjOEACgkQ9AfbAGHV
z0CvEAgAwxd/5nWgb9cxK6dUFILLsNh8rVRAZ69xt8FbdAdbSNo0/wvPZl41jx5a
mDGx8qKU3AmTrSd62ekqQ2w530HnSeG+XXE3i3d4Y5GDvTsHzQ6zIJvETegv5h4k
A2XouNdlPEtwyF8624UnbbCq10EivPz+thKkosg1R7z6micwG5Fim/wUMIRPfj7z
DSE5AA4vHpeQKcOxgP461vNFo8aONWMtNQEyGzNN27JfeKbUfBD3A/OpSJV5PoPB
3uFJ8xTmszL+KnRG+GMHx4MjD/I1PKra0E3m5YSNnMhGtI/xTHOEUHbIvLfFaAVh
mSV3auSYf0GWjK1nc9OCpG0cmxRIDg==
=9ZnX
-----END PGP SIGNATURE-----

--e5HSHuadfPpOw1o0O9W9FgXW0t5uPIqSs--
