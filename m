Received: from eggs.gnu.org ([2001:4830:134:3::10]:43967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAS-0003Sr-PO
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAN-0000Gk-Pj
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAN-0000GO-Fs
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2SKwsT2026752
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:30 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h0j47h2fn-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:29 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 28 Mar 2018 14:59:29 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 16:59:19 -0400
In-Reply-To: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1522270761-29646-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] tpm: CRB: Reset Granted flag when
 relinquishing locality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Reset the Granted flag when relinquishing a locality.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_crb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index e728b55..ee6c87e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,6 +145,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
         case CRB_LOC_CTRL_RELINQUISH:
             ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
                              locAssigned, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+                             Granted, 0);
             break;
         case CRB_LOC_CTRL_REQUEST_ACCESS:
             ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
-- 
2.5.5
