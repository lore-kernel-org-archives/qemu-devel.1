Received: from eggs.gnu.org ([2001:4830:134:3::10]:36529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nim-000487-9K
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Nii-0006qH-7X
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:58654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7Nii-0006oN-1l
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7Nif-0004pM-41
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:35:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 12F3E2E8074
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:35:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 15:20:16 -0000
From: Thomas Huth <1378407@bugs.launchpad.net>
Reply-To: Bug 1378407 <1378407@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141007151141.32185.92995.malonedeb@gac.canonical.com>
Message-Id: <150894481763.17996.13710639365242816045.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1378407] Re: [feature request] Partition table
 wrapper for single-filesystem images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1378407

Title:
  [feature request] Partition table wrapper for single-filesystem images

Status in QEMU:
  New

Bug description:
  Suppose you have a single filesystem image. It would be nice if QEMU
  could generate a virtual partition table for it and make it available
  to the guest as a partitioned disk. Otherwise you have to use
  workarounds like this:
  wiki.archlinux.org/index.php/QEMU#Simulate_virtual_disk_with_MBR_using_li=
near_RAID

  It should be relatively easy to do on top of existing vvfat code.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1378407/+subscriptions
