Received: from eggs.gnu.org ([2001:4830:134:3::10]:58876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dCIW9-0004ZO-B1
	for qemu-devel@nongnu.org; Sun, 21 May 2017 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dCIW6-00055x-1e
	for qemu-devel@nongnu.org; Sun, 21 May 2017 00:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:59003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dCIW5-00055V-Ku
	for qemu-devel@nongnu.org; Sun, 21 May 2017 00:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dCIW2-0006cw-EY
	for <qemu-devel@nongnu.org>; Sun, 21 May 2017 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4EB3A2E8050
	for <qemu-devel@nongnu.org>; Sun, 21 May 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 May 2017 04:17:21 -0000
From: Launchpad Bug Tracker <877498@bugs.launchpad.net>
Reply-To: Bug 877498 <877498@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111018150547.17888.51364.malonedeb@soybean.canonical.com>
Message-Id: <149534024416.3137.13143079380537288183.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 877498] Re: qemu does not pass sector size from
 physical devices to virtual devices
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
https://bugs.launchpad.net/bugs/877498

Title:
  qemu does not pass sector size from physical devices to virtual
  devices

Status in QEMU:
  Expired

Bug description:
  When passing a physical disk (i.e. a multipathed fcal volume in my
  case) with a 4k sector size as raw image to qemu (-drive
  file=3D/dev/mapper/hartebeest-sys,if=3Dnone,id=3Ddrive-virtio-
  disk0,boot=3Don,format=3Draw), the resulting virtual device has a sector
  size of 512b, rendering the partition table unusable.

  Versions used: QEMU 0.12.5 (qemu-kvm-0.12.5) from debian unstable

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/877498/+subscriptions
