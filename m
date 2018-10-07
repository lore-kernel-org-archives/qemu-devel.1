Received: from eggs.gnu.org ([2001:4830:134:3::10]:53683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g90hx-0007VU-MM
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 00:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g90hu-0005D9-IL
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 00:30:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:34592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g90hs-000576-Qm
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 00:30:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g90hr-0007vX-51
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:30:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 239222E80C8
	for <qemu-devel@nongnu.org>; Sun,  7 Oct 2018 04:30:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Oct 2018 04:17:40 -0000
From: Launchpad Bug Tracker <1483070@bugs.launchpad.net>
Reply-To: Bug 1483070 <1483070@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150810001525.6231.66973.malonedeb@gac.canonical.com>
Message-Id: <153888586104.11197.10800553753481619485.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1483070] Re: VIRTIO Sequential Write IOPS limits
 not working
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
https://bugs.launchpad.net/bugs/1483070

Title:
  VIRTIO Sequential Write IOPS limits not working

Status in QEMU:
  Expired

Bug description:
  Root Problem:
  IOPS limit does not work for VIRTIO devices if the disk workload is a seq=
uential write.

  To confirm:
  IDE disk devices - the IOPS limit works fine. Disk transfer speed limit w=
orks fine.
  VIRTIO disk devices - the IOPS limit works fine for random IO (write/read=
) and sequential read, but not for sequential write. Disk transfer speed li=
mits work fine.

  Tested on Windows 7,10 and 2k12 (Fedora drivers used and here is the twis=
t):
  virtio-win-0.1.96 (stable) or older won't limit write IO if workload is s=
equential.
  virtio-win-0.1.105 (latest) or newer will limit but I have had two test m=
achines crash when under high workload using IOPS limit.

  For Linux:
  The issue is also apparent, tested on Ubuntu 14.04

  On the hypervisor (using KVM) machine I have tried with Qemu 2.1.2
  (3.16.0-4-amd64 - Debian 8) and Qemu 2.3.0 (3.19.8-1-pve - Proxmox 3.4
  and 4) using multiple machines but all are 64bit intel.

  Even though the latest VIRTIO guest drivers fix the problem, the guest
  drivers shouldn't be able to ignore the limits the host puts in place
  or am I missing something??

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1483070/+subscriptions
