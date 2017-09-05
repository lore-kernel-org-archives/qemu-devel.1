Received: from eggs.gnu.org ([2001:4830:134:3::10]:42174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpHNY-0003cZ-HJ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpHNT-0001ne-O4
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:11:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:35251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dpHNT-0001nM-Hw
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:11:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dpHNS-0006bM-5b
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 17:11:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1111F2E80D0
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 17:11:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Sep 2017 16:57:41 -0000
From: Daniel Berrange <1715186@bugs.launchpad.net>
Reply-To: Bug 1715186 <1715186@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150462661769.17099.11925025088141121020.malonedeb@gac.canonical.com>
Message-Id: <150463066181.16996.4572164984216544456.malone@gac.canonical.com>
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

At very least we should also use 404 if given a invalid path

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715186

Title:
  websockets: Improve error messages

Status in QEMU:
  New

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
