Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06522C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9EA20720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9EA20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKRi-0006Qw-5X
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 14:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juKQn-0005zi-0p
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:41:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:60922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juKQi-0000bW-IB
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:41:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1juKQg-0004JJ-0O
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 18:40:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 01D3C2E80EC
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 18:40:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2020 18:34:27 -0000
From: Alexander Bulekov <1681439@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr bugs-syssec janitor jnsnow kempniu th-huth
X-Launchpad-Bug-Reporter: =?utf-8?b?TWljaGHFgiBLxJlwaWXFhCAoa2VtcG5pdSk=?=
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
Message-Id: <159449246775.12745.14152885399246712247.malone@soybean.canonical.com>
Subject: [Bug 1681439] Re: qemu-system-x86_64: hw/ide/core.c:685:
 ide_cancel_dma_sync: Assertion `s->bus->dma->aiocb == NULL' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7cb504325ea9c7183c196b5585edc34c0888e582
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 14:40:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a qtest reproducer

cat << EOF | ./i386-softmmu/qemu-system-i386 \
-M pc,accel=3Dqtest -qtest null -nographic -vga qxl -qtest stdio -nodefault=
s \
-drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,file.read-zeroes=3Don,format=
=3Draw \
-drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroes=3Don,format=
=3Draw  \
-device ide-cd,drive=3Ddrive0 -device ide-hd,drive=3Ddrive1 =

writel 0x0 0xffffffff
outw 0x171 0x32a
outw 0x176 0x3570
outl 0xcf8 0x80000903
outl 0xcfc 0x4e002700
outl 0xcf8 0x80000920
outb 0xcfc 0x5e
outb 0x58 0xe1
outw 0x57 0x0
EOF

With -trace ide\*:
[I 1594492439.431181] OPENED
8666@1594492439.441003:ide_reset IDEstate 0x557f44953598
8666@1594492439.441084:ide_reset IDEstate 0x557f44953968
8666@1594492439.441407:ide_reset IDEstate 0x557f44953e88
8666@1594492439.441484:ide_reset IDEstate 0x557f44954258
8666@1594492439.442483:ide_reset IDEstate 0x557f44953e88
8666@1594492439.442548:ide_reset IDEstate 0x557f44954258
8666@1594492439.444817:ide_reset IDEstate 0x557f44953598
8666@1594492439.444822:ide_reset IDEstate 0x557f44953968
8666@1594492439.444824:ide_reset IDEstate 0x557f44953e88
8666@1594492439.444825:ide_reset IDEstate 0x557f44954258
[R +0.015229] writel 0x0 0xffffffff
OK
[S +0.015321] OK
[R +0.015328] outw 0x171 0x32a
8666@1594492439.446534:ide_ioport_write IDE PIO wr @ 0x171 (Features); val =
0x2a; bus 0x557f44953e00 IDEState 0x557f44953e88
8666@1594492439.446537:ide_ioport_write IDE PIO wr @ 0x172 (Sector Count); =
val 0x03; bus 0x557f44953e00 IDEState 0x557f44953e88
OK
[S +0.015360] OK
[R +0.015377] outw 0x176 0x3570
8666@1594492439.446561:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head); v=
al 0x70; bus 0x557f44953e00 IDEState 0x557f44953e88
8666@1594492439.446564:ide_ioport_write IDE PIO wr @ 0x177 (Command); val 0=
x35; bus 0x557f44953e00 IDEState 0x557f44954258
8666@1594492439.446581:ide_exec_cmd IDE exec cmd: bus 0x557f44953e00; state=
 0x557f44954258; cmd 0x35
OK
[S +0.015404] OK
[R +0.015410] outl 0xcf8 0x80000903
OK
[S +0.015413] OK
[R +0.015429] outl 0xcfc 0x4e002700
OK
[S +0.015555] OK
[R +0.015559] outl 0xcf8 0x80000920
OK
[S +0.015561] OK
[R +0.015563] outb 0xcfc 0x5e
OK
[S +0.015663] OK
[R +0.015667] outb 0x58 0xe1
8666@1594492439.446896:ide_dma_cb IDEState 0x557f44954258; sector_num=3D1 n=
=3D259 cmd=3DDMA WRITE
OK
[S +0.015801] OK
[R +0.015806] outw 0x57 0x0
8666@1594492439.447006:ide_cancel_dma_sync_remaining draining all remaining=
 requests
qemu-system-i386: /home/alxndr/Development/qemu/hw/ide/core.c:724: void ide=
_cancel_dma_sync(IDEState *): Assertion `s->bus->dma->aiocb =3D=3D NULL' fa=
iled.
Aborted

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681439

Title:
  qemu-system-x86_64: hw/ide/core.c:685: ide_cancel_dma_sync: Assertion
  `s->bus->dma->aiocb =3D=3D NULL' failed.

Status in QEMU:
  New

Bug description:
  Since upgrading to QEMU 2.8.0, my Windows 7 64-bit virtual machines
  started crashing due to the assertion quoted in the summary failing.
  The assertion in question was added by commit 9972354856 ("block: add
  BDS field to count in-flight requests").  My tests show that setting
  discard=3Dunmap is needed to reproduce the issue.  Speaking of
  reproduction, it is a bit flaky, because I have been unable to come up
  with specific instructions that would allow the issue to be triggered
  outside of my environment, but I do have a semi-sane way of testing that
  appears to depend on a specific initial state of data on the underlying
  storage volume, actions taken within the VM and waiting for about 20
  minutes.

  Here is the shortest QEMU command line that I managed to reproduce the
  bug with:

      qemu-system-x86_64 \
          -machine pc-i440fx-2.7,accel=3Dkvm \
          -m 3072 \
          -drive file=3D/dev/lvm/qemu,format=3Draw,if=3Dide,discard=3Dunmap=
 \
  	-netdev tap,id=3Dhostnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhos=
t=3Don \
          -device virtio-net-pci,netdev=3Dhostnet0 \
  	-vnc :0

  The underlying storage (/dev/lvm/qemu) is a thin LVM snapshot.

  QEMU was compiled using:

      ./configure --python=3D/usr/bin/python2.7 --target-list=3Dx86_64-soft=
mmu
      make -j3

  My virtualization environment is not really a critical one and
  reproduction is not that much of a hassle, so if you need me to gather
  further diagnostic information or test patches, I will be happy to help.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681439/+subscriptions

