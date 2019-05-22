Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ECEC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DBB20863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DBB20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRYG-0005I0-DT
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:45:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTRX8-0004fO-Rp
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTRX7-0000Dn-OD
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:43:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43224
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hTRX7-0000DF-J2
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:43:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4MDdJYQ049398
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:43:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sn68xbp3w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:43:52 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 22 May 2019 14:43:50 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 22 May 2019 14:43:48 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
	[9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4MDhlRw59572388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 22 May 2019 13:43:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B14D42041;
	Wed, 22 May 2019 13:43:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D4F942047;
	Wed, 22 May 2019 13:43:47 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.23.58])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2019 13:43:47 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 May 2019 15:43:46 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052213-0016-0000-0000-0000027E5795
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052213-0017-0000-0000-000032DB49BE
Message-Id: <155853262675.1158324.17301777846476373459.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-22_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905220099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] spapr: Don't migrate the hpt_maxpagesize cap
 to older machine types
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 0b8c89be7f7b added the hpt_maxpagesize capability to the migration
stream. This is okay for new machine types but it breaks backward migration
to older QEMUs, which don't expect the extra subsection.

Add a compatibility boolean flag to the sPAPR machine class and use it to
skip migration of the capability for machine types 4.0 and older. This
fixes migration to an older QEMU. Note that the destination will emit a
warning:

qemu-system-ppc64: warning: cap-hpt-max-page-size lower level (16) in incoming stream than on destination (24)

This is expected and harmless though. It is okay to migrate from a lower
HPT maximum page size (64k) to a greater one (16M).

Fixes: 0b8c89be7f7b "spapr: Add forgotten capability to migration stream"
Based-on: <20190522074016.10521-3-clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---

Please notice that this is based on Cedric's patch that make "dual" the
default for the ic-mode property.
---
 hw/ppc/spapr.c         |    1 +
 hw/ppc/spapr_caps.c    |   12 +++++++++++-
 include/hw/ppc/spapr.h |    1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4fd16b43f014..e2b33e5890ae 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4431,6 +4431,7 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     smc->phb_placement = phb_placement_4_0;
     smc->irq = &spapr_irq_xics;
+    smc->pre_4_1_migration = true;
 }
 
 DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 658eb15a147b..31b466139975 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -64,6 +64,7 @@ typedef struct SpaprCapabilityInfo {
     void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
     void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                       uint8_t val, Error **errp);
+    bool (*migrate_needed)(void *opaque);
 } SpaprCapabilityInfo;
 
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
@@ -350,6 +351,11 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
     spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
 }
 
+static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
+{
+    return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_1_migration;
+}
+
 static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
                               uint32_t pshift)
 {
@@ -542,6 +548,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "int",
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
+        .migrate_needed = cap_hpt_maxpagesize_migrate_needed,
     },
     [SPAPR_CAP_NESTED_KVM_HV] = {
         .name = "nested-hv",
@@ -679,8 +686,11 @@ int spapr_caps_post_migration(SpaprMachineState *spapr)
 static bool spapr_cap_##sname##_needed(void *opaque)    \
 {                                                       \
     SpaprMachineState *spapr = opaque;                  \
+    bool (*needed)(void *opaque) =                      \
+        capability_table[cap].migrate_needed;           \
                                                         \
-    return spapr->cmd_line_caps[cap] &&                 \
+    return needed ? needed(opaque) : true &&            \
+           spapr->cmd_line_caps[cap] &&                 \
            (spapr->eff.caps[cap] !=                     \
             spapr->def.caps[cap]);                      \
 }                                                       \
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9fc91c8f5eac..4f5becf1f3cc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -119,6 +119,7 @@ struct SpaprMachineClass {
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
     bool broken_host_serial_model; /* present real host info to the guest */
+    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 


