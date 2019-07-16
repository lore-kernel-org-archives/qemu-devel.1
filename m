Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553CC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC2720659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC2720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIm0-0005FV-HS
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36559)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1hnIln-0004lH-2e
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1hnIll-0005zL-TY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:25:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47144
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hnIll-0005yl-Ny
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:25:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6G8LrU1050096
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 04:25:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ts9a5mbp1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 04:25:04 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Tue, 16 Jul 2019 09:25:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Jul 2019 09:25:00 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6G8Oxs433292358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 08:24:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 191F14C044;
 Tue, 16 Jul 2019 08:24:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BF144C046;
 Tue, 16 Jul 2019 08:24:58 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2019 08:24:58 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Date: Tue, 16 Jul 2019 03:24:57 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071608-4275-0000-0000-0000034D5EAD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071608-4276-0000-0000-0000385D6FCA
Message-Id: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-16_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] ppc: Fix some memory leaks
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

valgrind showed some memory leaks while running qemu-system-ppc64.
Fixing them in this patch.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_caps.c  |    2 ++
 hw/ppc/spapr_drc.c   |    5 ++++-
 hw/ppc/spapr_hcall.c |    2 ++
 target/ppc/kvm.c     |    3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index bbb001f84a..8e3350f777 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -786,11 +786,13 @@ void spapr_caps_add_properties(SpaprMachineClass *smc, Error **errp)
                                   NULL, cap, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
+            g_free((char *)name);
             return;
         }
 
         desc = g_strdup_printf("%s", cap->description);
         object_class_property_set_description(klass, name, desc, &local_err);
+        g_free((char *)name);
         g_free(desc);
         if (local_err) {
             error_propagate(errp, local_err);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index bacadfcac5..37fbfe6900 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -827,6 +827,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
         Object *obj;
         SpaprDrc *drc;
         SpaprDrcClass *drck;
+        const char *drc_name = NULL;
         uint32_t drc_index, drc_power_domain;
 
         if (!strstart(prop->type, "link<", NULL)) {
@@ -856,8 +857,10 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
         g_array_append_val(drc_power_domains, drc_power_domain);
 
         /* ibm,drc-names */
-        drc_names = g_string_append(drc_names, spapr_drc_name(drc));
+        drc_name = spapr_drc_name(drc);
+        drc_names = g_string_append(drc_names, drc_name);
         drc_names = g_string_insert_len(drc_names, -1, "\0", 1);
+        g_free((char *)drc_name);
 
         /* ibm,drc-types */
         drc_types = g_string_append(drc_types, drck->typename);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6808d4cda8..0fc58156a0 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1612,6 +1612,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     ov5_updates = spapr_ovec_new();
     spapr->cas_reboot = spapr_ovec_diff(ov5_updates,
                                         ov5_cas_old, spapr->ov5_cas);
+    spapr_ovec_cleanup(ov5_cas_old);
     /* Now that processing is finished, set the radix/hash bit for the
      * guest if it requested a valid mode; otherwise terminate the boot. */
     if (guest_radix) {
@@ -1640,6 +1641,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) != 0);
     }
+    spapr_ovec_cleanup(ov1_guest);
 
     /*
      * Ensure the guest asks for an interrupt mode we support; otherwise
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a06d3171e..498ca6d53b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -491,7 +491,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
-    idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
+    if (!idle_timer)
+        idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
 
     switch (cenv->mmu_model) {
     case POWERPC_MMU_BOOKE206:


