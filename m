Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336CAC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73664206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73664206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN9iM-00058x-Dw
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kN9hk-0004jC-8u
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:05:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:50804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kN9hi-0007lw-8v
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:05:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kN9hg-0005IL-EY
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6ABF02E804E
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2020 06:57:34 -0000
From: Changho Choi <1897680@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: zpzigi
X-Launchpad-Bug-Reporter: Changho Choi (zpzigi)
X-Launchpad-Bug-Modifier: Changho Choi (zpzigi)
Message-Id: <160136265426.22784.9778102281742505477.malonedeb@gac.canonical.com>
Subject: [Bug 1897680] [NEW] memory address over 0x2000_7ffc is not accessible
 in mps2-an505
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d685c0a40836eb9844ed835c9700f20633c1d7af"; Instance="production"
X-Launchpad-Hash: e26863213e87ce432c7862c8e281103029f2b72e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 03:05:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.199, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1897680 <1897680@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I currently run qemu with the following options
`qemu-system-aarch64 -machine mps2-an505 -cpu cortex-m33 -m 16`

For some reason, memory address over 0x2000_7ffc is not accessible.
It can be tested in gdb as follow.

(gdb) x/x 0x20007ffc
0x20007ffc:	0x00000000
(gdb) x/x 0x20007ffd
0x20007ffd:	Cannot access memory at address 0x20007ffd
(gdb) x/x 0x20008000
0x20008000:	Cannot access memory at address 0x20008000

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1897680

Title:
  memory address over 0x2000_7ffc is not accessible in mps2-an505

Status in QEMU:
  New

Bug description:
  I currently run qemu with the following options
  `qemu-system-aarch64 -machine mps2-an505 -cpu cortex-m33 -m 16`

  For some reason, memory address over 0x2000_7ffc is not accessible.
  It can be tested in gdb as follow.

  (gdb) x/x 0x20007ffc
  0x20007ffc:	0x00000000
  (gdb) x/x 0x20007ffd
  0x20007ffd:	Cannot access memory at address 0x20007ffd
  (gdb) x/x 0x20008000
  0x20008000:	Cannot access memory at address 0x20008000

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1897680/+subscriptions

