Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4269C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0DE20714
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FJeG0AIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0DE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYC96-0000tK-KM
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC6y-00056N-Lh
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:04 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com
 ([40.107.92.67]:10528 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC6w-0003uT-1W
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jozrcfD5844Hy8lyXgPNnM6hx/CTRFcGhx0Clvs4WnZXWrS78cKbjZGkQ4qHgfSE0n2jMCpqdKahIVnX9CGzRtO4iYXXuRWyL+PhfqOTWTSipKEtPiDOr2AlhsUnFARbrkOl9QZGVKtXds5SkHbgKynZ/hrAhgl0r0mLTM72SFZVXrshGWKuZQ8Rx6Gb6sIz4dsOOFFBoaRYW1laIxWuB76v9hOrafSe6sNm6KESnUZGQzE9f34wwSekH7vn0limL9g9T3qSEOq1PcZ9qVz+OGwNP92gPmqQmZmYHPGSSzRv8j9C4cDNlfbtkfvX6K8hQ2RCJMZO1kLpD2f2NS/Qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky2frw7xYYuP3OgTRuJ2N2y/8tHtihYuCes7f18Xri4=;
 b=Zo/g62hwEyZ2ufYGJ7YW6KDdFQZsSixNahhPJ3l0tlJyVvjc6hxVdN2rgGRrYg5TYc0pn6QQAi0jF6/WMqll25amFzDT3e7Y52YGALCeCxKIU9/R5p2P+5WQ4nES0HtIIN9fmV69A44oe7u7to7ankiNnKtMGhkrsD0/Yr8cEejGISYPj81JYIFBfyIVguC6VXu0pEFhs1n1JSXStjnj7RAGWuzUWdqLaYa31D/i1/3z66T+gbS362VsoDS70iEuCXnjVFnM00er8/wp1GDJzFmMkc5cgByB8G5Dx31sU1rkoFZxehHb4LslWHKV71a7KzoYdQeve7tb3Xfo1W5hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky2frw7xYYuP3OgTRuJ2N2y/8tHtihYuCes7f18Xri4=;
 b=FJeG0AIpv9VnMlkCR1Zqklv96oOQXFGYt5zZpzvOVmUR2oRNsn0X8RbHgqJIjmzayN1YOLIWvSh5QMoDh0XSKIl6xOIhkLCHCaHinB2EGLnKdCJAFnpudlz7fpbMfXcDWAUYN8bfipaPsv/cw9VvTeOFjEbIY7aXZi1RlJcJQDo=
Received: from SN4PR0501CA0033.namprd05.prod.outlook.com
 (2603:10b6:803:40::46) by MN2PR02MB6878.namprd02.prod.outlook.com
 (2603:10b6:208:20c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 17:05:57 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::d2) by SN4PR0501CA0033.outlook.office365.com
 (2603:10b6:803:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend
 Transport; Mon, 11 May 2020 17:05:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 17:05:56
 +0000
Received: from [149.199.38.66] (port=35080 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBs4-0007nE-Ul
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:40 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBsK-0004Py-3B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:56 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BH5pRC000795; 
 Mon, 11 May 2020 10:05:52 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYBsF-0004PW-Ql; Mon, 11 May 2020 10:05:51 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/4] target/microblaze: gdb: Extend the number of registers
 presented to GDB
Date: Mon, 11 May 2020 10:05:49 -0700
Message-Id: <1589216751-106038-3-git-send-email-komlodi@xilinx.com>
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
 SFS:(136003)(376002)(396003)(39860400002)(346002)(46966005)(33430700001)(26005)(186003)(47076004)(82740400003)(82310400002)(426003)(2616005)(86362001)(316002)(336012)(356005)(81166007)(33440700001)(478600001)(2906002)(8676002)(70586007)(4326008)(70206006)(107886003)(36756003)(9786002)(44832011)(7696005)(8936002)(6916009)(5660300002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84efa0b-df72-4ff8-f724-08d7f5cd920f
X-MS-TrafficTypeDiagnostic: MN2PR02MB6878:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6878D7B01CD071AC374DB7B8D0A10@MN2PR02MB6878.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aQCzDJXxuI+nUI5V3ns+v09wZE9MjZOSqdQrbTa/sGGwCD2aWRnY0iVQjoYzy/tpXnlw/NSYlR139kbKCpRBjz8ITmmu5U6yaIEuHeEbWpg7QJKdvfUFW6qyTN6CCYrai3shKBWvIp6a/CFrsCCj03yKkUY5CaH6Btd+osGJgyeXAI8573E+eS4B76JX4ghWKLSCtgbU8pxGLruGvIPzESyGA18mQLHmn5jw7NtNe1FBcL7zaZhQfT90qDSjLbE5SZvd/sXm5jxCB6Po0g1H7PZu7QqJVyNxRKfmkFftM4n0jYEt8QjfQbb9QeAZNB7HuJ3jaE4TDB+n87kfMVkpGH1akotCbaEojLprFxZHxRmNX/2hHGc2wWp9OOIgVBXf68P402c/MbIsJ2EIhHGm7gyId6UJ+d3/vjJ/jzc2iR0Y5S2FhF1aym5COXDZptZ3xWd2cDcUNTJauSFarSJ6hDO0UC09c2RXLr7xAIU+uZLU4+Q7tca2cZDkO3lWJPWKYZ2S1UCnRCAmfgHa7ATfMjw4/cP45i7OicdaRDQ6TJT9pmAbYOamcfi+OyNfR3U63ONMG2idI4qzx4tSuYiKQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 17:05:56.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84efa0b-df72-4ff8-f724-08d7f5cd920f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6878
Received-SPF: pass client-ip=40.107.92.67; envelope-from=komlodi@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Increase the number of Microblaze registers QEMU will report when
talking to GDB.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 target/microblaze/cpu.c     |  2 +-
 target/microblaze/gdbstub.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 41cac1b..5b6ad5b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -331,7 +331,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     dc->vmsd = &vmstate_mb_cpu;
     device_class_set_props(dc, mb_properties);
-    cc->gdb_num_core_regs = 32 + 5;
+    cc->gdb_num_core_regs = 32 + 27;
     cc->gdb_get_dynamic_xml = mb_gdb_get_dynamic_xml;
     cc->gdb_core_xml_file = "microblaze-core.xml";
 
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index cdca434..af29f00 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -26,12 +26,37 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
 
+    /*
+     * GDB expects registers to be reported in this order:
+     * R0-R31
+     * PC-BTR
+     * PVR0-PVR11
+     * EDR-TLBHI
+     * SLR-SHR
+     */
     if (n < 32) {
         return gdb_get_reg32(mem_buf, env->regs[n]);
     } else {
-        return gdb_get_reg32(mem_buf, env->sregs[n - 32]);
+        n -= 32;
+        switch (n) {
+        case 0 ... 5:
+            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        /* PVR12 is intentionally skipped */
+        case 6 ... 17:
+            n -= 6;
+            return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
+        case 18 ... 24:
+            /* Add an offset of 6 to resume where we left off with SRegs */
+            n = n - 18 + 6;
+            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        case 25:
+            return gdb_get_reg32(mem_buf, env->slr);
+        case 26:
+            return gdb_get_reg32(mem_buf, env->shr);
+        default:
+            return 0;
+        }
     }
-    return 0;
 }
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
@@ -50,7 +75,28 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < 32) {
         env->regs[n] = tmp;
     } else {
-        env->sregs[n - 32] = tmp;
+        n -= 32;
+        switch (n) {
+        case 0 ... 5:
+            env->sregs[n] = tmp;
+            break;
+        /* PVR12 is intentionally skipped */
+        case 6 ... 17:
+            n -= 6;
+            env->pvr.regs[n] = tmp;
+            break;
+        case 18 ... 24:
+            /* Add an offset of 6 to resume where we left off with SRegs */
+            n = n - 18 + 6;
+            env->sregs[n] = tmp;
+            break;
+        case 25:
+            env->slr = tmp;
+            break;
+        case 26:
+            env->shr = tmp;
+            break;
+        }
     }
     return 4;
 }
-- 
2.7.4


