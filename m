Received: from eggs.gnu.org ([2001:4830:134:3::10]:56198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d8PLh-0007EN-0k
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d8PLd-0008Hq-Uy
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:00:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:45601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d8PLd-0008HN-QW
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:00:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d8PLa-0005i7-HC
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 10:59:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7274B2E80C8
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 10:59:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 May 2017 10:47:32 -0000
From: ADMiNZ <support@adminz.us>
Reply-To: Bug 1449687 <1449687@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150428180718.24323.78355.malonedeb@wampee.canonical.com>
Message-Id: <149441325272.2336.2484916124672157031.malone@gac.canonical.com>
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

This patch does not help us. When migrating, the same drives become
thick ...

** Changed in: qemu
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1449687

Title:
  block migration of qcow2 VMs copies all empty space

Status in QEMU:
  Incomplete

Bug description:
  I'm running openstack 2012.1 'icehouse' which, ultimately, calls down
  into qemu-system-x86 2.0.0+dfsg-2ubuntu1.10.

  I primed the process by copying all necessary base images onto the
  destination host.  Nonetheless, post-migration instances are much
  larger than the original image; the copy duplicated all the empty
  space that ought to have remained copy-on-write.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1449687/+subscriptions
