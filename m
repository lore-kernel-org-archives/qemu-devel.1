Received: from eggs.gnu.org ([2001:4830:134:3::10]:36983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1co7Q2-0006ZK-Qy
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1co7Q1-0003oR-Iz
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1co7Q1-0003nX-Dd
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:41 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACA38342C4D
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:48:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Mar 2017 19:48:29 +0800
Message-Id: <1489578512-14031-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 0/3] Several fixes for virtio region caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Hi:

This series contains several fixes for virtio region caches, please
review.

Thakns

Jason Wang (3):
  virtio: guard against NULL pfn
  virtio: destroy region cache during reset
  virtio: validate address space cache during init

 hw/virtio/virtio.c | 104 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 21 deletions(-)

-- 
2.7.4
