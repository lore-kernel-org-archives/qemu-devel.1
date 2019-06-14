Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A896CC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E2220850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E2220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbm0R-00072c-KL
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hblxs-0006Ob-MJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hblxo-00032b-PP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:09:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41698
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hblxn-00031F-LF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:09:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5ED4S1u119901
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 09:09:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t49bxf7s3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 09:09:12 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 14 Jun 2019 14:09:08 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Jun 2019 14:09:04 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5ED93I747513654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 13:09:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 656D552054;
 Fri, 14 Jun 2019 13:09:03 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.152.28])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 139BD5204F;
 Fri, 14 Jun 2019 13:09:03 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 14 Jun 2019 15:09:02 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061413-0012-0000-0000-000003292368
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061413-0013-0000-0000-0000216233DC
Message-Id: <156051774276.244890.8660277280145466396.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-14_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] hw: Nuke hw_compat_4_0_1 and pc_compat_4_0_1
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 elohimes@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit c87759ce876a fixed a regression affecting pc-q35 machines by
introducing a new pc-q35-4.0.1 machine version to be used instead
of pc-q35-4.0. The only purpose was to revert the default behaviour
of not using split irqchip, but the change also introduced the usual
hw_compat and pc_compat bits, and wired them for pc-q35 only.

This raises questions when it comes to add new compat properties for
4.0* machine versions of any architecture. Where to add them ? In
4.0, 4.0.1 or both ? Error prone. Another possibility would be to teach
all other architectures about 4.0.1. This solution isn't satisfying,
especially since this is a pc-q35 specific issue.

It turns out that the split irqchip default is handled in the machine
option function and doesn't involve compat lists at all.

Drop all the 4.0.1 compat lists and use the 4.0 ones instead in the 4.0.1
machine option function.

Move the compat props that were added to the 4.0.1 since c87759ce876a to
4.0.

Even if only hw_compat_4_0_1 had an impact on other architectures,
drop pc_compat_4_0_1 as well for consistency.

Fixes: c87759ce876a "q35: Revert to kernel irqchip"
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/core/machine.c    |    5 +----
 hw/i386/pc.c         |    3 ---
 hw/i386/pc_q35.c     |   12 ++++++++----
 include/hw/boards.h  |    3 ---
 include/hw/i386/pc.h |    3 ---
 5 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 84ebb8d24701..ea5a01aa49bc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,16 +24,13 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
-GlobalProperty hw_compat_4_0_1[] = {
+GlobalProperty hw_compat_4_0[] = {
     { "VGA",            "edid", "false" },
     { "secondary-vga",  "edid", "false" },
     { "bochs-display",  "edid", "false" },
     { "virtio-vga",     "edid", "false" },
     { "virtio-gpu-pci", "edid", "false" },
 };
-const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
-
-GlobalProperty hw_compat_4_0[] = {};
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
 GlobalProperty hw_compat_3_1[] = {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2c5446b0951e..1a1935825ad2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -111,9 +111,6 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
-GlobalProperty pc_compat_4_0_1[] = {};
-const size_t pc_compat_4_0_1_len = G_N_ELEMENTS(pc_compat_4_0_1);
-
 GlobalProperty pc_compat_4_0[] = {};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dcddc6466200..57232aed6b6c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -378,8 +378,13 @@ static void pc_q35_4_0_1_machine_options(MachineClass *m)
 {
     pc_q35_4_1_machine_options(m);
     m->alias = NULL;
-    compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
-    compat_props_add(m->compat_props, pc_compat_4_0_1, pc_compat_4_0_1_len);
+    /*
+     * This is the default machine for the 4.0-stable branch. It is basically
+     * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
+     * 4.0 compat props.
+     */
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
 DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
@@ -390,8 +395,7 @@ static void pc_q35_4_0_machine_options(MachineClass *m)
     pc_q35_4_0_1_machine_options(m);
     m->default_kernel_irqchip_split = true;
     m->alias = NULL;
-    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+    /* Compat props are applied by the 4.0.1 machine */
 }
 
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index b7362af3f1d2..eaa050a7ab50 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -293,9 +293,6 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
-extern GlobalProperty hw_compat_4_0_1[];
-extern const size_t hw_compat_4_0_1_len;
-
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a7d0b8716604..c54cc54a4799 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -293,9 +293,6 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
-extern GlobalProperty pc_compat_4_0_1[];
-extern const size_t pc_compat_4_0_1_len;
-
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
 


