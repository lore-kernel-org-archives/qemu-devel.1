Received: from eggs.gnu.org ([2001:4830:134:3::10]:40571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqGgM-0003Mi-EM
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqGgI-0001fG-GZ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:06:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:47068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqGgI-0001e6-B0
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:06:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqGgF-0003Wx-Fz
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:06:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 58ED52E80C2
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:06:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Mar 2017 09:54:54 -0000
From: Thomas Huth <877498@bugs.launchpad.net>
Reply-To: Bug 877498 <877498@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111018150547.17888.51364.malonedeb@soybean.canonical.com>
Message-Id: <20170321095454.30084.95973.malone@wampee.canonical.com>
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

QEMU 2.1 is also not supported anymore. Please test with the latest
upstream QEMU version (2.8 ... or the latest 2.9 release candidate) - or
otherwise report the bug in the bug tracker of your distribution
instead.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/877498

Title:
  qemu does not pass sector size from physical devices to virtual
  devices

Status in QEMU:
  Incomplete

Bug description:
  When passing a physical disk (i.e. a multipathed fcal volume in my
  case) with a 4k sector size as raw image to qemu (-drive
  file=3D/dev/mapper/hartebeest-sys,if=3Dnone,id=3Ddrive-virtio-
  disk0,boot=3Don,format=3Draw), the resulting virtual device has a sector
  size of 512b, rendering the partition table unusable.

  Versions used: QEMU 0.12.5 (qemu-kvm-0.12.5) from debian unstable

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/877498/+subscriptions
