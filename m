Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8568C606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE7A20861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE7A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkSsG-0004Br-07
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hkRT2-0001jw-BO
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hkRSx-0001hd-VY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:05:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:53822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hkRSu-0001YY-Sq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:05:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hkRSn-0008Cd-Vl
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 11:05:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E7DEE2E8055
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 11:05:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jul 2019 10:58:15 -0000
From: Tristan Van Berkom <tristan.vanberkom@codethink.co.uk>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: gtk ui
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: tristan-vanberkom
X-Launchpad-Bug-Reporter: Tristan Van Berkom (tristan-vanberkom)
X-Launchpad-Bug-Modifier: Tristan Van Berkom (tristan-vanberkom)
Message-Id: <156258349508.21433.10621774615794067692.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ab71ca80d6c7d2d953e5484c371055f12fab14fd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 08 Jul 2019 08:32:36 -0400
Subject: [Qemu-devel] [Bug 1835732] [NEW] GTK display zoom in,
 zooms infinitely
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
Reply-To: Bug 1835732 <1835732@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The zoom in feature in the "View" menu of the gtk frontend (launch qemu
with -display gtk), seems to be very broken.

If I hit the zoom in feature, it first zooms in.

Then, it zooms in again.

Every subsequent second that passes, it zooms in again, until it
eventually eats up too much host resources and freezes the host desktop.

I have seen this with 3.1.0 (Debian 1:3.1+dfsg-8~deb10u1), and also with
a locally built 4.0, My colleague also confirms having seen the issue
with 3.1.0 (Debian 1:3.1+dfsg-8).

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: gtk ui

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835732

Title:
  GTK display zoom in, zooms infinitely

Status in QEMU:
  New

Bug description:
  The zoom in feature in the "View" menu of the gtk frontend (launch
  qemu with -display gtk), seems to be very broken.

  If I hit the zoom in feature, it first zooms in.

  Then, it zooms in again.

  Every subsequent second that passes, it zooms in again, until it
  eventually eats up too much host resources and freezes the host
  desktop.

  I have seen this with 3.1.0 (Debian 1:3.1+dfsg-8~deb10u1), and also
  with a locally built 4.0, My colleague also confirms having seen the
  issue with 3.1.0 (Debian 1:3.1+dfsg-8).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835732/+subscriptions

