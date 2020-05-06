Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC8C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5099220A8B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099220A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWMt1-0007xR-Gj
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 12:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWMry-0006b2-3q
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:26:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:57400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWMrw-0006Ol-Pn
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:26:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jWMru-00070w-MO
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 16:25:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A87982E810B
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 16:25:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2020 16:18:14 -0000
From: "A. Farrell" <1865160@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: npm qemu-system-s390x s390x
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alfarre
X-Launchpad-Bug-Reporter: A. Farrell (alfarre)
X-Launchpad-Bug-Modifier: A. Farrell (alfarre)
References: <158290082970.7536.17698296699397322599.malonedeb@chaenomeles.canonical.com>
Message-Id: <158878189466.11959.15143848478501964958.malone@wampee.canonical.com>
Subject: [Bug 1865160] Re: Unpredictable behaviour resulting in User process
 faults
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2cdc287481bb8ba45fc6728d34553ed4925ec055
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 08:46:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1865160 <1865160@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recreate with 20.04 LTS (GNU/Linux 5.4.0-26-generic s390x)


May  6 16:14:47 qemu2004 kernel: [86269.521861] User process fault: interru=
ption code 0038 ilc:1 =

May  6 16:14:47 qemu2004 kernel: [86269.521943] Failing address: 6563746de4=
0b6000 TEID: 6563746de40b6800
May  6 16:14:47 qemu2004 kernel: [86269.521961] Fault in primary space mode=
 while using user ASCE.
May  6 16:14:47 qemu2004 kernel: [86269.521994] AS:00000001cc8581c7 R3:0000=
000000000024 =

May  6 16:14:47 qemu2004 kernel: [86269.522113] CPU: 2 PID: 19249 Comm: npm=
 Not tainted 5.4.0-26-generic #30-Ubuntu
May  6 16:14:47 qemu2004 kernel: [86269.522127] Hardware name: QEMU 2964 QE=
MU (KVM/Linux)
May  6 16:14:47 qemu2004 kernel: [86269.522145] User PSW : 0705200180000000=
 6563746de40b6167
May  6 16:14:47 qemu2004 kernel: [86269.522173]            R:0 T:1 IO:1 EX:=
1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:3
May  6 16:14:47 qemu2004 kernel: [86269.522198] User GPRS: 0000000000000000=
 000000edc8ef86a1 6563746de40b6167 0000000000000000
May  6 16:14:47 qemu2004 kernel: [86269.522214]            0000000001cfb968=
 00000004e40b6164 0000000001cfedec 00000004e40b6100
May  6 16:14:47 qemu2004 kernel: [86269.522230]            0000000001cf60b0=
 000003fff32fbfb0 00000004e40b60e9 000003fff32fbee0
May  6 16:14:47 qemu2004 kernel: [86269.522246]            0000000000000004=
 00000004e40b616c 000003ffaeb7c5a4 000003fff32fbe70
May  6 16:14:47 qemu2004 kernel: [86269.522335] User Code: Bad PSW.
May  6 16:14:47 qemu2004 kernel: [86269.522350] Last Breaking-Event-Address:
May  6 16:14:47 qemu2004 kernel: [86269.522380]  [<000000edc8ef8a28>] 0xedc=
8ef8a28


Segmentation fault.] - rollbackFailedOptional: verb npm-session 6b1c0749947=
4304d


** Tags added: npm s390x

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

