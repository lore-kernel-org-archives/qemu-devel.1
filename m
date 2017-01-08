Received: from eggs.gnu.org ([2001:4830:134:3::10]:33104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ9RH-00065w-35
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQ9RE-0007hc-Az
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:06:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:60997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQ9RE-0007fy-4V
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:06:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQ9RD-0005ym-58
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 09:06:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95EA72E80D0
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 09:06:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jan 2017 08:52:40 -0000
From: Thomas Huth <884401@bugs.launchpad.net>
Reply-To: Bug 884401 <884401@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111031200405.19472.43985.malonedeb@soybean.canonical.com>
Message-Id: <20170108085240.21353.21490.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 884401] Re: PCI Passthrough for Digium TCE400P
 Codec Card Not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to the comment to Alex, this should have been fixed in newer
versions, so setting status to "Fix Released" now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/884401

Title:
  PCI Passthrough for Digium TCE400P Codec Card Not working

Status in QEMU:
  Fix Released

Bug description:
  trying to use a Digium TCE400P Codec card on a Virtual instance using
  the following information:

  lspci <enter>

  02:08.0 Ethernet controller: Digium, Inc. Wildcard TCE400P transcoder
  base card (rev 11)

  lspci -n <enter>

  02:08.0 0200: d161:8004 (rev 11)

  virsh nodedev-list | grep pci

  pci_0000_02_08_0

  printf %x 02
  2

  printf %x 08
  8

  printf %x 0
  0

  bus=3D'0x02'
  slot=3D'0x08'
  function=3D'0x0'

  # virsh edit vmanager
  <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
    <source>
        <address domain=3D'0x0000' bus=3D'0x02' slot=3D'0x08' function=3D'0=
x0'/>
    </source>
  </hostdev>

  I have SELINUX disabled at this time.

  virsh start vmanager I get the following error message:

  [root@twins qemu]# virsh start vmanager
  error: Failed to start domain vmanager
  error: internal error Process exited while reading console log output: ch=
ar device redirected to /dev/pts/2
  Unable to assign device: PCI region 1 at address 0xdf1fe000 has size 0x40=
0,  which is not a multiple of 4K
  qemu-kvm: -device pci-assign,host=3D02:08.0,id=3Dhostdev0,configfd=3D23,b=
us=3Dpci.0,addr=3D0x6: Device 'pci-assign' could not be initialized


  Version Numbers:

  [root@twins qemu]# yum list | grep qemu
  gpxe-roms-qemu.noarch                  0.9.7-6.3.el6_0.1                @=
updates
  qemu-img.x86_64                        2:0.12.1.2-2.113.el6_0.8         @=
updates
  qemu-kvm.x86_64                        2:0.12.1.2-2.113.el6_0.8         @=
updates
  qemu-kvm-tools.x86_64                  2:0.12.1.2-2.113.el6_0.8         u=
pdates

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/884401/+subscriptions
