Received: from eggs.gnu.org ([2001:4830:134:3::10]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgz8N-0005Ik-4y
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgz8I-0001yW-Dq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:32:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cgz8I-0001yO-7M
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:32:54 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50DECC04B93A
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:32:54 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 23 Feb 2017 12:32:52 -0700
Message-ID: <20170223193048.16909.25661.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/3] VFIO updates 2017-02-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170223.0

for you to fetch changes up to c2b2e158cc7b1cb431bd6039824ec13c3184a775:

  vfio/pci-quirks.c: Disable stolen memory for igd VFIO (2017-02-22 13:19:59 -0700)

----------------------------------------------------------------
VFIO updates 2017-02-23

 - Report qdev_unplug errors (Alex Williamson)
 - Fix ecap ID 0 handling, improve comment (Alex Williamson)
 - Disable IGD stolen memory in UPT mode too (Xiong Zhang)

----------------------------------------------------------------
Alex Williamson (2):
      vfio/pci: Report errors from qdev_unplug() via device request
      vfio/pci: Improve extended capability comments, skip masked caps

XiongZhang (1):
      vfio/pci-quirks.c: Disable stolen memory for igd VFIO

 hw/vfio/pci-quirks.c | 65 ++++++++++++++++++++++++++++++----------------------
 hw/vfio/pci.c        | 37 +++++++++++++++++++++---------
 2 files changed, 64 insertions(+), 38 deletions(-)
