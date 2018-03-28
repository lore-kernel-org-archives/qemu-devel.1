Received: from eggs.gnu.org ([2001:4830:134:3::10]:43946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAQ-0003Sc-Fa
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAL-0000G0-Dc
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59546
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAL-0000Fs-8i
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2SKwpwR003326
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:28 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h0exw8ru8-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:27 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 28 Mar 2018 14:59:27 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 16:59:18 -0400
In-Reply-To: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1522270761-29646-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/4] tpm: CRB: set the Idle flag by default
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

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_crb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index ef8b80e..e728b55 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -220,6 +220,8 @@ static void tpm_crb_reset(void *dev)
 
     ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
                      tpmRegValidSts, 1);
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                     tpmIdle, 1);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-- 
2.5.5
