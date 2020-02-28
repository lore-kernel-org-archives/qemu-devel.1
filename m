Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762CEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C182246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C182246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7gzD-0003Ff-G4
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 09:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j7gyP-0002KD-Sz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j7gyO-0001mY-26
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:50:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:45708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j7gyN-0001m2-SM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:50:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j7gyM-0004gi-C9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 14:50:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 446482E807E
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 14:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2020 14:40:29 -0000
From: "A. Farrell" <1865160@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: qemu-system-s390x
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alfarre
X-Launchpad-Bug-Reporter: A. Farrell (alfarre)
X-Launchpad-Bug-Modifier: A. Farrell (alfarre)
Message-Id: <158290082970.7536.17698296699397322599.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1865160] [NEW] Unpredictable behaviour resulting in User process
 faults
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: aac49a08da0537aca660b1a90b5b3e68daae2b4c
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
Reply-To: Bug 1865160 <1865160@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

An example of the behaviour can be reproduced when using NPM, whereby
running the command multiple times will result in a variety of error
conditions causing the command to fail:

Example of failure:

Segmentation fault.] / rollbackFailedOptional: verb npm-session
1a805a5e0ff7b8f5

[ 3144.216869] User process fault: interruption code 0038 ilc:3 =

[ 3144.216981] Failing address: 66616c7365000000 TEID: 66616c7365000800
[ 3144.217009] Fault in primary space mode while using user ASCE.
[ 3144.217055] AS:00000000ed28c1c7 R3:0000000000000024 =


Feb 28 14:32:08 qemus390x kernel: [ 3144.216869] User process fault: interr=
uption code 0038 ilc:3 =

Feb 28 14:32:08 qemus390x kernel: [ 3144.216981] Failing address: 66616c736=
5000000 TEID: 66616c7365000800
Feb 28 14:32:08 qemus390x kernel: [ 3144.217009] Fault in primary space mod=
e while using user ASCE.
Feb 28 14:32:08 qemus390x kernel: [ 3144.217055] AS:00000000ed28c1c7 R3:000=
0000000000024 =

Feb 28 14:32:08 qemus390x kernel: [ 3144.217217] CPU: 2 PID: 1018 Comm: npm=
 Not tainted 4.15.0-88-generic #88-Ubuntu
Feb 28 14:32:08 qemus390x kernel: [ 3144.217234] Hardware name: QEMU 2964 Q=
EMU (KVM/Linux)
Feb 28 14:32:08 qemus390x kernel: [ 3144.217257] User PSW : 00000000185db98=
2 00000000c1d5a1a1
Feb 28 14:32:08 qemus390x kernel: [ 3144.217290]            R:0 T:1 IO:1 EX=
:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:3
Feb 28 14:32:08 qemus390x kernel: [ 3144.217322] User GPRS: 000002aa0370520=
0 0000006a16d73ac1 0000003da4b829f1 0000000000000000
Feb 28 14:32:08 qemus390x kernel: [ 3144.217343]            0000003da4b82a0=
8 0000003da4b82a08 000002aa036a92ec 0000000000000000
Feb 28 14:32:08 qemus390x kernel: [ 3144.217364]            0000003da4b829f=
1 000003ffdb8f7e50 0000003da4b82a08 000003ffdb8f7d88
Feb 28 14:32:08 qemus390x kernel: [ 3144.217385]            66616c736500000=
0 000002aa036a05b0 000002aa015bcfb2 000003ffdb8f7d88
Feb 28 14:32:08 qemus390x kernel: [ 3144.217512] User Code:#0000006a16d73b0=
0: c0f4000000df	brcl	15,0000006a16d73cbe
Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]           >0000006a16d73b0=
6: a7290000		lghi	%r2,0
Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73b0=
a: 07fe		bcr	15,%r14
Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73b0=
c: c02f000001f3	llilf	%r2,499
Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73b1=
2: e3d0dff8ff71	lay	%r13,-8(%r13)
Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73b1=
8: e320d0000024	stg	%r2,0(%r13)
Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73b1=
e: c028000002aa	iihf	%r2,682
Feb 28 14:32:08 qemus390x kernel: [ 3144.217724] Last Breaking-Event-Addres=
s:
Feb 28 14:32:08 qemus390x kernel: [ 3144.217759]  [<000002aa015bcfae>] 0x2a=
a015bcfae


QEMU emulator version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

QEMU Command:

sudo qemu-system-s390x -smp cpus=3D5 -machine s390-ccw-virtio -cpu
max,zpci=3Don -serial telnet::4441,server -display none -m 4096 -net nic
-net tap  -drive file=3Dubuntu.root,if=3Dnone,id=3Ddrive-virtio-
disk0,format=3Draw,cache=3Dnone -device virtio-blk-ccw,devno=3Dfe.0.0003,dr=
ive
=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D100,scsi=3Doff -drive
file=3Dubuntu.home,if=3Dnone,id=3Ddrive-virtio-disk1,format=3Draw,cache=3Dn=
one
-device virtio-blk-ccw,devno=3Dfe.0.0002,drive=3Ddrive-virtio-disk1,id
=3Dvirtio-disk1,bootindex=3D1,scsi=3Doff -drive file=3Dubuntu.swap,if=3Dnon=
e,id
=3Ddrive-virtio-disk4,format=3Draw,cache=3Dnone -device virtio-blk-
ccw,devno=3Dfe.0.0005,drive=3Ddrive-virtio-disk4,id=3Dvirtio-
disk4,bootindex=3D101,scsi=3Doff


Ubuntu 18.04.4 LTS qemus390x ttysclp0

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-system-s390x

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1865160

Title:
  Unpredictable behaviour resulting in User process faults

Status in QEMU:
  New

Bug description:
  An example of the behaviour can be reproduced when using NPM, whereby
  running the command multiple times will result in a variety of error
  conditions causing the command to fail:

  Example of failure:

  Segmentation fault.] / rollbackFailedOptional: verb npm-session
  1a805a5e0ff7b8f5

  [ 3144.216869] User process fault: interruption code 0038 ilc:3 =

  [ 3144.216981] Failing address: 66616c7365000000 TEID: 66616c7365000800
  [ 3144.217009] Fault in primary space mode while using user ASCE.
  [ 3144.217055] AS:00000000ed28c1c7 R3:0000000000000024 =


  Feb 28 14:32:08 qemus390x kernel: [ 3144.216869] User process fault: inte=
rruption code 0038 ilc:3 =

  Feb 28 14:32:08 qemus390x kernel: [ 3144.216981] Failing address: 66616c7=
365000000 TEID: 66616c7365000800
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217009] Fault in primary space m=
ode while using user ASCE.
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217055] AS:00000000ed28c1c7 R3:0=
000000000000024 =

  Feb 28 14:32:08 qemus390x kernel: [ 3144.217217] CPU: 2 PID: 1018 Comm: n=
pm Not tainted 4.15.0-88-generic #88-Ubuntu
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217234] Hardware name: QEMU 2964=
 QEMU (KVM/Linux)
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217257] User PSW : 00000000185db=
982 00000000c1d5a1a1
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217290]            R:0 T:1 IO:1 =
EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:3
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217322] User GPRS: 000002aa03705=
200 0000006a16d73ac1 0000003da4b829f1 0000000000000000
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217343]            0000003da4b82=
a08 0000003da4b82a08 000002aa036a92ec 0000000000000000
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217364]            0000003da4b82=
9f1 000003ffdb8f7e50 0000003da4b82a08 000003ffdb8f7d88
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217385]            66616c7365000=
000 000002aa036a05b0 000002aa015bcfb2 000003ffdb8f7d88
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217512] User Code:#0000006a16d73=
b00: c0f4000000df	brcl	15,0000006a16d73cbe
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]           >0000006a16d73=
b06: a7290000		lghi	%r2,0
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73=
b0a: 07fe		bcr	15,%r14
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73=
b0c: c02f000001f3	llilf	%r2,499
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73=
b12: e3d0dff8ff71	lay	%r13,-8(%r13)
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73=
b18: e320d0000024	stg	%r2,0(%r13)
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217512]            0000006a16d73=
b1e: c028000002aa	iihf	%r2,682
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217724] Last Breaking-Event-Addr=
ess:
  Feb 28 14:32:08 qemus390x kernel: [ 3144.217759]  [<000002aa015bcfae>] 0x=
2aa015bcfae


  =

  QEMU emulator version 4.2.0
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  QEMU Command:

  sudo qemu-system-s390x -smp cpus=3D5 -machine s390-ccw-virtio -cpu
  max,zpci=3Don -serial telnet::4441,server -display none -m 4096 -net nic
  -net tap  -drive file=3Dubuntu.root,if=3Dnone,id=3Ddrive-virtio-
  disk0,format=3Draw,cache=3Dnone -device virtio-blk-
  ccw,devno=3Dfe.0.0003,drive=3Ddrive-virtio-disk0,id=3Dvirtio-
  disk0,bootindex=3D100,scsi=3Doff -drive file=3Dubuntu.home,if=3Dnone,id=
=3Ddrive-
  virtio-disk1,format=3Draw,cache=3Dnone -device virtio-blk-
  ccw,devno=3Dfe.0.0002,drive=3Ddrive-virtio-disk1,id=3Dvirtio-
  disk1,bootindex=3D1,scsi=3Doff -drive file=3Dubuntu.swap,if=3Dnone,id=3Dd=
rive-
  virtio-disk4,format=3Draw,cache=3Dnone -device virtio-blk-
  ccw,devno=3Dfe.0.0005,drive=3Ddrive-virtio-disk4,id=3Dvirtio-
  disk4,bootindex=3D101,scsi=3Doff

  =

  Ubuntu 18.04.4 LTS qemus390x ttysclp0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1865160/+subscriptions

