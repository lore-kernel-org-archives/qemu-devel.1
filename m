Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4DA20644
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4DA20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBff-00058J-6N
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBdD-0002ZT-5G
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:11:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:53524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBd8-0002uo-Ei
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:11:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kcBd7-0003LH-5u
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 18:11:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2964D2E8133
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 18:11:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 17:59:27 -0000
From: Thomas Huth <1699824@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mark-cave-ayland michal-nowak-b th-huth
X-Launchpad-Bug-Reporter: Michal Nowak (michal-nowak-b)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <149814308281.29005.7778167417390248347.malonedeb@wampee.canonical.com>
Message-Id: <160494476782.28892.8959230778038266403.malone@chaenomeles.canonical.com>
Subject: [Bug 1699824] Re: qemu-system-sparc64 -M sun4v aborts on
 tribblix-sparc-0m16.iso
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 5a17d0abeccd5e9c3fae0f9dad289256fc262b09
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:16:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1699824 <1699824@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting older bugs to "Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1699824

Title:
  qemu-system-sparc64 -M sun4v aborts on tribblix-sparc-0m16.iso

Status in QEMU:
  Incomplete

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

