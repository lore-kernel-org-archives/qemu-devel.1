Received: from eggs.gnu.org ([2001:4830:134:3::10]:36535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flK5N-0003l5-H0
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 16:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flK5K-0005yW-BJ
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 16:20:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:56406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1flK5K-0005yB-2k
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 16:20:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1flK5I-0002qS-LO
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 20:20:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 999FC2E80C7
	for <qemu-devel@nongnu.org>; Thu,  2 Aug 2018 20:20:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Aug 2018 20:11:53 -0000
From: Hans <zem@fnordpol.de>
Reply-To: Bug 1784919 <1784919@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153314732349.28680.8240678335924309425.malonedeb@chaenomeles.canonical.com>
Message-Id: <153324071356.31734.771721768222461752.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1784919] Re: native libgfapi glusterfs support
 for virtio 9p filesystem passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Tags added: whishlist

** Tags removed: whishlist
** Tags added: wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1784919

Title:
  native libgfapi  glusterfs support for virtio 9p filesystem
  passthrough

Status in QEMU:
  New

Bug description:
  I can add block devices on glusterfs natively to my virtual machines sinc=
e qemu 1.3 =

  I would like to see the same feature for virtio 9p filesystems added on m=
y VM. =


  Accessing a filesystem mounted on the Metal is my favorite solution
  for storage that is to be shared between more than one VM. But because
  my VMs are not running as root, they are not able to passthrough
  userids and gids to gluster-fuse. uid mapping is also not possible
  because no xattr support.

  So all I can do is either setting up seperate NFS Servers to bring the
  Filesystem in via Network, or to start qemu as root or to add
  fuse_xattr on top of glusterfs_fuse. I do expect however that the
  fastest and most relieable solution is to make something like this
  possible:

  -fsdev
  local,id=3Dtest_dev,path=3Dgluster://this.node/test_mount,security_model=
=3Dpassthrough
  -device virtio-9p-pci,fsdev=3Dtest_dev,mount_tag=3Dtest_mount

  regards

      Hans

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1784919/+subscriptions
