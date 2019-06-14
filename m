Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72183C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AE5208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 11:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AE5208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbkK7-0000j0-GL
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 07:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbkCS-0002RV-Fz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbk5R-0003N1-AS
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:09:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbk5Q-0003Lo-Us
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:09:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5EB73WC136449
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:09:35 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t48cudctq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:09:34 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 14 Jun 2019 12:09:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Jun 2019 12:09:18 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5EB9Hwo61538540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 11:09:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA0AC11C054;
 Fri, 14 Jun 2019 11:09:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0DC011C050;
 Fri, 14 Jun 2019 11:09:17 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.152.28])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2019 11:09:17 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jun 2019 13:09:17 +0200
In-Reply-To: <156051052402.224162.13664250996245267046.stgit@bahia.lan>
References: <156051052402.224162.13664250996245267046.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061411-0012-0000-0000-000003291A3B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061411-0013-0000-0000-000021622A10
Message-Id: <156051055736.224162.11641594431517798715.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140093
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 6/7] ppc: Introduce kvmppc_set_reg_tb_offset()
 helper
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

Introduce a KVM helper and its stub instead of guarding the code with
CONFIG_KVM.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/ppc.c         |    5 +----
 target/ppc/kvm.c     |    9 +++++++++
 target/ppc/kvm_ppc.h |    5 +++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 288196dfa67a..a9e508c496de 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1034,10 +1034,7 @@ static void timebase_load(PPCTimebase *tb)
     CPU_FOREACH(cpu) {
         PowerPCCPU *pcpu = POWERPC_CPU(cpu);
         pcpu->env.tb_env->tb_offset = tb_off_adj;
-#if defined(CONFIG_KVM)
-        kvm_set_one_reg(cpu, KVM_REG_PPC_TB_OFFSET,
-                        &pcpu->env.tb_env->tb_offset);
-#endif
+        kvmppc_set_reg_tb_offset(pcpu, pcpu->env.tb_env->tb_offset);
     }
 }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d4107dd70d21..cde39904510a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2939,3 +2939,12 @@ void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online)
         kvm_set_one_reg(cs, KVM_REG_PPC_ONLINE, &online);
     }
 }
+
+void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (kvm_enabled()) {
+        kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
+    }
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 45776cad79d9..e642aaaf9226 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -80,6 +80,7 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 bool kvmppc_hpt_needs_host_contiguous_pages(void);
 void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
 void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
+void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
 
 #else
 
@@ -206,6 +207,10 @@ static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
     return;
 }
 
+static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
+{
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline bool kvmppc_spapr_use_multitce(void)
 {


