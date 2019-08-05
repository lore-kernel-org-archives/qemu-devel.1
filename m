Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95D5C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7C12086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7C12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huVGq-0005TK-MG
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 01:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <daniel@linux.ibm.com>) id 1huVGO-0004s9-BH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel@linux.ibm.com>) id 1huVGM-0006Fi-7n
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:10:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <daniel@linux.ibm.com>)
 id 1huVGK-0006ET-GV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:10:26 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7557uTa089684
 for <qemu-devel@nongnu.org>; Mon, 5 Aug 2019 01:10:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u680n3p47-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 01:10:21 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <daniel@linux.ibm.com>;
 Mon, 5 Aug 2019 06:10:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 5 Aug 2019 06:10:18 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x755AHJR47186122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Aug 2019 05:10:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 283B74204B;
 Mon,  5 Aug 2019 05:10:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AC424204D;
 Mon,  5 Aug 2019 05:10:16 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  5 Aug 2019 05:10:16 +0000 (GMT)
Received: from volution.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8DF63A0259;
 Mon,  5 Aug 2019 15:10:15 +1000 (AEST)
From: Daniel Black <daniel@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 15:09:58 +1000
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080505-0008-0000-0000-0000030546C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080505-0009-0000-0000-0000A17F4A9E
Message-Id: <20190805050959.19935-1-daniel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-05_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050057
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v3] spapr: quantify error messages regarding
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Daniel Black <daniel@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Its not immediately obvious how cap-X=Y setting need to be applied
to the command line so, for spapr capability hints, this has been clarified to:

  ..try appending -machine cap-X=Y

The wrong value messages have been left as is, as the user has found the right
location.

Warning messages have been left as is for now.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Black <daniel@linux.ibm.com>
---
tcg (broken only for cap-{cfpc|sbbc|ibs}:

$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
^Cqemu-system-ppc64: terminating on signal 2
$  ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
^Cqemu-system-ppc64: terminating on signal 2
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=fixed
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-cfpc=fixed
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
^Cqemu-system-ppc64: terminating on signal 2
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken  -machine  cap-sbbc=fixed
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=fixed
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
^Cqemu-system-ppc64: terminating on signal 2
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken  -machine  cap-sbbc=broken
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
^Cqemu-system-ppc64: terminating on signal 2
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken  -machine  cap-sbbc=broken  -machine   cap-ibs=fixed-ibs
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=fixed-ibs
^Cqemu-system-ppc64: terminating on signal 2
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken  -machine  cap-sbbc=broken  -machine   cap-ibs=fixed-ccd
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=fixed-ccd
^Cqemu-system-ppc64: terminating on signal 2
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken  -machine  cap-sbbc=broken  -machine   cap-ibs=fixed-na
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=fixed-na
^Cqemu-system-ppc64: terminating on signal 2
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken  -machine  cap-sbbc=broken  -machine   cap-ibs=fixed-broken
qemu-system-ppc64: Invalid capability mode "fixed-broken" for cap-ibs
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=broken  -machine  cap-sbbc=broken  -machine   cap-ibs=broken
^Cqemu-system-ppc64: terminating on signal 2

result: No silly messages

kvm (older firmware without features "for testing"):

$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=workaround
qemu-system-ppc64: Requested safe cache capability level not supported by kvm, try appending -machine cap-cfpc=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=fixed
qemu-system-ppc64: Requested safe cache capability level not supported by kvm, try appending -machine cap-cfpc=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-sbbc=broken
qemu-system-ppc64: Requested safe cache capability level not supported by kvm, try appending -machine cap-cfpc=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken
qemu-system-ppc64: Requested safe indirect branch capability level not supported by kvm, try appending -machine cap-ibs=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=fixed
qemu-system-ppc64: Requested safe bounds check capability level not supported by kvm, try appending -machine cap-sbbc=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=workaround
qemu-system-ppc64: Requested safe bounds check capability level not supported by kvm, try appending -machine cap-sbbc=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken
qemu-system-ppc64: Requested safe indirect branch capability level not supported by kvm, try appending -machine cap-ibs=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken -machine cap-ibs=workaround
qemu-system-ppc64: Requested safe indirect branch capability level not supported by kvm, try appending -machine cap-ibs=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken -machine cap-ibs=fixed
qemu-system-ppc64: Invalid capability mode "fixed" for cap-ibs
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken -machine cap-ibs=fixed-ibs
qemu-system-ppc64: Requested safe indirect branch capability level not supported by kvm, try appending -machine cap-ibs=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken -machine cap-ibs=fixed-ccd
qemu-system-ppc64: Requested safe indirect branch capability level not supported by kvm, try appending -machine cap-ibs=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken -machine cap-ibs=fixed-na
qemu-system-ppc64: Requested safe indirect branch capability level not supported by kvm, try appending -machine cap-ibs=broken
$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries -accel kvm -machine cap-cfpc=broken  -machine cap-sbbc=broken -machine cap-ibs=broken
KVM: Failed to create TCE64 table for liobn 0x80000000

result: instructions can be followed.

v3 Hint, and not all messages, (can't use error_append_hint on
error_fatal) from Greg Kurz
v2 Improved error message thanks David Gibson
---
 hw/ppc/spapr_caps.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index bbb001f84a..b06faee7f6 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -37,6 +37,8 @@
 
 #include "hw/ppc/spapr.h"
 
+#define CAPABILITY_HINT(X) " try appending -machine " X
+
 typedef struct SpaprCapPossible {
     int num;            /* size of vals array below */
     const char *help;   /* help text for vals */
@@ -194,10 +196,12 @@ static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
     }
     if (tcg_enabled()) {
         error_setg(errp,
-                   "No Transactional Memory support in TCG, try cap-htm=off");
+                   "No Transactional Memory support in TCG,"
+                   CAPABILITY_HINT("cap-htm=off"));
     } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
         error_setg(errp,
-"KVM implementation does not support Transactional Memory, try cap-htm=off"
+"KVM implementation does not support Transactional Memory,"
+                   CAPABILITY_HINT("cap-htm=off")
             );
     }
 }
@@ -215,7 +219,8 @@ static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
      * rid of anything that doesn't do VMX */
     g_assert(env->insns_flags & PPC_ALTIVEC);
     if (!(env->insns_flags2 & PPC2_VSX)) {
-        error_setg(errp, "VSX support not available, try cap-vsx=off");
+        error_setg(errp, "VSX support not available,"
+                   CAPABILITY_HINT("cap-vsx=off"));
     }
 }
 
@@ -229,7 +234,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
         return;
     }
     if (!(env->insns_flags2 & PPC2_DFP)) {
-        error_setg(errp, "DFP support not available, try cap-dfp=off");
+        error_setg(errp, "DFP support not available,"
+                   CAPABILITY_HINT("cap-dfp=off"));
     }
 }
 
@@ -253,7 +259,8 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
                    cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe cache capability level not supported by kvm, try cap-cfpc=%s",
+                   "Requested safe cache capability level not supported by kvm,"
+                   CAPABILITY_HINT("cap-cfpc=%s"),
                    cap_cfpc_possible.vals[kvm_val]);
     }
 
@@ -281,7 +288,8 @@ static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
                    cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe bounds check capability level not supported by kvm, try cap-sbbc=%s",
+"Requested safe bounds check capability level not supported by kvm,"
+                   CAPABILITY_HINT("cap-sbbc=%s"),
                    cap_sbbc_possible.vals[kvm_val]);
     }
 
@@ -312,7 +320,8 @@ static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
                    cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe indirect branch capability level not supported by kvm, try cap-ibs=%s",
+"Requested safe indirect branch capability level not supported by kvm,"
+                   CAPABILITY_HINT("cap-ibs=%s"),
                    cap_ibs_possible.vals[kvm_val]);
     }
 
@@ -401,11 +410,13 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
 
     if (tcg_enabled()) {
         error_setg(errp,
-                   "No Nested KVM-HV support in tcg, try cap-nested-hv=off");
+                   "No Nested KVM-HV support in tcg,"
+                   CAPABILITY_HINT("cap-nested-hv=off"));
     } else if (kvm_enabled()) {
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
-"KVM implementation does not support Nested KVM-HV, try cap-nested-hv=off");
+"KVM implementation does not support Nested KVM-HV,"
+                       CAPABILITY_HINT("cap-nested-hv=off"));
         } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
                 error_setg(errp,
 "Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
@@ -435,10 +446,12 @@ static void cap_large_decr_apply(SpaprMachineState *spapr,
 
         if (!kvm_nr_bits) {
             error_setg(errp,
-                       "No large decrementer support, try cap-large-decr=off");
+                       "No large decrementer support,"
+                        CAPABILITY_HINT("cap-large-decr=off"));
         } else if (pcc->lrg_decr_bits != kvm_nr_bits) {
             error_setg(errp,
-"KVM large decrementer size (%d) differs to model (%d), try -cap-large-decr=off",
+"KVM large decrementer size (%d) differs to model (%d),"
+                CAPABILITY_HINT("cap-large-decr=off"),
                 kvm_nr_bits, pcc->lrg_decr_bits);
         }
     }
@@ -454,7 +467,8 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
     if (kvm_enabled()) {
         if (kvmppc_enable_cap_large_decr(cpu, val)) {
             error_setg(errp,
-                       "No large decrementer support, try cap-large-decr=off");
+                       "No large decrementer support,"
+                       CAPABILITY_HINT("cap-large-decr=off"));
         }
     }
 
@@ -474,10 +488,12 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
     if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp,
-"Requested count cache flush assist capability level not supported by tcg, try cap-ccf-assist=off");
+"Requested count cache flush assist capability level not supported by tcg,"
+                   CAPABILITY_HINT("cap-ccf-assist=off"));
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested count cache flush assist capability level not supported by kvm, try cap-ccf-assist=off");
+"Requested count cache flush assist capability level not supported by kvm,"
+                   CAPABILITY_HINT("cap-ccf-assist=off"));
     }
 }
 
-- 
2.21.0


