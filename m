Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F0420659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jSfNh7Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F0420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvrn-0007OU-J6
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoS-0001Vl-LH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:00 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com
 ([40.107.220.61]:60865 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoQ-00005g-DA
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHT0cqZ7y26A3XE+KFfesXF4CPeMm+BQ4I9BaNopyQK9Hrl4eLiKcXekjzV123shRQAdq+0FFKvcl1PmaQrnoctSbyrXst9vroVCAp6iuQ2DsQAYz0HKlhowP8JG6czzJXK64uGwp7xVUaPuP/kdoxFSjHMiQRLAyP0p0JNP94jX4bmrMxYiBztO7PqU1BywJYuTrrQzVJq3QV//vLb0B9hgPhYv6pU3q3X92cvdzUmF6wz2Wp/ENPfX2JJ7jDgDqzYtRfv2ZAlc+Pv+JW9u/9t1y4vO+X5ymCuN2QlTVyKReqOBXCoss+RkOa9L3KxkAqy0UD4SaDeVQ5L0fryreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3/E5s3M1pyvNPe5X4gSp7YzbDfRRSSw1oTxzgwvkkI=;
 b=HmZFNc0yWQR1QA0lEQ4ytsBgE+SWQVhSAb57SD4UACj2TYH6fp6S86f734GpMXk6jCMkMlZp5sAd7ACZKwI+rnocZQGFfC95R2HPjcB0evLTsgktqQQ3lLeQXjKKHuMGRr5QmKd0KOADx/+H6LUCke+vWoyETI7D0GJJSUXGJiqjh5NAMqUo+Xkruc8MUxEzF+21GtX6rKSYlGeQIQE0bJi9qFJAj8Vrf5IhKC/s46gWNJc9XMELtMqWisi0ZCuPUqpzRvV/YG8jAYmQ1ZqWH6pzHmOnywBAsuRLwB32ViEFzb4w5YUEyxaCkcB6crx7eqXkQEo6uQ3SFWRQrmVoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3/E5s3M1pyvNPe5X4gSp7YzbDfRRSSw1oTxzgwvkkI=;
 b=jSfNh7Z6qcEQe+9DUQzS7MkbSkURJqhdde9OdyZ8pJJFaqz/kO0ZP7ABvz3OQXFklLRKZCGUVXl5blafFryfvfMwEMIaQxl/SgSWQAkvp1URqM923dxstyoWboPSE0CmBG/9HAgitHWBkPw/CKlGv4L9M/tqGtB2BQvj0PPoHVI=
Received: from MN2PR17CA0036.namprd17.prod.outlook.com (2603:10b6:208:15e::49)
 by MN2PR02MB6592.namprd02.prod.outlook.com (2603:10b6:208:1d8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 13 May
 2020 18:08:55 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:15e:cafe::e5) by MN2PR17CA0036.outlook.office365.com
 (2603:10b6:208:15e::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Wed, 13 May 2020 18:08:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 18:08:54
 +0000
Received: from [149.199.38.66] (port=59430 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvo4-0007yD-NY
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:36 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvoM-0002TI-IX
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:54 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYvoI-0002SZ-0V; Wed, 13 May 2020 11:08:50 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 1/4] target/microblaze: gdb: Add dynamic GDB XML register
 support
Date: Wed, 13 May 2020 11:08:45 -0700
Message-Id: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(33430700001)(33440700001)(86362001)(9786002)(26005)(186003)(44832011)(36756003)(7696005)(478600001)(6916009)(21490400003)(8676002)(82310400002)(82740400003)(356005)(8936002)(2906002)(6666004)(4326008)(5660300002)(426003)(2616005)(336012)(81166007)(107886003)(70586007)(316002)(47076004)(70206006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc814e0f-739f-4bc5-af8c-08d7f768b314
X-MS-TrafficTypeDiagnostic: MN2PR02MB6592:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6592447F9679D494E203F5E6D0BF0@MN2PR02MB6592.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nm0E8Mkz6Hus7q2k2n6HVkwmqiC1+zD989ggBZJsRSuClqut9xqDBOP5748IASJywIIgAbbX9XLQ/NiFS/1BI9UdwbCXSo+Tb6AangIasGdVaH38yS1PC372yNYNF8XmISMej9s6gx8eRIdBo7IlOVZXy+aCPh5JI549wTIJXudL0KG68Sk8WLP8L9CRu5BdWbfKddbEx4bkb/zh0pDFX1GAxpte1it0cTFUlrc0c38dWsBkGR5YHlLN7iLTVuIw2EiE7LYO+TRZx8b5IEjDLX/F49pwIu3NGXnDWHy4GDj4NVgah6x9F/fOj4KcmKuSvks2S+/0FwR05KgxDDYHCYaILhw9cxFn1glHHrkygyTYSGZcsWEDbWkwUWJooGEyadqVSNxgWsZibwURTHm0RGyo38SJ3HAU60YrSXQQnun5gYSFnFS+2f9V9rlo48lIAEz5bz8KmKuVkBhCR/LAUZmUnZmUBifnf6wCZ/fMhYF/iXDhxCQUGmhp9t6djVNOrDf6GOEmUAHNunYPWxGhCZ4i+f5CSvdvqxxwnPM6o70tmN8tZF/c5I9J7dgoXivgQa6p6hQND+9ybwmeENPRkA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 18:08:54.9321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc814e0f-739f-4bc5-af8c-08d7f768b314
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6592
Received-SPF: pass client-ip=40.107.220.61; envelope-from=komlodi@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:08:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add dynamic GDB register XML for Microblaze, and modify the config file to
use XML when building for Microblaze.
For the dynamic XML to be read, there still needs to be a core XML file.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 configure                   |   1 +
 gdb-xml/microblaze-core.xml |  64 +++++++++++++++++++++++
 target/microblaze/cpu.c     |   4 ++
 target/microblaze/cpu.h     |   9 ++++
 target/microblaze/gdbstub.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 gdb-xml/microblaze-core.xml

diff --git a/configure b/configure
index 0d69c36..5a099b6 100755
--- a/configure
+++ b/configure
@@ -7832,6 +7832,7 @@ case "$target_name" in
     TARGET_ARCH=microblaze
     TARGET_SYSTBL_ABI=common
     bflt="yes"
+    gdb_xml_files="microblaze-core.xml"
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips|mipsel)
diff --git a/gdb-xml/microblaze-core.xml b/gdb-xml/microblaze-core.xml
new file mode 100644
index 0000000..13e2c08
--- /dev/null
+++ b/gdb-xml/microblaze-core.xml
@@ -0,0 +1,64 @@
+<?xml version="1.0"?>
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.microblaze.core">
+  <reg name="r0" bitsize="32"/>
+  <reg name="r1" bitsize="32" type="data_ptr"/>
+  <reg name="r2" bitsize="32"/>
+  <reg name="r3" bitsize="32"/>
+  <reg name="r4" bitsize="32"/>
+  <reg name="r5" bitsize="32"/>
+  <reg name="r6" bitsize="32"/>
+  <reg name="r7" bitsize="32"/>
+  <reg name="r8" bitsize="32"/>
+  <reg name="r9" bitsize="32"/>
+  <reg name="r10" bitsize="32"/>
+  <reg name="r11" bitsize="32"/>
+  <reg name="r12" bitsize="32"/>
+  <reg name="r13" bitsize="32"/>
+  <reg name="r14" bitsize="32" type="code_ptr"/>
+  <reg name="r15" bitsize="32" type="code_ptr"/>
+  <reg name="r16" bitsize="32" type="code_ptr"/>
+  <reg name="r17" bitsize="32"/>
+  <reg name="r18" bitsize="32"/>
+  <reg name="r19" bitsize="32"/>
+  <reg name="r20" bitsize="32"/>
+  <reg name="r21" bitsize="32"/>
+  <reg name="r22" bitsize="32"/>
+  <reg name="r23" bitsize="32"/>
+  <reg name="r24" bitsize="32"/>
+  <reg name="r25" bitsize="32"/>
+  <reg name="r26" bitsize="32"/>
+  <reg name="r27" bitsize="32"/>
+  <reg name="r28" bitsize="32"/>
+  <reg name="r29" bitsize="32"/>
+  <reg name="r30" bitsize="32"/>
+  <reg name="r31" bitsize="32"/>
+  <reg name="rpc" bitsize="32" type="code_ptr"/>
+  <reg name="rmsr" bitsize="32"/>
+  <reg name="rear" bitsize="32"/>
+  <reg name="resr" bitsize="32"/>
+  <reg name="rfsr" bitsize="32"/>
+  <reg name="rbtr" bitsize="32"/>
+  <reg name="rpvr0" bitsize="32"/>
+  <reg name="rpvr1" bitsize="32"/>
+  <reg name="rpvr2" bitsize="32"/>
+  <reg name="rpvr3" bitsize="32"/>
+  <reg name="rpvr4" bitsize="32"/>
+  <reg name="rpvr5" bitsize="32"/>
+  <reg name="rpvr6" bitsize="32"/>
+  <reg name="rpvr7" bitsize="32"/>
+  <reg name="rpvr8" bitsize="32"/>
+  <reg name="rpvr9" bitsize="32"/>
+  <reg name="rpvr10" bitsize="32"/>
+  <reg name="rpvr11" bitsize="32"/>
+  <reg name="redr" bitsize="32"/>
+  <reg name="rpid" bitsize="32"/>
+  <reg name="rzpr" bitsize="32"/>
+  <reg name="rtlbx" bitsize="32"/>
+  <reg name="rtlbsx" bitsize="32"/>
+  <reg name="rtlblo" bitsize="32"/>
+  <reg name="rtlbhi" bitsize="32"/>
+  <reg name="rslr" bitsize="32"/>
+  <reg name="rshr" bitsize="32"/>
+</feature>
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index aa99830..41cac1b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -226,6 +226,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     env->pvr.regs[11] = (cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
                         16 << 17;
 
+    mb_gen_dynamic_xml(cpu);
+
     mcc->parent_realize(dev, errp);
 }
 
@@ -330,6 +332,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_mb_cpu;
     device_class_set_props(dc, mb_properties);
     cc->gdb_num_core_regs = 32 + 5;
+    cc->gdb_get_dynamic_xml = mb_gdb_get_dynamic_xml;
+    cc->gdb_core_xml_file = "microblaze-core.xml";
 
     cc->disas_set_info = mb_disas_set_info;
     cc->tcg_initialize = mb_tcg_init;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a31134b..074a18e 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -25,6 +25,8 @@
 #include "fpu/softfloat-types.h"
 
 typedef struct CPUMBState CPUMBState;
+typedef struct DynamicMBGDBXMLInfo DynamicMBGDBXMLInfo;
+
 #if !defined(CONFIG_USER_ONLY)
 #include "mmu.h"
 #endif
@@ -272,6 +274,10 @@ struct CPUMBState {
     } pvr;
 };
 
+struct DynamicMBGDBXMLInfo {
+    char *xml;
+};
+
 /**
  * MicroBlazeCPU:
  * @env: #CPUMBState
@@ -286,6 +292,7 @@ struct MicroBlazeCPU {
 
     CPUNegativeOffsetState neg;
     CPUMBState env;
+    DynamicMBGDBXMLInfo dyn_xml;
 
     /* Microblaze Configuration Settings */
     struct {
@@ -321,6 +328,8 @@ void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void mb_gen_dynamic_xml(MicroBlazeCPU *cpu);
+const char *mb_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname);
 
 void mb_tcg_init(void);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index f41ebf1..cdca434 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -54,3 +54,126 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
     return 4;
 }
+
+static void mb_gen_xml_reg_tag(const MicroBlazeCPU *cpu, GString *s,
+                               const char *name, uint8_t bitsize,
+                               const char *type)
+{
+    g_string_append_printf(s, "<reg name=\"%s\" bitsize=\"%d\"",
+                           name, bitsize);
+    if (type) {
+        g_string_append_printf(s, " type=\"%s\"", type);
+    }
+    g_string_append_printf(s, "/>\n");
+}
+
+static uint8_t mb_cpu_sreg_size(const MicroBlazeCPU *cpu, uint8_t index)
+{
+    /*
+     * NOTE:  mb-gdb will refuse to connect if we say registers are
+     * larger then 32-bits.
+     * For now, say none of our registers are dynamically sized, and are
+     * therefore only 32-bits.
+     */
+
+    return 32;
+}
+
+static void mb_gen_xml_reg_tags(const MicroBlazeCPU *cpu, GString *s)
+{
+    uint8_t i;
+    const char *type;
+    char reg_name[4];
+    bool has_hw_exception = cpu->cfg.dopb_bus_exception ||
+                            cpu->cfg.iopb_bus_exception ||
+                            cpu->cfg.illegal_opcode_exception ||
+                            cpu->cfg.opcode_0_illegal ||
+                            cpu->cfg.div_zero_exception ||
+                            cpu->cfg.unaligned_exceptions;
+
+    static const char *reg_types[32] = {
+        [1] = "data_ptr",
+        [14] = "code_ptr",
+        [15] = "code_ptr",
+        [16] = "code_ptr",
+        [17] = "code_ptr"
+    };
+
+    for (i = 0; i < 32; ++i) {
+        type = reg_types[i];
+        /* r17 only has a code_ptr tag if we have HW exceptions */
+        if (i == 17 && !has_hw_exception) {
+            type = NULL;
+        }
+
+        sprintf(reg_name, "r%d", i);
+        mb_gen_xml_reg_tag(cpu, s, reg_name, 32, type);
+    }
+}
+
+static void mb_gen_xml_sreg_tags(const MicroBlazeCPU *cpu, GString *s)
+{
+    uint8_t i;
+
+    static const char *sreg_names[] = {
+        "rpc",
+        "rmsr",
+        "rear",
+        "resr",
+        "rfsr",
+        "rbtr",
+        "rpvr0",
+        "rpvr1",
+        "rpvr2",
+        "rpvr3",
+        "rpvr4",
+        "rpvr5",
+        "rpvr6",
+        "rpvr7",
+        "rpvr8",
+        "rpvr9",
+        "rpvr10",
+        "rpvr11",
+        "redr",
+        "rpid",
+        "rzpr",
+        "rtlblo",
+        "rtlbhi",
+        "rtlbx",
+        "rtlbsx",
+        "rslr",
+        "rshr"
+    };
+
+    static const char *sreg_types[ARRAY_SIZE(sreg_names)] = {
+        [SR_PC] = "code_ptr"
+    };
+
+    for (i = 0; i < ARRAY_SIZE(sreg_names); ++i) {
+        mb_gen_xml_reg_tag(cpu, s, sreg_names[i], mb_cpu_sreg_size(cpu, i),
+                           sreg_types[i]);
+    }
+}
+
+void mb_gen_dynamic_xml(MicroBlazeCPU *cpu)
+{
+    GString *s = g_string_new(NULL);
+
+    g_string_printf(s, "<?xml version=\"1.0\"?>\n"
+                       "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">\n"
+                       "<feature name=\"org.gnu.gdb.microblaze.core\">\n");
+
+    mb_gen_xml_reg_tags(cpu, s);
+    mb_gen_xml_sreg_tags(cpu, s);
+
+    g_string_append_printf(s, "</feature>");
+
+    cpu->dyn_xml.xml = g_string_free(s, false);
+}
+
+const char *mb_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    return cpu->dyn_xml.xml;
+}
-- 
2.7.4


