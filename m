Received: from eggs.gnu.org ([2001:4830:134:3::10]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsnz-0000Mx-5c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsnx-0008IE-1B
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:56096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsnw-0008Ff-Qm
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsnu-0005YD-Mg
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C5F312E80DE
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:25:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:19:32 -0000
From: Thomas Huth <1715186@bugs.launchpad.net>
Reply-To: Bug 1715186 <1715186@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150462661769.17099.11925025088141121020.malonedeb@gac.canonical.com>
Message-Id: <151335477286.19363.6920133410740611234.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715186] Re: websockets: Improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715186

Title:
  websockets: Improve error messages

Status in QEMU:
  Fix Released

Bug description:
  Since 2.9 / 07e95cd529af345fdeea230913f68eff5b925bb6 , whenever the
  VNC websocket server finds an error with the incoming connection
  request, it just closes the socket with no further information.

  This makes figuring out what's wrong with the request nearly
  impossible.

  I would be nice if:

  * HTTP 400 were returned to the client, with an appropriate error message
  * Maybe something written to the log as well?

  Currently, I'm resorting to looking at my request and the websocket
  source and hoping I can figure out what's wrong.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715186/+subscriptions
