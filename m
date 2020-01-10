Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACEFC33CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E744420661
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E744420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipw1A-0003LM-AW
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1ipvz6-0001L3-Pa
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1ipvz2-0000qI-E4
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1ipvz2-0000k7-4z; Fri, 10 Jan 2020 10:13:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00AFC3sS054415; Fri, 10 Jan 2020 10:13:51 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xe6ywpawx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 10:13:51 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00AFCAW0055331;
 Fri, 10 Jan 2020 10:13:51 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xe6ywpawg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 10:13:51 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00AFCaAv015445;
 Fri, 10 Jan 2020 15:13:50 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 2xajb8dhxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 15:13:50 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00AFDnk557541046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2020 15:13:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37042C605B;
 Fri, 10 Jan 2020 15:13:49 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA3DFC6059;
 Fri, 10 Jan 2020 15:13:47 +0000 (GMT)
Received: from farosas.linux.ibm.com.br.ibm.com (unknown [9.86.27.174])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jan 2020 15:13:47 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/3] target/ppc: Clarify the meaning of return values in
 kvm_handle_debug
Date: Fri, 10 Jan 2020 12:13:42 -0300
Message-Id: <20200110151344.278471-2-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200110151344.278471-1-farosas@linux.ibm.com>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-10_01:2020-01-10,
 2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=985
 priorityscore=1501 impostorscore=0 suspectscore=1 bulkscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001100129
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kvm_handle_debug function can return 0 to go back into the guest
or return 1 to notify the gdbstub thread and pass control to GDB.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/kvm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d1c334f0e3..0bd4a8d399 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -53,6 +53,9 @@
 
 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
 
+#define DEBUG_RETURN_GUEST 0
+#define DEBUG_RETURN_GDB   1
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
@@ -1570,7 +1573,7 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 static int kvm_handle_hw_breakpoint(CPUState *cs,
                                     struct kvm_debug_exit_arch *arch_info)
 {
-    int handle = 0;
+    int handle = DEBUG_RETURN_GUEST;
     int n;
     int flag = 0;
 
@@ -1578,13 +1581,13 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
         if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
             n = find_hw_breakpoint(arch_info->address, GDB_BREAKPOINT_HW);
             if (n >= 0) {
-                handle = 1;
+                handle = DEBUG_RETURN_GDB;
             }
         } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
                                         KVMPPC_DEBUG_WATCH_WRITE)) {
             n = find_hw_watchpoint(arch_info->address,  &flag);
             if (n >= 0) {
-                handle = 1;
+                handle = DEBUG_RETURN_GDB;
                 cs->watchpoint_hit = &hw_watchpoint;
                 hw_watchpoint.vaddr = hw_debug_points[n].addr;
                 hw_watchpoint.flags = flag;
@@ -1596,12 +1599,12 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
 
 static int kvm_handle_singlestep(void)
 {
-    return 1;
+    return DEBUG_RETURN_GDB;
 }
 
 static int kvm_handle_sw_breakpoint(void)
 {
-    return 1;
+    return DEBUG_RETURN_GDB;
 }
 
 static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
@@ -1653,7 +1656,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     env->error_code = POWERPC_EXCP_INVAL;
     ppc_cpu_do_interrupt(cs);
 
-    return 0;
+    return DEBUG_RETURN_GUEST;
 }
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
-- 
2.23.0


