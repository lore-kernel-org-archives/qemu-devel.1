Received: from eggs.gnu.org ([209.51.188.92]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld6n-0001z8-Pi
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld38-0005bl-1p
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gld37-0005a0-Mm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:49 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0LH4xZU089758
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:48 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q5htwh5h9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:47 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 21 Jan 2019 17:07:47 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 21 Jan 2019 12:07:29 -0500
In-Reply-To: <20190121170731.2500692-1-stefanb@linux.ibm.com>
References: <20190121170731.2500692-1-stefanb@linux.ibm.com>
Message-Id: <20190121170731.2500692-3-stefanb@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] tpm: use loop iterator to set sts data
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org, mdroth@linux.ibm.com
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Stefan Berger <stefanb@linux.ibm.com>

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
2.17.2
