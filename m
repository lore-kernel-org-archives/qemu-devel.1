Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C414CC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997B0218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997B0218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinEM-0004Vd-RZ
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1himl9-0006Du-2D
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1himl7-0002EE-65
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:25:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:44080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1himl5-0002DB-PH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1himl4-00051p-IL
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 21:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8728C2E8075
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 21:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jul 2019 21:12:41 -0000
From: Avi Eis <1834113@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=libvirt; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: amd64 apport-bug disco
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bryce ikes73 paelzer
X-Launchpad-Bug-Reporter: Avi Eis (ikes73)
X-Launchpad-Bug-Modifier: Avi Eis (ikes73)
References: <156142437029.30985.13623507391124028236.malonedeb@soybean.canonical.com>
Message-Id: <156218836156.23706.18093305873155322060.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 379e408e53c936db8e1c02c848cfcb5b1b7d7d77
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1834113] Re: QEMU touchpad input erratic after
 wakeup from sleep
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
Reply-To: Bug 1834113 <1834113@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>Core Gen8 Mobile

That's my i9-8950HK.

What I don't understand is why it works perfectly on the host but not on
the guest. And the fact that it persists even when rebooting the guest
implies it's not an issue with the guest runtime or anything. It seems
like the issue must be with the way qemu is sending the events through
to the guest, which I have no idea about.

Also, it never ignores my clicks. It's generating clicks that I never
made - specifically, when moving the cursor it's acting as if I had
clicked and dragged. So moving the cursor on a webpage just selects a
bunch of text, moving it across the desktop draws a window, etc.

I will try some of the other troubleshooting methods.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1834113

Title:
  QEMU touchpad input erratic after wakeup from sleep

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  New
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Using Ubuntu host and guest. Normally the touchpad works great. Within
  the last few days, suddenly, apparently after a wake from sleep, the
  touchpad will behave erratically. For example, it will take two clicks
  to select something, and when moving the cursor it will act as though
  it is dragging even with the button not clicked.

  A reboot fixes the issue temporarily.

  ProblemType: Bug
  DistroRelease: Ubuntu 19.04
  Package: qemu 1:3.1+dfsg-2ubuntu3.1
  Uname: Linux 5.1.14-050114-generic x86_64
  ApportVersion: 2.20.10-0ubuntu27
  Architecture: amd64
  CurrentDesktop: ubuntu:GNOME
  Date: Mon Jun 24 20:55:44 2019
  Dependencies:
   =

  EcryptfsInUse: Yes
  InstallationDate: Installed on 2019-02-20 (124 days ago)
  InstallationMedia: Ubuntu 18.04 "Bionic" - Build amd64 LIVE Binary 201806=
08-09:38
  Lsusb:
   Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
   Bus 001 Device 002: ID 8087:0025 Intel Corp. =

   Bus 001 Device 003: ID 0c45:671d Microdia =

   Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
  MachineType: Dell Inc. Precision 5530
  ProcEnviron:
   TERM=3Dxterm-256color
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-5.1.14-050114-generic root=
=3DUUID=3D18e8777c-1764-41e4-a19f-62476055de23 ro mem_sleep_default=3Ddeep =
mem_sleep_default=3Ddeep acpi_rev_override=3D1 scsi_mod.use_blk_mq=3D1 nouv=
eau.modeset=3D0 nouveau.runpm=3D0 nouveau.blacklist=3D1 acpi_backlight=3Dno=
ne acpi_osi=3DLinux acpi_osi=3D!
  SourcePackage: qemu
  UpgradeStatus: No upgrade log present (probably fresh install)
  dmi.bios.date: 04/26/2019
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: 1.10.1
  dmi.board.name: 0FP2W2
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A00
  dmi.chassis.type: 10
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvr1.10.1:bd04/26/2019:svnDellInc.:pnPrecis=
ion5530:pvr:rvnDellInc.:rn0FP2W2:rvrA00:cvnDellInc.:ct10:cvr:
  dmi.product.family: Precision
  dmi.product.name: Precision 5530
  dmi.product.sku: 087D
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1834113/+subscriptions

