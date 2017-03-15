Received: from eggs.gnu.org ([2001:4830:134:3::10]:48919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coBbH-0000Ji-BC
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coBbD-0004yB-Gt
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:34624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1coBbD-0004xn-8M
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:16:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1coBbB-00017h-HD
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 16:16:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B0372E80C8
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 16:16:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Mar 2017 16:05:25 -0000
From: Mohammed Gamal <m.gamal005@gmail.com>
Reply-To: Bug 1673130 <1673130@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170315160255.23768.27906.malonedeb@gac.canonical.com>
Message-Id: <20170315160525.23946.25713.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673130] Re: qemu 2.7.0 receives SIGABRT in
 qemu_coroutine_enter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Another stack trace:

--------------------------------------------------------------------------
(gdb) bt
#0  0x00007f2f34690067 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/sysde=
ps/unix/sysv/linux/raise.c:56
#1  0x00007f2f34691448 in __GI_abort () at abort.c:89
#2  0x00005629b8260b6c in qemu_coroutine_enter (co=3D0x7f2cd6a00940) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
#3  0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cd6a00880) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#4  0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cd6a00880) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#5  0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cee202b00) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#6  0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cee202b00) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#7  0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cee2141d0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#8  0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cee2141d0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#9  0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf300b370) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#10 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf300b370) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#11 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf1a03560) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#12 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf1a03560) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#13 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf3e15ba0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#14 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf3e15ba0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#15 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2ce80087f0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#16 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2ce80087f0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#17 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cee20d9c0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#18 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cee20d9c0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#19 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2ceff04850) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#20 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2ceff04850) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#21 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf21061c0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#22 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf21061c0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#23 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf2105c00) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#24 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf2105c00) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#25 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf3e1d590) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#26 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf3e1d590) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#27 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf3e16a00) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#28 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf3e16a00) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#29 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2ce8004da0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#30 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2ce8004da0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#31 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf3e15dc0) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#32 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf3e15dc0) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#33 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2ccff00420) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#34 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2ccff00420) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#35 0x00005629b8260e74 in qemu_co_queue_run_restart (co=3D0x7f2cf1e04900) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
#36 0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cf1e04900) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
#37 0x00005629b8260fa0 in qemu_co_enter_next (queue=3Dqueue@entry=3D0x5629b=
a5e35e0) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:=
106
#38 0x00005629b81ff060 in timer_cb (blk=3D0x5629ba5e3590, is_write=3D<optim=
ized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/block/throttle-groups.c:4=
00
#39 0x00005629b81bc615 in timerlist_run_timers (timer_list=3D0x5629ba64fd40=
) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:528
#40 0x00005629b81bc679 in timerlistgroup_run_timers (tlg=3Dtlg@entry=3D0x56=
29bb9cd758) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:564
#41 0x00005629b81bcf47 in aio_dispatch (ctx=3Dctx@entry=3D0x5629bb9cd610) a=
t /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:357
#42 0x00005629b81bd0e8 in aio_poll (ctx=3D0x5629bb9cd610, blocking=3D<optim=
ized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:479
#43 0x00005629b801ec79 in iothread_run (opaque=3D0x5629bb9cd3c0) at /build/=
pb-qemu-pssKUp/pb-qemu-2.7.0/iothread.c:46
#44 0x00007f2f34a0e0a4 in start_thread (arg=3D0x7f2f12fff700) at pthread_cr=
eate.c:403
#45 0x00007f2f3474362d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:111
--------------------------------------------------------------------------

Looking at the data:
--------------------------------------------------------------------------
(gdb) frame 2
#2  0x00005629b8260b6c in qemu_coroutine_enter (co=3D0x7f2cd6a00940) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
113    /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c: No such f=
ile or directory.
(gdb) print *co
$1 =3D {entry =3D 0x7f2efbfbc4d8, entry_arg =3D 0x1, caller =3D 0x7f2efbfbc=
4b8, pool_next =3D {sle_next =3D 0x10}, co_queue_wakeup =3D {sqh_first =3D =
0x7f2d217e2000, sqh_last =3D 0x1000}, co_queue_next =3D {sqe_next =3D 0x0}}
(gdb) print *co->caller
$2 =3D {entry =3D 0x1, entry_arg =3D 0xc21a480, caller =3D 0x0, pool_next =
=3D {sle_next =3D 0x0}, co_queue_wakeup =3D {sqh_first =3D 0x0, sqh_last =
=3D 0xffffea0000567882}, co_queue_next =3D {sqe_next =3D 0x100000000000}}
(gdb) frame 4
#4  0x00005629b82609a9 in qemu_coroutine_enter (co=3D0x7f2cd6a00880) at /bu=
ild/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
119    in /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c
(gdb) print *co
$3 =3D {entry =3D 0x200000046, entry_arg =3D 0x7f2c00000001, caller =3D 0x7=
f2cd6a00928, pool_next =3D {sle_next =3D 0x7f2cd6a00930}, co_queue_wakeup =
=3D {sqh_first =3D 0x0, sqh_last =3D 0x7f2cd6a008a0}, co_queue_next =3D {
    sqe_next =3D 0xc21a480}}
(gdb) print *co->caller
$4 =3D {entry =3D 0x2301bc4d8, entry_arg =3D 0x2301bc4b8, caller =3D 0x159e=
2000, pool_next =3D {sle_next =3D 0x7f2efbfbc4d8}, co_queue_wakeup =3D {sqh=
_first =3D 0x1, sqh_last =3D 0x7f2efbfbc4b8}, co_queue_next =3D {
    sqe_next =3D 0x10}}
--------------------------------------------------------------------------

Same as above. If co->caller is not NULL in earlier calls, why have they
succeeded?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673130

Title:
  qemu 2.7.0 receives SIGABRT in qemu_coroutine_enter()

Status in QEMU:
  New

Bug description:
  I've been experiencing frequent SIGABRTs (in addition to segfaults in
  #1671876) lately with qemu 2.7.0 running Ubuntu 16.04 guests. The
  crash usually happens in qemu_coroutine_enter(). I haven't seen this
  so far with any other guests or distros.

  Here is one stack trace I obtained
  --------------------------------------------------------------------------
  (gdb) bt
  #0  0x00007fd7cc676067 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/sys=
deps/unix/sysv/linux/raise.c:56
  #1  0x00007fd7cc677448 in __GI_abort () at abort.c:89
  #2  0x0000556aed247b6c in qemu_coroutine_enter (co=3D0x7fd574300df0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
  #3  0x0000556aed247e55 in qemu_co_queue_run_restart (co=3D0x7fd574300ce0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #4  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd574300ce0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #5  0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd589111670)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #6  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd589111670) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #7  0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd57430dba0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #8  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd57430dba0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #9  0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd589119130)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #10 0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd589119130) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #11 0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd589117410)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #12 0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd589117410) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #13 0x0000556aed247e74 in qemu_co_queue_run_restart (co=3D0x7fd577f00e00)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #14 0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd577f00e00) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #15 0x0000556aed247fa0 in qemu_co_enter_next (queue=3Dqueue@entry=3D0x556=
aef34e5e0) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.=
c:106
  #16 0x0000556aed1e6060 in timer_cb (blk=3D0x556aef34e590, is_write=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/block/throttle-groups.c=
:400
  #17 0x0000556aed1a3615 in timerlist_run_timers (timer_list=3D0x556aef3bad=
40) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:528
  #18 0x0000556aed1a3679 in timerlistgroup_run_timers (tlg=3Dtlg@entry=3D0x=
556af0738758) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:564
  #19 0x0000556aed1a3f47 in aio_dispatch (ctx=3Dctx@entry=3D0x556af0738610)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:357
  #20 0x0000556aed1a40e8 in aio_poll (ctx=3D0x556af0738610, blocking=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:479
  #21 0x0000556aed005c79 in iothread_run (opaque=3D0x556af07383c0) at /buil=
d/pb-qemu-pssKUp/pb-qemu-2.7.0/iothread.c:46
  #22 0x00007fd7cc9f40a4 in start_thread (arg=3D0x7fd7aafff700) at pthread_=
create.c:403
  #23 0x00007fd7cc72962d in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:111
  --------------------------------------------------------------------------

  The code crashes here
  --------------------------------------------------------------------------
  void qemu_coroutine_enter(Coroutine *co)
  {
      Coroutine *self =3D qemu_coroutine_self();
      CoroutineAction ret;

      trace_qemu_coroutine_enter(self, co, co->entry_arg);

      if (co->caller) {
          fprintf(stderr, "Co-routine re-entered recursively\n");          =
  =

          abort();  <--- Code aborts here                                  =
             =

      }

      [...]
  }
  --------------------------------------------------------------------------

  Debugging further we see:
  --------------------------------------------------------------------------
  (gdb) frame 2
  #2  0x0000556aed247b6c in qemu_coroutine_enter (co=3D0x7fd574300df0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:113
  113    /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c: No such=
 file or directory.
  (gdb) print *co
  $1 =3D {entry =3D 0x7fd793e95a58, entry_arg =3D 0x1, caller =3D 0x7fd793e=
95a38, pool_next =3D {sle_next =3D 0x10}, co_queue_wakeup =3D {sqh_first =
=3D 0x7fd6ebbd2000, sqh_last =3D 0x1000}, co_queue_next =3D {
      sqe_next =3D 0x7fd6ebbd1000}}
  (gdb) print *co->caller
  $2 =3D {entry =3D 0x400400000001, entry_arg =3D 0xc546a20, caller =3D 0x0=
, pool_next =3D {sle_next =3D 0x0}, co_queue_wakeup =3D {sqh_first =3D 0x0,=
 sqh_last =3D 0xffffea00061f7480}, co_queue_next =3D {sqe_next =3D 0x100000=
000000}}
  (gdb) frame 4
  #4  0x0000556aed2479a9 in qemu_coroutine_enter (co=3D0x7fd574300ce0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  119    in /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c
  (gdb) print *co
  $3 =3D {entry =3D 0xc00000053, entry_arg =3D 0x7fd500000001, caller =3D 0=
x7fd574300d88, pool_next =3D {sle_next =3D 0x7fd574300d90}, co_queue_wakeup=
 =3D {sqh_first =3D 0x7fd6ebbd1000, sqh_last =3D 0x7fd574300e00}, =

    co_queue_next =3D {sqe_next =3D 0xc546a20}}
  (gdb) print *co->caller
  $4 =3D {entry =3D 0x230095a58, entry_arg =3D 0x230095a38, caller =3D 0x18=
7dd2000, pool_next =3D {sle_next =3D 0x187dd1000}, co_queue_wakeup =3D {sqh=
_first =3D 0x187dd0000, sqh_last =3D 0x187dcf000}, co_queue_next =3D {
      sqe_next =3D 0x184970000}}
  --------------------------------------------------------------------------

  The question is, why did qemu_coroutine_enter not complain when in
  earlier calls co->caller was not NULL?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673130/+subscriptions
