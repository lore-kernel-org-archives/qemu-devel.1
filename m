Received: from eggs.gnu.org ([2001:4830:134:3::10]:36442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RPw-00030h-0A
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RPs-0003EY-3K
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:54250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RPr-0003Da-Tb
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:44:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RPq-0005c0-UP
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:44:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E4DDB2E80C3
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:44:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:35:10 -0000
From: Thomas Huth <1297781@bugs.launchpad.net>
Reply-To: Bug 1297781 <1297781@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140326104715.22580.86566.malonedeb@wampee.canonical.com>
Message-Id: <150919771041.8833.14360504567494418680.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1297781] Re: Network device cannot communicate
 with host machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... How did you start QEMU here? Can you still
reproduce this issue with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1297781

Title:
  Network device cannot communicate with host machine

Status in QEMU:
  Incomplete

Bug description:
  I know this used to work but it doesnt work any more using qemu 1.4.2  on=
 fedora 19 everything works fine
  except when i add a NIC sharing the main interface from the host (not the=
 virtual network)

  the hosts ip is 10.0.0.4, the router is 10.0.0.1 so when i boot my virtua=
l machine it gets an ip from the router no problem =

  i get on the internet fine, and i can connect (ping,ftp, samba whatever) =
to all the computers on the network except the host
  10.0.0.4 i can't ping it, i cant do anything to it, but i can connect to =
all the other computers on the network and i know i used to be able to do t=
his because thats how i shared files between the host and windows guest, wi=
th samba... but now i can't browse the host computer because it can't commu=
nicate... please help.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1297781/+subscriptions
