Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA88C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B588920721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B588920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyY3k-0006bp-TS
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iyY35-00065n-BH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iyY34-0005wy-9s
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:29:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:44068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iyY34-0005w2-3r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:29:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iyY32-0004HC-JC
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 09:29:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8C45A2E80C3
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 09:29:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Feb 2020 09:17:17 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=debian; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Unknown; assignee=None; 
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: akanouras laurent-vivier pmaydell ross rth
 sebastian-4
X-Launchpad-Bug-Reporter: Sebastian Macke (sebastian-4)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <20131028231528.17025.5795.malonedeb@chaenomeles.canonical.com>
Message-Id: <158072143774.18982.9247639324642037332.malone@gac.canonical.com>
Subject: [Bug 1245703] Re: LD_PREFIX option reads directories recursively in
 an endless loop
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 08e6a9854ee957dd063c86968ca92243c80570ed
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
Reply-To: Bug 1245703 <1245703@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed by in 4.1.0 by:

f3a8bdc1d5b2 ("util/path: Do not cache all filenames at startup")


** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1245703

Title:
  LD_PREFIX option reads directories recursively in an endless loop

Status in QEMU:
  Fix Released
Status in qemu package in Debian:
  Fix Released

Bug description:
  If I run qemu user emulation with -L /path/to/my/sysroot/ in which
  also the proc and dev filesystem is mounted QEMU eats my memory until
  it gets killed by the kernel.

  According to the strace output it follows the symbolic links in the
  proc filesystem running forever in a recursive loop.

  The easiest solution would be to add in the function "add_dir_maybe"
  in the file util/path.c an additional check for symbolic links that it
  don't follow them.

  Also I don't really understand the need of doing this. A lot of
  ressources are wasted everytime QEMU-user is started just by having
  the directory structure in memory. In my case this are more than 20000
  entries which QEMU is loading every time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1245703/+subscriptions

