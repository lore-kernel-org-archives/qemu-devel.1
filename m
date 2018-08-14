Received: from eggs.gnu.org ([2001:4830:134:3::10]:54496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpQyu-0006FM-3t
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpQyr-0006IV-Fu
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:30:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:55800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpQyr-0006Gr-94
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpQyq-0007mL-5j
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 04:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1DABF2E8526
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 04:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Aug 2018 04:17:28 -0000
From: Launchpad Bug Tracker <1463143@bugs.launchpad.net>
Reply-To: Bug 1463143 <1463143@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150608191356.22500.7085.malonedeb@chaenomeles.canonical.com>
Message-Id: <153422024890.598.16060854820786401224.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1463143] Re: Kernel Panic on Guest VM
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
https://bugs.launchpad.net/bugs/1463143

Title:
  Kernel Panic on Guest VM

Status in QEMU:
  Expired

Bug description:
  Hi,

  I've recently attempted to move a stack to qemu vm's that I have run
  successfully on both hard metal and ec2.

  I'm not sure where to even begin debugging, could someone please point
  me in the right direction?


  =

    [781785.483343] RIP: 0010:[<ffffffff81511830>]  [<ffffffff81511830>] at=
a_sff_hsm_move+0x1b0/0x780
  [781785.483345] RSP: 0000:ffff88007fd03dd0  EFLAGS: 00010097
  [781785.483346] RAX: 0000000000000000 RBX: ffff8800374d0000 RCX: 00000000=
00000050
  [781785.483347] RDX: 0000000000000006 RSI: ffff8800374d0158 RDI: ffff8800=
374d0000
  [781785.483348] RBP: ffff88007fd03e20 R08: 0000000000000086 R09: ffff8800=
7cc00000
  [781785.483349] R10: 0000000000000011 R11: 000000000000000b R12: ffff8800=
374d0158
  [781785.483350] R13: 0000000000000000 R14: ffff8800374d0158 R15: ffff8800=
374d0208
  [781785.483356] FS:  00007f3882e75700(0000) GS:ffff88007fd00000(0000) knl=
GS:0000000000000000
  [781785.483357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [781785.483358] CR2: 00007f37df39a000 CR3: 000000000b7a5000 CR4: 00000000=
000006e0
  [781785.483369] Stack:
  [781785.483373]  ffff8800373cb000 ffff88007fd03e60 ffffffff8108d7d2 ffff8=
8007fd03e28
  [781785.483375]  ffff8800374d2140 ffff8800374d0000 ffff8800374d0158 00000=
00000000000
  [781785.483378]  0000000000000050 0000000000000000 ffff88007fd03e50 fffff=
fff81511e96
  [781785.483378] Call Trace:
  [781785.483382]  <IRQ> =

  [781785.483396]  [<ffffffff8108d7d2>] ? run_posix_cpu_timers+0x42/0x5c0
  [781785.483400]  [<ffffffff81511e96>] __ata_sff_port_intr+0x96/0x120
  [781785.483403]  [<ffffffff815121ed>] ata_bmdma_port_intr+0x2d/0x120
  [781785.483405]  [<ffffffff81512ba3>] ata_bmdma_interrupt+0x183/0x1e0
  [781785.483414]  [<ffffffff810bf8be>] handle_irq_event_percpu+0x3e/0x1d0
  [781785.483433]  [<ffffffff810bfa8d>] handle_irq_event+0x3d/0x60
  [781785.483437]  [<ffffffff810c2517>] handle_edge_irq+0x77/0x130
  [781785.483455]  [<ffffffff81015cde>] handle_irq+0x1e/0x30
  [781785.483472]  [<ffffffff817312cd>] do_IRQ+0x4d/0xc0
  [781785.483476]  [<ffffffff81726a6d>] common_interrupt+0x6d/0x6d
  [781785.483478]  <EOI> =

  [781785.483480]  [<ffffffff8172efad>] ? system_call_fastpath+0x1a/0x1f
  [781785.483498] Code: f9 ff ff 41 0f b6 46 28 3c 06 0f 84 0b 03 00 00 3c =
07 0f 84 e3 02 00 00 3c 05 0f 84 c3 02 00 00 0f 0b 66 0f 1f 84 00 00 00 00 =
00 <0f> 0b 66 0f 1f 44 00 00 f6 c1 08 0f 84 19 05 00 00 f6 c1 21 0f =

  [781785.483501] RIP  [<ffffffff81511830>] ata_sff_hsm_move+0x1b0/0x780
  [781785.483501]  RSP <ffff88007fd03dd0>
  [781785.484009] ---[ end trace 1b6ef3497a5641b3 ]---
  [781785.484009] Kernel panic - not syncing: Fatal exception in interrupt
  [781785.484009] Shutting down cpus with NMI

  =

  Thanks for any pointers.

  Ryan

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1463143/+subscriptions
