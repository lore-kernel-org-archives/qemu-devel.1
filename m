Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4p4G-0002cl-G0
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 10:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4p4C-00019o-GF
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 10:43:48 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:60199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f4p4C-000191-8k
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 10:43:44 -0400
Received: from player773.ha.ovh.net (unknown [10.109.105.75])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2344819F5F1
	for <qemu-devel@nongnu.org>; Sat,  7 Apr 2018 16:43:41 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 07 Apr 2018 16:43:30 +0200
Message-ID: <152311221072.203086.16767398863033055271.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/2] vfio-ccw: fix memory leak + cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

This series fixes two leaks in vfio_ccw_realize(). The v2 is basically
the same as the initial series, split in two patches: a trivial bugfix
suitable for 2.12 and stable, and a follow-up with more cleanup for
2.13.

--
Greg

---

Greg Kurz (2):
      vfio-ccw: fix memory leaks in vfio_ccw_realize()
      vfio-ccw: introduce vfio_ccw_get_device()


 hw/vfio/ccw.c |   54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)
