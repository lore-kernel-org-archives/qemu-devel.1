Received: from eggs.gnu.org ([2001:4830:134:3::10]:57957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dQyPc-0005I2-Mk
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dQyPX-0004yk-PH
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dQyPX-0004wO-J3
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B25A9C0587C1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 16:04:42 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 30 Jun 2017 18:04:20 +0200
Message-Id: <20170630160422.14842-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] vhost-user: fix crashes on disconnect when
 iommu is on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This two patches series aims at fixing a couple of crashes
that happens when the vhost-user socket is closed and iommu
enabled.

Maxime Coquelin (2):
  vhost: ensure vhost_ops are set before calling iotlb callback
  vhost-user: unregister slave req handler at cleanup time

 hw/virtio/vhost-backend.c | 10 ++++++++--
 hw/virtio/vhost-user.c    |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.9.4
