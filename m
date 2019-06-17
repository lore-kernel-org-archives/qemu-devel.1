Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB15C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB6B206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB6B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwpL-0002SB-LX
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hcwFR-0001S0-Fu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hcwFO-0004Oy-TO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:20:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:42388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hcwFL-0004LG-IR
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:20:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hcwFG-0000KX-Ba
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 555982E8076
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Jun 2019 18:15:03 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Tags: testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rth
X-Launchpad-Bug-Reporter: Richard Henderson (rth)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156055034616.22882.34472617820287855.malonedeb@soybean.canonical.com>
Message-Id: <156079530431.22508.3554080548193875900.launchpad@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18981";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 69a6a905956cc9b8c4e9de6e1db70515449287d1
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

** Tags added: testcase

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

