Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C1BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC31120679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31dy-000377-Lv
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i31d0-0002Hj-7s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i31cz-00080V-0U
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:21:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i31cy-0007z7-PQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:21:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7SHCCIO006152
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 13:20:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2unuc065ff-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 13:20:58 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 28 Aug 2019 18:20:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 28 Aug 2019 18:20:54 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7SHKru950266220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 17:20:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A850F11C050;
 Wed, 28 Aug 2019 17:20:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77DC211C04A;
 Wed, 28 Aug 2019 17:20:53 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.62.210])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 28 Aug 2019 17:20:53 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 28 Aug 2019 19:20:53 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082817-0008-0000-0000-0000030E5593
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082817-0009-0000-0000-00004A2C96A9
Message-Id: <156701285312.499757.7807417667750711711.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-28_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] spapr: Set compat mode in spapr_core_plug()
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A recent change in spapr_machine_reset() showed that resetting the compat
mode in spapr_machine_reset() for the boot vCPU and in spapr_cpu_reset()
for all other vCPUs was fragile. The fix was thus to reset the compat mode
for all vCPUs in spapr_machine_reset(), but we still have to propagate
it to hot-plugged CPUs. This is still performed from spapr_cpu_reset(),
hence resulting in ppc_set_compat() being called twice for every vCPU at
machine reset. Apart from wasting cycles, which isn't really an issue
during machine reset, this seems to indicate that spapr_cpu_reset() isn't
the best place to set the compat mode.

A natural candidate for CPU-hotplug specific code is spapr_core_plug().
Also, it sits in the same file as spapr_machine_reset() : this makes
it easier for someone who wants to know when the compat PVR is set.

Call ppc_set_compat() from there. This doesn't need to be done for
initial vCPUs since the compat PVR is 0 and spapr_machine_reset() sets
the appropriate value later. No need to do this on manually added vCPUS
on the destination QEMU during migration since the compat PVR is
part of the migrated vCPU state. Both conditions can be checked with
spapr_drc_hotplugged().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c          |   24 ++++++++++++++++--------
 hw/ppc/spapr_cpu_core.c |    7 -------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 447fb5c4eaaf..ea56499b4b3e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1758,12 +1758,6 @@ static void spapr_machine_reset(MachineState *machine)
         spapr_ovec_cleanup(spapr->ov5_cas);
         spapr->ov5_cas = spapr_ovec_new();
 
-        /*
-         * reset compat_pvr for all CPUs
-         * as qemu_devices_reset() is called before this,
-         * it can't be propagated by spapr_cpu_reset()
-         * from the first CPU to all the others
-         */
         ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
     }
 
@@ -3841,6 +3835,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUArchId *core_slot;
     int index;
     bool hotplugged = spapr_drc_hotplugged(dev);
+    int i;
 
     core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
     if (!core_slot) {
@@ -3874,13 +3869,26 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     core_slot->cpu = OBJECT(dev);
 
     if (smc->pre_2_10_has_unused_icps) {
-        int i;
-
         for (i = 0; i < cc->nr_threads; i++) {
             cs = CPU(core->threads[i]);
             pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
         }
     }
+
+    /*
+     * Set compatibility mode to match the boot CPU, which was either set
+     * by the machine reset code or by CAS.
+     */
+    if (hotplugged) {
+        for (i = 0; i < cc->nr_threads; i++) {
+            ppc_set_compat(core->threads[i], POWERPC_CPU(first_cpu)->compat_pvr,
+                           &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
+    }
 }
 
 static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 45e2f2747ffc..1d93de8161f3 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -41,13 +41,6 @@ static void spapr_cpu_reset(void *opaque)
      * using an RTAS call */
     cs->halted = 1;
 
-    /* Set compatibility mode to match the boot CPU, which was either set
-     * by the machine reset code or by CAS. This should never fail.
-     * At startup the value is already set for all the CPUs
-     * but we need this when we hotplug a new CPU
-     */
-    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
-
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];


