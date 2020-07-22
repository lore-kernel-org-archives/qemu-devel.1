Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA0C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D98B207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D98B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPPf-0002YH-B1
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.ibm.com>)
 id 1jyOPt-0000JP-D4; Wed, 22 Jul 2020 19:44:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53276
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.ibm.com>)
 id 1jyOPr-0006U6-NU; Wed, 22 Jul 2020 19:44:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06MNUx05184399; Wed, 22 Jul 2020 19:44:35 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32e1wmke8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 19:44:35 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MNe7T3032244;
 Wed, 22 Jul 2020 23:44:34 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04dal.us.ibm.com with ESMTP id 32d5dqfgq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 23:44:34 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06MNiXBg51118446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2020 23:44:33 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5152AC605A;
 Wed, 22 Jul 2020 23:44:33 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51623C6055;
 Wed, 22 Jul 2020 23:44:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.98])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2020 23:44:29 +0000 (GMT)
From: Gustavo Romero <gromero@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH] ppc/xive: Fix some typos in comments
Date: Wed, 22 Jul 2020 19:43:54 -0400
Message-Id: <1595461434-27725-1-git-send-email-gromero@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_16:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=1 bulkscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220142
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gromero@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 18:08:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2020 20:47:53 -0400
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
Cc: clg@kaod.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org,
 gromero@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix some typos in comments about code modeling coalescing points in the
XIVE routing engine (IVRE).

Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
---
 hw/intc/xive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9a16243..9b55e03 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1502,7 +1502,7 @@ static bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
 
 /*
  * Notification using the END ESe/ESn bit (Event State Buffer for
- * escalation and notification). Profide futher coalescing in the
+ * escalation and notification). Provide further coalescing in the
  * Router.
  */
 static bool xive_router_end_es_notify(XiveRouter *xrtr, uint8_t end_blk,
@@ -1581,7 +1581,7 @@ static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
 
     /*
      * Check the END ESn (Event State Buffer for notification) for
-     * even futher coalescing in the Router
+     * even further coalescing in the Router
      */
     if (!xive_end_is_notify(&end)) {
         /* ESn[Q]=1 : end of notification */
@@ -1660,7 +1660,7 @@ do_escalation:
 
     /*
      * Check the END ESe (Event State Buffer for escalation) for even
-     * futher coalescing in the Router
+     * further coalescing in the Router
      */
     if (!xive_end_is_uncond_escalation(&end)) {
         /* ESe[Q]=1 : end of notification */
-- 
2.7.4


