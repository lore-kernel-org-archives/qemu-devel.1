Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92489C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 18:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B53E20820
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 18:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B53E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcZUP-0007H6-Bl
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 14:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hcZSc-00069c-5H
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hcZSb-0003SW-1g
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:00:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:48194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hcZSa-0003O6-SV
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:00:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hcZSW-0000je-Qg
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 18:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A92522E80C9
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 18:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Jun 2019 17:53:05 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rth
X-Launchpad-Bug-Reporter: Richard Henderson (rth)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <156055034616.22882.34472617820287855.malonedeb@soybean.canonical.com>
Message-Id: <156070758538.2098.11276740927873889610.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b38de714100d6f7b9fb31432f8cbc6d3b4d0b65e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1832916] Re: linux-user does not check PROT_EXEC
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
Reply-To: Bug 1832916 <1832916@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It turns out we can't fix this without also fixing
our implementation of signal trampolines.

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832916

Title:
  linux-user does not check PROT_EXEC

Status in QEMU:
  Confirmed

Bug description:
  At no point do we actually verify that a page is PROT_EXEC before
  translating.  All we end up verifying is that the page is readable.
  Not the same thing, obviously.

  The following test case should work for any architecture, though I've
  only validated it for x86_64 and aarch64.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1832916/+subscriptions

