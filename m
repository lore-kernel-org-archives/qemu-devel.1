Received: from eggs.gnu.org ([2001:4830:134:3::10]:44920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTKPO-0008Fp-SP
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTKPO-0003Mn-2M
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:54988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eTKPN-0003M8-Rr
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eTKPM-0007J6-OQ
	for <qemu-devel@nongnu.org>; Mon, 25 Dec 2017 04:30:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B007D2E80C9
	for <qemu-devel@nongnu.org>; Mon, 25 Dec 2017 04:30:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Dec 2017 04:17:39 -0000
From: Launchpad Bug Tracker <1336801@bugs.launchpad.net>
Reply-To: Bug 1336801 <1336801@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140702141735.10601.33631.malonedeb@gac.canonical.com>
Message-Id: <151417545948.5133.15260835585920404344.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1336801] Re: 12.04 guest hangs on a 14.04 host
 server with cirrus graphics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1336801

Title:
  12.04 guest hangs on a 14.04 host  server with cirrus graphics

Status in QEMU:
  Expired
Status in qemu package in Ubuntu:
  Expired

Bug description:
  A new 12.04.4 server guest installation hangs on a 14.04 server host
  machine.

  I did the following:

  Created a new Virtual Machine with the Ubuntu 12.04 template using virt-m=
anager
  Ran through the installation without a hitch to install a LAMP+SSH server=
. All standard options apart from that.
  On reboot the 12.04 guest started but then hung after doing fsck step.
  Trying different options (change disk driver, etc) made it progress a cou=
ple more steps but still hung.

  The thing that fixed it in the end was to switch to a VGA display
  driver, away from the default.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1336801/+subscriptions
