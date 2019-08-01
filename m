Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D500C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 03:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2681C206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 03:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2681C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht1w5-0002su-7e
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 23:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <daniel@linux.ibm.com>) id 1ht1vW-0002NE-JT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 23:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel@linux.ibm.com>) id 1ht1vV-0004QI-6X
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 23:38:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <daniel@linux.ibm.com>)
 id 1ht1vU-0004Pg-Vv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 23:38:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x713bDgb135135
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 23:38:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u3r3pgfur-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 23:38:46 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <daniel@linux.ibm.com>;
 Thu, 1 Aug 2019 04:38:44 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 1 Aug 2019 04:38:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x713cfpE56557798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2019 03:38:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC3BFA4053;
 Thu,  1 Aug 2019 03:38:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41F13A4040;
 Thu,  1 Aug 2019 03:38:41 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2019 03:38:41 +0000 (GMT)
Received: from volution.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 279A0A01FE;
 Thu,  1 Aug 2019 13:38:40 +1000 (AEST)
From: Daniel Black <daniel@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 13:38:19 +1000
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080103-4275-0000-0000-000003529DA4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080103-4276-0000-0000-000038638EE1
Message-Id: <20190801033819.29664-1-daniel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-01_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010030
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v2] spapr: quantify error messages regarding
 capability settings
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Daniel Black <daniel@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Its not immediately obvious how cap-X=Y setting need to be applied
to the command line so, for spapr capability error messages, this
has been clarified to:

  ..[try] appending -machine cap-X=Y

The wrong value messages have been left as is, as the user has found
the right location.

Signed-off-by: Daniel Black <daniel@linux.ibm.com>
---
v2 Improved error message thanks David Gibson

Left the "appending" as its not obvious more that one -machine
arguement is allowed.
---
 hw/ppc/spapr_caps.c | 47 ++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index bbb001f84a..1c0222a081 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -37,6 +37,8 @@
 
 #include "hw/ppc/spapr.h"
 
+#define CAPABILITY_ERROR(X) "appending -machine " X
+
 typedef struct SpaprCapPossible {
     int num;            /* size of vals array below */
     const char *help;   /* help text for vals */
@@ -194,10 +196,12 @@ static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
     }
     if (tcg_enabled()) {
         error_setg(errp,
-                   "No Transactional Memory support in TCG, try cap-htm=off");
+                   "No Transactional Memory support in TCG, try "
+                   CAPABILITY_ERROR("cap-htm=off"));
     } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
         error_setg(errp,
-"KVM implementation does not support Transactional Memory, try cap-htm=off"
+"KVM implementation does not support Transactional Memory, try "
+                   CAPABILITY_ERROR("cap-htm=off")
             );
     }
 }
@@ -215,7 +219,8 @@ static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
      * rid of anything that doesn't do VMX */
     g_assert(env->insns_flags & PPC_ALTIVEC);
     if (!(env->insns_flags2 & PPC2_VSX)) {
-        error_setg(errp, "VSX support not available, try cap-vsx=off");
+        error_setg(errp, "VSX support not available, try "
+                   CAPABILITY_ERROR("cap-vsx=off"));
     }
 }
 
@@ -229,7 +234,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
         return;
     }
     if (!(env->insns_flags2 & PPC2_DFP)) {
-        error_setg(errp, "DFP support not available, try cap-dfp=off");
+        error_setg(errp, "DFP support not available, try "
+                   CAPABILITY_ERROR("cap-dfp=off"));
     }
 }
 
@@ -249,11 +255,13 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
     if (tcg_enabled() && val) {
         /* TCG only supports broken, allow other values and print a warning */
         error_setg(&local_err,
-                   "TCG doesn't support requested feature, cap-cfpc=%s",
+                   "TCG doesn't support requested feature, "
+                   CAPABILITY_ERROR("cap-cfpc=%s"),
                    cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe cache capability level not supported by kvm, try cap-cfpc=%s",
+"Requested safe cache capability level not supported by kvm, try "
+                   CAPABILITY_ERROR("cap-cfpc=%s"),
                    cap_cfpc_possible.vals[kvm_val]);
     }
 
@@ -281,7 +289,8 @@ static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
                    cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe bounds check capability level not supported by kvm, try cap-sbbc=%s",
+"Requested safe bounds check capability level not supported by kvm, try "
+                   CAPABILITY_ERROR("cap-sbbc=%s"),
                    cap_sbbc_possible.vals[kvm_val]);
     }
 
@@ -312,7 +321,8 @@ static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
                    cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe indirect branch capability level not supported by kvm, try cap-ibs=%s",
+"Requested safe indirect branch capability level not supported by kvm, try "
+                   CAPABILITY_ERROR("cap-ibs=%s"),
                    cap_ibs_possible.vals[kvm_val]);
     }
 
@@ -401,11 +411,13 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
 
     if (tcg_enabled()) {
         error_setg(errp,
-                   "No Nested KVM-HV support in tcg, try cap-nested-hv=off");
+                   "No Nested KVM-HV support in tcg, try "
+                   CAPABILITY_ERROR("cap-nested-hv=off"));
     } else if (kvm_enabled()) {
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
-"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=off");
+"KVM implementation does not support Nested KVM-HV, try "
+                       CAPABILITY_ERROR("cap-nested-hv=off"));
         } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
                 error_setg(errp,
 "Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
@@ -435,10 +447,12 @@ static void cap_large_decr_apply(SpaprMachineState *spapr,
 
         if (!kvm_nr_bits) {
             error_setg(errp,
-                       "No large decrementer support, try cap-large-decr=off");
+                       "No large decrementer support, try "
+                        CAPABILITY_ERROR("cap-large-decr=off"));
         } else if (pcc->lrg_decr_bits != kvm_nr_bits) {
             error_setg(errp,
-"KVM large decrementer size (%d) differs to model (%d), try -cap-large-decr=off",
+"KVM large decrementer size (%d) differs to model (%d), try "
+                CAPABILITY_ERROR("cap-large-decr=off"),
                 kvm_nr_bits, pcc->lrg_decr_bits);
         }
     }
@@ -454,7 +468,8 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
     if (kvm_enabled()) {
         if (kvmppc_enable_cap_large_decr(cpu, val)) {
             error_setg(errp,
-                       "No large decrementer support, try cap-large-decr=off");
+                       "No large decrementer support, try "
+                       CAPABILITY_ERROR("cap-large-decr=off"));
         }
     }
 
@@ -474,10 +489,12 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
     if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp,
-"Requested count cache flush assist capability level not supported by tcg, try cap-ccf-assist=off");
+"Requested count cache flush assist capability level not supported by tcg, try "
+                   CAPABILITY_ERROR("cap-ccf-assist=off"));
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested count cache flush assist capability level not supported by kvm, try cap-ccf-assist=off");
+"Requested count cache flush assist capability level not supported by kvm, try "
+                   CAPABILITY_ERROR("cap-ccf-assist=off"));
     }
 }
 
-- 
2.21.0


