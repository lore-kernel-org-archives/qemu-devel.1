Received: from eggs.gnu.org ([2001:4830:134:3::10]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWahe-0007NP-Cz
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWaha-0007kX-Fw
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:30:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:50430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eWaha-0007j0-9G
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:30:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eWahW-0005zY-TI
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 04:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C33E82E80D4
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jan 2018 04:17:23 -0000
From: Launchpad Bug Tracker <1087411@bugs.launchpad.net>
Reply-To: Bug 1087411 <1087411@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121206195502.27824.72446.malonedeb@gac.canonical.com>
Message-Id: <151495304376.5160.18110985320475686858.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1087411] Re: pseries machine breaks in
 instalation of SLES11_SP2
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
https://bugs.launchpad.net/bugs/1087411

Title:
  pseries machine breaks in instalation of SLES11_SP2

Status in QEMU:
  Expired

Bug description:
  QEMU version: 1.0, 1.1, and 1.2

  Host OS:
  Intel(R) Core(TM) i5-2520M CPU @ 2.50GH
   Linux tpad 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10 20:39:51 UTC 2012 =
x86_64 x86_64 x86_64 GNU/Linux

  SLES Media:
  SLES-11-SP2-DVD-ppc64-GM-DVD1.iso: sha256 -> 2247dd6bb495eb50860668e46f7d=
6ba004eece9909f347c8ce487fd6a5f65ee1

  Command line:
  ./ppc64-softmmu/qemu-system-ppc64 -machine type=3Dpseries,usb=3Doff -m 51=
2 -net nic,vlan=3D0 -net tap -nographic -cdrom =

  /exports/isos/SLES-11-SP2-DVD-ppc64-GM-DVD1.iso -hda /exports/sles11_sp2.=
qcow2 -monitor unix:/dev/tty1,nowait,server

  Error message (after starting instalation ~23%):
  Installation of package ./suse/ppc64/vim-base-7.2-8.15.2.ppc64.rpm failed.
  Subprocess failed. Error: RPM failed: error: %post(vim-base-7.2-8.15.2.pp=
c64.rpm)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1087411/+subscriptions
