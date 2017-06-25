Received: from eggs.gnu.org ([2001:4830:134:3::10]:59129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dOzCL-000311-0Q
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dOzCH-0001LZ-RO
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 00:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:39081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dOzCH-0001L2-Kj
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 00:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dOzCE-0006R6-CT
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4BFA72E80E3
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Jun 2017 04:17:28 -0000
From: Launchpad Bug Tracker <1288620@bugs.launchpad.net>
Reply-To: Bug 1288620 <1288620@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140306085506.13520.47301.malonedeb@gac.canonical.com>
Message-Id: <149836424865.21670.765656899158797916.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1288620] Re: memory leak with config file
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
https://bugs.launchpad.net/bugs/1288620

Title:
  memory leak with config file

Status in QEMU:
  Expired

Bug description:
  I have a Windows 7 SP1 Professional 64-bit installation on a QCOW2
  image with compat=3D1.1, which I launch via

  qemu-system-x86_64 -drive file=3Dwindows_base_HDD.img,index=3D0,media=3Dd=
isk
  -enable-kvm -m 512M -vga std -net nic,vlan=3D0 -net user,vlan=3D0

  As soon as I start using the network in any application =E2=80=94 for exa=
mple,
  visiting www.google.com in Internet Explorer =E2=80=94 QEMU starts gobbli=
ng
  memory until the (host) kernel kills it because of an OOM condition.
  If I run the QEMU with the same options, but with model=3De1000 option
  set for the NIC (i.e. -net -nic,vlan=3D0,model=3De1000), I can use the
  network from the guest OS without any noticeable effect on QEMU's
  memory consumption.

  I do not have this problem when running QEMU with the exact same options =
(as above, without model=3De1000) but with a Debian wheezy installation (on=
 a QCOW image of the same format).  My host system in Ubuntu 13.10 x86_64, =
kernel image 3.11.0-17-generic, but with the QEMU packages from trusty (the=
 codename for the next release):
  Output of `dpkg -l \*qemu\* | grep '^ii'`:
  ii  ipxe-qemu                             1.0.0+git-20130710.936134e-0ubu=
ntu1        all          Virtual package to support use of kvm-ipxe with qe=
mu
  ii  qemu-keymaps                          1.7.0+dfsg-3ubuntu2            =
            all          QEMU keyboard maps
  ii  qemu-system-common                    1.7.0+dfsg-3ubuntu2            =
            amd64        QEMU full system emulation binaries (common files)
  ii  qemu-system-x86                       1.7.0+dfsg-3ubuntu2            =
            amd64        QEMU full system emulation binaries (x86)
  ii  qemu-utils                            1.7.0+dfsg-3ubuntu2            =
            amd64        QEMU utilities

  (If necessary, I can try to reproduce this with QEMU built from the
  upstream source or the latest source from version control.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1288620/+subscriptions
