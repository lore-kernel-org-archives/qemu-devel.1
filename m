Received: from eggs.gnu.org ([2001:4830:134:3::10]:48963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmYfx-0007uo-1P
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 23:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmYft-0000Bu-Tq
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 23:30:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:39645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cmYft-0000Ae-O3
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 23:30:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cmYfp-0001BQ-9e
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 04:30:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3FD812E80D3
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 04:30:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Mar 2017 04:17:18 -0000
From: Launchpad Bug Tracker <546638@bugs.launchpad.net>
Reply-To: Bug 546638 <546638@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100325035005.19590.69261.malonedeb@wampee.canonical.com>
Message-Id: <20170311041719.7718.73015.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 546638] Re: Connection error when use PXE+NFS to
 boot guest
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
https://bugs.launchpad.net/bugs/546638

Title:
  Connection error when use PXE+NFS to boot guest

Status in QEMU:
  Expired

Bug description:
  I use NFS+PXE to boot RHEL 5. The installation is slow, and I send
  Ctrl+Alt+F4, then find that half (but not all) of connections are
  dropped:

  nfs: server 192.168.122.50 OK
  nfs: server 192.168.122.50 OK
  nfs: server 192.168.122.50 OK
  nfs: server 192.168.122.50 not responding, still trying
  nfs: server 192.168.122.50 OK
  nfs: server 192.168.122.50 not responding, still trying
  nfs: server 192.168.122.50 not responding, still trying
  :
  :

  I have checked that there is no IP conflict.

  Host machine
  Kernel: 2.6.32.9-70.fc12.x86_64
  QEMU version: 0.12.3-2.fc12.x86_64
  libvirt version: 0.7.1-15.fc12.x86_64

  Guest machine 1 (NFS server)
  Kernel: 2.6.18-164.el5
  nfs-utils version: 1.0.9-42.el5
  Set up command: virt-install --connect qemu:///system -n m5 --vnc --accel=
erate --ram=3D256 --noreboot --os-type=3Dlinux --pxe --os-variant=3Drhel5 -=
-mac=3D52:54:00:50:00:00 --file=3D/dev/VolGroup00/m5

  Guest machine 2 (the machine to be installed via PXE+NFS)
  Set up command: virt-install --connect qemu:///system -n e51 --vnc --acce=
lerate --ram=3D128 --noreboot --os-type=3Dlinux --pxe =E2=80=93os-variant=
=3Drhel5 --mac=3D52:54:00:51:01:00 --file=3D/dev/VolGroup00/e51

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  I try to use NFS under different situations to test.
  Test 1) Try normal NFS mount. This test successes.
  Test 2) Try to boot a diskless machine via PXE, use a NFS mount point at =
root. This test suffers the same problem

  At test 1)
  NFS client mount an export of the NFS server, and use command "find ." to=
 see if it runs smoothly.
  Result: it runs smoothly for thousands of lines.

  Guest machine 3 (NFS server)
  Kernel: 2.6.18-164.el5
  Set up command: virt-install --connect qemu:///system -n dm1 --vnc --acce=
lerate --ram=3D256 --noreboot --os-type=3Dlinux --pxe --os-variant=3Drhel5 =
--mac=3D52:54:00:d1:00:00 --file=3D/dev/VolGroup00/dm1

  NFS client is Guest machine 1 mentioned before.

  At test 2)
  Set up a PXE server, write a customized initrd, in which init script uses=
 "mkrootdev -t nfs -o nolock,ro" to set root directory on a NFS mount.

  Result: the client machine can boot, but very slowly, with numerous
  nfs: server 192.168.122.110 OK
  nfs: server 192.168.122.110 not responding, still trying

  NFS server: it is Guest machine 3
  Client to be booted: Guest machine 4
  Set up command: virt-install --connect qemu:///system -n de11 --vnc --acc=
elerate --ram=3D128 --noreboot --os-type=3Dlinux --pxe =E2=80=93os-variant=
=3Drhel5 --nodisk --mac=3D52:54:00:d1:01:00

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/546638/+subscriptions
