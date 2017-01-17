Received: from eggs.gnu.org ([2001:4830:134:3::10]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTbPV-00010O-ST
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTbPS-0005Dx-Rg
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:59972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTbPS-0005Df-MD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTbPR-0004Gv-PE
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:35:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BD3C52E80C2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:35:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 21:20:56 -0000
From: Thomas Huth <747583@bugs.launchpad.net>
Reply-To: Bug 747583 <747583@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110401175509.1231.27239.malonedeb@palladium.canonical.com>
Message-Id: <20170117212056.14243.71731.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 747583] Re: Windows 2008 Time Zone Change Even
 When Using -locatime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU 0.12 is completely outdated nowadays ... can you still reproduce
this issue with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/747583

Title:
  Windows 2008 Time Zone Change Even When Using -locatime

Status in QEMU:
  Incomplete

Bug description:
  * What cpu model : Intel(R) Xeon(R) CPU E5620  @ 2.40GHz
  * What kvm version you are using. : qemu-kvm-0.12.3
  * The host kernel version : 2.6.32-30-server
  * What host kernel arch you are using (i386 or x86_64) : x86_64
  * What guest you are using, including OS type: Windows 2008 Enterprise x8=
6_64
  * The qemu command line you are using to start the guest : /usr/bin/kvm -=
S -M pc-0.12 -enable-kvm -m 1024 -smp 1 -name 2-6176 -uuid 4d1d56b1-d0b7-50=
6b-31a5-a87c8cb0560b -chardev socket,id=3Dmonitor,path=3D/var/lib/libvirt/q=
emu/2-6176.monitor,server,nowait -monitor chardev:monitor -localtime -boot =
c -drive file=3D/dev/disk/by-id/scsi-3600144f05c11090000004d9602950073,if=
=3Dvirtio,index=3D0,boot=3Don,format=3Draw -drive file=3D/dev/disk/by-id/sc=
si-3600144f0eae8810000004c7bb0920037,if=3Dide,media=3Dcdrom,index=3D2,forma=
t=3Draw -net nic,macaddr=3D00:00:d1:d0:3f:5e,vlan=3D0,name=3Dnic.1 -net tap=
,fd=3D212,vlan=3D0,name=3Dtap.1 -net nic,macaddr=3D00:00:0a:d0:3f:5e,vlan=
=3D1,name=3Dnic.1 -net tap,fd=3D213,vlan=3D1,name=3Dtap.1 -chardev pty,id=
=3Dserial0 -serial chardev:serial0 -parallel none -usb -usbdevice tablet -v=
nc 0.0.0.0:394,password -k en-us -vga cirrus
  * Whether the problem goes away if using the -no-kvm-irqchip or -no-kvm-p=
it switch. : Unable to test
  * Whether the problem also appears with the -no-kvm switch. : Unable to t=
est

  Host time zone: EDT Guest time zone: PDT

  Steps to reproduce:
  1) Set time zone to (GMT-08:00) Pacific Time (US & Canada) on guest
  2) Power off Windows 2008 Enterprise x86_64 guest completely. Ensure the =
kvm process exits.
  3) Power on Windows 2008 Enterprise x86_64 guest using virsh start <domai=
n>
  4) Server will show EDT time but have the time zone still set to (GMT-08:=
00) Pacific Time (US & Canada).

  Syncing the time after stopping and starting the kvm process using
  Windows "Internet Time" ntp time sync will sync the time to the
  correct PDT time.

  Doing a reboot from within the guest's operating system where kvm does
  not exit will not cause the timezone shift to happen.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/747583/+subscriptions
