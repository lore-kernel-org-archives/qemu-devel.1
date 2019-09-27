Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E798BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB922075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB922075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDxrU-00053g-So
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iDxpL-0003rH-2r
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iDxpJ-0001WN-HN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:30:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:47918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iDxpI-0001QX-Iw
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:30:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iDxpF-0001HV-KR
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 21:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 99BAB2E80C9
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 21:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Sep 2019 21:20:21 -0000
From: Matt Haggard <1798451@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: hvf x86
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mhaggard romell roolebo
X-Launchpad-Bug-Reporter: Rob Maskell (romell)
X-Launchpad-Bug-Modifier: Matt Haggard (mhaggard)
References: <153980387714.3465.12419240219281347614.malonedeb@soybean.canonical.com>
Message-Id: <156961922177.15885.5386658623649180806.malone@gac.canonical.com>
Subject: [Bug 1798451] Re: MMX emulation is missing on HVF Acceleration
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19064";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f5029ab4b014b32ab2c8824d020ab54206b66b8d
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
Reply-To: Bug 1798451 <1798451@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding a ditto to this.

=3D=3D Command and output =3D=3D

$ qemu-system-x86_64 -m 2G -hda mydisk.vdi -accel hvf -vga std
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
80000001H:ECX.svm [bit 2]
Unimplemented handler (7fe3aac905e8) for 0 (f 11) =


This is for a customized Ubuntu install.

=3D=3D Symptoms =3D=3D

Guest window repeatedly alternates between the desktop, then flickers to
terminal with the following text:

/dev/sda4: recovering journal
/dev/sda4: clean, 93356/1264800 files, 1076062/5056592 blocks
[  OK  ] Started xrdp session manager.
[  OK  ] Started OpenBSD Secure Shell server.
[  OK  ] Started Terminate Plymouth Boot Screen.
[  OK  ] Started Hold until boot process finishes up.

=3D=3D Host system =3D=3D

- macOS 10.14.6
- Bluetooth mouse and keyboard


Also, the workaround of using -cpu host,-mmx,-sse doesn't work (the guest a=
ppears to never even boot).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798451

Title:
  MMX emulation is missing on HVF Acceleration

Status in QEMU:
  New

Bug description:
  Robs-MacBook-Pro-2:~ robmaskell$ qemu-system-x86_64 --version
  QEMU emulator version 3.0.0

  Host: MacOS - 10.13.6
    Model Name:	MacBook Pro
    Model Identifier:	MacBookPro14,3
    Processor Name:	Intel Core i7
    Processor Speed:	2.8 GHz
    Number of Processors:	1
    Total Number of Cores:	4
    L2 Cache (per Core):	256 KB
    L3 Cache:	6 MB
    Memory:	16 GB

  Guest OS: Elementary Linux Loki 0.4.1, patched up to date

  Command used to start QEMU:

  qemu-system-x86_64 \
    -name ElementaryLokiDev \
    -machine pc,accel=3Dhvf \
    -cpu max \
    -smp cpus=3D2,sockets=3D2,cores=3D1,threads=3D1,maxcpus=3D2 \
    -numa node,nodeid=3D0 \
    -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D0,socket-id=3D1=
 \
    -m 8G \
    -vga vmware \
    -hda e4.qcow2

  Symptoms: Started without the -smp / -numa commands to install the OS,
  then added -smp / -numa and the machine boots and lscpu reports extra
  cpu as expected. Restart VM and it hangs on startup. Remove -smp /
  -numa and machine starts again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798451/+subscriptions

