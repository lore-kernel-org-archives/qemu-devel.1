Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D150C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 15:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AF82084F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 15:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AF82084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK2u5-0006Wq-2v
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 11:36:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hK2t9-00065p-3Z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hK2t8-0004eN-2s
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:35:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:37988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hK2t7-0004c7-TT
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:35:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hK2t4-0004h2-An
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 15:35:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D951F2E81B0
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 15:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2019 15:23:42 -0000
From: Floyd42 <1826568@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: axelheider
X-Launchpad-Bug-Reporter: Floyd42 (axelheider)
X-Launchpad-Bug-Modifier: Floyd42 (axelheider)
Message-Id:
 <155629222212.6615.9281610848583512798.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ecd28b05ed82f21454acba05883c76ce1672e42e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1826568] [NEW] RISC-V Disassembler/translator
 instruction decoding disagreement
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
Reply-To: Bug 1826568 <1826568@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426152342.Euy1KKnMLIEZMq4xnSYrYsOUca76jXOfhVNwWTi1Tk4@z>

Public bug reported:


When running QEMU V3.1.0 for platform  RISC-V, 64bit, Spike V1.10 with "-d =
in_asm -singlestep -D qemu_log.txt", my (faulty) test code brought up this =
message in the logs:

  0x000000008002cade:  051300009517e2bf  illegal         =

  Disassembler disagrees with translator over instruction decoding
  Please report this to qemu-devel@nongnu.org


You may want to resolve the disagreement.

Axel

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826568

Title:
  RISC-V Disassembler/translator instruction decoding disagreement

Status in QEMU:
  New

Bug description:
  =

  When running QEMU V3.1.0 for platform  RISC-V, 64bit, Spike V1.10 with "-=
d in_asm -singlestep -D qemu_log.txt", my (faulty) test code brought up thi=
s message in the logs:

    0x000000008002cade:  051300009517e2bf  illegal         =

    Disassembler disagrees with translator over instruction decoding
    Please report this to qemu-devel@nongnu.org

  =

  You may want to resolve the disagreement.

  Axel

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826568/+subscriptions

