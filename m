Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E3FC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766962087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766962087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ubuntu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0qF-00010A-MG
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 10:13:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hO0oQ-0008Fd-Kv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hO0oO-0000Rr-J7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:11:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:60538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hO0oO-0000Qq-DI
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:11:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hO0oN-0002aC-0O
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 14:11:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EB3BC2E80C9
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 14:11:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 May 2019 14:04:58 -0000
From: Sebastien Bacher <seb128@ubuntu.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=mesa; status=Won't Fix; importance=High; assignee=None;
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=mesa; component=main;
	milestone=ubuntu-19.04; status=Fix Released; importance=Medium;
	assignee=tjaalton@ubuntu.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
	status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=disco; sourcepackage=mesa; 
	component=main; milestone=ubuntu-19.04; status=Fix Released;
	importance=Medium; assignee=tjaalton@ubuntu.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=eoan; sourcepackage=mesa;
	component=main; status=Fix Released; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; distroseries=eoan; sourcepackage=qemu;
	component=main; status=Triaged; importance=Undecided;
	assignee=christian.ehrhardt@canonical.com; 
X-Launchpad-Bug-Tags: amd64 apport-crash apport-failed-retrace disco
	qemu-19.10 wayland-session
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahzo alexdeucher apport baker-dylan-c berrange
	dan-freedesktop janitor jokx maraeo marcandre-lureau michel-daenzer
	paelzer tjaalton willcooke
X-Launchpad-Bug-Reporter: Joseph Maillardet (jokx)
X-Launchpad-Bug-Modifier: Sebastien Bacher (seb128)
References: <155014036044.634.15252078016929169795.malonedeb@gac.canonical.com>
Message-Id: <155723790017.18129.11253337142707029220.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18958";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e38720dce19f91ef7235e82b57769d57c630de75
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1815889] Re: qemu-system-x86_64 crashed with
 signal 31 in __pthread_setaffinity_new()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1815889 <1815889@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: mesa (Ubuntu Eoan)
       Status: Triaged =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815889

Title:
  qemu-system-x86_64 crashed with signal 31 in
  __pthread_setaffinity_new()

Status in Mesa:
  Won't Fix
Status in QEMU:
  Fix Released
Status in mesa package in Ubuntu:
  Fix Released
Status in qemu package in Ubuntu:
  Invalid
Status in mesa source package in Disco:
  Fix Released
Status in mesa source package in Eoan:
  Fix Released
Status in qemu source package in Eoan:
  Triaged

Bug description:
  Unable to launch Default Fedora 29 images in gnome-boxes

  ProblemType: Crash
  DistroRelease: Ubuntu 19.04
  Package: qemu-system-x86 1:3.1+dfsg-2ubuntu1
  ProcVersionSignature: Ubuntu 4.19.0-12.13-generic 4.19.18
  Uname: Linux 4.19.0-12-generic x86_64
  ApportVersion: 2.20.10-0ubuntu20
  Architecture: amd64
  Date: Thu Feb 14 11:00:45 2019
  ExecutablePath: /usr/bin/qemu-system-x86_64
  KvmCmdLine: COMMAND         STAT  EUID  RUID   PID  PPID %CPU COMMAND
  MachineType: Dell Inc. Precision T3610
  ProcEnviron: PATH=3D(custom, user)
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-4.19.0-12-generic root=3DUU=
ID=3D939b509b-d627-4642-a655-979b44972d17 ro splash quiet vt.handoff=3D1
  Signal: 31
  SourcePackage: qemu
  StacktraceTop:
   __pthread_setaffinity_new (th=3D<optimized out>, cpusetsize=3D128, cpuse=
t=3D0x7f5771fbf680) at ../sysdeps/unix/sysv/linux/pthread_setaffinity.c:34
   () at /usr/lib/x86_64-linux-gnu/dri/radeonsi_dri.so
   () at /usr/lib/x86_64-linux-gnu/dri/radeonsi_dri.so
   start_thread (arg=3D<optimized out>) at pthread_create.c:486
   clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
  Title: qemu-system-x86_64 crashed with signal 31 in __pthread_setaffinity=
_new()
  UpgradeStatus: Upgraded to disco on 2018-11-14 (91 days ago)
  UserGroups: adm cdrom dip lpadmin plugdev sambashare sudo video
  dmi.bios.date: 11/14/2018
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: A18
  dmi.board.name: 09M8Y8
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A01
  dmi.chassis.type: 7
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvrA18:bd11/14/2018:svnDellInc.:pnPrecision=
T3610:pvr00:rvnDellInc.:rn09M8Y8:rvrA01:cvnDellInc.:ct7:cvr:
  dmi.product.name: Precision T3610
  dmi.product.sku: 05D2
  dmi.product.version: 00
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/mesa/+bug/1815889/+subscriptions

