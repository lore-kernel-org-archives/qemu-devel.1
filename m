Received: from eggs.gnu.org ([2001:4830:134:3::10]:44474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drHgK-0003bl-Hm
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drHgF-0005Mn-LY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:54:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:52563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1drHgF-0005Mb-Ev
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:54:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1drHgD-0008HA-FZ
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 05:54:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 67DB02E8492
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 05:54:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Sep 2017 05:40:23 -0000
From: Thomas Huth <1119861@bugs.launchpad.net>
Reply-To: Bug 1119861 <1119861@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130208231600.11384.57636.malonedeb@chaenomeles.canonical.com>
Message-Id: <150510842413.31851.15733631615351376950.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1119861] Re: Poor console performance in Windows 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1119861

Title:
  Poor console performance in Windows 7

Status in QEMU:
  Fix Released

Bug description:
  As part of its conformance test suite, Wine tests the behavior of the
  Windows console API. Part of this test involves opening a test console
  and scrolling things around. The test probably does not need to
  perform that many scroll operations to achieve its goal. However as is
  it illustrates a significant performance issue in QEmu. Unfortunately
  it does so by timing out (the tests must run in less than 2 minutes).
  Here are the run times on a few configurations:

   10s - QEmu 1.4 + Q9450@2.6GHz + Windows XP + QXL + QXL driver
    8s - QEmu 1.12 + Opteron 6128 + Windows XP + QXL + QXL driver
  127s - QEmu 1.12 + Opteron 6128 + Windows 7 + cirrus + vga driver
  127s - QEmu 1.12 + Opteron 6128 + Windows 7 + QXL + QXL driver
  147s - QEmu 1.12 + Opteron 6128 + Windows 7 + vmvga + vga driver
  145s - QEmu 1.12 + Opteron 6128 + Windows 7 + vmvga + vmware driver (xpdm=
, no better with all graphics effects disabled)

   10s - Metal + Atom N270 + Windows XP + GMA 950 + Intel driver
    6s - Metal + i5-3317U + Windows 8 + HD4000 + Intel driver
    3s - VMware + Q9450@2.6GHz + Windows XP + vmvga + vmware driver
   65s - VMware + Q9450@2.6GHz + Windows 7 + vmvga + vmware driver

  So when running on the bare metal all versions of Windows are about as
  fast. However in QEmu Windows 7 is almost 16 times slower than Windows
  XP! VMware is impacted too but it's still maintains a good lead in
  performance.

  Disabling all graphics effects did not help so it's not clear that the
  fault lies with Windows 7's compositing desktop window manager. Maybe
  it has to do with the lack of a proper wddm driver?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1119861/+subscriptions
