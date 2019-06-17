Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57589C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1C42080A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1C42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcs2p-0007ck-8h
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcryD-0004LQ-6k
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcryB-0000a0-UJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48810
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcryB-0000ZM-Ob
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5HDbcTF177599
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:46:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t6brv0wnr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:46:46 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 17 Jun 2019 14:46:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 17 Jun 2019 14:46:42 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5HDkf8E51380230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 13:46:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C1F0AE051;
 Mon, 17 Jun 2019 13:46:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C0A6AE053;
 Mon, 17 Jun 2019 13:46:41 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.14.35])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2019 13:46:41 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jun 2019 15:46:41 +0200
In-Reply-To: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061713-0028-0000-0000-0000037B06D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061713-0029-0000-0000-0000243B0B45
Message-Id: <156077920102.433243.6605099291134598170.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 2/6] xics/spapr: Rename xics_kvm_init()
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to using the connect/disconnect terminology like we already do for
XIVE.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c          |    2 +-
 hw/ppc/spapr_irq.c          |    2 +-
 include/hw/ppc/xics_spapr.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index c7f8f5edd257..534515143ea8 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -331,7 +331,7 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
     }
 }
 
-int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
+int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
 {
     int rc;
     CPUState *cs;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 84b9b32fe40f..ff3df0bbd8cf 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -237,7 +237,7 @@ static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spapr)
 static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **errp)
 {
     if (kvm_enabled()) {
-        xics_kvm_init(spapr, errp);
+        xics_kvm_connect(spapr, errp);
     }
 }
 
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 330448126223..5dabc9a1388f 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -33,7 +33,7 @@
 
 void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle);
-int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
+int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
 bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
 void xics_spapr_init(SpaprMachineState *spapr);


