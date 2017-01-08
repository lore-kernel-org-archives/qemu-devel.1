Received: from eggs.gnu.org ([2001:4830:134:3::10]:35067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ57X-000144-17
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ57T-00044R-L6
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:30:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:47073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQ57T-000449-Fd
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:30:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQ57S-0004qr-E5
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 04:30:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 68E0B2E8043
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 04:30:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jan 2017 04:17:24 -0000
From: Launchpad Bug Tracker <891525@bugs.launchpad.net>
Reply-To: Bug 891525 <891525@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111117085751.16490.43574.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170108041725.16754.37817.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 891525] Re: Guest kernel crashes when booting a
 NUMA guest without explicitly specifying cpus= in -numa option
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
https://bugs.launchpad.net/bugs/891525

Title:
  Guest kernel crashes when booting a NUMA guest without explicitly
  specifying cpus=3D in -numa option

Status in QEMU:
  Expired

Bug description:
  Target: x86_64-softmmu

  Qemu Command line: [root@hs22 qemu-1.0-rc2]# ./x86_64-softmmu/qemu-
  system-x86_64 -smp sockets=3D2,cores=3D4,threads=3D2 -numa
  node,nodeid=3D0,mem=3D4g -numa node,nodeid=3D1,mem=3D1g -cpu core2duo -m =
5g
  /home/bharata/f15-lvm -nographic --enable-kvm -net
  nic,macaddr=3D54:52:00:46:26:84,model=3De1000 -net tap,script=3D/etc/qemu-
  if,ifname=3Dvnet0

  Qemu version: 1.0-rc2

  When guest is started with -numa option without explicitly specifying
  the cpus=3D, guest kernel crashes as below:

  [    0.252159] divide error: 0000 [#1] SMP =

  [    0.252970] last sysfs file: =

  [    0.252970] CPU 1 =

  [    0.252970] Modules linked in:
  [    0.252970] =

  [    0.252970] Pid: 2, comm: kthreadd Not tainted 2.6.38.6-26.rc1.fc15.x8=
6_64 #1 Bochs Bochs
  [    0.252970] RIP: 0010:[<ffffffff8104f4d4>]  [<ffffffff8104f4d4>] selec=
t_task_rq_fair+0x44a/0x571
  [    0.252970] RSP: 0000:ffff88011767fc60  EFLAGS: 00010046
  [    0.252970] RAX: 0000000000000000 RBX: ffff88015d6ad300 RCX: 000000000=
0000000
  [    0.252970] RDX: 0000000000000000 RSI: 0000000000000100 RDI: 000000000=
0000000
  [    0.252970] RBP: ffff88011767fd10 R08: 0000000000000100 R09: ffff88015=
d6ad338
  [    0.252970] R10: 0000000000013840 R11: 0000000000800711 R12: 000000000=
0000000
  [    0.252970] R13: ffff88015fc0f810 R14: 0000000000000001 R15: 000000000=
0000000
  [    0.252970] FS:  0000000000000000(0000) GS:ffff88015fc00000(0000) knlG=
S:0000000000000000
  [    0.252970] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
  [    0.252970] CR2: 00000000ffffffff CR3: 0000000001a03000 CR4: 000000000=
00006e0
  [    0.252970] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
  [    0.252970] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000000000=
0000400
  [    0.252970] Process kthreadd (pid: 2, threadinfo ffff88011767e000, tas=
k ffff88015d671720)
  [    0.252970] Stack:
  [    0.252970]  ffffffff81475873 ffffffff81a02140 ffff88011767fce0 ffffff=
ff8106c5a3
  [    0.252970]  ffff88015d6ad318 000000010000000e 0000000000013840 000000=
0000013840
  [    0.252970]  ffff88015d6ad318 0000007d00000001 ffff880100000000 ffff88=
015d6d81e8
  [    0.252970] Call Trace:
  [    0.252970]  [<ffffffff81475873>] ? _raw_spin_lock_irq+0x1c/0x1e
  [    0.252970]  [<ffffffff8106c5a3>] ? alloc_pid+0x2e6/0x335
  [    0.252970]  [<ffffffff81048960>] select_task_rq+0x16/0x46
  [    0.252970]  [<ffffffff8104e29a>] wake_up_new_task+0x3a/0xde
  [    0.252970]  [<ffffffff810546ce>] do_fork+0x1f1/0x2bf
  [    0.252970]  [<ffffffff8100804e>] ? load_TLS+0x10/0x14
  [    0.252970]  [<ffffffff81008714>] ? __switch_to+0xc6/0x220
  [    0.252970]  [<ffffffff81010c1a>] kernel_thread+0x75/0x77
  [    0.252970]  [<ffffffff8106eacf>] ? kthread+0x0/0x8c
  [    0.252970]  [<ffffffff8100a9e0>] ? kernel_thread_helper+0x0/0x10
  [    0.252970]  [<ffffffff8106ee93>] kthreadd+0xe7/0x124
  [    0.252970]  [<ffffffff8100a9e4>] kernel_thread_helper+0x4/0x10
  [    0.252970]  [<ffffffff8106edac>] ? kthreadd+0x0/0x124
  [    0.252970]  [<ffffffff8100a9e0>] ? kernel_thread_helper+0x0/0x10
  [    0.252970] Code: 01 45 c0 8b 8d 78 ff ff ff 48 8b 75 90 89 cf e8 4a 2=
8 ff ff 3b 05 bd 89 ae 00 89 c1 7c c5 48 8b 45 c0 8b 4b 08 31 d2 48 c1 e0 0=
a =

  [    0.252970]  f7 f1 45 85 e4 75 08 48 3b 45 b0 72 08 eb 0d 48 89 45 b8 =
eb =

  [    0.252970] RIP  [<ffffffff8104f4d4>] select_task_rq_fair+0x44a/0x571
  [    0.252970]  RSP <ffff88011767fc60>

  When cpus=3D is specified for each node explicitly, guest boots fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/891525/+subscriptions
