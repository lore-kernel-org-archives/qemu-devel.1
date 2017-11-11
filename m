Received: from eggs.gnu.org ([2001:4830:134:3::10]:39189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDMdn-00074a-3s
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 22:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDMdi-00076y-8u
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 22:39:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51256
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDMdi-000761-3G
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 22:39:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAB3d84P052082
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 22:39:25 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e5h55v197-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 22:39:24 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 20:39:24 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 22:39:14 -0500
In-Reply-To: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510371554-29833-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] tpm_tis: Return 0 for every register in
 case of failure mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Rather than returning ~0, return 0 for every register in case of
failure mode. The '0' is better to indicate that there's no device
there.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index eca3374..d0bdd96 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -519,7 +519,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
     uint8_t v;
 
     if (tpm_backend_had_startup_error(s->be_driver)) {
-        return val;
+        return 0;
     }
 
     switch (offset) {
-- 
2.5.5
