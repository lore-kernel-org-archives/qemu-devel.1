Received: from eggs.gnu.org ([2001:4830:134:3::10]:35741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpaCI-0004Qk-IG
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpaCC-00016x-EA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:16:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:47255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dpaCC-00015w-7U
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:16:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dpaC7-000442-UN
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 13:16:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 69C5A2E80D8
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 13:16:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Sep 2017 13:03:28 -0000
From: ChristianEhrhardt <1589923@bugs.launchpad.net>
Reply-To: Bug 1589923 <1589923@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160607104531.2663.45779.malonedeb@chaenomeles.canonical.com>
Message-Id: <150470301012.19046.3150314893790559800.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1589923] Re: https websockets not working in 2.5
 or 2.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu (Ubuntu Yakkety)
       Status: Triaged =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1589923

Title:
  https websockets not working in 2.5 or 2.6

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  Triaged
Status in qemu source package in Yakkety:
  Won't Fix
Status in Arch Linux:
  New

Bug description:
  % gdb --args ./x86_64-softmmu/qemu-system-x86_64 -vnc 0.0.0.0:1,tls,x509=
=3D/etc/pki/libvirt-le,websocket=3D5701 =

                          =

  GNU gdb (GDB) 7.11
  Copyright (C) 2016 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "x86_64-pc-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
  <http://www.gnu.org/software/gdb/documentation/>.
  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Reading symbols from ./x86_64-softmmu/qemu-system-x86_64...done.
  (gdb) run
  Starting program: /home/ben/qemu/qemu-2.6.0/x86_64-softmmu/qemu-system-x8=
6_64 -vnc 0.0.0.0:1,tls,x509=3D/etc/pki/libvirt-le,websocket=3D5701
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/usr/lib/libthread_db.so.1".
  [New Thread 0x7fffe16f6700 (LWP 12767)]
  [New Thread 0x7fffde2d4700 (LWP 12768)]
  [New Thread 0x7fffd3fff700 (LWP 12769)]
  Initializing VNC server with x509 no auth
  Client sioc=3D0x55555874d6b0 ws=3D1 auth=3D1 subauth=3D0
  New client on socket 0x55555874d6b0
  vnc_set_share_mode/0x55555874d6b0: undefined -> connecting
  TLS Websocket connection required
  Start TLS WS handshake process
  Handshake failed TLS handshake failed: The TLS connection was non-properl=
y terminated.
  Closing down client sock: protocol error
  vnc_set_share_mode/0x55555779f510: connecting -> disconnected
  Client sioc=3D0x55555873c6a0 ws=3D1 auth=3D1 subauth=3D0
  New client on socket 0x55555873c6a0
  vnc_set_share_mode/0x55555873c6a0: undefined -> connecting
  TLS Websocket connection required
  Start TLS WS handshake process
  TLS handshake complete, starting websocket handshake
  Websocket negotiate starting
  Websock handshake complete, starting VNC protocol
  Write Plain: Pending output 0x555557b91c60 size 4096 offset 12. Wait SSF 0
  Wrote wire 0x555557b91c60 12 -> 12

  Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
  0x0000000000000001 in ?? ()
  (gdb) thread apply all bt

  Thread 4 (Thread 0x7fffd3fff700 (LWP 12769)):
  #0  0x00007fffef35a09f in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib=
/libpthread.so.0
  #1  0x0000555555a20bd9 in qemu_cond_wait (cond=3Dcond@entry=3D0x555558726=
7e0, =

      mutex=3Dmutex@entry=3D0x555558726810) at util/qemu-thread-posix.c:123
  #2  0x00005555559770ab in vnc_worker_thread_loop (queue=3Dqueue@entry=3D0=
x5555587267e0)
      at ui/vnc-jobs.c:228
  #3  0x00005555559775e8 in vnc_worker_thread (arg=3D0x5555587267e0) at ui/=
vnc-jobs.c:335
  #4  0x00007fffef354474 in start_thread () from /usr/lib/libpthread.so.0
  #5  0x00007fffea43c69d in clone () from /usr/lib/libc.so.6

  Thread 3 (Thread 0x7fffde2d4700 (LWP 12768)):
  #0  0x00007fffef35a09f in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib=
/libpthread.so.0
  #1  0x0000555555a20bd9 in qemu_cond_wait (cond=3D<optimized out>, =

  ---Type <return> to continue, or q <return> to quit---
      emu_global_mutex>) at util/qemu-thread-posix.c:123
  #2  0x0000555555715edf in qemu_tcg_wait_io_event (cpu=3D0x5555564ee840) a=
t /home/ben/qemu/qemu-2.6.0/cpus.c:1015
  #3  qemu_tcg_cpu_thread_fn (arg=3D<optimized out>) at /home/ben/qemu/qemu=
-2.6.0/cpus.c:1161
  #4  0x00007fffef354474 in start_thread () from /usr/lib/libpthread.so.0
  #5  0x00007fffea43c69d in clone () from /usr/lib/libc.so.6

  Thread 2 (Thread 0x7fffe16f6700 (LWP 12767)):
  #0  0x00007fffea438229 in syscall () from /usr/lib/libc.so.6
  #1  0x0000555555a20ee8 in futex_wait (val=3D<optimized out>, ev=3D<optimi=
zed out>) at util/qemu-thread-posix.c:292
  #2  qemu_event_wait (ev=3Dev@entry=3D0x55555641ece4 <rcu_call_ready_event=
>) at util/qemu-thread-posix.c:399
  #3  0x0000555555a2f2ae in call_rcu_thread (opaque=3D<optimized out>) at u=
til/rcu.c:250
  #4  0x00007fffef354474 in start_thread () from /usr/lib/libpthread.so.0
  #5  0x00007fffea43c69d in clone () from /usr/lib/libc.so.6

  Thread 1 (Thread 0x7ffff7f5bb00 (LWP 12763)):
  #0  0x0000000000000001 in ?? ()
  #1  0x00005555559efb53 in qio_task_free (task=3D0x555558212140) at io/tas=
k.c:58
  #2  0x00005555559efd89 in qio_task_complete (task=3Dtask@entry=3D0x555558=
212140) at io/task.c:145
  #3  0x00005555559ef5aa in qio_channel_websock_handshake_send (ioc=3D0x555=
55873c6a0, condition=3D<optimized out>, =

      user_data=3D0x555558212140) at io/channel-websock.c:289
  #4  0x00007fffecf59c8a in g_main_context_dispatch () from /usr/lib/libgli=
b-2.0.so.0
  #5  0x000055555598a6b3 in glib_pollfds_poll () at main-loop.c:213
  #6  os_host_main_loop_wait (timeout=3D<optimized out>) at main-loop.c:258
  #7  main_loop_wait (nonblocking=3D<optimized out>) at main-loop.c:506
  #8  0x00005555556e1fbd in main_loop () at vl.c:1934
  #9  main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimiz=
ed out>) at vl.c:4656

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1589923/+subscriptions
