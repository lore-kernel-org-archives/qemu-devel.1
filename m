Received: from eggs.gnu.org ([2001:4830:134:3::10]:58407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIIAG-0004BN-2n
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIIAB-00085j-4z
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:21:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:42304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIIAA-00085P-UR
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:21:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIIA7-0007Mn-Ui
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:21:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9D0432E81A9
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 17:20:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2017 17:08:56 -0000
From: Ziemowit Pierzycki <ziemowit@pierzycki.com>
Reply-To: Bug 1696180 <1696180@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149676875833.612.2775062648799367879.malonedeb@chaenomeles.canonical.com>
Message-Id: <149676893628.8221.3722443844631828797.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1696180] Re: Issues with qemu-img, libgfapi,
 and encryption at rest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm using Fedora 24 with version:

qemu-img 2.6.2
glusterfs-api-3.8.12

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696180

Title:
  Issues with qemu-img, libgfapi, and encryption at rest

Status in QEMU:
  New

Bug description:
  Hi,

  Encryption-at-rest has been supported for some time now.  The client
  is responsible for encrypting the files with a help of a master key
  file.  I have a properly setup environment and everything appears to
  be working fine but when I use qemu-img to move a file to gluster I
  get the following:

  =

  # qemu-img convert -f raw -O raw linux.iso gluster://gluster01/virt0/linu=
x.raw
  [2017-06-06 16:52:25.489720] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_lookup+0x4e5) [0x7f30f7a36d35] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL
  [2017-06-06 16:52:25.490778] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_lookup+0x4e5) [0x7f30f7a36d35] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL
  [2017-06-06 16:52:25.492263] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_lookup+0x4e5) [0x7f30f7a36d35] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL
  [2017-06-06 16:52:25.497226] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_create+0x44d) [0x7f30f7a3cf5d] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL

  On and on until I get this message:

  [2017-06-06 17:00:03.467361] E [MSGID: 108006] [afr-common.c:4409:afr_not=
ify] 0-virt0-replicate-0: All subvolumes are down. Going offline until atle=
ast one of them comes back up.
  [2017-06-06 17:00:03.467442] E [MSGID: 108006] [afr-common.c:4409:afr_not=
ify] 0-virt0-replicate-1: All subvolumes are down. Going offline until atle=
ast one of them comes back up.

  I asked for help assuming it's a problem with glusterfs and was told
  it appears qemu-img's implementation of libgfapi doesn't call the
  xlator function correctly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1696180/+subscriptions
