Received: from eggs.gnu.org ([2001:4830:134:3::10]:37403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBoAO-0007IX-3c
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBoAL-0006na-Lz
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:60511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBoAL-0006lK-Eg
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBoAK-0008So-Ml
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 20:06:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A9DFE2E804A
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 20:06:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 19:48:51 -0000
From: Thomas Huth <959992@bugs.launchpad.net>
Reply-To: Bug 959992 <959992@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120320080129.16383.11883.malonedeb@gac.canonical.com>
Message-Id: <149522333171.12915.14013577724749810563.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 959992] Re: segfault in apic_report_irq_delivered
 when booting tinycore_3.3.iso
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you somehow still reproduce this
problem with the latest version of QEMU (currently v2.9), or could we
close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/959992

Title:
  segfault in apic_report_irq_delivered when booting tinycore_3.3.iso

Status in QEMU:
  Incomplete

Bug description:
  it git head (33cf629) sometimes it segfaults in
  apic_report_irq_delivered() and backtrace is looping in
  apic_update_irq(#3-#4)

  Log:
  C:\msys\home\User\qemu\i386-softmmu>gdb --args qemu-system-i386.exe -L ..=
\pc-bios -cdrom tinycore_3.3.iso
  GNU gdb (GDB) 7.3
  Copyright (C) 2011 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "mingw32".
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>...
  Reading symbols from C:\msys\home\User\qemu\i386-softmmu/qemu-system-i386=
.exe...
  done.
  (gdb) r
  Starting program: C:\msys\home\User\qemu\i386-softmmu/qemu-system-i386.ex=
e -L ..\\pc-bios -cdrom tinycore_3.3.iso
  [New Thread 9012.0x2348]
  [New Thread 9012.0x2860]
  [New Thread 9012.0x2b64]

  Program received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 9012.0x2b64]
  0x0053cde8 in apic_report_irq_delivered (delivered=3D0)
      at C:/msys/home/User/qemu/hw/apic_common.c:110
  110     {
  (gdb) bt
  #0  0x0053cde8 in apic_report_irq_delivered (delivered=3D0)
      at C:/msys/home/User/qemu/hw/apic_common.c:110
  #1  0x0053b9eb in apic_set_irq (s=3D0x1d7aff8, vector_num=3D<optimized ou=
t>,
      trigger_mode=3D0) at C:/msys/home/User/qemu/hw/apic.c:390
  #2  0x0053b990 in apic_update_irq (s=3D0x1d7aff8)
      at C:/msys/home/User/qemu/hw/apic.c:376
  #3  apic_update_irq (s=3D0x1d7aff8) at C:/msys/home/User/qemu/hw/apic.c:3=
67
  #4  0x0053b990 in apic_update_irq (s=3D0x1d7aff8)
      at C:/msys/home/User/qemu/hw/apic.c:376
  #5  apic_update_irq (s=3D0x1d7aff8) at C:/msys/home/User/qemu/hw/apic.c:3=
67
  #6  0x0053b990 in apic_update_irq (s=3D0x1d7aff8)
      at C:/msys/home/User/qemu/hw/apic.c:376
  #7  apic_update_irq (s=3D0x1d7aff8) at C:/msys/home/User/qemu/hw/apic.c:3=
67
  ...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/959992/+subscriptions
