Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF5BC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1520217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1520217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hECJa-0007fK-1d
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 08:26:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hECIp-0007Fe-IF
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hECIo-0004Gc-Gt
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:26:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:42198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hECIo-0004FS-8n
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:26:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hECIn-0007dE-2s
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:26:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0275F2E80C9
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:26:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2019 12:08:08 -0000
From: Thomas Huth <1572959@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sylvain-m th-huth
X-Launchpad-Bug-Reporter: Sylvain (sylvain-m)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160421104958.17539.32983.malonedeb@soybean.canonical.com>
Message-Id:
 <155489808867.20511.17680902118216981333.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: fca9516cdb5a70eaf29cd3e16cb1b959cb12d4d1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1572959] Re: bcm2835_property: inconsistent
 values when both setting and querying the framebuffer
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
Reply-To: Bug 1572959 <1572959@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410120808.dEKAb-iZr417srcCHN1pJosiHF7x2ZFSFgefN2nSaGA@z>

The patch had been merged here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D27a5dc7be6a55b60039e3=
920

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1572959

Title:
  bcm2835_property: inconsistent values when both setting and querying
  the framebuffer

Status in QEMU:
  Fix Released

Bug description:
  As the framebuffer settings are copied into the result message before
  it is reconfigured, inconsistent behavior can happen when, for
  instance, you set with a single message the width, height, and depth,
  and ask at the same time to allocate the buffer and get the pitch and
  the size.

  In this case, the reported pitch and size would be incorrect as they
  were computed with the initial values of width, height and depth, not
  the ones the client requested.

  Attached is a patch also sent to the qemu-devel mailing list.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1572959/+subscriptions

