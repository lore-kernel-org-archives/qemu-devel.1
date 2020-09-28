Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2568BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430EB2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lWp6ytBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430EB2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzRq-0000TH-B9
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzPZ-0006Vw-Cb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:06:14 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com
 ([40.107.94.65]:7990 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzPW-0006yf-87
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:06:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgCnxfLbw7qOX06/6OWP+4OD25Qyoivl1aftZceljhqcuT71uSuTX9DHsNYaW2gYyKU8GnH5PbJ4DMLpsPTsksw8wqnNtO5xy8EoFf00+qrzhDrvhOjRLEQjXVGeJ99ViLIJ69wKzRQNg0mmrfZDqRHjy/d0JYpwRLxLR5qeAZvrKelywEHVGbmUPsV9NZ+XN9kWx5B/lYlnmCHRUpo4b3DTWQ+db96NmAi4Qlk/NqzfVJJZQVEvMnnUIDSntnCQKEEmCr8i9eWrE88pGJAhMJOtXrKtCQTRLnbNUj/bo9e+6/5WsYG44ng1CSUSY6RgKkVsG2UmgMPh56y1UXRqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMe/pp6s+8dbhrTztejnvQj6XXscuz4gpO6YE2NMuwY=;
 b=hx2DTjACMmBeyMXgNPSdragU1YX+rjiNks7IrxYbzbfzXRxMgvV+jM6hdUc861ZuHQghD5uxdqSur99tVkAhhxlT5qPR7UrkKea+Rj2uBOy/51jMMXVzrHiGev4wf7R6ryvJjUUaX5jjEcfY/bE9ai4HE7cwd9XoLbcvPgQB97SiGns1DvRMuRkJ2UdHUvS2lZ/6JWyXoY9e1uv75eL/VsERYNB2o1OsVHWhfig9+qFtbE6ITI901in6ZXofWLCgAixryT5gKlyDJtVneU8/qkPVrysVKrPbMLpYa55oYfdUW0mpBNm4xWL2RTo1/nJXqTdz8HWRwxtHhh6PgUOHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMe/pp6s+8dbhrTztejnvQj6XXscuz4gpO6YE2NMuwY=;
 b=lWp6ytByxZtZdUgKfW0l2K+BCSi3pKhAQihv1yLXmB7dwc1+2H06vmH7tVDrhRt7xn4DWXFPKhI3yj6WSqX2jsbort9v8wZtTPUBWoN+JCgChAdntd8WwJfOiZAbiT+53iGT9iXktkjjLQIEJTvwbfzPBJpZjOyoWEHwdJWZhWU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Mon, 28 Sep
 2020 20:05:51 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:05:51 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 3/3] amd-iommu: Fix amdvi_mmio_trace() to differentiate
 MMIO R/W
Date: Mon, 28 Sep 2020 15:05:06 -0500
Message-Id: <20200928200506.75441-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200928200506.75441-1-wei.huang2@amd.com>
References: <20200928200506.75441-1-wei.huang2@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0019.namprd06.prod.outlook.com
 (2603:10b6:803:2f::29) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx56bbhost.amd.com (165.204.78.2) by
 SN4PR0601CA0019.namprd06.prod.outlook.com (2603:10b6:803:2f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 20:05:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df1c5895-fc15-4d61-d933-08d863e9e5bb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0023A750598A914819B68514CF350@CY4PR1201MB0023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdPPSilLvDDkSZTS9kpz6kwNKApGKM07VLuK3nUeloP/kFN1+DbEST3AEsOsgBmDdRRGqDI79+LglaVoXcul5L7vVxAMXbDLSWraxEts/LSmJwu6wz+YKcP9jG8C8iKr9rars1sw5N96IDe1Tuqm5rzlSE/SGe/khUoS9FUGlDSOFAHbAxIkWOxWv+iL+GK0qOaWhj8mx3sJWf7Mt8/wu3abU6rr4wHkzSUDLfSisC4fMezbAvWiaiglQl0i6PbBH0Y8ixBlJ5OAA1ns91i1H2ppP0mMNMp8YEpgqxRVITDRM3v5SMgDiKD2og2Jww8l6Fq6WH07pBRmer9OHzY5vwWZqJBj1E5FM0h82slzfMlq47CSyq0nl7xjVSf5XY4V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(6486002)(4326008)(316002)(2906002)(8676002)(86362001)(8936002)(6666004)(478600001)(16526019)(5660300002)(186003)(26005)(1076003)(6916009)(83380400001)(66946007)(2616005)(52116002)(7696005)(66476007)(956004)(36756003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7xWmsRiBxZ8ZyRv0ZoQnh4w7gwwWuxmjbwJTdbPpMinkD472vlA5vuET8uF0ylBHTfT6YH+ND7qvTvlHG+bVX3TdnXlXJSbF/7YAmU/PlzaBHUk0ZkxbU6UafXVmBVrutZ0ntfUokz4kL/bwQabm7H/FzVtw8L6f36rV2XGxcA2dgu6kwVcmClkyKbu3KfzMPNzsfhRs8ZI6/H4vwFX3A4XmId0rgS9zYWstzWhXNVEP58gPtK8NtV5xIhXwP/PCtjAMDGniyG1MKB3FoNQnwoYnmCunf+gV2xEmuNMPFDyWNtpRNi7Vzj7wpNpDcfgL6CGwelaCWRNXs9RyGr/Hn8ccUoUQ/YAZoKjr1XYVQHEip7lEs9ThZrlj5oSN27Llg8sEjo9rYSqBjUQ10pBqQqKIvHIfb8C/WRClQvF59W8y9xPvCqIepl43yMCM8YjmL68+6DfJP0I+mgl9bCexobqZgN/KGHLscW31T3WmwLWcE8W9hszYnVzEmTJaUt3eA0A2y4AqdL89PvyQMdr19EZ1pajYN3Ocmnnx1NQ+9MWI1xTYHwH245z9vzVwEQ3oHlOIsKkL5zx6dPhwokovhhPzIzA7PM353naP1gF6RWzADA1Jb4CVusUGX4D03RYO85tfYAI7zvezuTMjlmWxbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1c5895-fc15-4d61-d933-08d863e9e5bb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:05:50.8497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eI0Gkba9RYW3l7vm6ryNjnhTanww6qY3hTPERI1hiLuj7P8dqtP6cbfZ2l9IZdWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
Received-SPF: none client-ip=40.107.94.65; envelope-from=Wei.Huang2@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 16:06:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, wei.huang2@amd.com, peterx@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

amd-iommu MMIO trace function does not differentiate MMIO writes from
reads. Let us extend it to support both types.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7604e2080595..827818b9f781 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -662,17 +662,28 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static void amdvi_mmio_trace(hwaddr addr, unsigned size)
+static void amdvi_mmio_trace(hwaddr addr, unsigned size, bool iswrite,
+                             uint64_t val)
 {
     uint8_t index = (addr & ~0x2000) / 8;
 
     if ((addr & 0x2000)) {
         /* high table */
         index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
+        if (!iswrite)
+            trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size,
+                                  addr & ~0x07);
+        else
+            trace_amdvi_mmio_write(amdvi_mmio_high[index], addr, size, val,
+                                   addr & ~0x07);
     } else {
         index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
-        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
+        if (!iswrite)
+            trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size,
+                                  addr & ~0x07);
+        else
+            trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
+                                   addr & ~0x07);
     }
 }
 
@@ -693,7 +704,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
     } else if (size == 8) {
         val = amdvi_readq(s, addr);
     }
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace(addr, size, 0, val);
 
     return val;
 }
@@ -840,7 +851,7 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace(addr, size, 1, val);
     switch (addr & ~0x07) {
     case AMDVI_MMIO_CONTROL:
         amdvi_mmio_reg_write(s, size, val, addr);
-- 
2.25.2


