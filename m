Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF9C04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48202082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48202082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYiI-0003ew-SQ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:11:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNYh0-0002qj-1g
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNYgy-0000Tb-JJ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:09:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41880
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNYgy-0000T5-EZ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:09:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4688oOg049820
	for <qemu-devel@nongnu.org>; Mon, 6 May 2019 04:09:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sagbja75h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 04:09:43 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 May 2019 09:09:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 6 May 2019 09:09:39 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4689cZ558458174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 6 May 2019 08:09:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BBA3A4060;
	Mon,  6 May 2019 08:09:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1458AA405F;
	Mon,  6 May 2019 08:09:38 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.26.205])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2019 08:09:38 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Mon, 06 May 2019 10:09:37 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050608-0020-0000-0000-00000339B885
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050608-0021-0000-0000-0000218C4BB0
Message-Id: <155713017771.272495.17615824973869586988.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-06_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905060071
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] spapr: Allow machine to dump dtb after SLOF
 update
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that SLOF can update QEMU's device tree at runtime, it makes sense
to be able to dump the resulting dtb, pretty much like it is already
possible to dump the initial dtb with the dumpdtb machine option.

Add a new dumpdtb-slof property to the pseries machine with the same
semantics as dumpdtb, except that the dtb is dumped at the first call
to h_update_dt() and QEMU exits right after that.

The dtb size sanity check is skipped on purpose so that one has a chance
to peek into the dump file and see what's wrong. If the size is big enough
to cause g_malloc0() to fail then QEMU will abort though. This is likely
not ever to happen, and anyway, we don't really care because dumpdtb-slof
is for developpers, not production, and they should try to debug at the
SLOF level in this case.

Even if 3.1 and older machine types don't support device tree updates, it
doesn't hurt to let them dump the dtb and exit anyway, and it seems better
to ensure a consistent behaviour for this feature.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   19 +++++++++++++++++++
 hw/ppc/spapr_hcall.c   |   22 ++++++++++++++--------
 include/hw/ppc/spapr.h |    1 +
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ce84806ee3d5..18de51d03bd1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3322,6 +3322,19 @@ static void spapr_set_host_serial(Object *obj, const char *value, Error **errp)
     spapr->host_serial = g_strdup(value);
 }
 
+static char *spapr_get_dumpdtb_slof(Object *obj, Error **errp)
+{
+    return g_strdup(SPAPR_MACHINE(obj)->dumpdtb_slof);
+}
+
+static void spapr_set_dumpdtb_slof(Object *obj, const char *value, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    g_free(spapr->dumpdtb_slof);
+    spapr->dumpdtb_slof = g_strdup(value);
+}
+
 static void spapr_instance_init(Object *obj)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
@@ -3378,6 +3391,12 @@ static void spapr_instance_init(Object *obj)
         &error_abort);
     object_property_set_description(obj, "host-serial",
         "Host serial number to advertise in guest device tree", &error_abort);
+
+    object_property_add_str(obj, "dumpdtb-slof", spapr_get_dumpdtb_slof,
+                            spapr_set_dumpdtb_slof, &error_abort);
+    object_property_set_description(obj, "dumpdtb-slof",
+                                    "Dump SLOF dtb to a file and quit",
+                                    &error_abort);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6c16d2b12040..30a3880cf1d6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1766,20 +1766,26 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
     cb = fdt32_to_cpu(hdr.totalsize);
 
-    if (!smc->update_dt_enabled) {
-        return H_SUCCESS;
-    }
+    if (!spapr->dumpdtb_slof) {
+        if (!smc->update_dt_enabled) {
+            return H_SUCCESS;
+        }
 
-    /* Check that the fdt did not grow out of proportion */
-    if (cb > spapr->fdt_initial_size * 2) {
-        trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
-                                          fdt32_to_cpu(hdr.magic));
-        return H_PARAMETER;
+        /* Check that the fdt did not grow out of proportion */
+        if (cb > spapr->fdt_initial_size * 2) {
+            trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
+                                              fdt32_to_cpu(hdr.magic));
+            return H_PARAMETER;
+        }
     }
 
     fdt = g_malloc0(cb);
     cpu_physical_memory_read(dt, fdt, cb);
 
+    if (spapr->dumpdtb_slof) {
+        exit(g_file_set_contents(spapr->dumpdtb_slof, fdt, cb, NULL) ? 0 : 1);
+    }
+
     /* Check the fdt consistency */
     if (fdt_check_full(fdt, cb)) {
         trace_spapr_update_dt_failed_check(spapr->fdt_initial_size, cb,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7e32f309c2be..72a5ff7bfee9 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -191,6 +191,7 @@ struct SpaprMachineState {
     char *kvm_type;
     char *host_model;
     char *host_serial;
+    char *dumpdtb_slof;
 
     int32_t irq_map_nr;
     unsigned long *irq_map;


