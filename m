Received: from eggs.gnu.org ([2001:4830:134:3::10]:58829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyW-0001HL-LR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyU-0001o1-LI
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34110
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyU-0001nY-FK
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYJXU066463
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:17 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6frx9drf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:17 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:15 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:35:56 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 04/12] util/qemu-config: Add loadparm to qemu
 machine_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

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
