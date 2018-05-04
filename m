Received: from eggs.gnu.org ([2001:4830:134:3::10]:36731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEdby-0004Iq-Ru
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEdbx-0007tr-FI
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:31:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:43168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fEdbx-0007tF-9Z
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:31:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fEdbt-0007lf-L3
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 16:31:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6156C2E8193
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 16:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 May 2018 16:15:49 -0000
From: Dan Streetman <dan.streetman@canonical.com>
Reply-To: Bug 1769053 <1769053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
Message-Id: <152545054926.7415.17162809739615865916.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769053] Re: Cannot start a guest with more than
 1TB of RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

BTW this is the stacktrace I get from a Xenial guest on Xenial host:

[    0.000000] BUG: unable to handle kernel paging request at ffffc90000000=
004
[    0.000000] IP: [<ffffffff81f7dc60>] hpet_enable.part.13+0x23/0x2a5
[    0.000000] PGD 171629ab067 PUD 171629ac067 PMD 171629ad067 PTE 80000000=
fed00073
[    0.000000] Oops: 0009 [#1] SMP =

[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.0-122-generic =
#146-Ubuntu
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[    0.000000] task: ffffffff81e13500 ti: ffffffff81e00000 task.ti: fffffff=
f81e00000
[    0.000000] RIP: 0010:[<ffffffff81f7dc60>]  [<ffffffff81f7dc60>] hpet_en=
able.part.13+0x23/0x2a5
[    0.000000] RSP: 0000:ffffffff81e03ef0  EFLAGS: 00010282
[    0.000000] RAX: ffffc90000000000 RBX: ffffffffffffffff RCX: 00000000000=
00000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000100 RDI: 00000000000=
00000
[    0.000000] RBP: ffffffff81e03f10 R08: 000000000001ad50 R09: 00000000000=
001f0
[    0.000000] R10: ffff89773fa20000 R11: 0000000000000001 R12: ffff89773f9=
9f6c0
[    0.000000] R13: ffffffff8200e920 R14: ffffffff8201c2e0 R15: ffffffff81e=
03fa8
[    0.000000] FS:  0000000000000000(0000) GS:ffff897162c00000(0000) knlGS:=
0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    0.000000] CR2: ffffc90000000004 CR3: 0000000001e0a000 CR4: 00000000000=
00630
[    0.000000] Stack:
[    0.000000]  ffffffffffffffff ffff89773f99f6c0 ffffffff8200e920 ffffffff=
8201c2e0
[    0.000000]  ffffffff81e03f20 ffffffff81f7df00 ffffffff81e03f30 ffffffff=
81f6ee7a
[    0.000000]  ffffffff81e03f40 ffffffff81f6ee4a ffffffff81e03f80 ffffffff=
81f63f71
[    0.000000] Call Trace:
[    0.000000]  [<ffffffff81f7df00>] hpet_enable+0x1e/0x20
[    0.000000]  [<ffffffff81f6ee7a>] hpet_time_init+0x9/0x19
[    0.000000]  [<ffffffff81f6ee4a>] x86_late_time_init+0x10/0x17
[    0.000000]  [<ffffffff81f63f71>] start_kernel+0x3d8/0x4aa
[    0.000000]  [<ffffffff81f63120>] ? early_idt_handler_array+0x120/0x120
[    0.000000]  [<ffffffff81f63339>] x86_64_start_reservations+0x2a/0x2c
[    0.000000]  [<ffffffff81f63485>] x86_64_start_kernel+0x14a/0x16d
[    0.000000] Code: 01 00 00 00 41 5c 5d c3 55 48 8b 3d 63 f4 18 00 be 00 =
04 00 00 48 89 e5 41 56 41 55 41 54 53 e8 f7 f2 0e ff 48 89 05 d8 f4 18 00 =
<8b> 48 04 b8 e9 03 00 00 48 8b 15 c9 f4 18 00 8b 52 10 ff c2 75 =

[    0.000000] RIP  [<ffffffff81f7dc60>] hpet_enable.part.13+0x23/0x2a5
[    0.000000]  RSP <ffffffff81e03ef0>
[    0.000000] CR2: ffffc90000000004
[    0.000000] ---[ end trace 404be15fe05aa681 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the i=
dle task!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769053

Title:
  Cannot start a guest with more than 1TB of RAM

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Attempting to start a KVM guest with more than 1TB of RAM fails.

  It looks like we might need some extra patches:
  https://lists.gnu.org/archive/html/qemu-discuss/2017-12/msg00005.html

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: qemu-system-x86 1:2.11+dfsg-1ubuntu7
  ProcVersionSignature: Ubuntu 4.15.0-20.21-generic 4.15.17
  Uname: Linux 4.15.0-20-generic x86_64
  ApportVersion: 2.20.9-0ubuntu7
  Architecture: amd64
  CurrentDesktop: Unity:Unity7:ubuntu
  Date: Fri May  4 16:21:14 2018
  InstallationDate: Installed on 2017-04-05 (393 days ago)
  InstallationMedia: Ubuntu 16.10 "Yakkety Yak" - Release amd64 (20161012.2)
  MachineType: Dell Inc. XPS 13 9360
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.15.0-20-generic root=3D/dev/ma=
pper/ubuntu--vg-root ro quiet splash transparent_hugepage=3Dmadvise vt.hand=
off=3D1
  SourcePackage: qemu
  UpgradeStatus: Upgraded to bionic on 2018-04-30 (3 days ago)
  dmi.bios.date: 02/26/2018
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: 2.6.2
  dmi.board.name: 0PF86Y
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A00
  dmi.chassis.type: 9
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvr2.6.2:bd02/26/2018:svnDellInc.:pnXPS1393=
60:pvr:rvnDellInc.:rn0PF86Y:rvrA00:cvnDellInc.:ct9:cvr:
  dmi.product.family: XPS
  dmi.product.name: XPS 13 9360
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769053/+subscriptions
