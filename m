Received: from eggs.gnu.org ([2001:4830:134:3::10]:44871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ey90E-0004IM-6q
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ey908-000469-Vz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:36:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:37498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ey908-00045e-Q1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 00:35:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ey907-0008SI-4C
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 04:35:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1253C2E80CD
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 04:35:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Mar 2018 04:17:21 -0000
From: Launchpad Bug Tracker <1385934@bugs.launchpad.net>
Reply-To: Bug 1385934 <1385934@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141026182810.4047.56419.malonedeb@soybean.canonical.com>
Message-Id: <152151944145.32465.13809173126919772230.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1385934] Re: USB with passthrougth guest cannot
 enumerate USB host
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
https://bugs.launchpad.net/bugs/1385934

Title:
  USB with passthrougth guest cannot enumerate USB host

Status in QEMU:
  Expired

Bug description:
  Following the guide at http://www.linux-kvm.org/page/USB_Host_Device_Assi=
gned_to_Guest
  Qemu is launched with qemu-system-x86_64 /dev/vgstripe/kvm_wifi -enable-k=
vm -m 512 -k fr -net nic -net tap,ifname=3Dtap1,script=3D/bin/ifup.script -=
kernel /usr/src/linux_git/arch/x86_64/boot/bzImage -append root=3D/dev/sda =
-usb -device usb-host,hostbus=3D1,hostaddr=3D6
  The USB device does not show and USB stack seems not working
  On the guest:
  dmesg |grep -i usb
  [    1.416966] hub 1-0:1.0: USB hub found
  [    1.420431] usbcore: registered new interface driver usb-storage
  [    1.445374] usbcore: registered new interface driver usbhid
  [    1.446839] usbhid: USB HID core driver
  [    1.863226] usb 1-1: new low-speed USB device number 2 using uhci_hcd
  [    2.126173] usb 1-1: Invalid ep0 maxpacket: 64
  [    2.373161] usb 1-1: new low-speed USB device number 3 using uhci_hcd
  [    2.648112] usb 1-1: Invalid ep0 maxpacket: 64
  [    2.892404] usb 1-1: new low-speed USB device number 4 using uhci_hcd
  [    2.913001] usb 1-1: Invalid ep0 maxpacket: 64
  [    3.161367] usb 1-1: new low-speed USB device number 5 using uhci_hcd
  [    3.180070] usb 1-1: Invalid ep0 maxpacket: 64
  [    3.181633] usb usb1-port1: unable to enumerate USB device
  lsusb
  Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

  On the host:
  lsusb
  Bus 001 Device 006: ID 0457:0163 Silicon Integrated Systems Corp. SiS163U=
 802.11 Wireless LAN Adapter
  qemu-system-x86_64 --version
  QEMU emulator version 2.1.2, Copyright (c) 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1385934/+subscriptions
