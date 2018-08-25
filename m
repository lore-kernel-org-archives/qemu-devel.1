Received: from eggs.gnu.org ([2001:4830:134:3::10]:47686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ftQCj-0002Db-Gj
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 00:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ftQCe-0000jZ-Iw
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 00:29:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:41514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ftQCe-0000jA-Ck
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 00:29:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ftQCd-0005Gd-2K
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 04:29:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 041D12E8083
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 04:29:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Aug 2018 04:17:27 -0000
From: Launchpad Bug Tracker <1331859@bugs.launchpad.net>
Reply-To: Bug 1331859 <1331859@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140618233942.6989.4044.malonedeb@chaenomeles.canonical.com>
Message-Id: <153517064773.26541.12718173375363543243.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1331859] Re: QEMU kernel panic on Windows with
 arithmetic syntax error
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
https://bugs.launchpad.net/bugs/1331859

Title:
  QEMU kernel panic on Windows with arithmetic syntax error

Status in QEMU:
  Expired

Bug description:
  During attempts to bring-up QEMU 64-bit ARM support I discovered a
  kernel panics that only occur on Windows but work properly on Linux.

  The issue can be reproduced by running the following command line:

  $ ./arm-softmmu/qemu-system-arm -M versatilepb -kernel
  $IMAGES/vmlinuz-3.2.0-4-versatile -initrd
  $IMAGES/initrd.img-3.2.0-4-versatile -hda
  $IMAGES/debian_wheezy_armel_standard.qcow2 -append "root=3D/dev/sda1"

  where $IMAGES is the location where the images are downloaded from
  http://people.debian.org/~aurel32/qemu/armel/.

  This was reproduced with both a custom built QEMU as well as the QEMU
  image installed by
  http://qemu.weilnetz.de/w32/qemu_w32-setup-20140617.exe.

  The same command line runs properly on Linux using a custom built
  QEMU.

  The Windows versions of QEMU do appear to work properly using the arm-
  test images available on qemu.org.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1331859/+subscriptions
