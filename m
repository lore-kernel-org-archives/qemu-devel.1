Received: from eggs.gnu.org ([2001:4830:134:3::10]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYANG-0005j8-HU
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYANC-000072-Gw
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:41241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYANC-00006i-Ab
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYANA-0007Re-Eu
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:16:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 361AA2E809C
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:16:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2017 11:57:10 -0000
From: Thomas Huth <1201447@bugs.launchpad.net>
Reply-To: Bug 1201447 <1201447@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130715142153.21460.28243.malonedeb@soybean.canonical.com>
Message-Id: <150055183145.26763.2450225968465481788.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1201447] Re: Blue screen when disk uses
 cache='writeback'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1201447

Title:
  Blue screen when disk uses cache=3D'writeback'

Status in qemu package in Ubuntu:
  New

Bug description:
  I am running Windows 2008R2 as KVM guest on Ubuntu 12.04 hypervisor. Disk=
 controller and network card are virtio devices with drivers from https://l=
aunchpad.net/kvm-guest-drivers-windows/+download (virtio-win-drivers-201207=
12-1.iso).
  Everything worked fine until I changed disk controller cache from the def=
ault (writethrough) to writeback. This introduced occasional blue screens. =
I noticed that they are linked to high disk IO. For example restoring over =
1GB of backup files will results in a blue screen on around 4 out of 5 atte=
mpts. Also Windows update crashes the system sometimes. When idle the syste=
m will run fine for hours or sometimes even days.
  After removing cache=3D'writeback' from the config everything came back t=
o normal.

  qemu-kvm:
    Installed: 1.0+noroms-0ubuntu14.8
    Candidate: 1.0+noroms-0ubuntu14.8
    Version table:
   *** 1.0+noroms-0ubuntu14.8 0
          500 http://archive.ubuntu.com/ubuntu/ precise-updates/main amd64 =
Packages
          100 /var/lib/dpkg/status
       1.0+noroms-0ubuntu14.7 0
          500 http://security.ubuntu.com/ubuntu/ precise-security/main amd6=
4 Packages
       1.0+noroms-0ubuntu13 0
          500 http://archive.ubuntu.com/ubuntu/ precise/main amd64 Packages

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1201447/+subscriptions
