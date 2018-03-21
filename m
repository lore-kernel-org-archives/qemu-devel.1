Received: from eggs.gnu.org ([2001:4830:134:3::10]:52121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycXT-0002ny-HH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycXQ-0008NF-Rx
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eycXQ-0008Mu-Jk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LC846v012612
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:08:15 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gun59wawb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:08:12 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 08:07:55 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 08:07:50 -0400
In-Reply-To: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1521634071-16519-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 3/4] tpm: CRB: reset locAssigned upon
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 4bd76b5..e8c42f6 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -137,6 +137,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
             /* not loc 3 or 4 */
             break;
         case CRB_LOC_CTRL_RELINQUISH:
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                             locAssigned, 0);
             break;
         case CRB_LOC_CTRL_REQUEST_ACCESS:
             ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
--=20
2.5.5
