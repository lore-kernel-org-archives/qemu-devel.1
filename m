Received: from eggs.gnu.org ([2001:4830:134:3::10]:39294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdMP7-0008Km-Jd
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdMP3-0000dh-MP
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:35:17 -0500
Received: from indium.canonical.com ([91.189.90.7]:44135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdMP3-0000cu-GX
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:35:13 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdMP0-0004OC-Uj
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 19:35:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8704D2E80C9
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 19:35:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Feb 2017 19:25:07 -0000
From: Thomas Huth <989504@bugs.launchpad.net>
Reply-To: Bug 989504 <989504@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120427090042.27084.71596.malonedeb@gac.canonical.com>
Message-Id: <20170213192507.5447.19176.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 989504] Re: assertion failed when attaching USB
 MSD device
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
https://bugs.launchpad.net/bugs/989504

Title:
  assertion failed when attaching USB MSD device

Status in QEMU:
  Incomplete

Bug description:
  version: git rev be5ea8ed4481f0ffa4ea0f7ba13e465701536001
  commandline: qemu-system-i386 -usb -fda dosusb.img -drive if=3Dnone,id=3D=
usbstick,file=3Dusb.img -device usb-storage,bus=3Dusb.0,drive=3Dusbstick -b=
oot a -L d:\_programs\qemu

  ---------------------------
  Microsoft Visual C++ Runtime Library
  ---------------------------
  Assertion failed!

  Program: E:\qemu-system-i386.exe
  File: C:/msys/home/User/qemu/hw/usb/hcd-uhci.c
  Line: 968

  Expression: ret =3D=3D TD_RESULT_ASYNC_START

  For information on how your program can cause an assertion
  failure, see the Visual C++ documentation on asserts

  (Press Retry to debug the application - JIT must be enabled)
  ---------------------------
  Abort   Retry   Ignore   =

  ---------------------------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/989504/+subscriptions
