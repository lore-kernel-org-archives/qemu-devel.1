Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03095C32755
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D059A20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D059A20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNpM-0006qd-MO
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCNo4-0005o9-Q1
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCNo3-0000Fa-OC
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:51:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:60698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCNo3-0000EZ-J4
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:51:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCNny-0004w5-IM
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 12:51:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 51F0F2E820C
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 12:50:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Sep 2019 12:38:41 -0000
From: Frank Heimes <1842916@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=ubuntu-z-systems; status=Triaged; importance=High;
 assignee=frank.heimes@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux; component=main;
 status=New; importance=Undecided; assignee=skipper-screen-team; 
X-Launchpad-Bug-Tags: architecture-s39064 bugnameltc-181316 severity-high
 targetmilestone-inin1804
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugproxy frank-heimes
X-Launchpad-Bug-Reporter: bugproxy (bugproxy)
X-Launchpad-Bug-Modifier: Frank Heimes (frank-heimes)
X-Launchpad-Bug-Duplicate: 1842774
References: <156768308911.708.6152721761425216653.malonedeb@wampee.canonical.com>
Message-Id: <156924232205.27427.14157217670358330923.launchpad@soybean.canonical.com>
Subject: [Bug 1842916] Re: [18.04 FEAT] Enhanced Hardware Support - Finalize
 Naming
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5f0951511b6be75ed98f1f208c493d297cbb64a8
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
Reply-To: Bug 1842916 <1842916@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1842774 ***
    https://bugs.launchpad.net/bugs/1842774

** Information type changed from Private to Public

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1842916

Title:
  [18.04 FEAT] Enhanced Hardware Support - Finalize Naming

Status in QEMU:
  Incomplete
Status in Ubuntu on IBM z Systems:
  Triaged
Status in linux package in Ubuntu:
  New

Bug description:
  This feature request will provide the final naming of the next machine

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1842916/+subscriptions

