Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B99C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AE921D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AE921D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLh7t-0007rg-8t
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kLh6Q-00070w-1Z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:21:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:34730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kLh6N-0004Jm-S1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:21:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kLh6K-0004vM-Ba
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:21:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 53E192E80DB
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:21:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2020 06:07:46 -0000
From: Launchpad Bug Tracker <1849644@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=focal; sourcepackage=qemu; 
 component=main; status=In Progress; importance=Low;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange laurent-vivier npes87184 paelzer samuel-t
X-Launchpad-Bug-Reporter: Samuel (samuel-t)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <157191258679.29920.9268940625941119092.malonedeb@soybean.canonical.com>
Message-Id: <160101406860.2048.16326445419879746217.launchpad@ackee.canonical.com>
Subject: [Bug 1849644] Re: QEMU VNC websocket proxy requires non-standard
 'binary' subprotocol
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: 8f866b2a46ca67200e94db35acd325f6a1ace0f0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:55:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

** Merge proposal linked:
   https://code.launchpad.net/~paelzer/ubuntu/+source/qemu/+git/qemu/+merge=
/391348

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1849644

Title:
  QEMU VNC websocket proxy requires non-standard 'binary' subprotocol

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Focal:
  In Progress

Bug description:
  [Impact]

   * The exact details of the protocol/subprotocal was slightly unclear
     between the projects. So qemu ended up insisting on "binary" being
     used but newer noVNC clients no more used it.

   * Qemu got fixed in 5.0 to be more tolerant and accept an empty sub-
     protocol as well. This SRU backports that fix to Focal.

  [Test Case]

   * Without the fix the following will "Failed to connect", but with
  the fix it will work.

  $ sudo apt install qemu-system-x86
  # will only boot into a failing bootloader, but that is enough
  $ qemu-system-x86_64 -vnc :0,websocket
  # We need version 1.2 or later, so use the snap
  $ snap install novnc
  $ novnc --vnc localhost:5700
  Connect browser to http://<IP>:6080/vnc.html
  Click "Connect"

   * Cross check with an older noVNC (e.g. the one in Focal) if the =

     connectivity still works on those as well

     - Reminders when switching between the noVNC implementations
       - always refresh the browser with all clear ctrl+alt+f5
       - start/stop the snapped one via snap.novnc.novncsvc.service

  [Regression Potential]

   * This is exclusive to the functionality of noVNC, so regressions would =

     have to be expected in there. The tests try to exercise the basics, but
     e.g. Openstack would be a major product using =


  [Other Info]
   =

   * The noVNC in Focal itself does not yet have the offending change, but
     we want the qemu in focal to be connecteable from ~any type of client


  ---


  =

  When running a machine using "-vnc" and the "websocket" option QEMU seems=
 to require the subprotocol called 'binary'. This subprotocol does not exis=
t in the WebSocket specification. In fact it has never existed in the spec,=
 in one of the very early drafts of WebSockets it was briefly mentioned but=
 it never made it to a final version.

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

