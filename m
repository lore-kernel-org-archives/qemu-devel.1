Received: from eggs.gnu.org ([2001:4830:134:3::10]:59165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gAFoS-0003bs-Dh
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gAFoO-0005Jz-Bz
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:50:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:55026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gAFoO-0005HT-5d
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:50:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gAFoN-0006Bc-8k
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:50:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3CEF02E804E
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:50:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Oct 2018 14:31:46 -0000
From: Afsah Anwar <1481272@bugs.launchpad.net>
Reply-To: Bug 1481272 <1481272@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150804095638.25012.1470.malonedeb@chaenomeles.canonical.com>
Message-Id: <153918190683.8753.843092496754845625.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1481272] Re: main-loop: WARNING: I/O thread spun
 for 1000 iterations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I see the same issue with qemu version 2.5.0 (Debian 1:2.5+dfsg-
5ubuntu10.31).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1481272

Title:
  main-loop: WARNING: I/O thread spun for 1000 iterations

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  Won't Fix
Status in qemu source package in Artful:
  Fix Released
Status in qemu source package in Bionic:
  Fix Released

Bug description:
  I compile the latest qemu to launch a VM but the monitor output the
  "main-loop: WARNING: I/O thread spun for 1000 iterations".

  # /usr/local/bin/qemu-system-x86_64 -name rhel6 -S -no-kvm -m 1024M -real=
time mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid c9dd2a5c-40=
f2-fd3d-3c54-9cd84f8b9174 -rtc base=3Dutc  -drive file=3D/home/samba-share/=
ubuntu.img,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnone -d=
evice virtio-blk-pci,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=
=3Ddisk,serial=3D425618d4-871f-4021-bc5d-bcd7f1b5ca9c,bootindex=3D0 -vnc :1=
 -boot menu=3Don -monitor stdio
  QEMU 2.3.93 monitor - type 'help' for more information
  (qemu) c
  (qemu) main-loop: WARNING: I/O thread spun for 1000 iterations           =
    <-----------------------

  qemu]# git branch -v
  * master               e95edef Merge remote-tracking branch 'remotes/ssta=
bellini/tags/xen-migration-2.4-tag' into staging

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1481272/+subscriptions
