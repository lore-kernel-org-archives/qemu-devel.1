Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F76C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC6A2239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC6A2239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyC4-0001Ph-7e
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAF-00041d-9q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAD-00056F-OA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyAD-00055L-Cg
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NGklKK033675
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:20 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60xgj8x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:20 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:19 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:17 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1GqG57606464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:16 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D0B1BE059;
 Tue, 23 Jul 2019 17:01:16 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D937BE062;
 Tue, 23 Jul 2019 17:01:16 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:16 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:41 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19072317-0004-0000-0000-0000152DB9AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-0005-0000-0000-00008C9463A7
Message-Id: <20190723170104.4327-14-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x6NGklKK033675
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 13/36] hw/rdma: another clang compilation fix
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Configuring QEMU with:
   configure --target-list=3D"x86_64-softmmu" --cc=3Dclang --enable-pvrdm=
a
Results in:
   qemu/hw/rdma/rdma_rm_defs.h:108:3: error: redefinition of typedef 'Rdm=
aDeviceResources' is a C11 feature [-Werror,-Wtypedef-redefinition]
   } RdmaDeviceResources;
     ^
   qemu/hw/rdma/rdma_backend_defs.h:24:36: note: previous definition is h=
ere
   typedef struct RdmaDeviceResources RdmaDeviceResources;

Fix by removing one of the 'typedef' definitions.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
(cherry picked from commit 59f911938fbaa6a5eff1146c8a4d74e1c55ecc2b)
*drop context dep. on c2dd117b385
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/rdma/rdma_rm_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 7228151239..17ee8f2871 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -85,7 +85,7 @@ typedef struct RdmaRmPort {
     enum ibv_port_state state;
 } RdmaRmPort;
=20
-typedef struct RdmaDeviceResources {
+struct RdmaDeviceResources {
     RdmaRmPort ports[MAX_PORTS];
     RdmaRmResTbl pd_tbl;
     RdmaRmResTbl mr_tbl;
@@ -94,6 +94,6 @@ typedef struct RdmaDeviceResources {
     RdmaRmResTbl cq_tbl;
     RdmaRmResTbl cqe_ctx_tbl;
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
-} RdmaDeviceResources;
+};
=20
 #endif
--=20
2.17.1


