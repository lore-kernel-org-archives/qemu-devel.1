Received: from eggs.gnu.org ([2001:4830:134:3::10]:58674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPBdX-0001jj-EC
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPBdU-0002AL-9u
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:15:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:38794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPBdU-0002AB-49
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:15:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPBdS-0007ZT-6O
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 17:15:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2D4B02E80C8
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 17:15:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Jan 2017 16:56:15 -0000
From: Daniel Berrange <1455912@bugs.launchpad.net>
Reply-To: Bug 1455912 <1455912@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150517130746.26692.51704.malonedeb@gac.canonical.com>
Message-Id: <20170105165615.20524.24506.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1455912] Re: vnc websocket option not properly
 parsed when running on commandline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00583.html

** Changed in: qemu
       Status: Confirmed =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1455912

Title:
  vnc websocket option not properly parsed when running on commandline

Status in QEMU:
  In Progress

Bug description:
  All of my vms are started with a simple script on the command line.  =

  Starting with Qemu 2.3.0, the option "-vnc host:port,websocket" is no lon=
ger working.

  Previously if I said listen on Tor:17,websocket it would function
  correctly.  Now it's kicking an error:

  =

  qemu-system-x86_64: -vnc tor:17,websocket: Failed to start VNC server on =
`(null)': address resolution failed for tor:on: Servname not supported for =
ai_socktype

  The error leads me to believe it's not parsing the command line
  options for the "vnc" option correctly.  If I leave off ",websocket"
  it works correctly.  I've even tried, replacing the hostname with an
  IP address, and using the alternate form " -display
  vnc=3Dtor:17,webscoket". It reports the same error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1455912/+subscriptions
