Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB6C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA874217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA874217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTLyc-0007w7-OU
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 03:47:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTLxc-0007ZJ-NO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTLxb-0000Y2-IG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:46:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:57046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hTLxb-0000WZ-CI
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:46:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hTLxZ-0001x7-Un
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 07:46:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E00BB2E80C0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 07:46:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2019 07:27:50 -0000
From: Thomas Huth <599958@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Wishlist;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 8-roothorick-gmail-com andcycle-launchpad-net
	anthony-codemonkey lmr th-huth
X-Launchpad-Bug-Reporter: Lucas Meneghel Rodrigues (lmr)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20100629211802.16137.10587.malonedeb@soybean.canonical.com>
Message-Id: <155851007014.15345.5491380337471675746.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: a8e2b9d761fe31544304cea6cc81a794ece17cdf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 599958] Re: Timedrift problems with Win7: hpet
 missing time drift fixups
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
Reply-To: Bug 599958 <599958@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking through old bug tickets... can this issue still be reproduced
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/599958

Title:
  Timedrift problems with Win7: hpet missing time drift fixups

Status in QEMU:
  Incomplete

Bug description:
  We've been finding timedrift issues witth Win7 under qemu-kvm on our
  daily testing

  kvm.qemu-kvm-git.smp2.Win7.64.timedrift.with_load	FAIL	1	Time drift too l=
arge after rest period: 38.63%
  kvm.qemu-kvm-git.smp2.Win7.64.timedrift.with_reboot	FAIL	1	Time drift too=
 large at iteration 1: 17.77 seconds
  kvm.qemu-kvm-git.smp2.Win7.64.timedrift.with_migration	FAIL	1	Time drift =
too large at iteration 2: 3.08 seconds

  Steps to reproduce:

  timedrift.with_load

  1) Log into a guest.
  2) Take a time reading from the guest and host.
  3) Run load on the guest and host.
  4) Take a second time reading.
  5) Stop the load and rest for a while.
  6) Take a third time reading.
  7) If the drift immediately after load is higher than a user-
      specified value (in %), fail.
      If the drift after the rest period is higher than a user-specified va=
lue,
      fail.

  timedrift.with_migration

  1) Log into a guest.
  2) Take a time reading from the guest and host.
  3) Migrate the guest.
  4) Take a second time reading.
  5) If the drift (in seconds) is higher than a user specified value, fail.

  timedrift.with_reboot

  1) Log into a guest.
  2) Take a time reading from the guest and host.
  3) Reboot the guest.
  4) Take a second time reading.
  5) If the drift (in seconds) is higher than a user specified value, fail.

  This bug is to register those issues and keep an eye on them.

  Attached, some logs from the autotest tests executed on the guest

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/599958/+subscriptions

