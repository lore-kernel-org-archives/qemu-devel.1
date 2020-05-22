Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E044C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C660020812
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l8VsOCh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C660020812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc26C-0007R8-07
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 03:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jc25X-0006zY-ON
 for qemu-devel@nongnu.org; Fri, 22 May 2020 03:27:31 -0400
Received: from mail-eopbgr750045.outbound.protection.outlook.com
 ([40.107.75.45]:57828 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jc25V-0007wW-SG
 for qemu-devel@nongnu.org; Fri, 22 May 2020 03:27:27 -0400
Received: from BYAPR02MB5672.namprd02.prod.outlook.com (2603:10b6:a03:97::19)
 by DM6PR02MB5674.namprd02.prod.outlook.com (2603:10b6:5:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 07:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUYKZOxsuMswrifNqkbBY1KO7N3PoOXb7rsAsUCLUSty01plgIt/VBttBUjWh4x/MfRtU6525seiJ8SENb72Jrhp9bdVu3x2JHoRmkYFonJiQI3MFgrPg6bd63s4wsI6yKJdO+oBqnBZYhb1BIF17bJefQsTqSDXUr/T2E8bSemgjM2rFlZmCbMC2vJkvteO0ZG0+dNH86kvCpBJjyLVKZXEOG3J22UHW1hbRm1vUfVflSDJJ7SJJL0nvtCOKKpeKUrXnrnf6tKFfMnkK8/WV3OeAHS5nxRS0nxs3xeIurfUlcdN6s0JD2Tm6uHTGIJG6L4Oqi6GsHCZWo/DIra3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T1fzXbqFStGzT6XgjJTecdYzTv5xhVwpH9CorB49Cg=;
 b=BBvMzNTSICZ3z8p+ss22uBBP7pqBxiOz87vflaD5KRCox/j1kq2CPob7BAZHYfN4BRdytD/X5X9xev+4ts60UMF64Vbl7UcRJ7AJfyrNQnQjZdDFAbuf1XhStwodeSVwvyk2yReC4ba15quUNi+cskTEEJRO5iX4XTaoNRPyEh4Rr3DmX0sJLmo8Y+fCKAM4vfwRNypAmq4zFIQZeHmqKVQu0uoT/wi+p5sdPT5ACsDuhkuSzURPpZaVRO4jprOTbSp6d2nSZIdY5xBkcK0JECNvMkiaZA1MdUY+w8q8eu4KL1ruL/rypP1B3PnRTY4PSYMx7DOhlPtEwXnsYKMqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T1fzXbqFStGzT6XgjJTecdYzTv5xhVwpH9CorB49Cg=;
 b=l8VsOCh/ON578sY0B+JVEXuBwgd+TfOFdBbPcKArgyoTuy7Mq1GRZ90POHOy8KdACqboepuPtAUW0GvYC5MsjY4sGOzmiVCmrI+QEagF/pNuBZN66HKPOlxEPkuWuNocQri5pmzw9cfz8C3nLBtk6UlKeaBWIS9gwqJilAW67KM=
Received: from CY4PR15CA0015.namprd15.prod.outlook.com (2603:10b6:910:14::25)
 by BYAPR02MB5672.namprd02.prod.outlook.com (2603:10b6:a03:97::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Fri, 22 May
 2020 07:15:18 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:14:cafe::c9) by CY4PR15CA0015.outlook.office365.com
 (2603:10b6:910:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25 via Frontend
 Transport; Fri, 22 May 2020 07:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 07:15:17
 +0000
Received: from [149.199.38.66] (port=35339 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jc1tI-000228-BP
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:14:48 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jc1tl-0006xr-L6
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:15:17 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04M7F7tV013391; 
 Fri, 22 May 2020 00:15:07 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jc1ta-0006tF-Vb; Fri, 22 May 2020 00:15:07 -0700
Date: Fri, 22 May 2020 09:14:49 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH v1 0/1] target/microblaze: Add GDB XML files
Message-ID: <20200522071449.GI2945@toto>
References: <1590120134-39470-1-git-send-email-komlodi@xilinx.com>
 <1590120134-39470-2-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1590120134-39470-2-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(346002)(376002)(136003)(39860400002)(396003)(46966005)(6862004)(82740400003)(1076003)(4326008)(478600001)(8676002)(9786002)(356005)(2906002)(81166007)(70586007)(6666004)(33716001)(47076004)(426003)(70206006)(82310400002)(33656002)(316002)(8936002)(5660300002)(44144004)(336012)(235185007)(26005)(9686003)(186003)(66616009)(6636002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5d8960a-6a2e-4894-4810-08d7fe1fe19d
X-MS-TrafficTypeDiagnostic: BYAPR02MB5672:|DM6PR02MB5674:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5672D8622C2BC95A3D7767CCC2B40@BYAPR02MB5672.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5x+/fSQUG/DNagrhgpBpzi1ndRkUO5zm1iFvPHnd+JrN5s4UZzIBZym18L9JNYrLjUZuVLL+WOsN/7AbdFehwBMgO93kRbMXit4MLlxzCU+FIqHheKjDG2+z9vLHNNDuVxA9fZ6kdmYM/n+zVtaLE7Tf++O3ZC9BIQYvnNX1BEwIJQhdv8pB/yNGa5Lj90nHc4mVKWvdX2y+eJiRQtsAZVqu1sDTB09V1/h+Q8tKgrPUY5l1Cs1+Nm1NW1ymum81llej32w3SPbJKbICCh4G0s2IxOE8XQMxWfIVaAdwS+ye4D6LXeqbG5LE3BYK/5o3cp23lxsBmemQeF1QslecStyO6Sc/gd2SFA1L43ICYEGrjejgSov4O6su6AIs+E3j8HpPqcBlTujZuIUsPvmPpg21dLh+JXJagMIn1kbX9Jou8e4FAtZZMnrPQvnqFDM33XWCHjxBrIroq43xRAJU1ivETLuO3jCD0FVFuAA+ERc+rYQkgBpnGCIwq3mnO/kasB7AkYigxD2OPAqTyMDJV+z7v7Vqqy72qb/KIJQHPg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 07:15:17.8807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d8960a-6a2e-4894-4810-08d7fe1fe19d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5672
X-OriginatorOrg: xilinx.com
Received-SPF: pass client-ip=40.107.75.45; envelope-from=edgar@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 03:27:23
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 09:02:14PM -0700, Joe Komlodi wrote:
> Hi all,
> 
> This adds GDB XML files for Microblaze CPUs.
> For Microblaze, it's split up into core and stack protect XML files.

Hi Joe,

Can you please add a license header to microblaze-core.xml?
I think you wrote this on your own but in case you took it from
GDB (or if they actually are identical) we can keep GDB's
permissive license?

We also need to register the stackprot xml with
gdb_register_coprocessor().

I think you were right about lowering gdb_num_core_regs back to:
    cc->gdb_num_core_regs = 32 + 25;

Things work even if we keep 32 + 27 but I think it's a little
confusing. I've tried a version that uses:

    cc->gdb_num_core_regs = 32 + 25;

And registers stack-prot:
    gdb_register_coprocessor(cs, mb_sp_gdb_get_reg, mb_sp_gdb_set_reg,
                             2, "microblaze-stack-protect.xml", 32 + 25);

That works with GDB from upstream and with Xilinx XSDB.
Vitis 2019.2 microblaze gdb thinks SLR/SHR are 64bit for some
reason and doesn't handle them well with any QEMU version.
We should probably talk to the Vitis folks about changing their
version to match upstream GDB and XSDB.

I'm attaching the diff I used as reference.

Thanks,
Edgar

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a31134b65c..faa48493f6 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -321,6 +321,8 @@ void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+int mb_sp_gdb_get_reg(CPUMBState *env, GByteArray *buf, int n);
+int mb_sp_gdb_set_reg(CPUMBState *env, uint8_t *buf, int n);
 
 void mb_tcg_init(void);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index faa88e5865..c87257d928 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
+#include "exec/gdbstub.h"
 #include "fpu/softfloat-helpers.h"
 
 static const struct {
@@ -226,6 +227,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     env->pvr.regs[11] = (cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
                         16 << 17;
 
+    gdb_register_coprocessor(cs, mb_sp_gdb_get_reg, mb_sp_gdb_set_reg,
+                             2, "microblaze-stack-protect.xml", 32 + 25);
+
     mcc->parent_realize(dev, errp);
 }
 
@@ -329,7 +333,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     dc->vmsd = &vmstate_mb_cpu;
     device_class_set_props(dc, mb_properties);
-    cc->gdb_num_core_regs = 32 + 27;
+    cc->gdb_num_core_regs = 32 + 25;
     cc->gdb_core_xml_file = "microblaze-core.xml";
 
     cc->disas_set_info = mb_disas_set_info;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 73e8973597..6eeccb9201 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -65,10 +65,12 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         /* Other SRegs aren't modeled, so report a value of 0 */
         case 19 ... 24:
             return gdb_get_reg32(mem_buf, 0);
+#if 0
         case 25:
             return gdb_get_reg32(mem_buf, env->slr);
         case 26:
             return gdb_get_reg32(mem_buf, env->shr);
+#endif
         default:
             return 0;
         }
@@ -129,13 +131,47 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         case 18:
             env->sregs[SR_EDR] = tmp;
             break;
+#if 0
         case 25:
             env->slr = tmp;
             break;
         case 26:
             env->shr = tmp;
             break;
+#endif
         }
     }
     return 4;
 }
+
+int mb_sp_gdb_get_reg(CPUMBState *env, GByteArray *buf, int n)
+{
+    printf("%s: n=%d\n", __func__, n);
+    switch (n) {
+    case 0:
+        return gdb_get_reg32(buf, env->slr);
+    case 1:
+        return gdb_get_reg32(buf, env->shr);
+    default:
+        return 0;
+    }
+    return 0;
+}
+
+int mb_sp_gdb_set_reg(CPUMBState *env, uint8_t *buf, int n)
+{
+    uint32_t tmp;
+
+    tmp = ldl_p(buf);
+
+    printf("%s: n=%d\n", __func__, n);
+    switch (n) {
+    case 25:
+        env->slr = tmp;
+        break;
+    case 26:
+        env->shr = tmp;
+        break;
+    }
+    return 4;
+}

--9amGYk9869ThD9tj--

