Received: from eggs.gnu.org ([2001:4830:134:3::10]:34092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzDqD-0002Zh-9H
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fzDqA-0001AH-UC
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:51126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fzDqA-00013I-IM
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fzDq1-0005ip-2e
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 04:30:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0EE722E80C7
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 04:30:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Sep 2018 04:17:17 -0000
From: Launchpad Bug Tracker <1476183@bugs.launchpad.net>
Reply-To: Bug 1476183 <1476183@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150720101804.20267.90084.malonedeb@soybean.canonical.com>
Message-Id: <153655303909.11513.15375879031150778234.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1476183] Re: can not create 4 serial port on
 window (guest os)
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
https://bugs.launchpad.net/bugs/1476183

Title:
  can not create 4 serial port on window (guest os)

Status in QEMU:
  Expired

Bug description:
  qemu ver: 2.1.2-Latest

  guest os: window 7 64bit with 2 cpu

  problem: when qemu start with 4 serial port, on linux(rhel 7) guest
  os, /dev/ttyS0-4 is work fine.  but on window 7 guest os, only show
  com1,com2 in device manager, how to get com3 & com4 ?

  qemu cmd:
   -chardev spiceport,id=3Dcharserial0,name=3Dorg.qemu.console.serial.0
   -device isa-serial,chardev=3Dcharserial0,id=3Dserial0
   -chardev spiceport,id=3Dcharserial1,name=3Dorg.qemu.console.serial.1
   -device isa-serial,chardev=3Dcharserial1,id=3Dserial1
   -chardev spiceport,id=3Dcharserial2,name=3Dorg.qemu.console.serial.2
   -device isa-serial,chardev=3Dcharserial2,id=3Dserial2
   -chardev spiceport,id=3Dcharserial3,name=3Dorg.qemu.console.serial.3
   -device isa-serial,chardev=3Dcharserial3,id=3Dserial3

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1476183/+subscriptions
