Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05EC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB31020989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB31020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6Ip-0003Lm-0Y
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 04:27:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQ6HO-0002HI-JJ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQ6HM-0003Kq-Ng
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:55946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hQ6HL-0003Iy-M2
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hQ6HI-0006bc-Iz
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D3B92E8024
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 May 2019 08:16:40 -0000
From: Anisse Astier <1828608@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anisse berrange
X-Launchpad-Bug-Reporter: Anisse Astier (anisse)
X-Launchpad-Bug-Modifier: Anisse Astier (anisse)
References: <155750549613.15038.5455007066011551794.malonedeb@wampee.canonical.com>
Message-Id: <155773540027.14554.6407046734054940516.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 6367e874046cd5358dd605b5bfc44cb10c03a670
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1828608] Re: Chardev websocket might not support
 pasting more than a few chars
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
Reply-To: Bug 1828608 <1828608@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I wrote a websocket client to help reproduce the bug without a browser:
https://github.com/anisse/websocktty

You can install it to your $GOPATH/bin (defaults to ~/go/bin) with "go
get github.com/anisse/websocktty"

I can reproduce the bug with it by simply pasting a long-enough (5 to 20
characters) string.

I could not reproduce the bug with qemu's  "-serial tcp" and netcat, so
this problem might indeed be limited to the websock channel
implementation.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1828608

Title:
  Chardev websocket might not support pasting more than a few chars

Status in QEMU:
  New

Bug description:
  When sending more than 4-5 characters on the websocket serial console
  (with pasting for example), the guest might not receive all of them,
  or worse interpret the input as Magic SysRq keys.

  This might be due to the io loop not checking the backend readiness
  before calling the read function.

  Attached patched fixes the problem on my system. I'm not sure it's the
  proper approach, this is just to start discussion.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1828608/+subscriptions

