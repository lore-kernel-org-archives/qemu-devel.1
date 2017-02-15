Received: from eggs.gnu.org ([2001:4830:134:3::10]:55190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdrEa-0000EI-VP
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 23:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdrEX-0004zW-Qe
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 23:30:28 -0500
Received: from indium.canonical.com ([91.189.90.7]:34473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdrEX-0004xr-LC
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 23:30:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdrEW-0004tI-GD
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 04:30:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 757642E80C7
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 04:30:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Feb 2017 04:17:31 -0000
From: Launchpad Bug Tracker <906221@bugs.launchpad.net>
Reply-To: Bug 906221 <906221@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111219101920.8813.57045.malonedeb@wampee.canonical.com>
Message-Id: <20170215041731.9002.14989.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 906221] Re: USBDEVFS_CLEAR_HALT stall with
 USB-CDROM qemu-1.0
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
https://bugs.launchpad.net/bugs/906221

Title:
  USBDEVFS_CLEAR_HALT stall with USB-CDROM qemu-1.0

Status in QEMU:
  Expired

Bug description:
  When connecting a USB DVD/CDROM drive to the linux host, it works fine an=
d I can mount the inserted DVD properly and work with it. After unmounting =
the DVD and routing the USB drive to the linux guest (same kernel version),=
 both host and guest become unresponsive and on the QEMU console I get the =
QEMU console flodded with the message:
  USBDEVFS_CLEAR_HALT: Connection timed out
  again and again, approx. each 10-20 seconds.

  When I unplug the device from the host, the message
  USBDEVFS_CLEAR_HALT: No such device
  comes up in one block at least 100 times (my scrollback history of the di=
splay is limited, so I cannot say how often it actually appreared)

  On the guest side linux, I see the following dmesg after having it routed=
 from the host to the guest:
  [  160.292231] usb 1-2.1: new full speed USB device using uhci_hcd and ad=
dress 5
  [  160.475762] usb 1-2.1: configuration #1 chosen from 1 choice
  [  160.478553] scsi3 : SCSI emulation for USB Mass Storage devices
  [  160.479689] usb-storage: device found at 5
  [  160.480121] usb-storage: waiting for device to settle before scanning
  [  165.494016] scsi 3:0:0:0: CD-ROM            slimtype  eTDU108   1     =
SL03 PQ: 0 ANSI: 0

  then, the guest stalls and on the host side the USBDEVFS_CLEAR_HALT
  appears until I unplug the hardware from the host - pay also attention
  on the stalled dmesg timestamp! The "real" timegap between the last
  line above and the first line below is more than 20 seconds!

  [  165.645735] usb 1-2.1: USB disconnect, address 5
  [  165.663770] sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda pop-up
  [  165.664416] sr 3:0:0:0: Attached scsi CD-ROM sr0
  [  165.664623] sr 3:0:0:0: Attached scsi generic sg1 type 5
  [  165.665565] usb-storage: device scan complete

  The drive used is a self-powered LITEON External Slim DVD-ROM Drive (Mode=
l number eTDU108-02 1)
  The power is not a problem, because the drive works fine on the host dire=
ctly.

  Best regards,

  Erik

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/906221/+subscriptions
