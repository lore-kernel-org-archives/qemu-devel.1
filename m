Received: from eggs.gnu.org ([2001:4830:134:3::10]:51361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7IGM-0000nv-Rg
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7IGC-0001HE-Em
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:46:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:41556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7IGC-0001Fq-5u
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:46:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7IG9-0005Rb-7l
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:46:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 79D6C2E80E8
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:45:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 09:39:09 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1727259 <1727259@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150892430716.18436.10907121916690603983.malonedeb@chaenomeles.canonical.com>
Message-Id: <150892434933.17420.15613583951571269004.malone@gac.canonical.com>
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

from demsg:
[84831.506917] qemu-io[35971]: unhandled signal 11 at 0000000000000004 nip =
00007fffae20f7d4 lr 00000000102d3ec8 code 30001
[84831.519551] qemu-io[35977]: unhandled signal 11 at 0000000000000004 nip =
00007fff9925f7d4 lr 00000000102d3ec8 code 30001
[84831.634000] qemu-io[35990]: unhandled signal 11 at 0000000000000004 nip =
00007fff86b4f7d4 lr 00000000102d3ec8 code 30001
[84831.646318] qemu-io[35997]: unhandled signal 11 at 0000000000000004 nip =
00007fffa165f7d4 lr 00000000102d3ec8 code 30001

from gdb:
(gdb) bt
#0  0x00007fff8c75f7d4 in __strcmp_power9 () from /lib64/libc.so.6
#1  0x00000000102d3ec8 in find_desc_by_name (desc=3D0x1036d6f0, name=3D0x28=
e46670 "server.path") at util/qemu-option.c:166
#2  0x00000000102d93e0 in qemu_opts_absorb_qdict (opts=3D0x28e47a80, qdict=
=3D0x28e469a0, errp=3D0x7fffec247c98) at util/qemu-option.c:1026
#3  0x000000001012a2e4 in nbd_open (bs=3D0x28e42290, options=3D0x28e469a0, =
flags=3D24578, errp=3D0x7fffec247d80) at block/nbd.c:406
#4  0x00000000100144e8 in bdrv_open_driver (bs=3D0x28e42290, drv=3D0x1036e0=
70 <bdrv_nbd_unix>, node_name=3D0x0, options=3D0x28e469a0, open_flags=3D245=
78, errp=3D0x7fffec247f50) at block.c:1135
#5  0x0000000010015b04 in bdrv_open_common (bs=3D0x28e42290, file=3D0x0, op=
tions=3D0x28e469a0, errp=3D0x7fffec247f50) at block.c:1395
#6  0x000000001001bee8 in bdrv_open_inherit (filename=3D0x7fffec24f2c2 "nbd=
:unix:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_soc=
ket", reference=3D0x0, options=3D0x28e469a0, flags=3D57346, parent=3D0x28e3=
bf90,
    child_role=3D0x102fa980 <child_file>, errp=3D0x7fffec248150) at block.c=
:2615
#7  0x000000001001a620 in bdrv_open_child_bs (filename=3D0x7fffec24f2c2 "nb=
d:unix:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_so=
cket", options=3D0x28e40250, bdref_key=3D0x102fb618 "file", parent=3D0x28e3=
bf90,
    child_role=3D0x102fa980 <child_file>, allow_none=3Dtrue, errp=3D0x7fffe=
c248150) at block.c:2314
#8  0x000000001001b9c0 in bdrv_open_inherit (filename=3D0x7fffec24f2c2 "nbd=
:unix:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_soc=
ket", reference=3D0x0, options=3D0x28e40250, flags=3D24578, parent=3D0x0,
    child_role=3D0x0, errp=3D0x7fffec248310) at block.c:2566
#9  0x000000001001c70c in bdrv_open (filename=3D0x7fffec24f2c2 "nbd:unix:/h=
ome/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_socket", re=
ference=3D0x0, options=3D0x28e3af70, flags=3D16386, errp=3D0x7fffec248310)
    at block.c:2697
#10 0x00000000100e7664 in blk_new_open (filename=3D0x7fffec24f2c2 "nbd:unix=
:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_socket",=
 reference=3D0x0, options=3D0x28e3af70, flags=3D16386, errp=3D0x7fffec24831=
0)
    at block/block-backend.c:321
#11 0x000000001000b57c in openfile (name=3D0x7fffec24f2c2 "nbd:unix:/home/n=
asastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_socket", flags=
=3D16386, writethrough=3Dfalse, force_share=3Dfalse, opts=3D0x28e3af70) at =
qemu-io.c:81
#12 0x000000001000e388 in main (argc=3D11, argv=3D0x7fffec248a38) at qemu-i=
o.c:624
(gdb) bt full
#0  0x00007fff8c75f7d4 in __strcmp_power9 () from /lib64/libc.so.6
No symbol table info available.
#1  0x00000000102d3ec8 in find_desc_by_name (desc=3D0x1036d6f0, name=3D0x28=
e46670 "server.path") at util/qemu-option.c:166
        i =3D 7
#2  0x00000000102d93e0 in qemu_opts_absorb_qdict (opts=3D0x28e47a80, qdict=
=3D0x28e469a0, errp=3D0x7fffec247c98) at util/qemu-option.c:1026
        local_err =3D 0x0
        state =3D {opts =3D 0x28e47a80, errp =3D 0x7fffec247bd0}
        entry =3D 0x28e46640
        next =3D 0x28e479e0
#3  0x000000001012a2e4 in nbd_open (bs=3D0x28e42290, options=3D0x28e469a0, =
flags=3D24578, errp=3D0x7fffec247d80) at block/nbd.c:406
        s =3D 0x28e48740
        opts =3D 0x28e47a80
        local_err =3D 0x0
        sioc =3D 0x0
        tlscreds =3D 0x0
        hostname =3D 0x0
        ret =3D -22
        __func__ =3D "nbd_open"
#4  0x00000000100144e8 in bdrv_open_driver (bs=3D0x28e42290, drv=3D0x1036e0=
70 <bdrv_nbd_unix>, node_name=3D0x0, options=3D0x28e469a0, open_flags=3D245=
78, errp=3D0x7fffec247f50) at block.c:1135
        local_err =3D 0x0
        ret =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_open_driver"
        __func__ =3D "bdrv_open_driver"
#5  0x0000000010015b04 in bdrv_open_common (bs=3D0x28e42290, file=3D0x0, op=
tions=3D0x28e469a0, errp=3D0x7fffec247f50) at block.c:1395
        ret =3D 0
        open_flags =3D 24578
        filename =3D 0x0
        driver_name =3D 0x28e47c00 "nbd"
        node_name =3D 0x0
        discard =3D 0x28e47ce0 "unmap"
        detect_zeroes =3D 0x0
        opts =3D 0x28e47ad0
        drv =3D 0x1036e070 <bdrv_nbd_unix>
        local_err =3D 0x0
        __PRETTY_FUNCTION__ =3D "bdrv_open_common"
        __func__ =3D "bdrv_open_common"
#6  0x000000001001bee8 in bdrv_open_inherit (filename=3D0x7fffec24f2c2 "nbd=
:unix:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_soc=
ket", reference=3D0x0, options=3D0x28e469a0, flags=3D57346, parent=3D0x28e3=
bf90,
    child_role=3D0x102fa980 <child_file>, errp=3D0x7fffec248150) at block.c=
:2615
        ret =3D 0
        file =3D 0x0
        bs =3D 0x28e42290
        drv =3D 0x1036e070 <bdrv_nbd_unix>
        drvname =3D 0x28e46750 "nbd"
        backing =3D 0x0
        local_err =3D 0x0
        snapshot_options =3D 0x0
        snapshot_flags =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_open_inherit"
        __func__ =3D "bdrv_open_inherit"
#7  0x000000001001a620 in bdrv_open_child_bs (filename=3D0x7fffec24f2c2 "nb=
d:unix:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_so=
cket", options=3D0x28e40250, bdref_key=3D0x102fb618 "file", parent=3D0x28e3=
bf90,
    child_role=3D0x102fa980 <child_file>, allow_none=3Dtrue, errp=3D0x7fffe=
c248150) at block.c:2314
        bs =3D 0x0
        image_options =3D 0x28e41270
        bdref_key_dot =3D 0x28e29a60 ""
        reference =3D 0x0
        __PRETTY_FUNCTION__ =3D "bdrv_open_child_bs"
        __func__ =3D "bdrv_open_child_bs"
#8  0x000000001001b9c0 in bdrv_open_inherit (filename=3D0x7fffec24f2c2 "nbd=
:unix:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_soc=
ket", reference=3D0x0, options=3D0x28e40250, flags=3D24578, parent=3D0x0,
    child_role=3D0x0, errp=3D0x7fffec248310) at block.c:2566
        file_bs =3D 0x7fffec2481c0
        ret =3D 0
        file =3D 0x0
        bs =3D 0x28e3bf90
        drv =3D 0x10354b40 <bdrv_raw>
        drvname =3D 0x28e29440 "raw"
        backing =3D 0x0
        local_err =3D 0x0
        snapshot_options =3D 0x0
---Type <return> to continue, or q <return> to quit---
        snapshot_flags =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_open_inherit"
        __func__ =3D "bdrv_open_inherit"
#9  0x000000001001c70c in bdrv_open (filename=3D0x7fffec24f2c2 "nbd:unix:/h=
ome/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_socket", re=
ference=3D0x0, options=3D0x28e3af70, flags=3D16386, errp=3D0x7fffec248310)
    at block.c:2697
No locals.
#10 0x00000000100e7664 in blk_new_open (filename=3D0x7fffec24f2c2 "nbd:unix=
:/home/nasastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_socket",=
 reference=3D0x0, options=3D0x28e3af70, flags=3D16386, errp=3D0x7fffec24831=
0)
    at block/block-backend.c:321
        blk =3D 0x28e294b0
        bs =3D 0x7fffec248280
        perm =3D 3
#11 0x000000001000b57c in openfile (name=3D0x7fffec24f2c2 "nbd:unix:/home/n=
asastry/qemu_gcov/tests/qemu-iotests/scratch/test_qemu_nbd_socket", flags=
=3D16386, writethrough=3Dfalse, force_share=3Dfalse, opts=3D0x28e3af70) at =
qemu-io.c:81
        local_err =3D 0x0
#12 0x000000001000e388 in main (argc=3D11, argv=3D0x7fffec248a38) at qemu-i=
o.c:624
        readonly =3D 0
        sopt =3D 0x102fa128 "hVc:d:f:rsnCmkt:T:U"
        lopt =3D {{name =3D 0x102fa1f8 "help", has_arg =3D 0, flag =3D 0x0,=
 val =3D 104}, {name =3D 0x102fa200 "version", has_arg =3D 0, flag =3D 0x0,=
 val =3D 86}, {name =3D 0x102fa208 "cmd", has_arg =3D 1, flag =3D 0x0, val =
=3D 99}, {
            name =3D 0x102fa210 "format", has_arg =3D 1, flag =3D 0x0, val =
=3D 102}, {name =3D 0x102fa218 "read-only", has_arg =3D 0, flag =3D 0x0, va=
l =3D 114}, {name =3D 0x102fa228 "snapshot", has_arg =3D 0, flag =3D 0x0, v=
al =3D 115}, {
            name =3D 0x102fa238 "nocache", has_arg =3D 0, flag =3D 0x0, val=
 =3D 110}, {name =3D 0x102fa240 "copy-on-read", has_arg =3D 0, flag =3D 0x0=
, val =3D 67}, {name =3D 0x102fa250 "misalign", has_arg =3D 0, flag =3D 0x0=
, val =3D 109}, {
            name =3D 0x102fa260 "native-aio", has_arg =3D 0, flag =3D 0x0, =
val =3D 107}, {name =3D 0x102fa270 "discard", has_arg =3D 1, flag =3D 0x0, =
val =3D 100}, {name =3D 0x102fa278 "cache", has_arg =3D 1, flag =3D 0x0, va=
l =3D 116}, {
            name =3D 0x102fa280 "trace", has_arg =3D 1, flag =3D 0x0, val =
=3D 84}, {name =3D 0x102fa108 "object", has_arg =3D 1, flag =3D 0x0, val =
=3D 256}, {name =3D 0x102fa288 "image-opts", has_arg =3D 0, flag =3D 0x0, v=
al =3D 257}, {
            name =3D 0x102f9768 "force-share", has_arg =3D 0, flag =3D 0x0,=
 val =3D 85}, {name =3D 0x0, has_arg =3D 0, flag =3D 0x0, val =3D 0}}
        c =3D -1
        opt_index =3D 11
        flags =3D 16386
        writethrough =3D false
        local_error =3D 0x0
        opts =3D 0x28e3af70
        format =3D 0x7fffec24f28f "raw"
        trace_file =3D 0x0
        force_share =3D false

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
