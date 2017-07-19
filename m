Received: from eggs.gnu.org ([2001:4830:134:3::10]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXnQO-0006V2-Es
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXnQJ-0001Ti-F4
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:45:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:48829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXnQJ-0001TY-1K
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:45:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXnQH-0007F2-CW
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:45:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5D9A72E8079
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:45:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 11:27:50 -0000
From: Thomas Huth <1333216@bugs.launchpad.net>
Reply-To: Bug 1333216 <1333216@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140623113621.6929.85009.malonedeb@chaenomeles.canonical.com>
Message-Id: <150046367077.24500.16020460636668819027.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1333216] Re: Xen 4.4 with qemu 1.6.2 VGA passthru
 NVIDIA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU? If
so, have you already tried to report it to the folks from the Xen
project?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1333216

Title:
  Xen 4.4 with qemu 1.6.2 VGA passthru NVIDIA

Status in QEMU:
  Incomplete

Bug description:
  Hi!

  Please, give me an advice.

  I try use VGA passthough NVidia k40 on SuperMicro Server, but server is h=
aving error.
  My Xen is using qemu (a9e8aeb3755bccb7b51174adcf4a3fc427e0d147)2.0.0

  My VirtualMachine is have config:
  device_model_version =3D "qemu-xen"
  device_model_override =3D "/opt/sources/qemu-a9e8aeb/x86_64-softmmu/qemu-=
system-x86_64"

  When I start VM:
  dmesg
  [    0.906181] pci 0000:00:05.0: BAR 1: can't assign mem pref (size 0x100=
000000)
  [    0.906187] pci 0000:00:05.0: BAR 1: trying firmware assignment [mem 0=
x100000000-0x1ffffffff 64bit pref]
  [    0.906193] pci 0000:00:05.0: BAR 1: assigned [mem 0x100000000-0x1ffff=
ffff 64bit pref]
  and lspci -s 00:05.0 -vvv
          Region 0: Memory at 85000000 (32-bit, non-prefetchable) [size=3D1=
6M]
          Region 1: Memory at 100000000 (64-bit, prefetchable) [size=3D4G]
          Region 3: Memory at 82000000 (64-bit, prefetchable) [size=3D32M]

  Why?

  This is message in DOM0:
  lspci -s 03:00.0 -vvv
  ....
  Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=3D16M]
  Region 1: Memory at 5800000000 (64-bit, prefetchable) [size=3D16G]
  Region 3: Memory at 5c00000000 (64-bit, prefetchable) [size=3D32M]

  =

  Why Qemu don`t mapping BAR1?
  Thanks!
  Regards!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1333216/+subscriptions
