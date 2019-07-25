Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F0C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D0B2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D0B2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfMw-0002hs-5w
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43635)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1hqfMM-0000cy-OB
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1hqfML-0004nn-DM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:08:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27082
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1hqfML-0004nT-6l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:08:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6PF8BhE076784
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:08:44 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tydmrkudb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:08:44 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
 Thu, 25 Jul 2019 16:08:43 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Jul 2019 16:08:41 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6PF8eIh36700478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 15:08:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0DEC112066;
 Thu, 25 Jul 2019 15:08:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88E0D112061;
 Thu, 25 Jul 2019 15:08:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jul 2019 15:08:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:08:31 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725150832.1180275-1-stefanb@linux.vnet.ibm.com>
References: <20190725150832.1180275-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19072515-0072-0000-0000-0000044D66F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011491; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01237278; UDB=6.00652191; IPR=6.01018652; 
 MB=3.00027886; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-25 15:08:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072515-0073-0000-0000-00004CBDC6E3
Message-Id: <20190725150832.1180275-2-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-25_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250177
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x6PF8BhE076784
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v2 1/2] tpm: Exit in reset when backend
 indicates failure
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Exit() in the frontend reset function when the backend indicates
intialization failure.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 4 +++-
 hw/tpm/tpm_tis.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 5e2db9e0c4..db0e3e7c67 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -273,7 +273,9 @@ static void tpm_crb_reset(void *dev)
     s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->tpmbe),
                             CRB_CTRL_CMD_SIZE);
=20
-    tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
+    if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
+        exit(1);
+    }
 }
=20
 static void tpm_crb_realize(DeviceState *dev, Error **errp)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 174618ac30..d6b3212890 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -910,7 +910,9 @@ static void tpm_tis_reset(DeviceState *dev)
         s->rw_offset =3D 0;
     }
=20
-    tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
+    if (tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size) < 0) {
+        exit(1);
+    }
 }
=20
 /* persistent state handling */
--=20
2.20.1


