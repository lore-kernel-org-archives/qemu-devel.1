Received: from eggs.gnu.org ([2001:4830:134:3::10]:34606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dQSyz-0000k9-BX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dQSyw-00007S-5S
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:31:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:58321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dQSyv-000073-SL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:31:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dQSyt-0000A7-Ps
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:31:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9D0C62E8194
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:31:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2017 06:16:57 -0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reply-To: Bug 1699824 <1699824@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149814308281.29005.7778167417390248347.malonedeb@wampee.canonical.com>
Message-Id: <149871701760.4785.17007538378431485250.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1699824] Re: qemu-system-sparc64 -M sun4v aborts
 on tribblix-sparc-0m16.iso
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Michal,

Currently the sun4v machine is still at an alpha stage. Artyom has made
some good progress on the niagara machine which was merged for the 2.9
release and is able to run several OSs, so please try that and let us
know how you get on.

Note that I generally try and keep the wiki page at
http://wiki.qemu.org/Documentation/Platforms/SPARC up-to-date with the
latest information so do have a look there to see examples of how to use
the niagara machine.


ATB,

Mark.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1699824

Title:
  qemu-system-sparc64 -M sun4v aborts on tribblix-sparc-0m16.iso

Status in QEMU:
  New

Bug description:
  qemu-system-sparc64 qemu-2.9.0-3.10.x86_64 on openSUSE Leap 42.3 using
  'sun4v' machine aborts with tribblix. With 2048 MB of RAM it takes
  considerably more time to abort (but the core is always truncated).

  > qemu-system-sparc64 -m 1024 -cdrom tribblix-sparc-0m16.iso -boot d -nog=
raphic -M sun4v
  qemu: fatal: Trap 0x0010 while trap level (6) >=3D MAXTL (6), Error state
  pc: 0000000000000200  npc: 0000000000000204
  %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %o0-3: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %o4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %l0-3: 000000003ff00000 000001ff00000000 000001fff0080000 000000000000000=
0 =

  %l4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %i0-3: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %i4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  pstate: 00000014 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0 gl: 8
  tbr: 0000000000000000 hpstate: 0000000000000004 htba: 0000000000000000
  cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
  fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000

  Aborted (core dumped)

  =

             PID: 26999 (qemu-system-spa)
             UID: 1000 (newman)
             GID: 100 (users)
          Signal: 6 (ABRT)
       Timestamp: Thu 2017-06-22 16:19:02 CEST (1min 5s ago)
    Command Line: qemu-system-sparc64 -m 1024 -cdrom tribblix-sparc-0m16.is=
o -boot d -nographic -M sun4v
      Executable: /usr/bin/qemu-system-sparc64
   Control Group: /
           Slice: -.slice
         Boot ID: aa7431274f854fb7a02a773eefa8a9bb
      Machine ID: 89c660865c00403a9bacef32b6828556
        Hostname: assam.suse.cz
        Coredump: /var/lib/systemd/coredump/core.qemu-system-spa.1000.aa743=
1274f854fb7a02a773eefa8a9bb.26999.1498141142000000.xz
         Message: Process 26999 (qemu-system-spa) of user 1000 dumped core.


  (gdb) thread apply all bt full

  Thread 4 (Thread 0x7f3896aca700 (LWP 27001)):
  #0  0x00007f38bb983295 in do_futex_wait () at /lib64/libpthread.so.0
  #1  0x00007f38bb983349 in __new_sem_wait_slow () at /lib64/libpthread.so.0
  #2  0x00007f38bb9833f7 in sem_timedwait () at /lib64/libpthread.so.0
  #3  0x00005599ec6a1147 in qemu_sem_timedwait (sem=3Dsem@entry=3D0x5599ef1=
68628, ms=3Dms@entry=3D10000) at util/qemu-thread-posix.c:255
          rc =3D <optimized out>
          ts =3D {tv_sec =3D 1498141152, tv_nsec =3D 280531000}
          __func__ =3D "qemu_sem_timedwait"
  #4  0x00005599ec69c83c in worker_thread (opaque=3D0x5599ef1685c0) at util=
/thread-pool.c:92
          req =3D <optimized out>
          ret =3D <optimized out>
          pool =3D 0x5599ef1685c0
  #5  0x00007f38bb97c744 in start_thread () at /lib64/libpthread.so.0
  #6  0x00007f38b79bdd3d in clone () at /lib64/libc.so.6

  Thread 3 (Thread 0x7f38bee01c40 (LWP 26999)):
  #0  0x00007f38b79b555f in ppoll () at /lib64/libc.so.6
  #1  0x00005599ec69d289 in ppoll (__ss=3D0x0, __timeout=3D0x7ffd1dcf2a20, =
__nfds=3D<optimized out>, __fds=3D<optimized out>) at /usr/include/bits/pol=
l2.h:77
          ts =3D {tv_sec =3D 1, tv_nsec =3D 0}
  Python Exception <class 'gdb.error'> That operation is not available on i=
ntegers of more than 8 bytes.: =

  #2  0x00005599ec69d289 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D<op=
timized out>, timeout=3Dtimeout@entry=3D1000000000) at util/qemu-timer.c:334
          ts =3D {tv_sec =3D 1, tv_nsec =3D 0}
  Python Exception <class 'gdb.error'> That operation is not available on i=
ntegers of more than 8 bytes.: =

  #3  0x00005599ec69dff8 in os_host_main_loop_wait (timeout=3D1000000000) a=
t util/main-loop.c:255
          context =3D 0x5599ef147470
          ret =3D <optimized out>
          spin_counter =3D 0
          ret =3D -283872144
          timeout =3D 1000
  #4  0x00005599ec69dff8 in main_loop_wait (nonblocking=3D<optimized out>) =
at util/main-loop.c:517
          ret =3D -283872144
          timeout =3D 1000
  #5  0x00005599ec3c8c5f in main_loop () at vl.c:1900
          i =3D <optimized out>
          snapshot =3D <optimized out>
          linux_boot =3D <optimized out>
          initrd_filename =3D <optimized out>
          kernel_filename =3D <optimized out>
          kernel_cmdline =3D <optimized out>
          boot_order =3D <optimized out>
          boot_once =3D 0x0
          ds =3D <optimized out>
          cyls =3D <optimized out>
          heads =3D <optimized out>
          secs =3D <optimized out>
          translation =3D <optimized out>
          opts =3D <optimized out>
          hda_opts =3D <optimized out>
          icount_opts =3D <optimized out>
          accel_opts =3D <optimized out>
          olist =3D <optimized out>
          optind =3D 10
          optarg =3D 0x7ffd1dcf51d2 "sun4v"
          loadvm =3D <optimized out>
          machine_class =3D 0x5599ec6d6f6f
          cpu_model =3D <optimized out>
          vga_model =3D 0x5599ec6d6f81 "std"
          qtest_chrdev =3D <optimized out>
          qtest_log =3D <optimized out>
          pid_file =3D <optimized out>
          incoming =3D <optimized out>
          defconfig =3D <optimized out>
          userconfig =3D <optimized out>
          nographic =3D <optimized out>
          display_type =3D <optimized out>
          display_remote =3D <optimized out>
          log_mask =3D <optimized out>
          log_file =3D <optimized out>
          trace_file =3D <optimized out>
          maxram_size =3D <optimized out>
          ram_slots =3D <optimized out>
          vmstate_dump_file =3D <optimized out>
          main_loop_err =3D 0x0
          err =3D 0x0
          list_data_dirs =3D <optimized out>
          bdo_queue =3D {sqh_first =3D 0x0, sqh_last =3D 0x7ffd1dcf2ba0}
          rlimit_as =3D {rlim_cur =3D 18446744073709551615, rlim_max =3D 18=
446744073709551615}
          __func__ =3D "main"
          __FUNCTION__ =3D "main"
  #6  0x00005599ec3c8c5f in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at vl.c:4730
          i =3D <optimized out>
          snapshot =3D <optimized out>
          linux_boot =3D <optimized out>
          initrd_filename =3D <optimized out>
          kernel_filename =3D <optimized out>
          kernel_cmdline =3D <optimized out>
          boot_order =3D <optimized out>
          boot_once =3D 0x0
          ds =3D <optimized out>
          cyls =3D <optimized out>
          heads =3D <optimized out>
          secs =3D <optimized out>
          translation =3D <optimized out>
          opts =3D <optimized out>
          hda_opts =3D <optimized out>
          icount_opts =3D <optimized out>
          accel_opts =3D <optimized out>
          olist =3D <optimized out>
          optind =3D 10
          optarg =3D 0x7ffd1dcf51d2 "sun4v"
          loadvm =3D <optimized out>
          machine_class =3D 0x5599ec6d6f6f
          cpu_model =3D <optimized out>
          vga_model =3D 0x5599ec6d6f81 "std"
          qtest_chrdev =3D <optimized out>
          qtest_log =3D <optimized out>
          pid_file =3D <optimized out>
          incoming =3D <optimized out>
          defconfig =3D <optimized out>
          userconfig =3D <optimized out>
          nographic =3D <optimized out>
          display_type =3D <optimized out>
          display_remote =3D <optimized out>
          log_mask =3D <optimized out>
          log_file =3D <optimized out>
          trace_file =3D <optimized out>
          maxram_size =3D <optimized out>
          ram_slots =3D <optimized out>
          vmstate_dump_file =3D <optimized out>
          main_loop_err =3D 0x0
          err =3D 0x0
          list_data_dirs =3D <optimized out>
          bdo_queue =3D {sqh_first =3D 0x0, sqh_last =3D 0x7ffd1dcf2ba0}
          rlimit_as =3D {rlim_cur =3D 18446744073709551615, rlim_max =3D 18=
446744073709551615}
          __func__ =3D "main"
          __FUNCTION__ =3D "main"

  Thread 2 (Thread 0x7f38abf99700 (LWP 27000)):
  #0  0x00007f38b79b98e9 in syscall () at /lib64/libc.so.6
  #1  0x00005599ec6a12d6 in qemu_futex_wait (val=3D<optimized out>, f=3D<op=
timized out>) at /usr/src/debug/qemu-2.9.0/include/qemu/futex.h:26
          value =3D <optimized out>
  #2  0x00005599ec6a12d6 in qemu_event_wait (ev=3Dev@entry=3D0x5599ed0f1e40=
 <rcu_gp_event>) at util/qemu-thread-posix.c:399
          value =3D <optimized out>
  #3  0x00005599ec6b0a78 in wait_for_readers () at util/rcu.c:131
          qsreaders =3D {lh_first =3D 0x7f38abf99588}
          index =3D <optimized out>
          tmp =3D <optimized out>
  #4  0x00005599ec6b0a78 in synchronize_rcu () at util/rcu.c:162
  #5  0x00005599ec6b0c79 in call_rcu_thread (opaque=3D<optimized out>) at u=
til/rcu.c:256
          tries =3D 0
          n =3D 565
          node =3D <optimized out>
  #6  0x00007f38bb97c744 in start_thread () at /lib64/libpthread.so.0
  #7  0x00007f38b79bdd3d in clone () at /lib64/libc.so.6

  Thread 1 (Thread 0x7f38962c9700 (LWP 27002)):
  #0  0x00007f38b79088d7 in raise () at /lib64/libc.so.6
  #1  0x00007f38b7909caa in abort () at /lib64/libc.so.6
  #2  0x00005599ec3d1125 in cpu_abort (cpu=3Dcpu@entry=3D0x5599ef16f800, fm=
t=3Dfmt@entry=3D0x5599ec6d3388 "Trap 0x%04x while trap level (%d) >=3D MAXT=
L (%d), Error state") at /usr/src/debug/qemu-2.9.0/exec.c:962
          ap =3D {{gp_offset =3D 40, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f38962c88b0, reg_save_area =3D 0x7f38962c87d0}}
          ap2 =3D {{gp_offset =3D 16, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f38962c88b0, reg_save_area =3D 0x7f38962c87d0}}
  #3  0x00005599ec4790b8 in sparc_cpu_do_interrupt (cs=3D0x5599ef16f800) at=
 /usr/src/debug/qemu-2.9.0/target/sparc/int64_helper.c:119
          cpu =3D 0x5599ef16f800
          __func__ =3D "sparc_cpu_do_interrupt"
          env =3D 0x5599ef177a98
          intno =3D 16
          tsptr =3D 0x6
  #4  0x00005599ec3dcf54 in cpu_handle_exception (ret=3D<synthetic pointer>=
, cpu=3D0x5599ef12e000) at /usr/src/debug/qemu-2.9.0/cpu-exec.c:463
          cc =3D 0x5599ef12e000
          cc =3D <optimized out>
          __func__ =3D "cpu_exec"
          ret =3D <optimized out>
          sc =3D {diff_clk =3D 0, last_cpu_icount =3D 0, realtime_clock =3D=
 <optimized out>}
          __FUNCTION__ =3D "cpu_exec"
  #5  0x00005599ec3dcf54 in cpu_exec (cpu=3Dcpu@entry=3D0x5599ef16f800) at =
/usr/src/debug/qemu-2.9.0/cpu-exec.c:668
          cc =3D <optimized out>
          __func__ =3D "cpu_exec"
          ret =3D <optimized out>
          sc =3D {diff_clk =3D 0, last_cpu_icount =3D 0, realtime_clock =3D=
 <optimized out>}
          __FUNCTION__ =3D "cpu_exec"
  #6  0x00005599ec40796d in tcg_cpu_exec (cpu=3D0x5599ef16f800) at /usr/src=
/debug/qemu-2.9.0/cpus.c:1260
          ret =3D <optimized out>
          r =3D -1775462656
          cpu =3D 0x5599ef16f800
  #7  0x00005599ec40796d in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>) at /usr/src/debug/qemu-2.9.0/cpus.c:1355
          r =3D -1775462656
          cpu =3D 0x5599ef16f800
  #8  0x00007f38bb97c744 in start_thread () at /lib64/libpthread.so.0
  #9  0x00007f38b79bdd3d in clone () at /lib64/libc.so.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1699824/+subscriptions
