Received: from eggs.gnu.org ([209.51.188.92]:43131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47C-0003nk-LI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB476-0004zJ-Hg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB476-0004mv-3Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4hDd114644
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:47 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksvqh0ss-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:44 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:59 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:51 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-78-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 77/97] pc:piix4: Update smbus I/O space after a
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Corey Minyard <cminyard@mvista.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

Otherwise it won't be set up correctly and won't work after
miigration.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2b4e573c7c7b9a698ba6931ba456bbd8d3d8c84c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/acpi/piix4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6404af5f33..7ae6d14b46 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -173,6 +173,7 @@ static int vmstate_acpi_post_load(void *opaque, int version_id)
     PIIX4PMState *s = opaque;
 
     pm_io_space_update(s);
+    smbus_io_space_update(s);
     return 0;
 }
 
-- 
2.17.1
