Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3F9C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F8B218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 06:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F8B218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJBOy-00074i-SI
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 02:29:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH5-0008Kd-Be
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBH3-0001Au-VD
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBH3-00019y-NC
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:20:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBH2-0007lp-Gx
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7B67D2E80D3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:10:39 -0000
From: Thomas Huth <1795100@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange dgilbert-h lukeshu
X-Launchpad-Bug-Reporter: LukeShu (lukeshu)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <153818746845.29396.3425570709275982365.malonedeb@soybean.canonical.com>
Message-Id:
 <155608624076.7202.7057364423758398700.launchpad@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e8e5920a50059984510036064961356bfb51ae6c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1795100] Re: VNC unix-domain socket unlink()ed
 prematurely
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
Reply-To: Bug 1795100 <1795100@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424061039._2ghrpUT_fmoyZ30GNxTrWJCOwcqvYAy1pjKXK9PkyM@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1795100

Title:
  VNC unix-domain socket unlink()ed prematurely

Status in QEMU:
  Fix Released

Bug description:
  With qemu 3.0.0 (I don't believe this happened with previous
  versions), if I tell it `-vnc unix:/path/to/vnc.sock`, qemu will
  unlink() that file when the first client disconnects, meaning that
  once I disconnect, I can't ever reconnect without restarting the VM.

  A stupid testcase demonstrating the issue:

  In terminal A:

      $ qemu-system-x86_64 -vnc unix:$PWD/vnc.sock

  In terminal B:

      $ ls vnc.sock
      vnc.sock
      $ socat STDIO UNIX-CONNECT:vnc.sock <<<''
      RFB 003.008
      $ ls vnc.sock
      ls: cannot access 'vnc.sock': No such file or directory

  I have determined that the offending unlink() call is the one in
  io/channel-socket.c:qio_channel_socket_close().  That call was first
  introduced in commit d66f78e1eaa832f73c771d9df1b606fe75d52a50, which
  first appeared in version 3.0.0.

  This type of premature unlink() does not happen on monitor.sock with
  `-monitor unix:/path/to/monitor.sock,server,nowait`.

  I am not familiar enough with the QIO subsystem to suggest a fix that
  fixes VNC, but preserves the QMP fix targeted in the offending commit.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1795100/+subscriptions

