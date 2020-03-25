Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6772FC54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBEA20409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBEA20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7vf-0003k0-FA
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jH7uo-0002TW-EO
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jH7un-00079K-65
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8872
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jH7un-000794-0l
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PF43vB111098
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywet52hd6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:56 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 25 Mar 2020 15:25:50 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Mar 2020 15:25:48 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFPoWB38142128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:25:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D55C5A4067;
 Wed, 25 Mar 2020 15:25:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9932A4062;
 Wed, 25 Mar 2020 15:25:50 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.41.106])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2020 15:25:50 +0000 (GMT)
Subject: [PATCH 4/4] spapr: Drop CAS reboot flag
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 25 Mar 2020 16:25:49 +0100
In-Reply-To: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
References: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032515-4275-0000-0000-000003B2D76E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032515-4276-0000-0000-000038C81651
Message-Id: <158514994893.478799.11772512888322840990.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1034 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=2
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CAS reboot flag is false by default and all the locations that
could set it to true have been dropped. This means that all code
blocks depending on the flag being set is dead code and the other
code blocks should be executed always.

Just do that and drop the now uneeded CAS reboot flag. Fix a
comment on the way to make checkpatch happy.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   18 ++++--------------
 hw/ppc/spapr_hcall.c   |   33 ++++++++++++++-------------------
 include/hw/ppc/spapr.h |    1 -
 3 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c522cd205fee..4c46578b1387 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1579,9 +1579,7 @@ void spapr_setup_hpt(SpaprMachineState *spapr)
 {
     int hpt_shift;
 
-    if ((spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED)
-        || (spapr->cas_reboot
-            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
+    if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
     } else {
         uint64_t current_ram_size;
@@ -1645,16 +1643,10 @@ static void spapr_machine_reset(MachineState *machine)
 
     qemu_devices_reset();
 
-    /*
-     * If this reset wasn't generated by CAS, we should reset our
-     * negotiated options and start from scratch
-     */
-    if (!spapr->cas_reboot) {
-        spapr_ovec_cleanup(spapr->ov5_cas);
-        spapr->ov5_cas = spapr_ovec_new();
+    spapr_ovec_cleanup(spapr->ov5_cas);
+    spapr->ov5_cas = spapr_ovec_new();
 
-        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
-    }
+    ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
 
     /*
      * This is fixing some of the default configuration of the XIVE
@@ -1707,8 +1699,6 @@ static void spapr_machine_reset(MachineState *machine)
     spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, 0, fdt_addr, 0);
     first_ppc_cpu->env.gpr[5] = 0;
 
-    spapr->cas_reboot = false;
-
     spapr->fwnmi_system_reset_addr = -1;
     spapr->fwnmi_machine_check_addr = -1;
     spapr->fwnmi_machine_check_interlock = -1;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b424bca4d2c0..0fe8da3c9359 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1678,6 +1678,7 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
     bool raw_mode_supported = false;
     bool guest_xive;
     CPUState *cs;
+    void *fdt;
 
     /* CAS is supposed to be called early when only the boot vCPU is active. */
     CPU_FOREACH(cs) {
@@ -1817,27 +1818,21 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
 
     spapr_handle_transient_dev_before_cas(spapr);
 
-    if (!spapr->cas_reboot) {
-        void *fdt;
-
-        /* If spapr_machine_reset() did not set up a HPT but one is necessary
-         * (because the guest isn't going to use radix) then set it up here. */
-        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
-            /* legacy hash or new hash: */
-            spapr_setup_hpt(spapr);
-        }
-
-        fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
-
-        g_free(spapr->fdt_blob);
-        spapr->fdt_size = fdt_totalsize(fdt);
-        spapr->fdt_initial_size = spapr->fdt_size;
-        spapr->fdt_blob = fdt;
+    /*
+     * If spapr_machine_reset() did not set up a HPT but one is necessary
+     * (because the guest isn't going to use radix) then set it up here.
+     */
+    if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
+        /* legacy hash or new hash: */
+        spapr_setup_hpt(spapr);
     }
 
-    if (spapr->cas_reboot) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
-    }
+    fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size = fdt_totalsize(fdt);
+    spapr->fdt_initial_size = spapr->fdt_size;
+    spapr->fdt_blob = fdt;
 
     return H_SUCCESS;
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b7e13e5aafb7..e579eaf28c05 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -178,7 +178,6 @@ struct SpaprMachineState {
     SpaprEventSource *event_sources;
 
     /* ibm,client-architecture-support option negotiation */
-    bool cas_reboot;
     bool cas_pre_isa3_guest;
     SpaprOptionVector *ov5;         /* QEMU-supported option vectors */
     SpaprOptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */


