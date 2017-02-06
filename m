Received: from eggs.gnu.org ([2001:4830:134:3::10]:35354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caawQ-00012g-HM
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caawM-0007qe-OS
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:30:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:54062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caawM-0007pH-Go
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:30:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caawJ-0000aZ-VV
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 04:30:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A46872E80C3
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 04:30:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Feb 2017 04:17:28 -0000
From: Launchpad Bug Tracker <498417@bugs.launchpad.net>
Reply-To: Bug 498417 <498417@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20091219045751.13510.70467.malonedeb@gangotri.canonical.com>
Message-Id: <20170206041728.23021.40486.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 498417] Re: cache=writeback on disk image doesn't
 do write-back
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
https://bugs.launchpad.net/bugs/498417

Title:
  cache=3Dwriteback on disk image doesn't do write-back

Status in QEMU:
  Expired

Bug description:
  I noticed that qemu seems to have poor disk performance.  Here's a
  test that has miserable performance but which should be really fast:

  - Configure qemu to use the disk image with cache=3Dwriteback
  - Configure a 2GiB Linux VM on an 8GiB Linux host
  - In the VM, write a 4GiB file (dd if=3D/dev/zero of=3D/tmp/x bs=3D4K cou=
nt=3D1M)
  - In the VM, read it back (dd if=3D/tmp/x of=3D/dev/null bs=3D4K count=3D=
1M)

  With writeback, the whole file should end up in the host pagecache.
  So when I read it back, there should be no I/O to the real disk, and
  it should be really fast.  Instead, I see disk activity through the
  duration of the test, and the performance is roughly the native hard
  disk throughput (somewhat slower).

  I'm using version 0.11.1, and this is my command line:

  qemu-system-x86_64 -drive
  cache=3Dwriteback,index=3D0,media=3Ddisk,file=3Dubuntu.img -k en-us -m 20=
48
  -smp 2 -vnc :3100 -usbdevice tablet -enable-kvm &

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/498417/+subscriptions
