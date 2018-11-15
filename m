Received: from eggs.gnu.org ([2001:4830:134:3::10]:54503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gNILM-0000xk-Fz
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gNILI-00071K-J0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gNILI-00070S-AF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:10:00 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAFE3d4u016874
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:09:58 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ns9r41q0h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:09:58 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 15 Nov 2018 14:09:58 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2018 09:09:49 -0500
In-Reply-To: <20181115140949.3481699-1-stefanb@linux.vnet.ibm.com>
References: <20181115140949.3481699-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181115140949.3481699-3-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 2/2] tests: tpm: Use g_test_message rather
 than fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

Display a message during the test using g_test_message rather
than fprintf.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/tpm-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
index 93a5beba01..582ec0cfd4 100644
--- a/tests/tpm-tests.c
+++ b/tests/tpm-tests.c
@@ -22,7 +22,7 @@ static bool
 tpm_test_swtpm_skip(void)
 {
     if (!tpm_util_swtpm_has_tpm2()) {
-        fprintf(stderr, "swtpm not in PATH or missing --tpm2 support; ");
+        g_test_message("swtpm not in PATH or missing --tpm2 support");
         return true;
     }
 
-- 
2.17.1
