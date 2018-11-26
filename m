Received: from eggs.gnu.org ([2001:4830:134:3::10]:47125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRKFW-0002sd-4O
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gRKFR-0008K2-E5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:00:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:55012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gRKFR-0008Iu-73
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:00:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gRKFQ-0000vg-7B
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 17:00:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2BFEB2E80BA
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 17:00:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Nov 2018 16:44:04 -0000
From: tinywrkbee <1592351@bugs.launchpad.net>
Reply-To: Bug 1592351 <1592351@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160614104554.31869.91941.malonedeb@soybean.canonical.com>
Message-Id: <154325064494.16264.16475071947589679333.malone@gac.canonical.com>
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

seems to be fixed with f1aba960cc40ab65fa88c8678883bd2201708c55 :
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Df1aba960cc40ab65fa88c8678=
883bd2201708c55


anyone else can confirm, i have another issue affecting scaling with my set=
up.

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
