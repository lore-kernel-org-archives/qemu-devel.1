Received: from eggs.gnu.org ([2001:4830:134:3::10]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi5-0005Ay-IA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi4-0001mq-Br
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:37817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXgi4-0001mA-6F
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXgi3-0003q2-Be
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 53EE82E8075
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 04:17:53 -0000
From: Launchpad Bug Tracker <959992@bugs.launchpad.net>
Reply-To: Bug 959992 <959992@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120320080129.16383.11883.malonedeb@gac.canonical.com>
Message-Id: <150043787381.28289.10673016357903239513.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/959992

Title:
  segfault in apic_report_irq_delivered when booting tinycore_3.3.iso

Status in QEMU:
  Expired

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
