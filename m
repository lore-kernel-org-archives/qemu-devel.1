Received: from eggs.gnu.org ([2001:4830:134:3::10]:34827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Dp-0004ah-5f
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Dn-00047i-1g
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:44:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ej8Dm-00047P-Rq
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:43:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08BBCC0587DC
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 18:43:58 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 06 Feb 2018 11:43:57 -0700
Message-ID: <20180206184357.14644.79215.stgit@gimli.home>
In-Reply-To: <20180206184101.14644.84734.stgit@gimli.home>
References: <20180206184101.14644.84734.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 09/11] hw/vfio/platform: Init the interrupt mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Add the initialization of the mutex protecting the interrupt list.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/platform.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index da84abf4fc4c..0d4bc0aae889 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -643,6 +643,8 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     vbasedev->dev = dev;
     vbasedev->ops = &vfio_platform_ops;
 
+    qemu_mutex_init(&vdev->intp_mutex);
+
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
                                 vbasedev->sysfsdev : vbasedev->name,
                                 vdev->compat);
