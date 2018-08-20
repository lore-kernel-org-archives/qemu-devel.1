Received: from eggs.gnu.org ([2001:4830:134:3::10]:47006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1frc3m-0006Vh-TC
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 00:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1frbxU-0004XN-62
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 00:38:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:60702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1frbxU-0004Wt-1H
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 00:38:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1frbxQ-0007CX-Kd
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 04:38:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7F66E2E87E5
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 04:38:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Aug 2018 04:20:43 -0000
From: Launchpad Bug Tracker <1470481@bugs.launchpad.net>
Reply-To: Bug 1470481 <1470481@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150701120650.14797.87262.malonedeb@wampee.canonical.com>
Message-Id: <153473884349.13847.13471802518829423098.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1470481] Re: qemu-img converts large vhd files
 into only approx. 127GB raw file causing the VM to crash
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
https://bugs.launchpad.net/bugs/1470481

Title:
  qemu-img converts large vhd files into only approx. 127GB raw file
  causing the VM to crash

Status in QEMU:
  Expired

Bug description:
  I have a VHD file for Windows 2014 server OS. I use the following
  command to convert VHD file (20GB) to a RAW file for KVM.

  qemu-img convert -f vpc -O raw WIN-SNRGCQV6O3O.VHD disk.img

  The output file is about 127GB. When install the VM and boot it up,
  the OS crashes with STOP error after the intial screen. I found on the
  internet that the file limit of 127GB is an existing bug. Kindly fix
  the problem. The workaround to use a Hyper-V to convert to fixed disk
  is not a feasible solution.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1470481/+subscriptions
