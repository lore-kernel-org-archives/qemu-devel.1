Received: from eggs.gnu.org ([2001:4830:134:3::10]:60704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1TVP-0008Ad-KE
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1TVL-0004D1-Kd
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:05:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:39854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f1TVL-0004Cg-Dz
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:05:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f1TVJ-0001wJ-Tu
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 09:05:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D8BBC2E8025
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 09:05:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Mar 2018 08:55:26 -0000
From: Zhen Ning Lim <limzn88@gmail.com>
Reply-To: Bug 1588591 <1588591@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160603031333.20018.31663.malonedeb@wampee.canonical.com>
Message-Id: <152231372633.12283.13924147775777231573.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1588591] Re: Qemu 2.6 Solaris 8 Sparc telnet
 terminate itself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Nope. Not anymore. I shall close this. Thanks!

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1588591

Title:
  Qemu 2.6 Solaris 8 Sparc telnet terminate itself

Status in QEMU:
  Fix Released

Bug description:
  With Qemu 2.6, Solaris 8 can be installed and run. However, it
  sometimes terminate itself with I/O thread spun for 1000 iterations.

  qemu-system-sparc -nographic -monitor null -serial mon:telnet:0.0.0.0:300=
0,server -hda ./Sparc8.disk -m 256 -boot c -net nic,macaddr=3D52:54:0:12:34=
:56 -net tap,ifname=3Dtap0,script=3Dno,downscript=3DnoQEMU waiting for conn=
ection on: disconnected:telnet:0.0.0.0:3000,server
  main-loop: WARNING: I/O thread spun for 1000 iterations

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1588591/+subscriptions
