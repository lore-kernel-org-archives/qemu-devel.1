Received: from eggs.gnu.org ([2001:4830:134:3::10]:35600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gK33H-00049s-TU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gK33D-0004lL-GB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:13:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53162
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gK33D-0004jm-7O
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:13:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA6F5Efi077806
	for <qemu-devel@nongnu.org>; Tue, 6 Nov 2018 10:13:53 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nkaek0ux2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 10:13:53 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 6 Nov 2018 15:13:52 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  6 Nov 2018 10:13:46 -0500
Message-Id: <20181106151346.2728687-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tests: tpm: Use g_test_message rather than
 fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

Display a message during the test using g_test_message rather
than fprintf.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/tpm-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
index 93a5beba01..5f217a2d92 100644
--- a/tests/tpm-tests.c
+++ b/tests/tpm-tests.c
@@ -22,7 +22,7 @@ static bool
 tpm_test_swtpm_skip(void)
 {
     if (!tpm_util_swtpm_has_tpm2()) {
-        fprintf(stderr, "swtpm not in PATH or missing --tpm2 support; ");
+        g_test_message("swtpm not in PATH or missing --tpm2 support; ");
         return true;
     }
 
-- 
2.17.1
