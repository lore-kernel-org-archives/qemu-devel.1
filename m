Received: from eggs.gnu.org ([2001:4830:134:3::10]:39287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNjYZ-0002zs-UD
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 12:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNjYV-0003Jw-VS
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 12:04:27 -0500
Received: from indium.canonical.com ([91.189.90.7]:57561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cNjYV-0003JU-PR
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 12:04:23 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cNjYS-00025u-MA
	for <qemu-devel@nongnu.org>; Sun, 01 Jan 2017 17:04:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A44342E80C8
	for <qemu-devel@nongnu.org>; Sun,  1 Jan 2017 17:04:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Jan 2017 16:55:08 -0000
From: Rui Carmo <925405@bugs.launchpad.net>
Reply-To: Bug 925405 <925405@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120202110843.18662.48430.malonedeb@wampee.canonical.com>
Message-Id: <20170101165508.1274.40921.malone@soybean.canonical.com>
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

Hey there. Will git tip from September do? At that time I built QEMU on
Ubuntu 16.04.1, pointed my Mac (10.10) at it again and had the same
experience (had to use a third-party client)

Considering I opened this four years ago, I'm kind of surprised it's
still a talking topic. Was kind of expecting more people to report it,
but then again Launchpad is a bit off the beaten path these days and
most people just sigh and fetch a third party client.

It's just that it seems like a trivial thing to fix overall, so I
thought it worthwhile to chime in - Happy New Year!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/925405

Title:
  VNC server does not work with Mac Screen Sharing

Status in QEMU:
  Incomplete
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
