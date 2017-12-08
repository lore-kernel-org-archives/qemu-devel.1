Received: from eggs.gnu.org ([2001:4830:134:3::10]:44622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCh-0002io-Mu
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCd-0005l1-Rg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:27 -0500
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:60729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eNGCd-0005jS-Kz
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:23 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D562E924F4
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 11:48:18 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Dec 2017 11:48:07 +0100
Message-ID: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/5] 9pfs/fsdev: trivial code cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>

This series just do some cleanup to comply with the QEMU coding style.
No functional change.

--
Greg

---

Greg Kurz (5):
      virtio-9p: move unrealize/realize after virtio_9p_transport definition
      9pfs: fix XattrOperations typedef
      fsdev: fix some type definitions
      9pfs: fix some type definitions
      9pfs: handle: fix type definition


 fsdev/file-op-9p.h         |   32 +++++++++++------------
 hw/9pfs/9p-handle.c        |   48 +++++++++++++++++-----------------
 hw/9pfs/9p-xattr.h         |    5 +---
 hw/9pfs/9p.c               |    6 ++--
 hw/9pfs/9p.h               |   12 ++++-----
 hw/9pfs/virtio-9p-device.c |   62 +++++++++++++++++++++-----------------------
 hw/9pfs/xen-9p-backend.c   |    2 +
 7 files changed, 81 insertions(+), 86 deletions(-)
