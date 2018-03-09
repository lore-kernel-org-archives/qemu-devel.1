Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euE7n-0003LI-VP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euE7j-0005UW-0k
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:15:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:48392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1euE7i-0005U5-Qy
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:15:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1euE7h-0007xU-S4
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 09:15:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D20232E80C9
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 09:15:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Mar 2018 09:07:53 -0000
From: eezacque <eezacque@xs4all.nl>
Reply-To: Bug 1754597 <1754597@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152058647369.4543.14826209514925164924.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754597] [NEW] qemu-system-x86_64 broken on
 ubuntu 17.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I have run a virtual machine over the past three years without problems,
but the update to Ubuntu 17.10 broke it: the machine falls into an
infinite boot loop.

$ qemu-system-x86_64 --version
QEMU emulator version 2.10.1(Debian 1:2.10+dfsg-0ubuntu3.5)

$ sudo qemu-system-x86_64 -enable-kvm -usb \
    -chardev stdio,id=3Dchar0 \
    -device usb-host,vendorid=3D0x056a,productid=3D0x00c6 \
    -device usb-host,vendorid=3D0x04a9,productid=3D0x2220 \
    -soundhw all \
    -m 2048 -cpu core2duo -machine q35  \
    -smp 2 \
    -device usb-mouse  \
    -vga std  \
    -device isa-applesmc,osk=3D"CONFIDENTIAL" \
    -smbios type=3D2 \
    -device ide-drive,bus=3Dide.0,drive=3DHDD \
    -drive id=3DHDD,if=3Dnone,cache=3Dnone,file=3Dhdd.img \
    -device ide-drive,bus=3Dide.3,drive=3DScrapHDD \
    -drive id=3DScrapHDD,if=3Dnone,cache=3Dnone,file=3Dscrap.img \
    -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3Dno \
    -device e1000,netdev=3Dnet0,id=3Dnic0,mac=3D00:aa:00:60:00:01

$ uname -a
Linux behemoth 4.13.0-36-generic #40-Ubuntu SMP Fri Feb 16 20:07:48 UTC 201=
8 x86_64 x86_64 x86_64 GNU/Linux

$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 17.10
Release:	17.10
Codename:	artful

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754597

Title:
  qemu-system-x86_64 broken on ubuntu 17.10

Status in QEMU:
  New

Bug description:
  I have run a virtual machine over the past three years without
  problems, but the update to Ubuntu 17.10 broke it: the machine falls
  into an infinite boot loop.

  $ qemu-system-x86_64 --version
  QEMU emulator version 2.10.1(Debian 1:2.10+dfsg-0ubuntu3.5)

  $ sudo qemu-system-x86_64 -enable-kvm -usb \
      -chardev stdio,id=3Dchar0 \
      -device usb-host,vendorid=3D0x056a,productid=3D0x00c6 \
      -device usb-host,vendorid=3D0x04a9,productid=3D0x2220 \
      -soundhw all \
      -m 2048 -cpu core2duo -machine q35  \
      -smp 2 \
      -device usb-mouse  \
      -vga std  \
      -device isa-applesmc,osk=3D"CONFIDENTIAL" \
      -smbios type=3D2 \
      -device ide-drive,bus=3Dide.0,drive=3DHDD \
      -drive id=3DHDD,if=3Dnone,cache=3Dnone,file=3Dhdd.img \
      -device ide-drive,bus=3Dide.3,drive=3DScrapHDD \
      -drive id=3DScrapHDD,if=3Dnone,cache=3Dnone,file=3Dscrap.img \
      -netdev tap,id=3Dnet0,ifname=3Dtap0,script=3Dno \
      -device e1000,netdev=3Dnet0,id=3Dnic0,mac=3D00:aa:00:60:00:01

  $ uname -a
  Linux behemoth 4.13.0-36-generic #40-Ubuntu SMP Fri Feb 16 20:07:48 UTC 2=
018 x86_64 x86_64 x86_64 GNU/Linux

  $ lsb_release -a
  No LSB modules are available.
  Distributor ID:	Ubuntu
  Description:	Ubuntu 17.10
  Release:	17.10
  Codename:	artful

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754597/+subscriptions
