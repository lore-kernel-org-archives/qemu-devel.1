Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39718C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E914206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E914206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkOMJ-0006NK-Bw
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jkOLj-0005wA-Cx
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:50:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:57014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jkOLh-00040c-3z
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:50:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jkOLf-0005ha-Gb
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 08:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7188D2E810B
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 08:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2020 08:45:34 -0000
From: Uri Simchoni <1883414@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: urisimchoni
X-Launchpad-Bug-Reporter: Uri Simchoni (urisimchoni)
X-Launchpad-Bug-Modifier: Uri Simchoni (urisimchoni)
Message-Id: <159212433474.11524.6446671863571065618.malonedeb@soybean.canonical.com>
Subject: [Bug 1883414] [NEW] Cannot build qemu-5.0.0 from tarball
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 30f3aa252e1fc6d2f6836191e9a9742152ef0eee
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 03:10:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1883414 <1883414@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Cannot build qemu 5.0.0 from the release tarball. Building from git-
clone succeeds.

After downloading and unpacking the 5.0.0 tarball, I typed the
following:

mkdir build
cd build
../configure

Then got the following error message:

ERROR: missing file /home/uri/qemu-5.0.0/ui/keycodemapdb/README

This is not a GIT checkout but module content appears to
be missing. Do not use 'git archive' or GitHub download links
to acquire QEMU source archives. Non-GIT builds are only
supported with source archives linked from:

  https://www.qemu.org/download/#source

Developers working with GIT can use scripts/archive-source.sh
if they need to create valid source archives.

It appears the ui/keycodemapdb is missing some files that are obtained
from a git submodule in a git tree.

Building from a git clone succeeds.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883414

Title:
  Cannot build qemu-5.0.0 from tarball

Status in QEMU:
  New

Bug description:
  Cannot build qemu 5.0.0 from the release tarball. Building from git-
  clone succeeds.

  After downloading and unpacking the 5.0.0 tarball, I typed the
  following:

  mkdir build
  cd build
  ../configure

  Then got the following error message:

  ERROR: missing file /home/uri/qemu-5.0.0/ui/keycodemapdb/README

  This is not a GIT checkout but module content appears to
  be missing. Do not use 'git archive' or GitHub download links
  to acquire QEMU source archives. Non-GIT builds are only
  supported with source archives linked from:

    https://www.qemu.org/download/#source

  Developers working with GIT can use scripts/archive-source.sh
  if they need to create valid source archives.

  It appears the ui/keycodemapdb is missing some files that are obtained
  from a git submodule in a git tree.

  Building from a git clone succeeds.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883414/+subscriptions

