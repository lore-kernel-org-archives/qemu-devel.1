Received: from eggs.gnu.org ([2001:4830:134:3::10]:53132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fn6Cc-0007e0-MB
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fn6CZ-0002PA-9O
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:55:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:37580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fn6CZ-0002In-0e
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:55:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fn6CW-0000Vf-Vw
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 17:55:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C21E72E80CD
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 17:55:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Aug 2018 17:43:12 -0000
From: Thomas Huth <1483070@bugs.launchpad.net>
Reply-To: Bug 1483070 <1483070@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150810001525.6231.66973.malonedeb@gac.canonical.com>
Message-Id: <153366379234.3443.2579726964190926825.malone@wampee.canonical.com>
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

Has this issue ever been fixed? If not, is there still interest in
fixing it? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1483070

Title:
  VIRTIO Sequential Write IOPS limits not working

Status in QEMU:
  Incomplete

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
