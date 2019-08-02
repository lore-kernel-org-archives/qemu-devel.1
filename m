Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8008DC32753
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9CA20880
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9CA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htbxK-0007Vf-Mf
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htbry-0005SC-IN
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htbrw-00051X-OI
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:55790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htbrw-0004IW-ED
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:01:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htbrX-0001iB-J3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 18:01:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8E8E02E80CB
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 18:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2019 17:46:23 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: deepi mjt+launchpad-tls ospite pmaydell
X-Launchpad-Bug-Reporter: Antonio Ospite (ospite)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155085278488.30597.14551761138419562879.malonedeb@chaenomeles.canonical.com>
Message-Id: <156476798391.27618.703557350455095524.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 74e4b7b42be3977ee109886400d91d1de41ad851
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

Antonio's patches are in git and will be in the upcoming 4.1.0 release.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817345

Title:
  configure script breaks when $source_path contains white spaces

Status in QEMU:
  Fix Committed

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

