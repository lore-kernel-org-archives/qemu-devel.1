Received: from eggs.gnu.org ([2001:4830:134:3::10]:42502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfM-0006LH-8G
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfJ-0006fL-4d
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53668
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfI-0006du-Uw
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2U0907A068385
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h1a4y0qfx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:07 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Mar 2018 18:13:07 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Mar 2018 20:12:55 -0400
In-Reply-To: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1522368777-32742-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 2/4] tpm: CRB: Reset Granted flag when
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

Reset the Granted flag when relinquishing a locality.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index e728b55..ee6c87e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,6 +145,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
         case CRB_LOC_CTRL_RELINQUISH:
             ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
                              locAssigned, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+                             Granted, 0);
             break;
         case CRB_LOC_CTRL_REQUEST_ACCESS:
             ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
--=20
2.5.5
