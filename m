Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11122C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71D4206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71D4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMc6s-0005Rs-5T
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:36:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hMc63-00041f-Hd
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hMc5w-0004En-SJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:35:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:49648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hMc5u-0004Cv-5Y
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:35:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hMc5s-00019Q-Iv
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 17:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E4E72E80CB
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 17:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 May 2019 17:26:30 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: deepi mjt+launchpad-tls ospite pmaydell
X-Launchpad-Bug-Reporter: Antonio Ospite (ospite)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155085278488.30597.14551761138419562879.malonedeb@chaenomeles.canonical.com>
Message-Id:
 <155690439068.32165.1664289279704715772.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18953";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: f8b9e5b7527cdf4d373eb6b82bd6623e2d8aec37
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1817345] Re: configure script breaks when
 $source_path contains white spaces
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
Reply-To: Bug 1817345 <1817345@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503172630.NR4z32jHrntRSdCEIH1DPBXmCUzmoChIm4KznBom3AE@z>

Antonio has submitted a patchset here:
https://patchew.org/QEMU/20190503082728.16485-1-ao2@ao2.it/


** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817345

Title:
  configure script breaks when $source_path contains white spaces

Status in QEMU:
  In Progress

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

