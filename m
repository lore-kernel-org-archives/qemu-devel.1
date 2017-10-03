Received: from eggs.gnu.org ([2001:4830:134:3::10]:50722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKwj-0003lF-Gs
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKwd-0004iQ-Ny
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:01:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:43880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzKwd-0004hJ-HT
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:00:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzKwc-0002OY-DW
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 11:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 62C1F2E80C3
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 11:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 10:47:47 -0000
From: Thomas Huth <1327608@bugs.launchpad.net>
Reply-To: Bug 1327608 <1327608@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140607203050.27669.10321.malonedeb@gac.canonical.com>
Message-Id: <150702766740.1698.17693165473735413839.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1327608] Re: monitor socked path is cut a 105
 characters
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
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1327608

Title:
  monitor socked path is cut a 105 characters

Status in QEMU:
  Incomplete

Bug description:
  Starting a VM like so:

  /usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -monitor
  unix:/srv/localfs/Samsung_SSD_840_PRO_Series_S1AXNSAF320206J/vg-virt
  /lv-gentoosummerschool/gentoo-summerschool/gentoo-
  summerschool.img.monitor,server,nowait -name gentoo-summerschool
  -chardev
  socket,id=3Dmonitor,path=3D/srv/localfs/Samsung_SSD_840_PRO_Series_S1AXNS=
AF320206J
  /vg-virt/lv-gentoosummerschool/gentoo-
  summerschool/monitor.sock,server,nowait -monitor chardev:monitor
  -chardev
  socket,id=3Dserial0,path=3D/srv/localfs/Samsung_SSD_840_PRO_Series_S1AXNS=
AF320206J
  /vg-virt/lv-gentoosummerschool/gentoo-
  summerschool/console.sock,server,nowait -serial chardev:serial0
  -enable-kvm -cpu kvm64 -smp 2 -netdev
  tap,id=3Dnet0,script=3D/srv/localfs/Samsung_SSD_840_PRO_Series_S1AXNSAF32=
0206J
  /vg-virt/lv-gentoosummerschool/gentoo-summerschool/qemu-ifup.bash
  -device e1000,netdev=3Dnet0,mac=3D00:00:00:00:00:02 -drive
  id=3Ddisk,file=3D/srv/localfs/Samsung_SSD_840_PRO_Series_S1AXNSAF320206J
  /vg-virt/lv-gentoosummerschool/gentoo-summerschool/gentoo-
  summerschool.img,if=3Dnone -device ahci,id=3Dahci -device ide-
  drive,drive=3Ddisk,bus=3Dahci.0 -m 2048 -vga qxl -spice
  port=3D2002,addr=3D192.168.4.2,password=3DNO-thats-not-my-pwd -device
  virtio-serial-pci -device
  virtserialport,chardev=3Dspicechannel0,name=3Dcom.redhat.spice.0 -chardev
  spicevmc,id=3Dspicechannel0,name=3Dvdagent

  =

  The path: =


  unix:/srv/localfs/Samsung_SSD_840_PRO_Series_S1AXNSAF320206J/vg-virt
  /lv-gentoosummerschool/gentoo-summerschool/gentoo-
  summerschool.img.monitor

  ...is cut like so when I try to shutdown:

  pink ~ # echo system_powerdown | socat - UNIX-CONNECT:/srv/localfs/Samsun=
g_SSD_840_PRO_Series_S1AXNSAF320206J/vg-virt/lv-gentoosummerschool/gentoo-s=
ummerschool/gentoo-summerschool.img.monitor
  2014/06/08 06:39:01 socat[2344] E connect(3, AF=3D1 "/srv/localfs/Samsung=
_SSD_840_PRO_Series_S1AXNSAF320206J/vg-virt/lv-gentoosummerschool/gentoo-su=
mmerschoo", 110): No such file or directory
  pink ~ # =


  =

  It does work with a sorter path like: =

  pink ~ # echo system_powerdown | socat - UNIX-CONNECT:'/srv/localfs/Samsu=
ng_SSD_840_PRO_Series_S1AXNSAF320206J/vg-virt/my.img.monitor' =

  QEMU 1.5.3 monitor - type 'help' for more information
  (qemu) system_powerdown
  (qemu) pink ~ #

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1327608/+subscriptions
