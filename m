Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9B9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B3206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B3206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBnq-0008L6-Hs
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBmq-0007UK-Bv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:21:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:55656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBmo-0006Qf-8M
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:21:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kcBmm-0004SB-9P
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 18:21:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EE7442E8133
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 18:20:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 18:07:02 -0000
From: Thomas Huth <1702621@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h pork-prince th-huth zhangckid
X-Launchpad-Bug-Reporter: junchi (pork-prince)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <149932544038.24380.387410318124517933.malonedeb@soybean.canonical.com>
Message-Id: <160494522242.28833.5910076651377792267.malone@chaenomeles.canonical.com>
Subject: [Bug 1702621] Re: colo: secondary vm crash during loadvm
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 430a157ff8e2f37b6214527c7c1ab7562dfaf0e9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:16:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1702621 <1702621@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting older bugs to "Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1702621

Title:
  colo: secondary vm crash during loadvm

Status in QEMU:
  Incomplete

Bug description:
  Following document 'COLO-FT.txt', I test colo feature on my hosts. It see=
ms goes well. But after a while the secondary vm crash.  The stack is as fo=
llows:
  #0  0x00007f191456dc37 in raise () from /lib/x86_64-linux-gnu/libc.so.6
  #1  0x00007f1914571028 in abort () from /lib/x86_64-linux-gnu/libc.so.6
  #2  0x00007f1914566bf6 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
  #3  0x00007f1914566ca2 in __assert_fail () from /lib/x86_64-linux-gnu/lib=
c.so.6
  #4  0x0000564154ad9147 in pcibus_reset (qbus=3D0x564156760d10) at ../hw/p=
ci/pci.c:311
  #5  0x0000564154a07cdb in qbus_reset_one (bus=3D0x564156760d10, opaque=3D=
0x0) at hw/core/qdev.c:319
  #6  0x0000564154a0d721 in qbus_walk_children (bus=3D0x564156760d10, pre_d=
evfn=3D0, pre_busfn=3D0, =

      post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a0=
7c6c <qbus_reset_one>, opaque=3D0x0)
      at hw/core/bus.c:68
  #7  0x0000564154a08b4d in qdev_walk_children (dev=3D0x56415675f2b0, pre_d=
evfn=3D0, pre_busfn=3D0, =

      post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a0=
7c6c <qbus_reset_one>, opaque=3D0x0)
      at hw/core/qdev.c:617
  #8  0x0000564154a0d6e5 in qbus_walk_children (bus=3D0x564156594d30, pre_d=
evfn=3D0, pre_busfn=3D0, =

      post_devfn=3D0x564154a07c26 <qdev_reset_one>, post_busfn=3D0x564154a0=
7c6c <qbus_reset_one>, opaque=3D0x0)
      at hw/core/bus.c:59
  #9  0x0000564154a07df5 in qbus_reset_all (bus=3D0x564156594d30) at hw/cor=
e/qdev.c:336
  #10 0x0000564154a07e3a in qbus_reset_all_fn (opaque=3D0x564156594d30) at =
hw/core/qdev.c:342
  #11 0x0000564154a0e222 in qemu_devices_reset () at hw/core/reset.c:69
  #12 0x00005641548b3b47 in pc_machine_reset () at /vms/git/qemu/hw/i386/pc=
.c:2234
  #13 0x0000564154972ca7 in qemu_system_reset (report=3Dfalse) at vl.c:1697
  #14 0x0000564154b9d007 in colo_process_incoming_thread (opaque=3D0x564155=
3c1280) at migration/colo.c:617
  #15 0x00007f1914907184 in start_thread () from /lib/x86_64-linux-gnu/libp=
thread.so.0
  #16 0x00007f1914634bed in clone () from /lib/x86_64-linux-gnu/libc.so.6

  (gdb) frame 4
  #4  0x0000564154ad9147 in pcibus_reset (qbus=3D0x564156760d10) at ../hw/p=
ci/pci.c:311
  warning: Source file is more recent than executable.
  311             assert(bus->irq_count[i] =3D=3D 0);
  (gdb) ^CQuit
  (gdb) p bus->irq_count[i]
  $1 =3D -1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1702621/+subscriptions

