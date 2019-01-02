Received: from eggs.gnu.org ([208.118.235.92]:49205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1geeGe-00069l-LN
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1geeGZ-0007iN-PC
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:00:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:59824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1geeGZ-0007hX-JG
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:00:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1geeGY-00087z-Dj
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 11:00:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 64FC82E80C7
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 11:00:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jan 2019 10:53:57 -0000
From: Thomas Huth <1809665@bugs.launchpad.net>
Reply-To: Bug 1809665 <1809665@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154566626385.25910.12711983515604457304.malonedeb@chaenomeles.canonical.com>
Message-Id: <154642643767.24519.10955671248068508181.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809665] Re: Xbox One controller USB passthrough
 disconnections and stops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Do you get a different behavior if you use "-device usb-ehci" or
"-device nec-usb-xhci" instead of the "-usb" parameter?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809665

Title:
  Xbox One controller USB passthrough disconnections and stops

Status in QEMU:
  New

Bug description:
  I can't properly passthrough my Xbox One controller to a virtual
  machine; it causes USB disconnections on the host, ultimately
  preventing it to work (at all) on the guest

  I've seen a few other cases reported in other websites, which show the
  same symptoms:

  - https://www.reddit.com/r/VFIO/comments/97dhbw/qemu_w10_xbox_one_control=
ler
  - https://unix.stackexchange.com/questions/452751/how-can-i-pass-through-=
an-xbox-one-controller-to-a-windows-vm-on-ubuntu

  This is sample:

      libusb: error [udev_hotplug_event] ignoring udev action bind
      qemu-system-x86_64: libusb_release_interface: -4 [NO_DEVICE]
      qemu-system-x86_64: libusb_release_interface: -4 [NO_DEVICE]
      qemu-system-x86_64: libusb_release_interface: -4 [NO_DEVICE]
      libusb: error [_get_usbfs_fd] File doesn't exist, wait 10 ms and try =
again
      libusb: error [_get_usbfs_fd] libusb couldn't open USB device
          /dev/bus/usb/003/016: No such file or directory

  I think this is a quite long-standing issue, as I've been experiencing
  through several versions, including the current one (3.1).

  I can reproduce this 100% of the times, on multiple host O/S
  distributions (the current one being based on Ubuntu 18.04 x86-64).

  I compile QEMU directly from source, and execute it via commandline;
  the command is very long, however, the relevant part is standard (I
  think):

      -usb \
      -device usb-tablet \
      -device usb-host,vendorid=3D0x$VGAPT_XBOX_PAD_VEND_ID,productid=3D0x$=
VGAPT_XBOX_PAD_PROD_ID \

  The guest is Windows 10 64bit.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809665/+subscriptions
