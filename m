Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90124C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618CA20774
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618CA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ3GF-0000FX-GD
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 18:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jJ3FO-0008Ew-Ek
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jJ3FM-0003NF-0s
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:51:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:46564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jJ3FL-0003Hn-RD
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:51:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jJ3FK-0004oO-9K
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 22:51:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 43B9F2E80C0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 22:51:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2020 22:44:12 -0000
From: carlosedp <carlosedp@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: carlosedp laurent-vivier
X-Launchpad-Bug-Reporter: carlosedp (carlosedp)
X-Launchpad-Bug-Modifier: carlosedp (carlosedp)
References: <158445595923.20060.16174990100496488911.malonedeb@wampee.canonical.com>
Message-Id: <158560825206.24378.9864830478892806776.malone@soybean.canonical.com>
Subject: [Bug 1867786] Re: Qemu PPC64 freezes with multi-core CPU
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c52c9d3de8f31db235e42c569d425cf2cf372fd7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1867786 <1867786@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just built from latest master and got the kernel trace below.

=E2=9D=AF qemu-system-ppc64 --version
QEMU emulator version 4.2.90 (v4.2.0-2811-g83019e81d1-dirty)
Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers


qemu-system-ppc64 \
    -nographic -nodefaults -monitor pty -serial stdio \
    -M pseries -cpu POWER9 -smp cores=3D4,threads=3D1 -m 4G \
    -drive file=3Ddebian-ppc64el-qemu.qcow2,format=3Dqcow2,if=3Dvirtio \
    -netdev user,id=3Dnetwork01,hostfwd=3Dtcp::$LocalSSHPort-:22 -device rt=
l8139,netdev=3Dnetwork01 \


[  376.219450] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [swapper/3=
:0]
[  376.226712] Modules linked in: ctr(E) vmx_crypto(E) gf128mul(E) sunrpc(E=
) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) c=
rc32c_generic(E) virtio_blk(E) 8139too(E) virtio_pci(E) virtio_ring(E) 8139=
cp(E) virtio(E) mii(E)
[  376.235692] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G            E     5.=
5.0-rc5-powerpc64le #1 Debian 5.5~rc5-1~exp1
[  376.236245] NIP:  c00000000000af8c LR: c000000000019664 CTR: c000000000a=
f2c80
[  376.236365] REGS: c0000000fffcf920 TRAP: 0901   Tainted: G            E =
     (5.5.0-rc5-powerpc64le Debian 5.5~rc5-1~exp1)
[  376.236376] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44002248 =
 XER: 00000000
[  376.236479] CFAR: c000000000af2ce0 IRQMASK: 0
               GPR00: c000000000af2e38 c0000000fffcfbb0 c000000001365700 00=
00000000000500
               GPR04: 00000000fef90000 0000002be1f69c00 0000002beaa729fa c0=
000000fffec880
               GPR08: 0000000400000000 00000000000080ff 0000000000000001 c0=
080000004c6ff0
               GPR12: 0000000000002000 c0000000fffec880
[  376.238452] NIP [c00000000000af8c] replay_interrupt_return+0x0/0x4
[  376.238488] LR [c000000000019664] arch_local_irq_restore.part.0+0x54/0x70
[  376.238984] Call Trace:
[  376.240707] [c0000000fffcfbb0] [c0000000008ce910] napi_gro_receive+0x1e0=
/0x210 (unreliable)
[  376.240824] [c0000000fffcfbd0] [c000000000af2e38] _raw_spin_unlock_irqre=
store+0x98/0xb0
[  376.242114] [c0000000fffcfbf0] [c0080000004c5588] cp_rx_poll+0x580/0x610=
 [8139cp]
[  376.242131] [c0000000fffcfcf0] [c0000000008cf6c8] net_rx_action+0x1f8/0x=
550
[  376.242139] [c0000000fffcfe10] [c000000000af3a8c] __do_softirq+0x16c/0x3=
d8
[  376.242172] [c0000000fffcff30] [c0000000001329e8] irq_exit+0xd8/0x120
[  376.242181] [c0000000fffcff60] [c000000000019fb4] __do_irq+0x84/0x1c0
[  376.242193] [c0000000fffcff90] [c00000000002cbec] call_do_irq+0x14/0x24
[  376.242201] [c0000000fd4b7980] [c00000000001a178] do_IRQ+0x88/0xf0
[  376.242209] [c0000000fd4b79c0] [c000000000008d98] hardware_interrupt_com=
mon+0x158/0x160
[  376.242243] --- interrupt: 501 at plpar_hcall_norets+0x1c/0x28
                   LR =3D check_and_cede_processor+0x48/0x60
[  376.243892] [c0000000fd4b7cc0] [c0000000fd4b7cf0] 0xc0000000fd4b7cf0 (un=
reliable)
[  376.243922] [c0000000fd4b7d20] [c00000000086c710] shared_cede_loop+0x50/=
0x160
[  376.243942] [c0000000fd4b7d50] [c000000000868844] cpuidle_enter_state+0x=
a4/0x590
[  376.243953] [c0000000fd4b7dd0] [c000000000868dcc] cpuidle_enter+0x4c/0x70
[  376.243983] [c0000000fd4b7e10] [c000000000177d4c] call_cpuidle+0x4c/0x90
[  376.243991] [c0000000fd4b7e30] [c000000000178358] do_idle+0x2f8/0x400
[  376.243998] [c0000000fd4b7ed0] [c0000000001786a8] cpu_startup_entry+0x38=
/0x40
[  376.244011] [c0000000fd4b7f00] [c00000000004e910] start_secondary+0x640/=
0x670
[  376.244020] [c0000000fd4b7f90] [c00000000000b354] start_secondary_prolog=
+0x10/0x14
[  376.244093] Instruction dump:
[  376.244751] 7d200026 618c8000 2c030900 4182e348 2c030500 4182dcd0 2c030f=
00 4182f318
[  376.244797] 2c030a00 4182ffc8 60000000 60000000 <4e800020> 7c781b78 4800=
03d9 480003f1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867786

Title:
  Qemu PPC64 freezes with multi-core CPU

Status in QEMU:
  New

Bug description:
  I installed Debian 10 on a Qemu PPC64 VM running with the following
  flags:

  qemu-system-ppc64 \
       -nographic -nodefaults -monitor pty -serial stdio \
       -M pseries -cpu POWER9 -smp cores=3D4,threads=3D1 -m 4G \
       -drive file=3Ddebian-ppc64el-qemu.qcow2,format=3Dqcow2,if=3Dvirtio \
       -netdev user,id=3Dnetwork01,$ports -device rtl8139,netdev=3Dnetwork0=
1 \

  =

  Within a couple minutes on any operation (could be a Go application or si=
mply changing the hostname with hostnamectl, the VM freezes and prints this=
 on the console:

  ```
  root@debian:~# [  950.428255] rcu: INFO: rcu_sched self-detected stall on=
 CPU
  [  950.428453] rcu:     3-....: (5318 ticks this GP) idle=3D8e2/1/0x40000=
00000000004 softirq=3D5957/5960 fqs=3D2544
  [  976.244481] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [zsh:462]

  Message from syslogd@debian at Mar 17 11:35:24 ...
   kernel:[  976.244481] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! =
[zsh:462]
  [  980.110018] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tas=
ks: { 3-... } 5276 jiffies s: 93 root: 0x8/.
  [  980.111177] rcu: blocking rcu_node structures:
  [ 1013.442268] rcu: INFO: rcu_sched self-detected stall on CPU
  [ 1013.442365] rcu:     3-....: (21071 ticks this GP) idle=3D8e2/1/0x4000=
000000000004 softirq=3D5957/5960 fqs=3D9342
  ```

  If I change to 1 core on the command line, I haven't seen these
  freezes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1867786/+subscriptions

