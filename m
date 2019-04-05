Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03042C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B925B2175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B925B2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCJtq-00021M-Tv
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 04:08:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCJsM-00016i-Lk
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCJsJ-00020z-AZ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:07:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34022
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hCJsI-0001y7-WA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:06:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3586Vw1107199
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 04:06:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rp0vswvx2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 04:06:40 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 5 Apr 2019 09:05:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 5 Apr 2019 09:05:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3585PZF50200590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 5 Apr 2019 08:05:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77FC8AE05D;
	Fri,  5 Apr 2019 08:05:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA66AE05F;
	Fri,  5 Apr 2019 08:05:25 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.20.25])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2019 08:05:25 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Fri, 05 Apr 2019 10:05:24 +0200
In-Reply-To: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
References: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040508-0028-0000-0000-0000035D8AA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040508-0029-0000-0000-0000241C9C5B
Message-Id: <155445152490.302073.17033451726459859333.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-05_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904050060
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 2/2] target/ppc/kvm: Convert DPRINTF to traces
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
	qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405080524.p3a2DObzvTU4DJaEnLqZ1Fgtz0Wn3H_IlstkLtgLEi0@z>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c        |   68 +++++++++++++++++++----------------------------
 target/ppc/trace-events |   25 +++++++++++++++++
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2427c8ee13ae..3a11d2e1060c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,16 +49,6 @@
 #include "elf.h"
 #include "sysemu/kvm_int.h"
 
-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
@@ -626,7 +616,7 @@ static int kvm_put_fp(CPUState *cs)
         reg.addr = (uintptr_t)&fpscr;
         ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set FPSCR to KVM: %s\n", strerror(errno));
+            trace_kvm_failed_fpscr_set(strerror(errno));
             return ret;
         }
 
@@ -647,8 +637,8 @@ static int kvm_put_fp(CPUState *cs)
 
             ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to set %s%d to KVM: %s\n", vsx ? "VSR" : "FPR",
-                        i, strerror(errno));
+                trace_kvm_failed_fp_set(vsx ? "VSR" : "FPR", i,
+                                        strerror(errno));
                 return ret;
             }
         }
@@ -659,7 +649,7 @@ static int kvm_put_fp(CPUState *cs)
         reg.addr = (uintptr_t)&env->vscr;
         ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set VSCR to KVM: %s\n", strerror(errno));
+            trace_kvm_failed_vscr_set(strerror(errno));
             return ret;
         }
 
@@ -668,7 +658,7 @@ static int kvm_put_fp(CPUState *cs)
             reg.addr = (uintptr_t)cpu_avr_ptr(env, i);
             ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to set VR%d to KVM: %s\n", i, strerror(errno));
+                trace_kvm_failed_vr_set(i, strerror(errno));
                 return ret;
             }
         }
@@ -693,7 +683,7 @@ static int kvm_get_fp(CPUState *cs)
         reg.addr = (uintptr_t)&fpscr;
         ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to get FPSCR from KVM: %s\n", strerror(errno));
+            trace_kvm_failed_fpscr_get(strerror(errno));
             return ret;
         } else {
             env->fpscr = fpscr;
@@ -709,8 +699,8 @@ static int kvm_get_fp(CPUState *cs)
 
             ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to get %s%d from KVM: %s\n",
-                        vsx ? "VSR" : "FPR", i, strerror(errno));
+                trace_kvm_failed_fp_get(vsx ? "VSR" : "FPR", i,
+                                        strerror(errno));
                 return ret;
             } else {
 #ifdef HOST_WORDS_BIGENDIAN
@@ -733,7 +723,7 @@ static int kvm_get_fp(CPUState *cs)
         reg.addr = (uintptr_t)&env->vscr;
         ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to get VSCR from KVM: %s\n", strerror(errno));
+            trace_kvm_failed_vscr_get(strerror(errno));
             return ret;
         }
 
@@ -742,8 +732,7 @@ static int kvm_get_fp(CPUState *cs)
             reg.addr = (uintptr_t)cpu_avr_ptr(env, i);
             ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
             if (ret < 0) {
-                DPRINTF("Unable to get VR%d from KVM: %s\n",
-                        i, strerror(errno));
+                trace_kvm_failed_vr_get(i, strerror(errno));
                 return ret;
             }
         }
@@ -764,7 +753,7 @@ static int kvm_get_vpa(CPUState *cs)
     reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to get VPA address from KVM: %s\n", strerror(errno));
+        trace_kvm_failed_vpa_addr_get(strerror(errno));
         return ret;
     }
 
@@ -774,8 +763,7 @@ static int kvm_get_vpa(CPUState *cs)
     reg.addr = (uintptr_t)&spapr_cpu->slb_shadow_addr;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to get SLB shadow state from KVM: %s\n",
-                strerror(errno));
+        trace_kvm_failed_slb_get(strerror(errno));
         return ret;
     }
 
@@ -785,8 +773,7 @@ static int kvm_get_vpa(CPUState *cs)
     reg.addr = (uintptr_t)&spapr_cpu->dtl_addr;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to get dispatch trace log state from KVM: %s\n",
-                strerror(errno));
+        trace_kvm_failed_dtl_get(strerror(errno));
         return ret;
     }
 
@@ -812,7 +799,7 @@ static int kvm_put_vpa(CPUState *cs)
         reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
         ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(errno));
+            trace_kvm_failed_vpa_addr_set(strerror(errno));
             return ret;
         }
     }
@@ -823,7 +810,7 @@ static int kvm_put_vpa(CPUState *cs)
     reg.addr = (uintptr_t)&spapr_cpu->slb_shadow_addr;
     ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to set SLB shadow state to KVM: %s\n", strerror(errno));
+        trace_kvm_failed_slb_set(strerror(errno));
         return ret;
     }
 
@@ -833,8 +820,7 @@ static int kvm_put_vpa(CPUState *cs)
     reg.addr = (uintptr_t)&spapr_cpu->dtl_addr;
     ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
     if (ret < 0) {
-        DPRINTF("Unable to set dispatch trace log state to KVM: %s\n",
-                strerror(errno));
+        trace_kvm_failed_dtl_set(strerror(errno));
         return ret;
     }
 
@@ -843,7 +829,7 @@ static int kvm_put_vpa(CPUState *cs)
         reg.addr = (uintptr_t)&spapr_cpu->vpa_addr;
         ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
         if (ret < 0) {
-            DPRINTF("Unable to set VPA address to KVM: %s\n", strerror(errno));
+            trace_kvm_failed_null_vpa_addr_set(strerror(errno));
             return ret;
         }
     }
@@ -996,7 +982,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 
         if (cap_papr) {
             if (kvm_put_vpa(cs) < 0) {
-                DPRINTF("Warning: Unable to set VPA information to KVM\n");
+                trace_kvm_failed_put_vpa();
             }
         }
 
@@ -1296,7 +1282,7 @@ int kvm_arch_get_registers(CPUState *cs)
 
         if (cap_papr) {
             if (kvm_get_vpa(cs) < 0) {
-                DPRINTF("Warning: Unable to get VPA information from KVM\n");
+                trace_kvm_failed_get_vpa();
             }
         }
 
@@ -1352,7 +1338,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
          */
         irq = KVM_INTERRUPT_SET;
 
-        DPRINTF("injected interrupt %d\n", irq);
+        trace_kvm_injected_interrupt(irq);
         r = kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
         if (r < 0) {
             printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
@@ -1697,20 +1683,20 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     switch (run->exit_reason) {
     case KVM_EXIT_DCR:
         if (run->dcr.is_write) {
-            DPRINTF("handle dcr write\n");
+            trace_kvm_handle_dcr_write();
             ret = kvmppc_handle_dcr_write(env, run->dcr.dcrn, run->dcr.data);
         } else {
-            DPRINTF("handle dcr read\n");
+            trace_kvm_handle_drc_read();
             ret = kvmppc_handle_dcr_read(env, run->dcr.dcrn, &run->dcr.data);
         }
         break;
     case KVM_EXIT_HLT:
-        DPRINTF("handle halt\n");
+        trace_kvm_handle_halt();
         ret = kvmppc_handle_halt(cpu);
         break;
 #if defined(TARGET_PPC64)
     case KVM_EXIT_PAPR_HCALL:
-        DPRINTF("handle PAPR hypercall\n");
+        trace_kvm_handle_papr_hcall();
         run->papr_hcall.ret = spapr_hypercall(cpu,
                                               run->papr_hcall.nr,
                                               run->papr_hcall.args);
@@ -1718,18 +1704,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         break;
 #endif
     case KVM_EXIT_EPR:
-        DPRINTF("handle epr\n");
+        trace_kvm_handle_epr();
         run->epr.epr = ldl_phys(cs->as, env->mpic_iack);
         ret = 0;
         break;
     case KVM_EXIT_WATCHDOG:
-        DPRINTF("handle watchdog expiry\n");
+        trace_kvm_handle_watchdog_expiry();
         watchdog_perform_action();
         ret = 0;
         break;
 
     case KVM_EXIT_DEBUG:
-        DPRINTF("handle debug exception\n");
+        trace_kvm_handle_debug_exception();
         if (kvm_handle_debug(cpu, run)) {
             ret = EXCP_DEBUG;
             break;
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index ed4d57c6d9c1..7b3cfe11fdfe 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -3,3 +3,28 @@
 # kvm.c
 kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
 kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
+kvm_failed_fpscr_set(const char *msg) "Unable to set FPSCR to KVM: %s"
+kvm_failed_fp_set(const char *fpname, int fpnum, const char *msg) "Unable to set %s%d to KVM: %s"
+kvm_failed_vscr_set(const char *msg) "Unable to set VSCR to KVM: %s"
+kvm_failed_vr_set(int vr, const char *msg) "Unable to set VR%d to KVM: %s"
+kvm_failed_fpscr_get(const char *msg) "Unable to get FPSCR from KVM: %s"
+kvm_failed_fp_get(const char *fpname, int fpnum, const char *msg) "Unable to get %s%d from KVM: %s"
+kvm_failed_vscr_get(const char *msg) "Unable to get VSCR from KVM: %s"
+kvm_failed_vr_get(int vr, const char *msg) "Unable to get VR%d from KVM: %s"
+kvm_failed_vpa_addr_get(const char *msg) "Unable to get VPA address from KVM: %s"
+kvm_failed_slb_get(const char *msg) "Unable to get SLB shadow state from KVM: %s"
+kvm_failed_dtl_get(const char *msg) "Unable to get dispatch trace log state from KVM: %s"
+kvm_failed_vpa_addr_set(const char *msg) "Unable to set VPA address to KVM: %s"
+kvm_failed_slb_set(const char *msg) "Unable to set SLB shadow state to KVM: %s"
+kvm_failed_dtl_set(const char *msg) "Unable to set dispatch trace log state to KVM: %s"
+kvm_failed_null_vpa_addr_set(const char *msg) "Unable to set VPA address to KVM: %s"
+kvm_failed_put_vpa(void) "Warning: Unable to set VPA information to KVM"
+kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KVM"
+kvm_injected_interrupt(int irq) "injected interrupt %d"
+kvm_handle_dcr_write(void) "handle dcr write"
+kvm_handle_drc_read(void) "handle dcr read"
+kvm_handle_halt(void) "handle halt"
+kvm_handle_papr_hcall(void) "handle PAPR hypercall"
+kvm_handle_epr(void) "handle epr"
+kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
+kvm_handle_debug_exception(void) "handle debug exception"


