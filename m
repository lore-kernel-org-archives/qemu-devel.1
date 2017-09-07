Received: from eggs.gnu.org ([2001:4830:134:3::10]:40216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dq3E6-0006KO-PN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dq3E2-0003hL-5C
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:16:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dq3E1-0003eg-RX
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:16:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v87KErkt067192
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 16:16:31 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cucr80nde-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 16:16:31 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 14:16:30 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  7 Sep 2017 16:16:24 -0400
Message-Id: <1504815384-8490-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] Add myself as maintainer for TPM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, f4bug@amsat.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Also add backends/tpm.c to the list of files.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index caf7e8a..c434a09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1487,12 +1487,14 @@ F: docs/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
 
 TPM
-S: Orphan
+M: Stefan Berger <stefanb@linux.vnet.ibm.com>
+S: Maintained
 F: tpm.c
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
 F: qapi/tpm.json
+F: backends/tpm.c
 
 Checkpatch
 S: Odd Fixes
-- 
2.5.5
