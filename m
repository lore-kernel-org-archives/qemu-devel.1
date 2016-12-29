Received: from eggs.gnu.org ([2001:4830:134:3::10]:33165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cMVht-0008Im-3f
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cMVho-0007oi-5u
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:05:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:60408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cMVho-0007m2-0S
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:04:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cMVhm-0002NQ-17
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 08:04:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E1B4A2E80C8
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 08:04:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Dec 2016 07:53:22 -0000
From: Dave Eckhardt <de0u@andrew.cmu.edu>
Reply-To: Bug 925405 <925405@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120202110843.18662.48430.malonedeb@wampee.canonical.com>
Message-Id: <20161229075323.3176.38115.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 925405] Re: VNC server does not work with Mac
 Screen Sharing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

FWIW, this affects me too.

Ubuntu 14.04
QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.30), Copyright (c) =
2003-2008 Fabrice Bellard
OS X 10.9.5.

The observed behavior is that when I hit "Connect" a spinning circle
appears nearby but nothing else ever happens.

There are reports online:
https://www.reddit.com/r/homelab/comments/4jr893/qemu_with_vnc_to_osx_scree=
n_sharing/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/925405

Title:
  VNC server does not work with Mac Screen Sharing

Status in QEMU:
  New
Status in Ubuntu:
  Invalid

Bug description:
  When connecting to a QEMU instance from a Mac using any VNC settings
  on the QEMU CLI and any target arch (ARM, Intel, etc.), the connection
  is attempted but the negotiation never finishes.

  I've verified this when building QEMU from source (1.0 and HEAD) on
  Ubuntu, Fedora and Debian or when using Ubuntu (Oneiric) and Debian
  (Lenny) packages.

  It does not matter whether I specify authentication (or anything else)
  on QEMU's side, the behavior is always the same - I see the connection
  being established using netstat and tcpdump, but QEMU does not seem to
  send back any pixmap data after the connection setup.

  Best guess as to why this happens is that the VNC negotiation on QEMU
  does not like the protocol version and VNC encoding sent by the Mac's
  built-in VNC client, or that its negotiation logic is subtly broken. I
  appreciate that it's not meant to be a full VNC server, but it
  prevents me from using it remotely until a stable Mac build is
  feasible.

  Background info:

  Mac OS X includes a VNC client called Screen Sharing that you can
  invoke in two different ways:

  * At a terminal, by typing "open vnc://hostname:tcp_port"
  * From any URI-enabled field (such as the Safari URI field), where you ca=
n just type the URI as vnc://hostname:tcp_port

  Please do not confuse the enhanced VNC protocol Apple Remote Desktop
  uses with Screen Sharing - they are not mutually exclusive, but they
  are not incompatible either, since what Apple does is to negotiate
  extra pixmap encoding and authentication options - I use Screen
  Sharing to access many VNC servers such as vnc4server, tightvncserver,
  vino, etc. without any issues whatsoever, so the issue I'm reporting
  is not an issue with Apple's implementation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/925405/+subscriptions
