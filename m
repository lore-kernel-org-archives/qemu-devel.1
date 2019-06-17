Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB45C31E58
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078602080C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078602080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcs53-0001qU-AI
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcryY-0004Os-Qq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcryU-0000nf-Ue
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:47:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38434
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcryN-0000hs-K1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:47:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5HDbT5R113979
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:46:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t6bj89ktd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:46:58 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 17 Jun 2019 14:46:56 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 17 Jun 2019 14:46:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x5HDkiHj30277956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 13:46:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A26E5204F;
 Mon, 17 Jun 2019 13:46:52 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.14.35])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C03D52050;
 Mon, 17 Jun 2019 13:46:52 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jun 2019 15:46:52 +0200
In-Reply-To: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061713-0008-0000-0000-000002F47BC1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061713-0009-0000-0000-000022618DDE
Message-Id: <156077921212.433243.11716701611944816815.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 4/6] xics/kvm: Always use local_err in
 xics_kvm_init()
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

Passing both errp and &local_err to functions is a recipe for messing
things up.

Since we must use &local_err for icp_kvm_realize(), use &local_err
everywhere where rollback must happen and have a single call to
error_propagate() them all. While here, add errno to the error
message.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 377ff88701c2..c9e25fb051bb 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -353,32 +353,36 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
 
     rc = kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-xive");
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,set-xive");
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,set-xive");
         goto fail;
     }
 
     rc = kvmppc_define_rtas_kernel_token(RTAS_IBM_GET_XIVE, "ibm,get-xive");
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,get-xive");
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,get-xive");
         goto fail;
     }
 
     rc = kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_ON, "ibm,int-on");
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-on");
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,int-on");
         goto fail;
     }
 
     rc = kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_OFF, "ibm,int-off");
     if (rc < 0) {
-        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-off");
+        error_setg_errno(&local_err, -rc,
+                         "kvmppc_define_rtas_kernel_token: ibm,int-off");
         goto fail;
     }
 
     /* Create the KVM XICS device */
     rc = kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
     if (rc < 0) {
-        error_setg_errno(errp, -rc, "Error on KVM_CREATE_DEVICE for XICS");
+        error_setg_errno(&local_err, -rc, "Error on KVM_CREATE_DEVICE for XICS");
         goto fail;
     }
 
@@ -393,7 +397,6 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
 
         icp_kvm_realize(DEVICE(spapr_cpu_state(cpu)->icp), &local_err);
         if (local_err) {
-            error_propagate(errp, local_err);
             goto fail;
         }
     }
@@ -410,6 +413,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
     return 0;
 
 fail:
+    error_propagate(errp, local_err);
     kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,int-on");


