Received: from eggs.gnu.org ([2001:4830:134:3::10]:50717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caETV-0003xZ-H6
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caETU-0007FB-Fw
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:30:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:46495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caETU-0007F6-AK
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:30:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caETT-0006qM-C1
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 04:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 25F2A2E80CC
	for <qemu-devel@nongnu.org>; Sun,  5 Feb 2017 04:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Feb 2017 04:17:39 -0000
From: Launchpad Bug Tracker <1221966@bugs.launchpad.net>
Reply-To: Bug 1221966 <1221966@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130906230043.20668.15929.malonedeb@soybean.canonical.com>
Message-Id: <20170205041739.20738.94512.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1221966] Re: SIGSEGV in static_code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1221966

Title:
  SIGSEGV in static_code_gen_buffer

Status in QEMU:
  Expired

Bug description:
  Trying to run 'ls' (or, anything else as far as I can tell) from a
  SunOS 5.8 box under RHEL 6.4 linux, I get a segfault.  I've tried
  qemu-1.5.3, qemu-1.6.0, and I fetched git://git.qemu-
  project.org/qemu.git.  I've also tried a statically linked sh from
  /sbin/ and it also segfaulted.

  wcolburn@anotheruvula</home/anotheruvula/qemu>$ gdb bin/qemu-sparc
  GNU gdb (GDB) Red Hat Enterprise Linux (7.2-60.el6_4.1)
  Copyright (C) 2010 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "x86_64-redhat-linux-gnu".
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>...
  Reading symbols from /home/anotheruvula/qemu/bin/qemu-sparc...done.
  (gdb) run ../sparc/ls
  Starting program: /home/anotheruvula/qemu/bin/qemu-sparc ../sparc/ls
  [Thread debugging using libthread_db enabled]

  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff8259116 in static_code_gen_buffer ()
  Missing separate debuginfos, use: debuginfo-install glib2-2.22.5-7.el6.x8=
6_64 glibc-2.12-1.107.el6_4.4.x86_64
  (gdb) where
  #0  0x00007ffff8259116 in static_code_gen_buffer ()
  #1  0x00007ffff7f570cd in cpu_tb_exec (cpu=3D0x7ffffa2b1210, tb_ptr=3D
      0x7ffff82590d0 "A\213n=C2=A0\205=C3=AD\017\205=C3=8D")
      at /home/anotheruvula/qemu-devel/cpu-exec.c:56
  #2  0x00007ffff7f57b2d in cpu_sparc_exec (env=3D0x7ffffa2b1348)
      at /home/anotheruvula/qemu-devel/cpu-exec.c:631
  #3  0x00007ffff7f77f36 in cpu_loop (env=3D0x7ffffa2b1348)
      at /home/anotheruvula/qemu-devel/linux-user/main.c:1089
  #4  0x00007ffff7f798ff in main (argc=3D2, argv=3D0x7fffffffdfc8, envp=3D
      0x7fffffffdfe0) at /home/anotheruvula/qemu-devel/linux-user/main.c:40=
83
  (gdb)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1221966/+subscriptions
