Received: from eggs.gnu.org ([2001:4830:134:3::10]:39486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGO2s-0001tw-2c
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGO2o-0005mD-QZ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:41:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:57695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cGO2o-0005lU-Kp
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:41:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cGO2m-0003FK-NG
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:41:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 877042E80CC
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:41:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Dec 2016 10:28:28 -0000
From: Tom Yan <tom.ty89@gmail.com>
Reply-To: Bug 1649233 <1649233@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161212101630.16736.48530.malonedeb@soybean.canonical.com>
Message-Id: <20161212102829.25771.81731.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1649233] Re: scrolling does not work once mouse
 is grabbed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Not sure if it is relevant, but there's a HID button device cannot get
started in Windows 10 RS1.

** Attachment added: "Capture.PNG"
   https://bugs.launchpad.net/qemu/+bug/1649233/+attachment/4790624/+files/=
Capture.PNG

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1649233

Title:
  scrolling does not work once mouse is grabbed

Status in QEMU:
  New

Bug description:
  The title pretty much told it all. It occurs in Windows 10 RS1 on qemu
  2.7.0. Interestingly, I can scroll in the guest if the mouse is not
  grabbed. So using usb-tablet sort of works around it, but if I
  explicitly grab the mouse with Ctrl+Alt+G, scrolling will also stop
  working.

  The host is Arch Linux so the qemu build uses gtk(3) for GUI by
  default. I wanted to test with sdl but it seems sdl support in qemu is
  sort of broken that I can't even start the virtual machine properly
  with that.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649233/+subscriptions
