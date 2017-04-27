Received: from eggs.gnu.org ([2001:4830:134:3::10]:45641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3luL-0000OS-Hi
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3luI-0003Uk-95
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:04:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:33874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3luI-0003UN-2w
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:04:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3luH-0000nO-4B
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 16:04:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16D832E802D
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 16:04:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:51:32 -0000
From: undefined <1592351@bugs.launchpad.net>
Reply-To: Bug 1592351 <1592351@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160614104554.31869.91941.malonedeb@soybean.canonical.com>
Message-Id: <20170427155132.2834.71240.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1592351] Re: mouse pointer offset with gtk, gl=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Mouse still doesn't work properly with 2.9.0 and Ubuntu 17.04 guest
-smp 2 -enable-kvm -vga virtio -display gtk,gl=3Don -m 2048 -cdrom ubuntu-1=
7.04-desktop-amd64.iso

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1592351

Title:
  mouse pointer offset with gtk,gl=3Don

Status in QEMU:
  Confirmed

Bug description:
  When I turn gl=3Don for -display gtk, some Y offset is added to the
  mouse pointer coordinates. That is, when I click on an icon, an icon
  _above_ the one I clicked triggers.

  Using xev, it seems to be offset of 10-12 pixels.

  It happens with all ps/2 mouse, -usbdevice mouse and -usbdevice
  tablet.

  Without gl=3Don, the pointer is precise.

  I have these qemu versions:
  qemu-2.6.0-470.2.x86_64
  qemu-ipxe-1.0.0-470.2.noarch
  qemu-ksm-2.6.0-470.2.x86_64
  qemu-kvm-2.6.0-470.2.x86_64
  qemu-ovmf-x86_64-2015+git1462940744.321151f-2.1.noarch
  qemu-ppc-2.6.0-470.2.x86_64
  qemu-seabios-1.9.1-470.2.noarch
  qemu-sgabios-8-470.2.noarch
  qemu-tools-2.6.0-470.2.x86_64
  qemu-vgabios-1.9.1-470.2.noarch
  qemu-x86-2.6.0-470.2.x86_64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1592351/+subscriptions
