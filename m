Received: from eggs.gnu.org ([2001:4830:134:3::10]:49446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOAZ3-0003rG-Rs
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOAYz-0006ef-Vr
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:54:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:33667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOAYz-0006dh-Q7
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:54:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOAYw-0005la-VU
	for <qemu-devel@nongnu.org>; Mon, 02 Jan 2017 21:54:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D3C612E80D7
	for <qemu-devel@nongnu.org>; Mon,  2 Jan 2017 21:54:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jan 2017 21:44:24 -0000
From: mmu_man <925405@bugs.launchpad.net>
Reply-To: Bug 925405 <925405@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120202110843.18662.48430.malonedeb@wampee.canonical.com>
Message-Id: <916e830a-e2d6-cdae-e523-2d6beb1b7915@free.fr>
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

There is no need to change the protocol version itself to use new =

encoding, there are provisions for that in the existing one.

IIRC the problem was also that each party was waiting for the other one =

to send data after the protocol version exchange, but that was 5y ago.

Yes it should be possible to work around this, but I don't have a Mac
now.

Fran=C3=A7ois.

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
