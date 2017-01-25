Received: from eggs.gnu.org ([2001:4830:134:3::10]:46223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWJhU-0004NA-3D
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWJhQ-0003Zb-VM
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:17:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:53022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cWJhQ-0003ZO-NE
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:17:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cWJhP-0003K3-Us
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:17:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E77D62E8060
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:17:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jan 2017 09:04:26 -0000
From: Thomas Huth <1242765@bugs.launchpad.net>
Reply-To: Bug 1242765 <1242765@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131021155451.28203.66085.malonedeb@gac.canonical.com>
Message-Id: <20170125090426.12178.65016.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1242765] Re: USB passthrough to Windows 7 guest
 fails with error -110, hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU, or
could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1242765

Title:
  USB passthrough to Windows 7 guest fails with error -110, hangs

Status in QEMU:
  Incomplete

Bug description:
  Description of problem:

  Using a Sandisk Cruzer Fit 16GB USB thumb drive.
  Using virt-manager on Fedora 19 host, and Windows 7 32 bit guest.

  I set up a USB2 controller on Windows 7 guest in virt-manager. Windows
  sees the USB drive and can open the file manager and correctly show
  the files. I can copy a file from the thumb drive to the Fedora
  desktop, and then play the file on the desktop. However, any attempt
  to open a file directly on the thumb drive (example, play an MP3 using
  Windows Media Player) results in guest hang and host kernel messages:

  =

  Oct 19 21:15:35 localhost kernel: [187592.977839] usb 1-1.3: reset high-s=
peed USB device number 13 using ehci-pci
  Oct 19 21:15:40 localhost kernel: [187598.065274] usb 1-1.3: device descr=
iptor read/all, error -110
  Oct 19 21:15:40 localhost kernel: [187598.138167] usb 1-1.3: reset high-s=
peed USB device number 13 using ehci-pci
  Oct 19 21:15:56 localhost kernel: [187613.218119] usb 1-1.3: device descr=
iptor read/64, error -110
  Oct 19 21:16:11 localhost kernel: [187628.399275] usb 1-1.3: device descr=
iptor read/64, error -110
  Oct 19 21:16:11 localhost kernel: [187628.573355] usb 1-1.3: reset high-s=
peed USB device number 13 using ehci-pci
  Oct 19 21:16:16 localhost kernel: [187633.587778] usb 1-1.3: device descr=
iptor read/8, error -110
  Oct 19 21:16:21 localhost kernel: [187638.702244] usb 1-1.3: device descr=
iptor read/8, error -110
  Oct 19 21:16:21 localhost kernel: [187638.876201] usb 1-1.3: reset high-s=
peed USB device number 13 using ehci-pci
  Oct 19 21:16:26 localhost kernel: [187643.890642] usb 1-1.3: device descr=
iptor read/8, error -110
  Oct 19 21:16:31 localhost kernel: [187649.005071] usb 1-1.3: device descr=
iptor read/8, error -110
  Oct 19 21:16:31 localhost kernel: [187649.106188] usb 1-1.3: USB disconne=
ct, device number 13
  Oct 19 21:16:31 localhost kernel: [187649.178969] usb 1-1.3: new high-spe=
ed USB device number 14 using ehci-pci
  Oct 19 21:16:47 localhost kernel: [187664.258945] usb 1-1.3: device descr=
iptor read/64, error -110
  Oct 19 21:17:02 localhost kernel: [187679.440092] usb 1-1.3: device descr=
iptor read/64, error -110
  Oct 19 21:17:02 localhost kernel: [187679.614194] usb 1-1.3: new high-spe=
ed USB device number 15 using ehci-pci
  Oct 19 21:17:17 localhost kernel: [187694.694148] usb 1-1.3: device descr=
iptor read/64, error -110
  Oct 19 21:17:32 localhost kernel: [187709.875297] usb 1-1.3: device descr=
iptor read/64, error -110
  Oct 19 21:17:32 localhost kernel: [187710.049386] usb 1-1.3: new high-spe=
ed USB device number 16 using ehci-pci
  Oct 19 21:17:37 localhost kernel: [187715.063803] usb 1-1.3: device descr=
iptor read/8, error -110
  Oct 19 21:17:41 localhost kernel: [187719.005453] usb 1-1.3: device descr=
iptor read/8, error -71

  After that -71 error, the thumb drive completely disappears from the
  host, as if it is powered down.

  I read that -110 is supposedly a power issue. I can play media files
  directly from the thumb drive on the host, so the power seems fine on
  the host.

  =

  How reproducible:
  always

  =

  Steps to reproduce:
  1. use virt-manager, create a Windows 7 32 bit guest
  2. in virt-manager, set Controller USB to USB2
  3. on host, insert Sandisk Cruser Fit thumb drive FAT32 format, with an M=
P3 file on it
  4. in virt-manager, add a USB passthrough device and assign it to thumb d=
rive
  5. boot Windows 7 guest
  6. verify that Windows 7 can see the thumb drive
  7. use Windows Media Player to play MP3

  Actual results:
  guest hangs, then host powers off thumb drive

  Expected results:
  The MP3 file should play :)

  =

  Additional info:

  Fedora 19

  Installed Packages
  qemu-common.x86_64                                                2:1.4.2=
-11.fc19                                           @updates
  qemu-guest-agent.x86_64                                           2:1.4.2=
-11.fc19                                           @updates
  qemu-img.x86_64                                                   2:1.4.2=
-11.fc19                                           @updates
  qemu-kvm.x86_64                                                   2:1.4.2=
-11.fc19                                           @updates
  qemu-system-x86.x86_64                                            2:1.4.2=
-11.fc19                                           @updates
  virt-manager.noarch                                              0.10.0-3=
.fc19                                              @updates
  kernel.x86_64                                      3.11.1-200.fc19       =
                               @updates

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1242765/+subscriptions
