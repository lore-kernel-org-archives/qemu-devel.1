Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8h-00025z-GJ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEj8b-00010a-6p
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:53:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEj8Q-0000qD-Tl
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:52:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAELpAWc046504
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:39 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e87t9aksm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:52:39 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 16:52:37 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 16:52:29 -0500
In-Reply-To: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510696349-5151-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 3/3] tpm_tis: Return 0 for every
 register in case of failure mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, amarnath.valluri@intel.com
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

Rather than returning ~0, return 0 for every register in case of
failure mode. The '0' is better to indicate that there's no device
there.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index fec2fc6..42d647d 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -545,7 +545,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
     uint8_t v;
 
     if (tpm_backend_had_startup_error(s->be_driver)) {
-        return val;
+        return 0;
     }
 
     switch (offset) {
-- 
2.5.5
