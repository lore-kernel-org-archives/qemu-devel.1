Received: from eggs.gnu.org ([2001:4830:134:3::10]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdMYq-0006cs-7f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdMYn-0003Sv-3r
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:45:20 -0500
Received: from indium.canonical.com ([91.189.90.7]:45516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdMYm-0003Si-Td
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:45:17 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdMYl-0005mj-E1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 19:45:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 628452E80C0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 19:45:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Feb 2017 19:26:52 -0000
From: Thomas Huth <821078@bugs.launchpad.net>
Reply-To: Bug 821078 <821078@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110804185353.20230.46645.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170213192652.5740.50850.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 821078] Re: virtio-serial-bus: Unexpected port id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... Can you still reproduce this problem with
the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/821078

Title:
  virtio-serial-bus: Unexpected port id

Status in QEMU:
  Incomplete

Bug description:
  With qemu-kvm-0.15.0-rc1 virtio-serial-bus reports an error, and windows =
vdagent can not start.  qemu-0.15.0-rc1 behaves as expected, ie vdagent run=
s in the guest, mouse passes seamlessly between spicec and host and copy/pa=
ste works between guest and host.
  qemu-kvm has been configured with
  ./configure --target-list=3Dx86_64-softmmu --disable-curses  --disable-cu=
rl --audio-drv-list=3Dalsa --audio-card-list=3Dsb16,ac97,hda --enable-vnc-t=
hread --disable-bluez --enable-vhost-net --enable-spice
  and is started with
  qemu-system-x86_64 -cpu host -enable-kvm -pidfile /home/rick/qemu/hds/wxp=
.pid -drive file=3D/home/rick/qemu/hds/wxp.raw,if=3Dvirtio,aio=3Dnative -m =
1536 -name WinXP -net nic,model -net user -localtime -usb -vga qxl -device =
virtio-serial-pci,id=3Dvirtio-serial0,max_ports=3D16,bus=3Dpci.0,addr=3D0x5=
 -chardev spicevmc,name=3Dvdagent,id=3Dvdagent -device virtserialport,nr=3D=
1,bus=3Dvirtio-serial0.0,chardev=3Dvdagent,name=3Dcom.redhat.spice.0 -spice=
 port=3D1234,disable-ticketing -monitor stdio

  I've also tried start qemu like
  qemu-system-x86_64 -cpu host -enable-kvm -pidfile /home/rick/qemu/hds/wxp=
.pid -drive file=3D/home/rick/qemu/hds/wxp.raw,if=3Dvirtio -m 768 -name Win=
XP -net nic,model=3Dvirtio -net user -localtime -usb -vga qxl -device virti=
o-serial -chardev spicevmc,name=3Dvdagent,id=3Dvdagent -device virtserialpo=
rt,chardev=3Dvdagent,name=3Dcom.redhat.spice.0 -spice port=3D1234,disable-t=
icketing -monitor stdio
  and observed the same results.

  the host runs 2.6.39.4 vanilla kernel.  the guest uses the most recent
  virtio-serial, vga-qxl and vdagent from spice-space.org

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/821078/+subscriptions
