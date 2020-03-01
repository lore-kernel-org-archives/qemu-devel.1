Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BCC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 15:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFCA21D56
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 15:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFCA21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8Q62-0002z8-9j
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 10:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j8Q5K-0002Ww-0o
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 10:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j8Q5I-0007mg-MX
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 10:00:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:34794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j8Q5I-0007ls-Fk
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 10:00:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j8Q5H-0004Hf-0m
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 15:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F04D42E80C0
 for <qemu-devel@nongnu.org>; Sun,  1 Mar 2020 15:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Mar 2020 14:54:47 -0000
From: f1outsourcing <1865348@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: f1outsourcing
X-Launchpad-Bug-Reporter: f1outsourcing (f1outsourcing)
X-Launchpad-Bug-Modifier: f1outsourcing (f1outsourcing)
Message-Id: <158307448781.11876.11413888488198775469.malonedeb@soybean.canonical.com>
Subject: [Bug 1865348] [NEW] virsh domfsinfo testdom crashes the guest agent
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 00dfb83e699aa531dd65329d054a9c25c46d6728
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
Reply-To: Bug 1865348 <1865348@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:


[@ ~]# virsh qemu-agent-command vps-01 '{"execute":"guest-get-fsinfo"}'


error: Guest agent is not responding: Guest agent disappeared while executi=
ng command

[@ ~]# virsh domfsinfo vps-01
error: Unable to get filesystem information
error: Guest agent is not responding: Guest agent disappeared while executi=
ng command


Fault bucket , type 0
Event Name: APPCRASH
Response: Not available
Cab Id: 0

Problem signature:
P1: qemu-ga.exe
P2: 100.0.0.0
P3: 5c473543
P4: KERNELBASE.dll
P5: 6.1.7601.24545
P6: 5e0eb6bd
P7: c0000005
P8: 000000000000c4d2
P9: =

P10: =


Attached files:

These files may be available here:
C:\ProgramData\Microsoft\Windows\WER\ReportQueue\AppCrash_qemu-ga.exe_bd2e6=
535bdb93328680e0285e89e08f2866db83_49df29e2

Analysis symbol: =

Rechecking for solution: 0
Report Id: 2ad29522-5bcc-11ea-bca6-525400e83365
Report Status: 0


guest os: windows server std 2008r2

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1865348

Title:
  virsh domfsinfo testdom crashes the guest agent

Status in QEMU:
  New

Bug description:

  [@ ~]# virsh qemu-agent-command vps-01 '{"execute":"guest-get-
  fsinfo"}'

  =

  error: Guest agent is not responding: Guest agent disappeared while execu=
ting command

  [@ ~]# virsh domfsinfo vps-01
  error: Unable to get filesystem information
  error: Guest agent is not responding: Guest agent disappeared while execu=
ting command

  =

  Fault bucket , type 0
  Event Name: APPCRASH
  Response: Not available
  Cab Id: 0

  Problem signature:
  P1: qemu-ga.exe
  P2: 100.0.0.0
  P3: 5c473543
  P4: KERNELBASE.dll
  P5: 6.1.7601.24545
  P6: 5e0eb6bd
  P7: c0000005
  P8: 000000000000c4d2
  P9: =

  P10: =


  Attached files:

  These files may be available here:
  C:\ProgramData\Microsoft\Windows\WER\ReportQueue\AppCrash_qemu-ga.exe_bd2=
e6535bdb93328680e0285e89e08f2866db83_49df29e2

  Analysis symbol: =

  Rechecking for solution: 0
  Report Id: 2ad29522-5bcc-11ea-bca6-525400e83365
  Report Status: 0

  =

  guest os: windows server std 2008r2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1865348/+subscriptions

