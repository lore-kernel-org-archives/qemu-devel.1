Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7727C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC35206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Bs6a3C6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC35206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCA0-000277-Ss
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC6z-00059P-Jz
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:05 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com
 ([40.107.94.73]:37344 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC6w-0003uV-2I
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrkbXmEL4JkUe0KsYMnkTfgjuWZsIZS5oBR01Y3crM2y8MjEziKPC3k2+bvMA3uAE6SpIG88g5Saxjw/HZqWFBQXGSndsTo7QDMD0fSdbJ41/lOVeUTezwYi6fygn57C9rTbmgFvtGHxpxMoBSjoDBqljCuqDrIy+9IfSo+Oq2t4SBIdv3L/VOsRvrz32hzqP+5TqWIrpHaWrr6QwW0s1SzKDkptWbCammtQHJIjFpFsLe3Jh8nqxeBCjwNGeSmai6OSesH57ZybVAAfRUcs/KvgAL+C+2AMzz8fM6EKWQ0IkBaBpSUun+6hyvX/2GNIysFblR0jzZlSonwEtip6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUeNmFjAPFyqGor4e03Zece3+ySpxSOYPpwOHZIGd5c=;
 b=aVKZNONn4dMnRfOc/UlHAJh6m2Im94roRMVX8F/xoMOZPBVpl2dp7OtGEk0xZ+joIDBfXFqWuILJcnj06xwr1vBV3rRTsChdbiqQN+nLAx0mRRhBK5HU7KPwbSzonK0tbueZ2RcWOzFcjTrsZBM9MQ3cLIg2Vwq8VaYgzIB66fb+6/irgKz/qpcaMuuhQ1tTLaZBEdYDBrUjdKdlOo7V1i+wmEUhPfXJClRb4m3OVjQVlSNe4BkEpLfH3Qo9bRcRODRCYKnYBVZM7d5kYsAKMWhGtO2UMxl1geCjMgtx2+pDBXhXIXwRvPSdBugX1RqRBAGhvQzFxDuY2wuDP8LL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUeNmFjAPFyqGor4e03Zece3+ySpxSOYPpwOHZIGd5c=;
 b=Bs6a3C6h51vrqWjVt3u75H3BiqeHBUrBX6L0uqNhRHslWJe0VNraruebiVtF1y/vjZ21/nDDblIjKdmzQSovdSkU9u3bSpvjkx6pOstNg59Kqqm2w5Pf9g9vBbfppur9ftvH9VdTHXS9aWFN6vhO7XIFk6hIOG6sDd7EQQYN8wg=
Received: from SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) by CH2PR02MB7047.namprd02.prod.outlook.com
 (2603:10b6:610:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Mon, 11 May
 2020 17:05:56 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::57) by SN4PR0401CA0034.outlook.office365.com
 (2603:10b6:803:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30 via Frontend
 Transport; Mon, 11 May 2020 17:05:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 17:05:56
 +0000
Received: from [149.199.38.66] (port=35077 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBs4-0007nB-TO
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:40 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBsK-0004Py-1j
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:56 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BH5psI000793; 
 Mon, 11 May 2020 10:05:52 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYBsF-0004PW-P7; Mon, 11 May 2020 10:05:51 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/4] target/microblaze: gdb: Add dynamic GDB XML register
 support
Date: Mon, 11 May 2020 10:05:48 -0700
Message-Id: <1589216751-106038-2-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
References: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(136003)(396003)(346002)(39860400002)(46966005)(33430700001)(6666004)(336012)(44832011)(316002)(36756003)(33440700001)(82310400002)(2906002)(2616005)(426003)(86362001)(356005)(107886003)(478600001)(70206006)(81166007)(70586007)(6916009)(7696005)(82740400003)(8676002)(8936002)(186003)(9786002)(47076004)(26005)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da4eb191-8113-421e-beef-08d7f5cd9212
X-MS-TrafficTypeDiagnostic: CH2PR02MB7047:
X-Microsoft-Antispam-PRVS: <CH2PR02MB704714E2A5382F8EB573098DD0A10@CH2PR02MB7047.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rlePO0zG5nYjIx8Y3CPiDETq+G6OONthpvB7S6Pd9SGg5SVjgTcvPZ6Wxcjbws1qQ6EsMNjDIKZmeDPOaDvbFfJzF7+3+RIZRTBKf7E3eIWPpdOV4gKOZwAytCh80Rr1gxBVMMLETbPNReHUY7GC9UUjsHvu5SmH0occojLgCtpagImRU7jRkwZp4kpOR6cv/NUJleCV0wOkcC0KUePJq4QhXgturVHpxKm3r+X6rtAwtGivl/wWVX81H5Ypv6t0Cjgg0dBKp/lhVOCMQe5YJlJnbF/UAYani1lwA0gatbYhmNiKWkqYISrbwGilOzessWwaRIxbSQTc597fuGuKHVCtQ3yYFJYJXVq0WW3SJ83cmMbKPV58HftQiynhNAh2xi7cZV4EsggsXHz3QbKalsJepjW2e0HRdWE1n9P4vdnEJ0VXeuema8WxTpBPyAM13rLp/Nl4st3NqYVRRpmR6PTL78B4vrzxSaBgs+cR0Km+EUxaNcjRdJYCcMToXw/BvVVSiiaMmbVCv82oALgAjMbh0OS8H1p2opZtlfBdKnzgPdI+z7kdAyAhE3iEYov1zg01ZvEceop0nNeKXJHtQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 17:05:56.3987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4eb191-8113-421e-beef-08d7f5cd9212
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7047
Received-SPF: pass client-ip=40.107.94.73; envelope-from=komlodi@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 13:20:59
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
 target/microblaze/cpu.c     |   4 ++
 target/microblaze/cpu.h     |   9 ++++
 target/microblaze/gdbstub.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)

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


