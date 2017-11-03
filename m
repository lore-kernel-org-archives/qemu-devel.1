Received: from eggs.gnu.org ([2001:4830:134:3::10]:57719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAVl8-0004JY-KZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAVl5-0004cP-H3
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:47:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:47862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAVl5-0004bG-Aw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 02:47:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAVl2-0000de-6V
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 06:47:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 10E632E80CC
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 06:47:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 06:32:34 -0000
From: Thomas Huth <1188018@bugs.launchpad.net>
Reply-To: Bug 1188018 <1188018@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130606060816.21214.71277.malonedeb@chaenomeles.canonical.com>
Message-Id: <150969075415.4519.15415324252587277298.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1188018] Re: qemu monitor does not suppot rbd
 "savevm" command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... has this ever been fixed? Can you still
reproduce this issue with the latest version of QEMU? Or could we close
this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1188018

Title:
  qemu monitor does not suppot rbd "savevm" command

Status in QEMU:
  Incomplete

Bug description:
  1. I used ceph rbd as my block device, /usr/local/bin/qemu-system-
  x86_64 -drive
  format=3Drbd,file=3Drbd:rbd/sles.img:rbd_cache=3Dtrue,cache=3Dwriteback -=
boot
  c  -m 1024 -enable-kvm -vnc 0.0.0.0:0 -monitor stdio

  2. when in monitor command line "savevm", it reports "Error -95 while
  writing VM" in the monitor

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1188018/+subscriptions
