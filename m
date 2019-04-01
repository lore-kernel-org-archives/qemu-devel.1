Received: from eggs.gnu.org ([209.51.188.92]:41694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45Q-0002C9-4y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45P-0003xz-9G
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45O-0003r2-Sa
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1rKX122294
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8t3t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:07 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:06 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:58 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-85-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 84/97] tpm: use loop iterator to set sts data
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Stefan Berger <stefanb@linux.ibm.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

When TIS request is done, set 'sts' data field across all localities.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
(cherry picked from commit 6a50bb98f24929c9fc69e9197eb21c142e061fbd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 12f5c9a759..d9322692ee 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -295,7 +295,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
 
     if (s->cmd.selftest_done) {
         for (l = 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
-            s->loc[locty].sts |= TPM_TIS_STS_SELFTEST_DONE;
+            s->loc[l].sts |= TPM_TIS_STS_SELFTEST_DONE;
         }
     }
 
-- 
2.17.1
