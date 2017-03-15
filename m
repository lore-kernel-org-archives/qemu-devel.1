Received: from eggs.gnu.org ([2001:4830:134:3::10]:49338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coALI-0006ij-Tb
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coALE-0007wN-PG
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:56:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:39583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1coALE-0007vl-JK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:55:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1coALB-0006rZ-RT
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 14:55:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CEF002E80C8
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 14:55:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Mar 2017 14:48:13 -0000
From: Mohammed Gamal <m.gamal005@gmail.com>
Reply-To: Bug 1671876 <1671876@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170310164750.14977.41006.malonedeb@soybean.canonical.com>
Message-Id: <20170315144814.15665.3922.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1671876] Re: qemu 2.7.0 segfaults in
 qemu_co_queue_run_restart()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unfortunately it'd not be possible to use another version at the moment.
Is it possible that someone takes a look at the stack traces?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1671876

Title:
  qemu 2.7.0 segfaults in qemu_co_queue_run_restart()

Status in QEMU:
  New

Bug description:
  Hi,

  I've been experiencing frequent segfaults lately with qemu 2.7.0
  running Ubuntu 16.04 guests. The crash usually happens in
  qemu_co_queue_run_restart(). I haven't seen this so far with any other
  guests or distros.

  Here is one back trace I obtained from one of the crashing VMs.

  --------------------------------------------------------------------------
  (gdb) bt
  #0  qemu_co_queue_run_restart (co=3D0x7fba8ff05aa0) at /build/pb-qemu-pss=
KUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:59
  #1  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8ff05aa0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #2  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba8dd20430)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #3  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8dd20430) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #4  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba8dd14ea0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #5  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8dd14ea0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #6  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba80c11dc0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #7  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba80c11dc0) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #8  0x000055c1656f3e74 in qemu_co_queue_run_restart (co=3D0x7fba8dd0bd70)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.c:60
  #9  0x000055c1656f39a9 in qemu_coroutine_enter (co=3D0x7fba8dd0bd70) at /=
build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine.c:119
  #10 0x000055c1656f3fa0 in qemu_co_enter_next (queue=3Dqueue@entry=3D0x55c=
1669e75e0) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/util/qemu-coroutine-lock.=
c:106
  #11 0x000055c165692060 in timer_cb (blk=3D0x55c1669e7590, is_write=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/block/throttle-groups.c=
:400
  #12 0x000055c16564f615 in timerlist_run_timers (timer_list=3D0x55c166a53e=
80) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:528
  #13 0x000055c16564f679 in timerlistgroup_run_timers (tlg=3Dtlg@entry=3D0x=
55c167c81cf8) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/qemu-timer.c:564
  #14 0x000055c16564ff47 in aio_dispatch (ctx=3Dctx@entry=3D0x55c167c81bb0)=
 at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:357
  #15 0x000055c1656500e8 in aio_poll (ctx=3D0x55c167c81bb0, blocking=3D<opt=
imized out>) at /build/pb-qemu-pssKUp/pb-qemu-2.7.0/aio-posix.c:479
  #16 0x000055c1654b1c79 in iothread_run (opaque=3D0x55c167c81960) at /buil=
d/pb-qemu-pssKUp/pb-qemu-2.7.0/iothread.c:46
  #17 0x00007fbc4b64f0a4 in allocate_stack (stack=3D<synthetic pointer>, pd=
p=3D<synthetic pointer>, attr=3D0x0) at allocatestack.c:416
  #18 __pthread_create_2_1 (newthread=3D<error reading variable: Cannot acc=
ess memory at address 0xffffffffffffff48>, attr=3D<error reading variable: =
Cannot access memory at address 0xffffffffffffff40>,
  =C2=A0=C2=A0=C2=A0=C2=A0start_routine=3D<error reading variable: Cannot a=
ccess memory at address 0xffffffffffffff58>, arg=3D<error reading variable:=
 Cannot access memory at address 0xffffffffffffff50>) at pthread_create.c:5=
39
  Backtrace stopped: Cannot access memory at address 0x8
  --------------------------------------------------------------------------

  The code that crashes is this
  --------------------------------------------------------------------------
  void qemu_co_queue_run_restart(Coroutine *co)
  {
  =C2=A0=C2=A0=C2=A0=C2=A0Coroutine *next;

  =C2=A0=C2=A0=C2=A0=C2=A0trace_qemu_co_queue_run_restart(co);
  =C2=A0=C2=A0=C2=A0=C2=A0while ((next =3D QSIMPLEQ_FIRST(&co->co_queue_wak=
eup))) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QSIMPLEQ_REMOVE_HEAD(&co-=
>co_queue_wakeup, co_queue_next); <-Crash
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_coroutine_enter(next=
);
  =C2=A0=C2=A0=C2=A0=C2=A0}
  }
  --------------------------------------------------------------------------

  Expanding the macro QSIMPLEQ_REMOVE_HEAD gives us
  --------------------------------------------------------------------------
  #define QSIMPLEQ_REMOVE_HEAD(head, field) do {                          \
  =C2=A0=C2=A0=C2=A0=C2=A0if (((head)->sqh_first =3D (head)->sqh_first->fie=
ld.sqe_next) =3D=3D NULL)\
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(head)->sqh_last =3D &(he=
ad)->sqh_first;                          \
  } while (/*CONSTCOND*/0)
  --------------------------------------------------------------------------

  which corrsponds to
  --------------------------------------------------------------------------
  if (((&co->co_queue_wakeup)->sqh_first =3D (&co->co_queue_wakeup)->sqh_fi=
rst->co_queue_next.sqe_next) =3D=3D NULL)\
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(&co->co_queue_wakeup)->s=
qh_last =3D &(&co->co_queue_wakeup)->sqh_first;
  --------------------------------------------------------------------------

  Debugging the list we see
  --------------------------------------------------------------------------
  (gdb) print *(&co->co_queue_wakeup->sqh_first)
  $6 =3D (struct Coroutine *) 0x1000
  (gdb) print *(&co->co_queue_wakeup->sqh_first->co_queue_next)
  Cannot access memory at address 0x1030
  --------------------------------------------------------------------------

  So the data in co->co_queue_wakeup->sqh_first is corrupted and
  represents an invalid address. Any idea why is that?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1671876/+subscriptions
