Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18988C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECBA20644
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECBA20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htavz-0000Jr-4i
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 13:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htavU-0008Kg-HV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htavT-0007jC-B3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:01:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:33982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htavT-0007j0-64
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:01:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htavR-0000kO-0e
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 17:01:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E3EE22E80DD
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 17:01:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2019 16:52:12 -0000
From: Daniel Berrange <1838658@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange gson prlw1
X-Launchpad-Bug-Reporter: Patrick Welche (prlw1)
X-Launchpad-Bug-Modifier: Daniel Berrange (berrange)
References: <156467368424.6955.5535032657029646608.malonedeb@soybean.canonical.com>
Message-Id: <156476473271.24999.5249917154230498661.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 39b50b77c933482510d09976e045983730e26626
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838658] Re: qemu 4.0.0 broken by glib update
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
Reply-To: Bug 1838658 <1838658@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doh,  sorry for my comment earlier where I mistakenly used sparc instead
of sparc64.

I've now tested QEMU git master with that sparc64 ISO and qemu-system-
sparc64.

I still can't reproduce it though - it boots past the disk probing, and
into the installer, where it asks for the terminal type.

So looks like there's some further variable involved beyond just the
glib update - perhaps something about the host OS is combining with the
glib update to trigger it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838658

Title:
  qemu 4.0.0 broken by glib update

Status in QEMU:
  New

Bug description:
  In brief, an install CD will successfully boot with qemu 4.0.0 built with=
 glib 2.58.3, but freeze during boot with qemu 4.0.0 built with glib 2.60.0=
. I tracked it down to glib's GHashTable improvements. qemu is happy with a=
 glib built from
  ```
   git checkout -f 2.60.4
   git revert --no-edit 86c6f7e2b..3bed8a13b
   git revert --no-edit 75f8ec1df9b48b0c3a13a9125f2c7d7c5adf5159
   git revert --no-edit 603fb5958..d3074a748
   git revert --no-edit 0b45ddc55..0600dd322
  ```
  When the GHashTable improvements were committed, there was already a pree=
mptive note about any breakage being due to using private implementation de=
tails, hence mentioning it here rather than with glib.

  For the full saga, see: http://gnats.netbsd.org/54310

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838658/+subscriptions

