Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F0C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9BE21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9BE21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoEsl-0003KG-JK
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 18:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hoEsa-0002tx-J2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 18:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hoEsZ-0003UA-Ff
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 18:28:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:44914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hoEsZ-0003Sv-9r
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 18:27:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hoE94-0006YU-JS
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 21:40:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 91DAE2E80C9
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 21:40:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jul 2019 21:32:02 -0000
From: Thomas Moschny <1828723@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee moschny philmd
X-Launchpad-Bug-Reporter: Thomas Moschny (moschny)
X-Launchpad-Bug-Modifier: Thomas Moschny (moschny)
References: <155766144999.15801.8727893741494500797.malonedeb@wampee.canonical.com>
Message-Id: <156348552266.29847.1313567678080261029.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 85f65cb22c493b06ea6e6f8eca781d513dae0c05
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1828723] Re: [RFE] option to suppress gemu_log()
 output
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
Reply-To: Bug 1828723 <1828723@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Indeed I think gemu_log() is the problem here.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1828723

Title:
  [RFE] option to suppress gemu_log() output

Status in QEMU:
  New

Bug description:
  With user mode emulation, messages from genu_log() are emitted
  unconditionally to stderr. I didn't find a way to suppress them. It
  would be nice to have options similar to the -D/-d options to be able
  to filter and/or redirect the output.

  My use case is chroot/container execution for different architectures
  via binfmt. In this case it will appear as if the binary in question
  had emitted messages like "Unsupported setsockopt ..." to stderr while
  in fact the message came from qemu-*-static.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1828723/+subscriptions

