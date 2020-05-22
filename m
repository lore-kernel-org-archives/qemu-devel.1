Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB71C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D102420663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DYjCn0Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D102420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbz89-0004o0-Uh
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 00:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jbz7b-0004Mu-Jr
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:17:23 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com
 ([40.107.220.87]:53857 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jbz7Z-0008Nd-RW
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:17:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm3I+LK69fCXd0YJsU7kB+KhNfINgIeikN3kmS2d+MBID8W2rWnPRmI/c0DqWAptXa/WuY+oPq9rg8AXwZuwK5/mRnLGQsyNuQJOpb2Nzs9G4zHxPDFBY69u4GQKtOmEfb/Rpk5xoaPVmIyjAzd8il/7mANAA0aN+DiHFce5zZL52HhLpfaSMysl0yRVWofl07ueHJTNYXPyyWlhI0F8Rf9i3CYGPn388M3iilm+znE75XBX9n82Fx4TvtVWU/gippas9XYc4116P6pYRA4iJGTlOgDYBBxmJkSbvlwkm7aDznLWejTiuExxRT/pMag3FeZUgQ9b3NsmGGGv7gdFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPB/leU5i3Zd/T9qlRjbyw8mXQYLTUDKK0l914jfV9o=;
 b=d108jvSx9ZaqlKYisSKgSu3X5NWDWotqIdwvXm9JHlUGtWTot5PzMnUoa6tXFfNkAwrzp9udX+4Xw3+8qzboRmZOZadBxbjkS2oq6Kb361bMJQuGkm7zjoRRNUdEbt3GyHIj8yc2+55oNlRQHzGU7gHIck/G3exjgkm9GurbEmZsVejNDwMtIjdReEwMuGXsiqKebqJ6vn0XpEKAUQJ+cYqf1i/LPjdL4PXkU5BK0ISzjtNX5nq4m9zVg4BdbhB5OdcXhcQ1mIBP8eo+Nft5IRTYi7saT30HMvVI4BkK321WCFwjlyP7ocMbdmp5DVkauDaa4Lh32nC/XozC61GM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPB/leU5i3Zd/T9qlRjbyw8mXQYLTUDKK0l914jfV9o=;
 b=DYjCn0FdLFUGpueSwZVBbv/zZuGn2j6T/x4IKYtlT0LJAJ6C4kZm19jlzHTVmlWJ50xMC6mCe6x7OTU1kam+dyqGPKcn2nb69RmaaUVbnx9z1/IVlk1RYwxaqjGVxjPplo2E/f+vqWS9Ra+MGm5IiL24JvqNch75M91oTpf1ONg=
Received: from CY4PR06CA0025.namprd06.prod.outlook.com (2603:10b6:903:77::11)
 by MWHPR02MB2734.namprd02.prod.outlook.com (2603:10b6:300:10b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Fri, 22 May
 2020 04:02:17 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:77:cafe::16) by CY4PR06CA0025.outlook.office365.com
 (2603:10b6:903:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 04:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 04:02:16
 +0000
Received: from [149.199.38.66] (port=37150 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jbysV-0005Ei-AD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:01:47 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jbysy-00025n-Do
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:02:16 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04M42Es7016834; 
 Thu, 21 May 2020 21:02:14 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jbysw-000253-4Z; Thu, 21 May 2020 21:02:14 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] target/microblaze: Add GDB XML files for Microblaze
Date: Thu, 21 May 2020 21:02:13 -0700
Message-Id: <1590120134-39470-1-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(136003)(396003)(39860400002)(46966005)(8676002)(316002)(5660300002)(36756003)(426003)(478600001)(86362001)(107886003)(4326008)(6916009)(7696005)(186003)(8936002)(47076004)(21490400003)(26005)(2616005)(9786002)(2906002)(82310400002)(356005)(336012)(82740400003)(81166007)(70206006)(70586007)(44832011)(2004002)(42866002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44350fe1-1739-4aa6-18aa-08d7fe04eaab
X-MS-TrafficTypeDiagnostic: MWHPR02MB2734:
X-Microsoft-Antispam-PRVS: <MWHPR02MB27342AB2868B62D5CC032C7CD0B40@MWHPR02MB2734.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jLlf3WBJdkpakpc8YjOJ9oNSnwxuv2oSPCb1JB2cvJQUba+oHhuDM/RLoLQMWG1YuPp3JcT95+fzvZBMQrIb02tpy133rHeTK0VfufHs0IOyO3jZpQLyBXk/k0GEf6anfz1+2ZpESvAaopgFCuaMz9yt3nxGPeBWyvk0+/+5YEtf2xvPNEANIskX49YuuMUP2QRR42Vf8rlEtHLKCPb2DhERq03w9XKnkCETpHRqXvmR6o/V+5hTp71616VTudr5oQYYPOFQFtfIKLWWYqHRVkOrXGcxpWWtNpRPWR+x3j+lUdt+vFVBIgMiRerXdMjXm6YreK/RoECaeidYTnhoDZ0LC8sFskE6xoSZWJGJqYB5D9Mb+IyahQsva5Mvt0hPKKCvQmZ2hgiJp9A33xv+Bx1wuurWT8icEAUMgZ/ZHbMKJUWd25jxwTvehAAZ+Wc
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 04:02:16.6600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44350fe1-1739-4aa6-18aa-08d7fe04eaab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2734
Received-SPF: pass client-ip=40.107.220.87; envelope-from=komlodi@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 00:17:19
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

This adds the Microblaze core and stack protect XML files, and also
modifies the configuration to build those files.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 configure                            |  1 +
 gdb-xml/microblaze-core.xml          | 62 ++++++++++++++++++++++++++++++++++++
 gdb-xml/microblaze-stack-protect.xml | 12 +++++++
 target/microblaze/cpu.c              |  1 +
 4 files changed, 76 insertions(+)
 create mode 100644 gdb-xml/microblaze-core.xml
 create mode 100644 gdb-xml/microblaze-stack-protect.xml

diff --git a/configure b/configure
index 2fc05c4..8aed2fd 100755
--- a/configure
+++ b/configure
@@ -7832,6 +7832,7 @@ case "$target_name" in
     TARGET_ARCH=microblaze
     TARGET_SYSTBL_ABI=common
     bflt="yes"
+    gdb_xml_files="microblaze-core.xml microblaze-stack-protect.xml"
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips|mipsel)
diff --git a/gdb-xml/microblaze-core.xml b/gdb-xml/microblaze-core.xml
new file mode 100644
index 0000000..d30e596
--- /dev/null
+++ b/gdb-xml/microblaze-core.xml
@@ -0,0 +1,62 @@
+<?xml version="1.0"?>
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.microblaze.core">
+  <reg name="r0" bitsize="32" regnum="0"/>
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
+</feature>
diff --git a/gdb-xml/microblaze-stack-protect.xml b/gdb-xml/microblaze-stack-protect.xml
new file mode 100644
index 0000000..1b16223
--- /dev/null
+++ b/gdb-xml/microblaze-stack-protect.xml
@@ -0,0 +1,12 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2014-2020 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.microblaze.stack-protect">
+  <reg name="rslr" bitsize="32"/>
+  <reg name="rshr" bitsize="32"/>
+</feature>
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 51e5c85..faa88e5 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -330,6 +330,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_mb_cpu;
     device_class_set_props(dc, mb_properties);
     cc->gdb_num_core_regs = 32 + 27;
+    cc->gdb_core_xml_file = "microblaze-core.xml";
 
     cc->disas_set_info = mb_disas_set_info;
     cc->tcg_initialize = mb_tcg_init;
-- 
2.7.4


