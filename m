Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D883EC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B597A2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B597A2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijQp-0001Vy-1o
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hijOg-0007zE-8S
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hijOf-0001g4-4W
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:50:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47022
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hijOe-0001de-Vb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:50:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x63HlIBL068045
 for <qemu-devel@nongnu.org>; Wed, 3 Jul 2019 13:50:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tgxmwnxry-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 13:50:18 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 3 Jul 2019 18:50:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Jul 2019 18:50:13 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x63HoCeI47644672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jul 2019 17:50:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 883F9A4064;
 Wed,  3 Jul 2019 17:50:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59A47A405F;
 Wed,  3 Jul 2019 17:50:12 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.70.88])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  3 Jul 2019 17:50:12 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Wed, 03 Jul 2019 19:50:12 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070317-4275-0000-0000-00000348C5E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070317-4276-0000-0000-00003858E28A
Message-Id: <156217621200.562209.8968691631915806468.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-03_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030216
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH for-4.2] xics/kvm: Convert assert() to
 error_setg()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ics_set_kvm_state_one() is called either during reset, in which case
both 'saved priority' and 'current priority' are equal to 0xff, or
during migration. In the latter case, 'saved priority' may differ
from 'current priority' only if the interrupt had been masked with
the ibm,int-off RTAS call. Instead of aborting QEMU, print out an
error and exit.

Based-on: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
Signed-off-by: Greg Kurz <groug@kaod.org>
---

This isn't a bugfix, hence targetting 4.2, but it depends on an actual
fix for 4.1, as mentionned in the Based-on tag.
---
 hw/intc/xics_kvm.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 2df1f3e92c7e..f8758b928250 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -255,8 +255,21 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp)
     state = irq->server;
     state |= (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
         << KVM_XICS_PRIORITY_SHIFT;
-    if (irq->priority != irq->saved_priority) {
-        assert(irq->priority == 0xff);
+
+    /*
+     * An interrupt can be masked either because the ICS is resetting, in
+     * which case we expect 'current priority' and 'saved priority' to be
+     * equal to 0xff, or because the guest has called the ibm,int-off RTAS
+     * call, in which case we we have recorded the priority the interrupt
+     * had before it was masked in 'saved priority'. If the interrupt isn't
+     * masked, 'saved priority' and 'current priority' are equal (see
+     * ics_get_kvm_state()). Make sure we restore a sane state, otherwise
+     * fail migration.
+     */
+    if (irq->priority != irq->saved_priority && irq->priority != 0xff) {
+        error_setg(errp, "Corrupted state detected for interrupt source %d",
+                   srcno);
+        return -EINVAL;
     }
 
     if (irq->priority == 0xff) {


