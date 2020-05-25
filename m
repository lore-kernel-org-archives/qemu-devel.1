Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BDCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 19:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B55206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 19:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B55206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdIVN-0003tC-LT
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 15:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdIUq-0003S5-4p
 for qemu-devel@nongnu.org; Mon, 25 May 2020 15:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:51296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdIUp-0002TW-0N
 for qemu-devel@nongnu.org; Mon, 25 May 2020 15:10:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jdIUm-00021H-DA
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 19:10:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 54B1A2E8078
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 19:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2020 19:04:06 -0000
From: Aleksandar Markovic <1877706@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aleksandar-markovic wish-star
X-Launchpad-Bug-Reporter: Lu Haocong (wish-star)
X-Launchpad-Bug-Modifier: Aleksandar Markovic (aleksandar-markovic)
References: <158899708918.5208.6641592290214669384.malonedeb@soybean.canonical.com>
Message-Id: <159043344677.19637.16255562430838755194.malone@soybean.canonical.com>
Subject: [Bug 1877706] Re: [Feature request] qemu does not support for Octeon
 MIPS64 on X86
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 95a851fe27a97cd1d804c3d6cafa3c1550d010f5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 15:10:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1877706 <1877706@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Lu.

Where can I download Octeon toolchain you used?

I want to try it by myself.

Aleksandar

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877706

Title:
   [Feature request] qemu does not support for Octeon MIPS64 on X86

Status in QEMU:
  New

Bug description:
  Description of problem:

  I use mips64-octeon-linux-gnu-gcc cross toolchain on X86,and generate
  binary file.

  > mips64-octeon-linux-gnu-gcc hello.c -static
  > file a.out
  > a.out: ELF 32-bit MSB executable, MIPS, N32 MIPS64 rel2 version 1 (SYSV=
), statically linked, for GNU/Linux 2.4.0, not stripped

  I execute it with mips64-linux-user mode in qemu, it is invalid.

  > ./qemu-5.0.0/mips64-linux-user/qemu-mips64 a.out
  > a.out: Invalid ELF image for this architecture

  when I choose mips-linux-user mode, it regards as illegal instruction.

  > ./qemu-5.0.0/mips-linux-user/qemu-mips a.out
  > qemu: uncaught target signal 4 (Illegal instruction) - core dumped
  > Illegal instruction (core dumped)

  I would like to know, is this due to my problem or does qemu not
  support Octeon MIPS64 on X86?

  if qemu has supported Octeon MIPS64 on X86, how can I emulate it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877706/+subscriptions

