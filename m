Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FCC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0909420675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0909420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60707 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNiTB-0002jG-C7
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:36:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNiOd-0008Pr-85
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNiOc-0001fA-AD
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:31:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:58304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hNiOc-0001eS-4t
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:31:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hNiOa-0008Rr-7C
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 18:31:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 330182E80C9
	for <qemu-devel@nongnu.org>; Mon,  6 May 2019 18:31:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 May 2019 18:25:04 -0000
From: Floyd42 <1826568@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: axelheider kbastian
X-Launchpad-Bug-Reporter: Floyd42 (axelheider)
X-Launchpad-Bug-Modifier: Floyd42 (axelheider)
References: <155629222212.6615.9281610848583512798.malonedeb@chaenomeles.canonical.com>
Message-Id: <155716710425.31951.4690419366654957439.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18953";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b35463d28cce196e7858b81793527a4a05e8d82f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1826568] Re: RISC-V Disassembler/translator
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

Sorry, I don't have the test code, since this was created by a memory
corruption. However, the way I understand the message is, that there is
some internal disagreement how to decode the op-code "051300009517e2bf"
- which mige be an invalid opcode anyway. So a simple test application
would just consist of this opcode.

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

