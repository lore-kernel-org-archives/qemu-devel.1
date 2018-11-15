Received: from eggs.gnu.org ([2001:4830:134:3::10]:54499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gNILM-0000xa-BR
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gNILI-000716-D9
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gNILH-000709-S8
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:00 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAFE3enG073591
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:09:57 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ns9rmsrwq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:09:57 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 15 Nov 2018 14:09:56 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2018 09:09:48 -0500
In-Reply-To: <20181115140949.3481699-1-stefanb@linux.vnet.ibm.com>
References: <20181115140949.3481699-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181115140949.3481699-2-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 1/2] tpm: use loop iterator to set sts data
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
Cc: peter.maydell@linaro.org, Prasad J Pandit <pjp@fedoraproject.org>, Stefan Berger <stefanb@linux.ibm.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

When TIS request is done, set 'sts' data field across all localities.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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
