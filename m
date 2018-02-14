Received: from eggs.gnu.org ([2001:4830:134:3::10]:56874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1em0Lt-0006gU-9i
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1em0Lq-0006vp-7R
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:56:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:59424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1em0Lq-0006vT-1S
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:56:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1em0Lo-0006NC-Uq
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:56:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D925C2E806B
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:56:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2018 16:39:40 -0000
From: Thomas Huth <1461918@bugs.launchpad.net>
Reply-To: Bug 1461918 <1461918@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150604121104.9929.24787.malonedeb@wampee.canonical.com>
Message-Id: <151862638054.8935.7371361161398164395.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1461918] Re: guest hangs after use ethtool to set
 scatter-gather on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU and Fedora? Or could we close this ticket
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu
     Assignee: kifast (kifast) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1461918

Title:
  guest hangs after use ethtool to set scatter-gather on

Status in QEMU:
  Incomplete

Bug description:
  On the guests,  i have a rtl8139 nic,  I use ethtool to set  scatter-gath=
er on ( ethtool -K eth0 sg on ),
  after that,   at host side,  I  use scp to send a file into guest.  As a =
result, guest hang.
  At that point qemu is using 100% of one host CPU, about 100% guest.

  If guest is centOS6.5=EF=BC=8C with no problem.


  The guest system is Fedora release 19(Kernel 3.11.10-200.fc19.x86_64).

  host system is debian 7.1.
  Kernel:3.10.0
  Qemu: 2.3.0

  cmd:
  /boot/qemu-2.3.0-bin/qemu-system-x86_64 -vnc :13 -enable-kvm -name fedora=
 -smp sockets=3D1,cores=3D2 -cpu core2duo -nodefaults -vga cirrus -k en-us =
-boot menu=3Don,splash-time=3D8000 -m 2048 -usb -drive file=3D/boot/vm-disk=
-1.qcow2,if=3Dnone,id=3Ddrive-ide0,cache=3Dnone,aio=3Dnative -device ide-hd=
,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0,id=3Dide0,bootindex=3D100 -netdev =
type=3Dtap,id=3Dnet0,ifname=3D200,script=3D/etc/kvm/vtp-bridge -device rtl8=
139,romfile=3D,mac=3DFE:FC:FE:5C:58:65,netdev=3Dnet0,bus=3Dpci.0,addr=3D0x1=
2,id=3Dnet0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1461918/+subscriptions
