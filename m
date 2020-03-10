Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431F8C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCA92051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCA92051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbAI-0005Q0-By
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBb9A-0003jn-9v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBb99-0008DI-1L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:41594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBb98-0008BJ-S1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBb97-0005Dc-VU
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:25:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EC2E12E80C8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:25:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Mar 2020 09:13:34 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=th.huth@googlemail.com; 
X-Launchpad-Bug-Tags: s390x
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: jgkammerer laurent-vivier th-huth
X-Launchpad-Bug-Reporter: Jean-Gabriel Kammerer (jgkammerer)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158005183659.18916.14986952783973408797.malonedeb@gac.canonical.com>
Message-Id: <158383161468.27057.14100059222360517034.malone@gac.canonical.com>
Subject: [Bug 1860920] Re: qemu-s390x-softmmu: crash 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 004974176bfb5e4b794722b78e3fbbc9be3f45dd
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
Reply-To: Bug 1860920 <1860920@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D0bab189c96c7

** Changed in: qemu
       Status: Confirmed =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860920

Title:
  qemu-s390x-softmmu: crash

Status in QEMU:
  Fix Committed

Bug description:
  Trying to compile and use rust programs on an s390x emulated machine,
  crash in qemu/target/s390x/translate.c line 3894

  Steps to reproduce:
  on a amd64 PC, installed debian on s390x emulated by qemu, seems to work =
fine (installed some packages, etc.)
  installed rust cargo (either from rustup or from debian)
  cargo install anything makes *qemu* crash when beginning to compile

  Technical details:
  * host: amd64 Linux
  * qemu v4.2.0 (recompiled from git with debug options using configure --t=
arget-list=3Ds390x-softmmu --enable-debug) (problem appears also with older=
 versions of qemu from git, with default compilation options, with qemu fro=
m debian, etc.)
  * compiled with gcc 9.2
  * command line, relevant part: qemu-system-s390x -snapshot -machine s390-=
ccw-virtio -cpu max,zpci=3Don -serial mon:stdio -display none -m 512
  (tested with -smp 4  -m 4096 as well and without snapshotting)
  * command line, less relevant part: -drive file=3D./debian.qcow2,if=3Dnon=
e,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnone    -device virtio-blk=
-ccw,devno=3Dfe.0.0001,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootind=
ex=3D1,scsi=3Doff    -netdev user,id=3Dmynet0,hostfwd=3Dtcp::2223-:22 -devi=
ce virtio-net-pci,netdev=3Dmynet0
  * core dump: abort in qemu/target/s390x/translate.c line 3894 ; s->field:=
 op has value 0xEC and op2 has value 0x54
  (more info available if needed)

  Tried to patch source to add 0x54 case to no avail.
  Tried other cpu variants to no avail as well.

  Reporting this in security as well since it also looks very much like
  a DoS (albeit somewhat minor), feel free to tell me to report the bug
  somewhere else.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860920/+subscriptions

