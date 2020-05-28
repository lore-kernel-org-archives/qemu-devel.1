Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72FB207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72FB207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeCYM-0002qa-6X
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 03:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeCXI-0001sS-Gz
 for qemu-devel@nongnu.org; Thu, 28 May 2020 03:01:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:45848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeCXH-0006v0-Al
 for qemu-devel@nongnu.org; Thu, 28 May 2020 03:01:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jeCXF-0007Oe-0F
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 07:01:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E12DD2E810B
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 07:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2020 06:52:47 -0000
From: Thomas Huth <1877706@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aleksandar-markovic wish-star
X-Launchpad-Bug-Reporter: Lu Haocong (wish-star)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158899708918.5208.6641592290214669384.malonedeb@soybean.canonical.com>
Message-Id: <159064876797.14155.1467677292871353265.launchpad@gac.canonical.com>
Subject: [Bug 1877706] Re: [Feature request] qemu does not support for Octeon
 MIPS64 on X86
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e71d82a9b234527fb1b64f51ef060eac067ebbdb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:45:41
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

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

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

