Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15C8C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D70206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D70206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuVV-0005Qt-P3
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 05:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kRuTq-0004aq-FZ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:50:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:42560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kRuTn-0001xw-Us
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:50:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kRuTk-0003sg-O7
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:50:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8B11E2E811A
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:50:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2020 09:44:42 -0000
From: Launchpad Bug Tracker <1849644@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=focal; sourcepackage=qemu; 
 component=main; status=Fix Released; importance=Low;
 assignee=None; 
X-Launchpad-Bug-Tags: verification-done verification-done-focal
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange janitor laurent-vivier npes87184 paelzer
 racb samuel-t sil2100 ubuntu-sru-bot
X-Launchpad-Bug-Reporter: Samuel (samuel-t)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <157191258679.29920.9268940625941119092.malonedeb@soybean.canonical.com>
Message-Id: <160249588523.29606.12759895704348486626.malone@ackee.canonical.com>
Subject: [Bug 1849644] Re: QEMU VNC websocket proxy requires non-standard
 'binary' subprotocol
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="781851f4dc11c93bc506eb54e6a0d35c919a1ce6"; Instance="production"
X-Launchpad-Hash: 5fd18d85d40da1e9775c85a91de8339042886d39
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 05:21:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

This bug was fixed in the package qemu - 1:4.2-3ubuntu6.7

---------------
qemu (1:4.2-3ubuntu6.7) focal; urgency=3Dmedium

  * d/p/ubuntu/lp-1882774-*: add newer EPYC processor types (LP: #1887490)
  * d/p/u/lp-1896751-exec-rom_reset-Free-rom-data-during-inmigrate-skip.pat=
ch:
    fix reboot after migration (LP: #1896751)
  * d/p/u/lp-1849644-io-channel-websock-treat-binary-and-no-sub-protocol-.p=
atch:
    fix websocket compatibility with newer versions of noVNC (LP: #1849644)

 -- Christian Ehrhardt <christian.ehrhardt@canonical.com>  Mon, 27 Jul
2020 11:45:26 +0200

** Changed in: qemu (Ubuntu Focal)
       Status: Fix Committed =3D> Fix Released

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
  Fix Released

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

