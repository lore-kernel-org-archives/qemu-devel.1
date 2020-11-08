Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0501C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4984720665
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4984720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbhRA-0001Mh-BJ
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhQH-0000q7-1u
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:55:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:58684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhQF-0005Me-2K
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:55:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbhQD-0001ET-Dh
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:55:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 64CF92E8019
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:55:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:46:03 -0000
From: Thomas Huth <1816819@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anisse berrange th-huth
X-Launchpad-Bug-Reporter: Anisse Astier (anisse)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155068228906.30253.11103905943605426100.malonedeb@chaenomeles.canonical.com>
Message-Id: <160482876312.19128.12798303111512099896.malone@soybean.canonical.com>
Subject: [Bug 1816819] Re: Chardev websocket stops listening after first
 connection disconnects
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: b3df6f7e8e97dd4e4941a2842b2f7fba07e54a36
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1816819 <1816819@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Ddd154c4d9f48a44ad24e1

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1816819

Title:
  Chardev websocket stops listening after first connection disconnects

Status in QEMU:
  Fix Released

Bug description:
  Using qemu option:
   -chardev socket,id=3Dwebsock0,websocket,port=3D13042,host=3D127.0.0.1,se=
rver,nowait -serial chardev:websock0

  To have a websocket listening chardev. After the first connection
  disconnects (that does a full websocket handshake), subsequent
  connections aren't accepted. See below for a reproducing session
  kindly provided by Daniel:

  $ telnet localhost 13042
  Trying ::1...
  telnet: connect to address ::1: Connection refused
  Trying 127.0.0.1...
  Connected to localhost.
  Escape character is '^]'.
  GET / HTTP/1.1
  Upgrade: websocket
  Connection: Upgrade
  Host: localhost:%s
  Origin: http://localhost
  Sec-WebSocket-Key: o9JHNiS3/0/0zYE1wa3yIw=3D=3D
  Sec-WebSocket-Version: 13
  Sec-WebSocket-Protocol: binary

  HTTP/1.1 101 Switching Protocols
  Server: QEMU VNC
  Date: Wed, 20 Feb 2019 16:52:04 GMT
  Upgrade: websocket
  Connection: Upgrade
  Sec-WebSocket-Accept: b3DnPh7O8hyYE5sIjQxl/c1J+S8=3D
  Sec-WebSocket-Protocol: binary

  sfsd
  =EF=BF=BD&=EF=BF=BDonly binary frames may be fragmentedConnection closed =
by foreign host.

  $ telnet localhost 13042
  Trying ::1...
  telnet: connect to address ::1: Connection refused
  Trying 127.0.0.1...
  Connected to localhost.
  Escape character is '^]'.
  GET / HTTP/1.1
  Upgrade: websocket
  Connection: Upgrade
  Host: localhost:%s
  Origin: http://localhost
  Sec-WebSocket-Key: o9JHNiS3/0/0zYE1wa3yIw=3D=3D
  Sec-WebSocket-Version: 13
  Sec-WebSocket-Protocol: binary


  ...no response.....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1816819/+subscriptions

