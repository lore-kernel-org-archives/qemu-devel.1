Received: from eggs.gnu.org ([2001:4830:134:3::10]:33083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eidzt-0006WR-Fu
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eidzs-0006gB-PQ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:27:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eidzs-0006fx-JM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:27:36 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon,  5 Feb 2018 12:26:59 +0200
Message-Id: <20180205102659.60552-5-marcel@redhat.com>
In-Reply-To: <20180205102659.60552-1-marcel@redhat.com>
References: <20180205102659.60552-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PULL 4/4] MAINTAINERS: add entry for hw/rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f952d46ce..3e34ae25ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1995,6 +1995,14 @@ F: block/replication.c
 F: tests/test-replication.c
 F: docs/block-replication.txt
 
+PVRDMA
+M: Yuval Shaia <yuval.shaia@oracle.com>
+M: Marcel Apfelbaum <marcel@redhat.com>
+S: Maintained
+F: hw/rdma/*
+F: hw/rdma/vmw/*
+F: docs/pvrdma.txt
+
 Build and test automation
 -------------------------
 Build and test automation
-- 
2.13.5
