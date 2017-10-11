Received: from eggs.gnu.org ([2001:4830:134:3::10]:34227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhN-0003TV-U6
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhJ-0003c5-0I
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46346
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2OhI-0003bo-Qg
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BLYv0Y021849
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:45 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dhrsyxdj3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:44 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 17:37:44 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 17:37:28 -0400
In-Reply-To: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1507757851-12580-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/4] tpm: print buffers received from TPM
 when debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d5118e7..9bf0bce 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -373,6 +373,8 @@ static void tpm_tis_receive_bh(void *opaque)
     tis->loc[locty].r_offset = 0;
     tis->loc[locty].w_offset = 0;
 
+    tpm_tis_show_buffer(&tis->loc[locty].r_buffer, "tpm_tis: From TPM");
+
     if (TPM_TIS_IS_VALID_LOCTY(tis->next_locty)) {
         tpm_tis_abort(s, locty);
     }
-- 
2.5.5
