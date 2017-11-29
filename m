Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eK1Cs-0002Mf-Dv
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eK1Cp-0002k0-6g
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:11:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:53738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eK1Co-0002hq-W8
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:11:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eK1Co-0000y5-6r
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 12:11:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2EA782E8048
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 12:11:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2017 11:56:34 -0000
From: Daniel Berrange <1715186@bugs.launchpad.net>
Reply-To: Bug 1715186 <1715186@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150462661769.17099.11925025088141121020.malonedeb@gac.canonical.com>
Message-Id: <151195659440.20128.9211415518194549869.malone@chaenomeles.canonical.com>
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

Will be included  for 2.11 in

commit 3a3f8705962c8c8a47a9b981ffd5aab7274ad508
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Wed Sep 6 11:38:36 2017 +0100

    io: include full error message in websocket handshake trace
    =

    When the websocket handshake fails it is useful to log the real
    error message via the trace points for debugging purposes.
    =

    Fixes bug: #1715186
    =

    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

commit f69a8bde29354493ff8aea64cc9cb3b531d16337
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Wed Sep 6 11:33:17 2017 +0100

    io: send proper HTTP response for websocket errors
    =

    When any error occurs while processing the websockets handshake,
    QEMU just terminates the connection abruptly. This is in violation
    of the HTTP specs and does not help the client understand what they
    did wrong. This is particularly bad when the client gives the wrong
    path, as a "404 Not Found" would be very helpful.
    =

    Refactor the handshake code so that it always sends a response to
    the client unless there was an I/O error.
    =

    Fixes bug: #1715186
    =

    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715186

Title:
  websockets: Improve error messages

Status in QEMU:
  Fix Committed

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
