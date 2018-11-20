Received: from eggs.gnu.org ([2001:4830:134:3::10]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gPAkU-000831-24
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gPAkJ-0001gP-4T
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44908
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gPAkI-0001YY-LV
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:34 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAKINhLE053431
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:27:30 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nvnk0x2jj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:27:30 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 20 Nov 2018 18:27:29 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 20 Nov 2018 13:27:20 -0500
In-Reply-To: <20181120182721.227114-1-stefanb@linux.vnet.ibm.com>
References: <20181120182721.227114-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20181120182721.227114-2-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] tpm: Remove unused locty parameter from
 tpm_tis_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

Remove the unused locty parameter from tpm_tis_abort() function.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d9322692ee..176d424ed9 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -233,7 +233,7 @@ static void tpm_tis_new_active_locality(TPMState *s, uint8_t new_active_locty)
 }
 
 /* abort -- this function switches the locality */
-static void tpm_tis_abort(TPMState *s, uint8_t locty)
+static void tpm_tis_abort(TPMState *s)
 {
     s->rw_offset = 0;
 
@@ -281,7 +281,7 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
         }
     }
 
-    tpm_tis_abort(s, locty);
+    tpm_tis_abort(s);
 }
 
 /*
@@ -311,7 +311,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
     }
 
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
-        tpm_tis_abort(s, locty);
+        tpm_tis_abort(s);
     }
 
     tpm_tis_raise_irq(s, locty,
-- 
2.17.1
