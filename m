Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD71DC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C3D2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C3D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUTq-0004Xj-R6
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUQv-0000fI-MG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUQu-00056J-6v
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:05:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:52778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUQu-00055S-00
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:05:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUQs-0003Zf-UA
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:05:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D1D942E80C7
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:05:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 04:59:52 -0000
From: Thomas Huth <1817345@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: deepi mjt+launchpad-tls ospite pmaydell th-huth
X-Launchpad-Bug-Reporter: Antonio Ospite (ospite)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155085278488.30597.14551761138419562879.malonedeb@chaenomeles.canonical.com>
Message-Id: <156593159210.16299.14675862099162948506.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d0080326823231111ca9f0e93401c4488d7769d0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1817345] Re: configure script breaks when
 $source_path contains white spaces
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
Reply-To: Bug 1817345 <1817345@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D4ace32e22713ffd79deb22

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817345

Title:
  configure script breaks when $source_path contains white spaces

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  I noticed that the configure script breaks when the qemu source
  directory is in a path containing white spaces, in particular the list
  of targets is not correctly generated when calling "./configure
  --help".

  Steps to reproduce the problem:

  $ mkdir "dir with spaces"
  $ cd dir\ with\ spaces/
  $ git clone https://git.qemu.org/git/qemu.git
  $ cd qemu/
  $ ./configure --help | grep -A3 target-list

  =

  Actual result:

    --target-list=3DLIST       set target list (default: build everything)
                             Available targets: dir with *-softmmu dir with =

                             *-linux-user

  =

  Expected result:

    --target-list=3DLIST       set target list (default: build everything)
                             Available targets: aarch64-softmmu alpha-softm=
mu =

                             arm-softmmu cris-softmmu hppa-softmmu i386-sof=
tmmu =

                             lm32-softmmu m68k-softmmu microblaze-softmmu =


  =

  This happens because the $mak_wilds variable uses spaces to separate diff=
erent paths, maybe newlines may be used, which are less likely to be in dir=
ectory names.

  BTW "shellcheck" may help finding some other problems.

  Qemu version:

  $ git describe =

  v3.1.0-1960-ga05838cb2a

  Thanks,
     Antonio

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817345/+subscriptions

