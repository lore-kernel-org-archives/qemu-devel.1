Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E39C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14698206E3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14698206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCjc4-00048t-80
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 09:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kCjb4-0003hb-Rf
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 09:11:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:40988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kCjb0-0007hP-Sq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 09:11:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kCjax-0002xf-HF
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 13:11:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 818342E802E
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 13:11:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2020 12:51:56 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1589923@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=berrange@redhat.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=High; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=xenial; sourcepackage=qemu; 
 component=main; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=yakkety; sourcepackage=qemu;
 component=None; status=Won't Fix; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=archlinux; sourcepackage=None; component=None;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange paelzer th-huth z-ben-5
X-Launchpad-Bug-Reporter: Ben Aitchison (z-ben-5)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <20160607104531.2663.45779.malonedeb@chaenomeles.canonical.com>
Message-Id: <159887831721.13607.17466411866770091419.launchpad@gac.canonical.com>
Subject: [Bug 1589923] Re: https websockets not working in 2.5 or 2.6
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: 0d8006b61ebb200a20c8192790898b6f6b155f50
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 04:40:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1589923 <1589923@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags removed: server-next

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
  Incomplete
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

