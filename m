Received: from eggs.gnu.org ([2001:4830:134:3::10]:36645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfPx-0000oF-LA
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfPu-0003k7-HO
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:45:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:49942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBfPu-0003jy-B3
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:45:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBfPs-0002fk-FF
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:45:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 723CC2E800E
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:45:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 10:32:54 -0000
From: Thomas Huth <1511887@bugs.launchpad.net>
Reply-To: Bug 1511887 <1511887@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151031002349.21474.82964.malonedeb@soybean.canonical.com>
Message-Id: <149518997408.6599.2539835149881113867.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1511887] Re: USB device 1.1 not correctly
 passedthru from Linux host to Windows guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (currently v2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1511887

Title:
  USB device 1.1 not correctly passedthru from Linux host to Windows
  guest

Status in QEMU:
  Incomplete

Bug description:
  I have USB Digital Oscilloscope which works great on pure Windows
  machine but not work on virtualized one. I tried passthru the device
  from my Debian Jessie (64bit) host machine to Windows 7 (32bit) guest
  machine but unfortunately it does not work very well. It looks that
  device is passed thru so Windows machine knows about new device and
  loads HID device driver for it but the device driver failed to start
  the device and details of an error provided by device manager is "This
  device cannot start" Code 10.

  Installed Qemu version: 2.1+dfsg-12+deb8u4 0

  USB device spec: Dynon Instruments ELAB-080, USB 1.1

  On linux host computer
  ---------------------------
  lsusb identify it as:
  Bus 003 Device 009: ID 13a3:0001 =


  lsusb -t identify it as:
  /: Bus 03.Port 1: Dev 1, Class=3Droot_hub, Driver=3Duhci_hcd/2p, 12M
      |__ Port 1: Dev 9, If 0, Class=3DHuman Interface Device, Driver=3Dusb=
hid, 12M

  This is how I started my Windows guest machine
  ------------------------------------------------------
  kvm -cpu host \
      -m 2048MiB \
      -hda test.vdi \
      -ctrl-grab \
      -parallel /dev/parport0 \
      -usbdevice host:13a3:0001

  ...also instead of last line I tried this one:
      -device usb-host,vendorid=3D0x13a3,productid=3D0x0001

  none of them help to properly handle my device inside guest machine.

  Only one time the Windows guest machine properly start the device so
  software for that oscilloscope can identify the Oscilloscope and
  measure for a while but unfortunately after I guess 5 seconds of
  measurement the device was disconnected from Windows and never start
  working again even after couple of restarts of guest machine even
  after plug and unplug it's USB cable and power cable.

  I searched for a solution or some clues to get it work but none of my
  searching over the internet was successful. Because device works on
  pure Windows but not work on virtualized one, I think there is a
  problem with handling not standard USB devices (like sticks,
  keyboards, mouses etc.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1511887/+subscriptions
