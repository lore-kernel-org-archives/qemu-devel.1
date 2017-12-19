Received: from eggs.gnu.org ([2001:4830:134:3::10]:56932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRLK6-0003Jd-9p
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRLJx-0001pe-5q
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:04:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:46696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRLJw-0001mv-MY
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:04:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRLJv-0001wW-Ox
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:04:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B855D2E80C0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 17:04:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2017 16:52:27 -0000
From: Thomas Huth <1299566@bugs.launchpad.net>
Reply-To: Bug 1299566 <1299566@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140329195606.5581.53950.malonedeb@chaenomeles.canonical.com>
Message-Id: <151370234796.11277.9804871042474363559.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1299566] Re: virtio serial doesn't work with
 virtio nic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1299566

Title:
  virtio serial doesn't work with virtio nic

Status in QEMU:
  Incomplete

Bug description:
  If virtio NIC is not used virtserialport works and delivers data
  written to /dev/vport0p1 to localhost:4444:

  qemu-system-x86_64 -enable-kvm -kernel mykernel -initrd myramdisk
  -device virtio-serial -chardev
  socket,host=3Dlocalhost,port=3D4444,id=3Dagent -device
  virtserialport,chardev=3Dagent,name=3Dhera.agent -net user -net nic

  If using virtio nic, write to /dev/vport0p1 succeeds, but no data is
  delivered to localhost:4444:

  qemu-system-x86_64 -enable-kvm -kernel mykernel -initrd myramdisk
  -device virtio-serial -chardev
  socket,host=3Dlocalhost,port=3D4444,id=3Dagent -device
  virtserialport,chardev=3Dagent,name=3Dhera.agent -net user -net
  nic,model=3Dvirtio

  This bug exists in 2.0 release, Debian's QEMU 1.7 package and b3706faf
  from git.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1299566/+subscriptions
