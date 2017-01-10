Received: from eggs.gnu.org ([2001:4830:134:3::10]:40592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQspd-00084e-9d
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQspa-0002BO-4X
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:35:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQspZ-0002A5-VA
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:35:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQspY-0005nA-EQ
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:35:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2CD7E2E80CF
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:35:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Jan 2017 09:17:42 -0000
From: Thomas Huth <676934@bugs.launchpad.net>
Reply-To: Bug 676934 <676934@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101118110340.18016.73281.malonedeb@palladium.canonical.com>
Message-Id: <20170110091743.20288.93855.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 676934] Re: Ability to use -net socket with unix
 sockets
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
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/676934

Title:
  Ability to use -net socket with unix sockets

Status in QEMU:
  New

Bug description:
  It would be a nice feature (simplifying access control for example) to
  be able to do something like:

  qemu -net socket,listen=3Dunix:/tmp/qemunet
  qemu -net socket,connect=3Dunix:/tmp/qemunet

  For now one has to use TCP connections even for guests running on the
  same host, which involves setting up iptables to restrict access.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/676934/+subscriptions
