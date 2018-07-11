Received: from eggs.gnu.org ([2001:4830:134:3::10]:43919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fd9VU-0007Ls-6B
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fd9VQ-0006GE-O6
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:49468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fd9VQ-0006Eb-HU
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fd9VP-0002Pf-Hi
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7DDD42E80CB
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jul 2018 07:11:43 -0000
From: Thomas Huth <1476183@bugs.launchpad.net>
Reply-To: Bug 1476183 <1476183@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150720101804.20267.90084.malonedeb@soybean.canonical.com>
Message-Id: <153129310365.32055.4233544127097042844.malone@wampee.canonical.com>
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU and Windows? Or could we close this
ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1476183

Title:
  can not create 4 serial port on window (guest os)

Status in QEMU:
  Incomplete

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
