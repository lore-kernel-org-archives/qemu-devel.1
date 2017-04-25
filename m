Received: from eggs.gnu.org ([2001:4830:134:3::10]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xzc-0000Ap-S6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xzb-00019Z-M8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d2xzb-00018c-DP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PAd13i010019
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:46 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a1jvh2ad5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:45 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 25 Apr 2017 11:46:42 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 25 Apr 2017 12:46:26 +0200
In-Reply-To: <20170425104633.6130-1-cornelia.huck@de.ibm.com>
References: <20170425104633.6130-1-cornelia.huck@de.ibm.com>
Message-Id: <20170425104633.6130-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 04/11] util/qemu-config: Add loadparm to qemu
 machine_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Add S390CcwMachineState machine parameter "loadparm" to qemu machine_opts so
libvirt can query for it.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 util/qemu-config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/util/qemu-config.c b/util/qemu-config.c
index 5527100a01..405dd1a1d7 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -227,6 +227,12 @@ static QemuOptsList machine_opts = {
             .name = "dea-key-wrap",
             .type = QEMU_OPT_BOOL,
             .help = "enable/disable DEA key wrapping using the CPACF wrapping key",
+        },{
+            .name = "loadparm",
+            .type = QEMU_OPT_STRING,
+            .help = "Up to 8 chars in set of [A-Za-z0-9. ](lower case chars"
+                    " converted to upper case) to pass to machine"
+                    " loader, boot manager, and guest kernel",
         },
         { /* End of list */ }
     }
-- 
2.11.0
