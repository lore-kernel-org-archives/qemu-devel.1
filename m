Received: from eggs.gnu.org ([2001:4830:134:3::10]:46171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMY94-0003vc-P2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eMY91-0007xQ-Ki
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:45:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:33340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eMY91-0007x2-Bq
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:45:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eMY90-0000t0-CN
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 11:45:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5B9FC2E835C
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 11:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2017 11:39:44 -0000
From: Mohammed Gamal <m.gamal005@gmail.com>
Reply-To: Bug 1673130 <1673130@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170315160255.23768.27906.malonedeb@gac.canonical.com>
Message-Id: <151256038485.3104.14069293278371311538.malone@gac.canonical.com>
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

Fixed by commit 528f449f590829b53ea01ed91817a695b540421d

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673130

Title:
  qemu 2.7.0 receives SIGABRT in qemu_coroutine_enter()

Status in QEMU:
  Fix Released

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
