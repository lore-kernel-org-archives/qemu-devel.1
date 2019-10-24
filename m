Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07246CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03232166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03232166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cendio.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeMq-0004NS-Lk
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iNaOJ-0008DS-2y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iNaOH-0007c1-M5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:30:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:37530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iNaOH-0007be-DD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:30:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iNaOF-00028R-G8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 70A3B2E80C0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Oct 2019 10:23:06 -0000
From: Samuel <samuel@cendio.se>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: samuel-t
X-Launchpad-Bug-Reporter: Samuel (samuel-t)
X-Launchpad-Bug-Modifier: Samuel (samuel-t)
Message-Id: <157191258679.29920.9268940625941119092.malonedeb@soybean.canonical.com>
Subject: [Bug 1849644] [NEW] QEMU VNC websocket proxy requires non-standard
 'binary' subprotocol
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 172e9ee982931c2985dcd72d3813d9d80f059b59
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Thu, 24 Oct 2019 10:19:31 -0400
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
Reply-To: Bug 1849644 <1849644@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When running a machine using "-vnc" and the "websocket" option QEMU
seems to require the subprotocol called 'binary'. This subprotocol does
not exist in the WebSocket specification. In fact it has never existed
in the spec, in one of the very early drafts of WebSockets it was
briefly mentioned but it never made it to a final version.

When the WebSocket server requires a non-standard subprotocol any
WebSocket client that works correctly won't be able to connect.

One example of such a client is noVNC, it tells the server that it
doesn't want to use any subprotocol. QEMU's WebSocket proxy doesn't let
noVNC connect. If noVNC is modified to ask for 'binary' it will work,
this is, however, incorrect behavior.

Looking at the code in "io/channel-websock.c" it seems it's quite hard-
coded to binary:

Look at line 58 and 433 here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dio/channel-websock.c

This code has to be made more dynamic, and shouldn't require binary.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1849644

Title:
  QEMU VNC websocket proxy requires non-standard 'binary' subprotocol

Status in QEMU:
  New

Bug description:
  When running a machine using "-vnc" and the "websocket" option QEMU
  seems to require the subprotocol called 'binary'. This subprotocol
  does not exist in the WebSocket specification. In fact it has never
  existed in the spec, in one of the very early drafts of WebSockets it
  was briefly mentioned but it never made it to a final version.

  When the WebSocket server requires a non-standard subprotocol any
  WebSocket client that works correctly won't be able to connect.

  One example of such a client is noVNC, it tells the server that it
  doesn't want to use any subprotocol. QEMU's WebSocket proxy doesn't
  let noVNC connect. If noVNC is modified to ask for 'binary' it will
  work, this is, however, incorrect behavior.

  Looking at the code in "io/channel-websock.c" it seems it's quite
  hard-coded to binary:

  Look at line 58 and 433 here:
  https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dio/channel-websock.c

  This code has to be made more dynamic, and shouldn't require binary.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1849644/+subscriptions

