Received: from eggs.gnu.org ([2001:4830:134:3::10]:35793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxv-0001zm-Oz
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxt-0004St-Cl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:58:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilxt-0004Rz-2c
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:58:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51F6415447
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:58:04 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:58:00 -0700
Message-ID: <20180205185800.14391.48212.stgit@gimli.home>
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
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
