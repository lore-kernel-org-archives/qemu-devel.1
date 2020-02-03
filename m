Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B8CC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064FF20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064FF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVHC-0006tz-6D
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iyV6A-0003Q7-O5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iyV69-0005a6-47
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:20:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:53952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iyV68-0005WA-Ub
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:20:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iyV67-0007Ne-E8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 69B2D2E80C3
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 06:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Feb 2020 06:13:39 -0000
From: zwq <1861653@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: awdrg901
X-Launchpad-Bug-Reporter: zwq (awdrg901)
X-Launchpad-Bug-Modifier: zwq (awdrg901)
Message-Id: <158071042004.19865.7386710530747108432.malonedeb@wampee.canonical.com>
Subject: [Bug 1861653] [NEW] CPU of qemu-system-aarch64 always stuck
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 24e44a63cc61a3296c062f13f29e15df5f59ac6e
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
Reply-To: Bug 1861653 <1861653@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I started qemu with these arguments:
 qemu-system-aarch64 -M virt-2.9 -cpu cortex-a72 -smp cores=3D8,threads=3D1=
,sockets=3D1 -m 2G -device nec-usb-xhci -device usb-kbd -device usb-tablet =
-pflash /sdcard/QEMU_EFI.img -pflash /sdcard/QEMU_VARS.img -device virtio-b=
lk-device,drive=3DUbuntu -drive if=3Dnone,id=3DUbuntu,file=3DUbuntu.vhd -no=
graphic -net user -net nic,model=3Drtl8139 -kernel linux -initrd initrd.gz
The setup program of Ubuntu devel aarch64 ran normally.But after several ho=
urs,the CPUs emulated by qemu-system-aarch64 went wrong.
Here are the messages displayed on the tty
[15842.164745] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftirqd=
/0:9]                                                                      =
   [15930.163589] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksofti=
rqd/0:9]
[16110.163540] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftirqd=
/0:9] =

[16290.162801] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftirqd=
/0:9]
[16470.163927] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftirqd=
/0:9] =

[16650.163246] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftirqd=
/0:9] =

[16830.163216] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftirqd=
/0:9] =

[17010.164504] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftirqd=
/0:9]

Then I tried CentOS 7.1908 aarch64 with almost the same arguments.
After several hours,it went wrong too.
[17480 . 201 1 58] rcu : (3 ticks this GP) idle=3D362/0/0x3 softirq=3D61631=
 /61 631 fqs=3D10077
[17480 . 204889] (detected by 3 , t=3D24007 jiffies , g=3D218453 , q=3D5285=
) [1 7480 . 21 7986] Task dump for CPU 7 :
[17480.222379] swapper/7R running task	0 =

0  0x0000002a [17480.229073] Call trace :
[1 7480.241518]	switch t0+0x104/0x1 f8
[17480.249839]	Ox7fffffffffffffff
[17660.232314] rcu : INFO: rcu sched detected stalls on CPUs/ tasks :
[17660.233580] rcu : (3 ticks this GP) idle=3D362/0/0x3 softirq=3D61631 /61=
 631 fqs=3D17770
[17660.235837] (detected by 3,t=3D42012 jiffies , g=3D218453 , q=3D7039) =

[17660 . 237955] Task dump for CPU 7 :
[17660.238900] swapper/ 7  R running task  0   0
[17660.242967] Call trace :
[17660.246192]	switch t0+0x104/0x1 f8
[17660.253215]	Ox7fffffffffffffff

Obviously qemu-system-aarch64 caused these bugs.

qemu version: 4.x(I have tested version 4.0 & 4.1.0 & 4.2.0)
host architecture: aarch64(Qualcomm Snapdragon series)
host system:Ubuntu devel 20.04& Debian 10(I have tested on many devices)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861653

Title:
  CPU of qemu-system-aarch64 always stuck

Status in QEMU:
  New

Bug description:
  I started qemu with these arguments:
   qemu-system-aarch64 -M virt-2.9 -cpu cortex-a72 -smp cores=3D8,threads=
=3D1,sockets=3D1 -m 2G -device nec-usb-xhci -device usb-kbd -device usb-tab=
let -pflash /sdcard/QEMU_EFI.img -pflash /sdcard/QEMU_VARS.img -device virt=
io-blk-device,drive=3DUbuntu -drive if=3Dnone,id=3DUbuntu,file=3DUbuntu.vhd=
 -nographic -net user -net nic,model=3Drtl8139 -kernel linux -initrd initrd=
.gz
  The setup program of Ubuntu devel aarch64 ran normally.But after several =
hours,the CPUs emulated by qemu-system-aarch64 went wrong.
  Here are the messages displayed on the tty
  [15842.164745] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftir=
qd/0:9]                                                                    =
     [15930.163589] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksof=
tirqd/0:9]
  [16110.163540] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftir=
qd/0:9] =

  [16290.162801] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftir=
qd/0:9]
  [16470.163927] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftir=
qd/0:9] =

  [16650.163246] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftir=
qd/0:9] =

  [16830.163216] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftir=
qd/0:9] =

  [17010.164504] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [ksoftir=
qd/0:9]

  Then I tried CentOS 7.1908 aarch64 with almost the same arguments.
  After several hours,it went wrong too.
  [17480 . 201 1 58] rcu : (3 ticks this GP) idle=3D362/0/0x3 softirq=3D616=
31 /61 631 fqs=3D10077
  [17480 . 204889] (detected by 3 , t=3D24007 jiffies , g=3D218453 , q=3D52=
85) [1 7480 . 21 7986] Task dump for CPU 7 :
  [17480.222379] swapper/7R running task	0 =

  0  0x0000002a [17480.229073] Call trace :
  [1 7480.241518]	switch t0+0x104/0x1 f8
  [17480.249839]	Ox7fffffffffffffff
  [17660.232314] rcu : INFO: rcu sched detected stalls on CPUs/ tasks :
  [17660.233580] rcu : (3 ticks this GP) idle=3D362/0/0x3 softirq=3D61631 /=
61 631 fqs=3D17770
  [17660.235837] (detected by 3,t=3D42012 jiffies , g=3D218453 , q=3D7039) =

  [17660 . 237955] Task dump for CPU 7 :
  [17660.238900] swapper/ 7  R running task  0   0
  [17660.242967] Call trace :
  [17660.246192]	switch t0+0x104/0x1 f8
  [17660.253215]	Ox7fffffffffffffff

  Obviously qemu-system-aarch64 caused these bugs.

  qemu version: 4.x(I have tested version 4.0 & 4.1.0 & 4.2.0)
  host architecture: aarch64(Qualcomm Snapdragon series)
  host system:Ubuntu devel 20.04& Debian 10(I have tested on many devices)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861653/+subscriptions

