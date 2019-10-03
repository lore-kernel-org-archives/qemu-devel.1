Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69829C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E49218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E49218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFyCS-0005eo-8U
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iFyBQ-00055F-Ur
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iFyBP-0006oF-NK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:18:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:36782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iFyBP-0006nw-GC
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:18:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iFyBN-00076A-9r
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 10:18:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2F9CF2E80DE
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:18:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Oct 2019 10:03:23 -0000
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux; component=main;
 status=Won't Fix; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu-kvm; component=main; 
 status=Invalid; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=fedora; sourcepackage=linux; component=None;
 status=Won't Fix; importance=Medium; assignee=None; 
X-Launchpad-Bug-Tags: amd64 apport-bug kernel-core kernel-reviewed kj-triage
 lucid uec-images
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: amit-redhat-bugs anthony-codemonkey
 ariel-redhat-bugs bug-redhat-bugs cypressyew fedora-redhat-bugs hggdh2
 james-redhat-bugs jeremyfoshee justin-redhat-bugs serge-hallyn smoser
X-Launchpad-Bug-Reporter: Scott Moser (smoser)
X-Launchpad-Bug-Modifier: Po-Hsu Lin (cypressyew)
References: <20100324221929.19590.58686.malonedeb@wampee.canonical.com>
Message-Id: <157009700400.16699.3226138387992830590.malone@gac.canonical.com>
Subject: [Bug 546458] Re: kernel NULL pointer in -virtual (-server) kernel
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19066";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f017ad2222b455d5751df9d5e13675a879c3ef8c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 546458 <546458@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Closing this bug with Won't fix as this kernel / release is no longer suppo=
rted.
Please feel free to open a new bug report if you're still experiencing this=
 on a newer release (Bionic 18.04.3 / Disco 19.04)
Thanks!

** Changed in: linux (Ubuntu)
       Status: Triaged =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/546458

Title:
  kernel NULL pointer in -virtual (-server) kernel

Status in QEMU:
  Invalid
Status in linux package in Ubuntu:
  Won't Fix
Status in qemu-kvm package in Ubuntu:
  Invalid
Status in linux package in Fedora:
  Won't Fix

Bug description:
  When stress testing eucalyptus we have run into this oops inside VMs
  [   82.907577] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000358^M
  [   82.908842] IP: [<ffffffff813982e8>] sym_int_sir+0x2a8/0x750^M
  [   82.909773] PGD 0 ^M
  [   82.910110] Thread overran stack, or stack corrupted^M
  [   82.910870] Oops: 0000 [#1] SMP ^M
  [   82.911407] last sysfs file: /sys/devices/virtual/block/ram9/uevent^M

  We launched 18 instances, 2 of them failed this way.  The instances
  run with 192M of memory.  With 6 VM launches on a single node all at
  the same time the host is under heavy load.

  This occurred in 20100323 lucid x86_64 uec-image instance.

  ProblemType: Bug
  AlsaDevices: Error: command ['ls', '-l', '/dev/snd/'] failed with exit co=
de 2: ls: cannot access /dev/snd/: No such file or directory
  AplayDevices: Error: [Errno 2] No such file or directory
  Architecture: amd64
  ArecordDevices: Error: [Errno 2] No such file or directory
  CurrentDmesg:
   =

  Date: Wed Mar 24 22:06:32 2010
  DistroRelease: Ubuntu 10.04
  Frequency: Once a day.
  Lsusb: Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
  MachineType: Bochs Bochs
  Package: linux-image-2.6.32-16-virtual 2.6.32-16.25
  PciMultimedia:
   =

  ProcCmdLine: root=3D/dev/sda1 console=3DttyS0
  ProcEnviron:
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  ProcVersionSignature: User Name 2.6.32-16.25-server
  Regression: No
  Reproducible: No
  SourcePackage: linux
  TestedUpstream: No
  Uname: Linux 2.6.32-16-server x86_64
  dmi.bios.date: 01/01/2007
  dmi.bios.vendor: Bochs
  dmi.bios.version: Bochs
  dmi.chassis.type: 1
  dmi.chassis.vendor: Bochs
  dmi.modalias: dmi:bvnBochs:bvrBochs:bd01/01/2007:svnBochs:pnBochs:pvr:cvn=
Bochs:ct1:cvr:
  dmi.product.name: Bochs
  dmi.sys.vendor: Bochs

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/546458/+subscriptions

