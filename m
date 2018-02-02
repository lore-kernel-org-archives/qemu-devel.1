Received: from eggs.gnu.org ([2001:4830:134:3::10]:39861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca6-0001Yw-Ml
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca2-000388-8y
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehca1-000379-Uy
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12EhBGP051241
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:44:40 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvqccyvpp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:44:40 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 07:44:39 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri,  2 Feb 2018 09:44:28 -0500
In-Reply-To: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1517582668-10923-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/4] tpm: tis: move one-line function into
 caller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 08f41d2..f81168a 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -946,11 +946,6 @@ static const MemoryRegionOps tpm_tis_memory_ops = {
     },
 };
 
-static int tpm_tis_do_startup_tpm(TPMState *s, size_t buffersize)
-{
-    return tpm_backend_startup_tpm(s->be_driver, buffersize);
-}
-
 /*
  * Get the TPMVersion of the backend device being used
  */
@@ -1005,7 +1000,7 @@ static void tpm_tis_reset(DeviceState *dev)
         s->rw_offset = 0;
     }
 
-    tpm_tis_do_startup_tpm(s, s->be_buffer_size);
+    tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
 }
 
 static const VMStateDescription vmstate_tpm_tis = {
-- 
2.5.5
