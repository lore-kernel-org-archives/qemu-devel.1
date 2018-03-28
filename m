Received: from eggs.gnu.org ([2001:4830:134:3::10]:46679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1CTh-00039a-0F
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1CTd-00013Y-2C
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:55:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:41540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f1CTc-00013C-Rp
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:55:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f1CTb-0007pp-CH
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 14:54:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 52BEE2E80CC
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 14:54:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Mar 2018 14:41:46 -0000
From: "mike@papersolve.com" <mike@papersolve.com>
Reply-To: Bug 1588591 <1588591@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160603031333.20018.31663.malonedeb@wampee.canonical.com>
Message-Id: <152224810688.30058.11985765980313957104.malone@gac.canonical.com>
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

Although I have occasionally seen this message with later versions of
QEMU running Solaris 8/SPARC it has never affected any operations for me
or terminated a telnet or QEMU process, so I think if it is still there
it's not having any affect.  So I think this can be closed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1588591

Title:
  Qemu 2.6 Solaris 8 Sparc telnet terminate itself

Status in QEMU:
  New

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
