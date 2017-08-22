Received: from eggs.gnu.org ([2001:4830:134:3::10]:34555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk7s4-0003kz-Am
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dk7ry-0003lS-BJ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:01:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:37845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dk7ry-0003lI-2d
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:01:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dk7rw-0006oo-Ea
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 12:01:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 642302E80CB
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 12:01:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Aug 2017 11:46:59 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150340241947.19716.11322764336680128548.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with qemu
 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

repeated the assert in #26:
Program received signal SIGABRT, Aborted.
0x00007f02163005f7 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/sysdeps/u=
nix/sysv/linux/raise.c:56
56	  return INLINE_SYSCALL (tgkill, 3, pid, selftid, sig);
(gdb) where
#0  0x00007f02163005f7 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/sysde=
ps/unix/sysv/linux/raise.c:56
#1  0x00007f0216301ce8 in __GI_abort () at abort.c:90
#2  0x00007f02162f9566 in __assert_fail_base (fmt=3D0x7f0216449288 "%s%s%s:=
%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x560ac0=
191e93 "!ioc->write_coroutine", file=3Dfile@entry=3D0x560ac0191e66 "/root/q=
emu/io/channel.c", line=3Dline@entry=3D303, function=3Dfunction@entry=3D0x5=
60ac0191f60 <__PRETTY_FUNCTION__.22239> "qio_channel_yield")
    at assert.c:92
#3  0x00007f02162f9612 in __GI___assert_fail (assertion=3Dassertion@entry=
=3D0x560ac0191e93 "!ioc->write_coroutine", file=3Dfile@entry=3D0x560ac0191e=
66 "/root/qemu/io/channel.c", line=3Dline@entry=3D303, function=3Dfunction@=
entry=3D0x560ac0191f60 <__PRETTY_FUNCTION__.22239> "qio_channel_yield") at =
assert.c:101
#4  0x0000560ac0036a08 in qio_channel_yield (ioc=3Dioc@entry=3D0x560ac2397c=
90, condition=3Dcondition@entry=3DG_IO_OUT)
    at /root/qemu/io/channel.c:303
#5  0x0000560ac001930e in nbd_rwv (ioc=3D0x560ac2397c90, iov=3D<optimized o=
ut>, niov=3D<optimized out>, length=3D<optimized out>, do_read=3Ddo_read@en=
try=3Dfalse, errp=3Derrp@entry=3D0x0) at /root/qemu/nbd/common.c:47
#6  0x0000560ac0007e24 in nbd_co_send_request (bs=3Dbs@entry=3D0x560ac30167=
a0, request=3Drequest@entry=3D0x7f0209afc9a0, qiov=3Dqiov@entry=3D0x560ac24=
28d68) at /root/qemu/block/nbd-client.c:154
#7  0x0000560ac0008244 in nbd_client_co_pwritev (bs=3D0x560ac30167a0, offse=
t=3D3414163456, bytes=3D<optimized out>, qiov=3D0x560ac2428d68, flags=3D<op=
timized out>) at /root/qemu/block/nbd-client.c:260
#8  0x0000560ac00030e1 in bdrv_driver_pwritev (bs=3Dbs@entry=3D0x560ac30167=
a0, offset=3Doffset@entry=3D3414163456, bytes=3Dbytes@entry=3D589824, qiov=
=3Dqiov@entry=3D0x560ac2428d68, flags=3Dflags@entry=3D0) at /root/qemu/bloc=
k/io.c:877
#9  0x0000560ac0004480 in bdrv_aligned_pwritev (req=3Dreq@entry=3D0x7f0209a=
fcba0, offset=3Doffset@entry=3D3414163456, bytes=3D589824, align=3Dalign@en=
try=3D1, qiov=3Dqiov@entry=3D0x560ac2428d68, flags=3Dflags@entry=3D0, child=
=3D0x560ac1f0a9b0, child=3D0x560ac1f0a9b0) at /root/qemu/block/io.c:1382
#10 0x0000560ac0005258 in bdrv_co_pwritev (child=3D0x560ac1f0a9b0, offset=
=3Doffset@entry=3D3414163456, bytes=3D<optimized out>, qiov=3Dqiov@entry=3D=
0x560ac2428d68, flags=3D0) at /root/qemu/block/io.c:1633
#11 0x0000560abffbf564 in raw_co_pwritev (bs=3D0x560ac22807f0, offset=3D341=
4163456, bytes=3D<optimized out>, qiov=3D0x560ac2428d68, flags=3D<optimized=
 out>) at /root/qemu/block/raw-format.c:243
#12 0x0000560ac00030e1 in bdrv_driver_pwritev (bs=3Dbs@entry=3D0x560ac22807=
f0, offset=3Doffset@entry=3D3414163456, bytes=3Dbytes@entry=3D589824, qiov=
=3Dqiov@entry=3D0x560ac2428d68, flags=3Dflags@entry=3D0) at /root/qemu/bloc=
k/io.c:877
#13 0x0000560ac0004480 in bdrv_aligned_pwritev (req=3Dreq@entry=3D0x7f0209a=
fce70, offset=3Doffset@entry=3D3414163456, bytes=3D589824, align=3Dalign@en=
try=3D1, qiov=3Dqiov@entry=3D0x560ac2428d68, flags=3Dflags@entry=3D0, child=
=3D0x560ac33c1e70, child=3D0x560ac33c1e70) at /root/qemu/block/io.c:1382
#14 0x0000560ac0005258 in bdrv_co_pwritev (child=3D0x560ac33c1e70, offset=
=3Doffset@entry=3D3414163456, bytes=3D<optimized out>, bytes@entry=3D589824=
, qiov=3Dqiov@entry=3D0x560ac2428d68, flags=3D0) at /root/qemu/block/io.c:1=
633
#15 0x0000560abfff5173 in blk_co_pwritev (blk=3D0x560ac14f31e0, offset=3D34=
14163456, bytes=3D589824, qiov=3D0x560ac2428d68, flags=3D<optimized out>) a=
t /root/qemu/block/block-backend.c:1062
#16 0x0000560abfff528a in blk_aio_write_entry (opaque=3D0x560ac2c18f70) at =
/root/qemu/block/block-backend.c:1253
#17 0x0000560ac0092cca in coroutine_trampoline (i0=3D<optimized out>, i1=3D=
<optimized out>)
    at /root/qemu/util/coroutine-ucontext.c:79
#18 0x00007f0216312110 in __start_context () at /lib64/libc.so.6
#19 0x00007fff12c4db30 in  ()
#20 0x0000000000000000 in  ()
(gdb)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711602

Title:
  --copy-storage-all failing with qemu 2.10

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Confirmed
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  We fixed an issue around disk locking already in regard to qemu-nbd
  [1], but there still seem to be issues.

  $ virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh=
://10.22.69.196/system
  error: internal error: qemu unexpectedly closed the monitor: 2017-08-18T1=
2:10:29.800397Z qemu-system-x86_64: -chardev pty,id=3Dcharserial0: char dev=
ice redirected to /dev/pts/0 (label charserial0)
  2017-08-18T12:10:48.545776Z qemu-system-x86_64: load of migration failed:=
 Input/output error

  Source libvirt log for the guest:
  2017-08-18 12:09:08.251+0000: initiating migration
  2017-08-18T12:09:08.809023Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer
  2017-08-18T12:09:08.809481Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer

  Target libvirt log for the guest:
  2017-08-18T12:09:08.730911Z qemu-system-x86_64: load of migration failed:=
 Input/output error
  2017-08-18 12:09:09.010+0000: shutting down, reason=3Dcrashed

  Given the timing it seems that the actual copy now works (it is busy ~10 =
seconds on my environment which would be the copy).
  Also we don't see the old errors we saw before, but afterwards on the act=
ual take-over it fails.

  Dmesg has no related denials as often apparmor is in the mix.

  Need to check libvirt logs of source [2] and target [3] in Detail.

  [1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02200.html
  [2]: http://paste.ubuntu.com/25339356/
  [3]: http://paste.ubuntu.com/25339358/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711602/+subscriptions
