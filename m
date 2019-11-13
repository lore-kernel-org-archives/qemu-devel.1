Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A48C17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E705920818
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E705920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUpEb-0001rW-5O
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iUpDv-0001Qy-HZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iUpDu-00011g-6G
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:46:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:43872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iUpDu-00010t-0y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:46:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iUpDq-0001KQ-VY
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 09:45:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 96C8F2E80DF
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 09:45:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Nov 2019 09:34:49 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Wishlist;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: amitshah dkg0 laurent-vivier th-huth
X-Launchpad-Bug-Reporter: dkg (dkg0)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <154753485996.31938.10842883255904010357.malonedeb@wampee.canonical.com>
Message-Id: <157363769017.21696.8697806904316907402.malone@soybean.canonical.com>
Subject: [Bug 1811758] Re: virtio-rng backend should use getentropy() syscall
 when available
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 366627a9b22452fb6cb809d2083253e0810b9d44
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1811758 <1811758@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

rng-builtin is the new RNG default backend for virtio-rng and is based
on getrandom().

0198c2621a1e virtio-rng: change default backend to rng-builtin
5f7655f6ef15 virtio-rng: Keep the default backend out of VirtIORNGConf
6c4e9d487fea rng-builtin: add an RNG backend that uses qemu_guest_getrandom=
()

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811758

Title:
  virtio-rng backend should use getentropy() syscall when available

Status in QEMU:
  Fix Committed

Bug description:
  According to https://wiki.qemu.org/Features/VirtIORNG the default
  backend for `virtio-rng-pci` is `/dev/random`.  Alternately, the user
  can point it to a different backend file, like `/dev/urandom`.

  However, both of these files have suboptimal behavior in one way or
  another, as documented in `random(7)`.  Instead, the default behavior
  should be to pull the requested octets from the `getrandom()` system
  call, if available, called with no flags set.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811758/+subscriptions

