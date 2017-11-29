Received: from eggs.gnu.org ([2001:4830:134:3::10]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eK1MQ-00064W-5c
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eK1MN-0006Om-09
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:58194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eK1MM-0006Og-QC
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:21:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eK1ML-0002C8-EI
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 12:21:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7E39E2E8179
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 12:21:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2017 12:14:42 -0000
From: Daniel Berrange <1724477@bugs.launchpad.net>
Reply-To: Bug 1724477 <1724477@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150831284620.1599.14269987525342877867.malonedeb@soybean.canonical.com>
Message-Id: <151195768303.3246.13908680600997103626.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724477] Re: Build-in websocket broken since
 v2.9.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Key fixes for client interoperability coming in 2.11  include


6d5d23b00709510d55711661c7ca41408fd9934e io: cope with websock 'Connection'=
 header having multiple values
530ca60c16c83435d4becc9916d74fa43e003815 io: Attempt to send websocket clos=
e messages to client
268a53f50de795481dd73ffd0e0c1339ad3dc44b io: Reply to ping frames
01af17fc002414ee1ac0800babfb0edc2bef1a7d io: Ignore websocket PING and PONG=
 frames
3a29640e2cbae9d47b89ffaf98ed358920eb6797 io: Allow empty websocket payload
ff1300e626949fa9850b0f91dc5e8c2cb45b6a88 io: Add support for fragmented web=
socket binary frames
eefa3d8ef649f9055611361e2201cca49f8c3433 io: Small updates in preparation f=
or websocket changes
33badfd1e3735b877e41939100511c65572be6b9 io: use case insensitive check for=
 Connection & Upgrade websock headers
3a3f8705962c8c8a47a9b981ffd5aab7274ad508 io: include full error message in =
websocket handshake trace
f69a8bde29354493ff8aea64cc9cb3b531d16337 io: send proper HTTP response for =
websocket errors


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1724477

Title:
  Build-in websocket broken since v2.9.0-rc0

Status in QEMU:
  Fix Committed

Bug description:
  Since upgrading to 2.9.0, the qemu's build-in websocket was no longer
  available.

  Host: Ubuntu 16.04 LTS
  Command-line: /bin/qemu-system-x86_64 -enable-kvm -vnc 0.0.0.0:8,websocket

  I have tested the following qemu versions:

  master      Fail
  2.10.1      Fail
  2.9.1       Fail
  2.9.0       Fail
  2.9.0-rc3   Fail
  2.9.0-rc0   Fail

  2.8.1.1     Pass
  2.7.1       Pass
  2.6.2       Pass

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724477/+subscriptions
