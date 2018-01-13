Received: from eggs.gnu.org ([2001:4830:134:3::10]:41247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eaDSF-0007ju-7D
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 23:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eaDSC-000056-2c
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 23:30:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eaDSB-0008WO-S6
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 23:29:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eaDS9-0006AZ-DB
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 04:29:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C8AB12E867C
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 04:29:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jan 2018 04:17:16 -0000
From: Launchpad Bug Tracker <1449687@bugs.launchpad.net>
Reply-To: Bug 1449687 <1449687@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150428180718.24323.78355.malonedeb@wampee.canonical.com>
Message-Id: <151581703810.16027.126153189721903655.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1449687] Re: block migration of qcow2 VMs copies
 all empty space
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
https://bugs.launchpad.net/bugs/1449687

Title:
  block migration of qcow2 VMs copies all empty space

Status in QEMU:
  Expired

Bug description:
  I'm running openstack 2012.1 'icehouse' which, ultimately, calls down
  into qemu-system-x86 2.0.0+dfsg-2ubuntu1.10.

  I primed the process by copying all necessary base images onto the
  destination host.  Nonetheless, post-migration instances are much
  larger than the original image; the copy duplicated all the empty
  space that ought to have remained copy-on-write.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1449687/+subscriptions
