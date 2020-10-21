Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA78C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80B720797
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="v0tYHMfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80B720797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2hD-00063u-PC
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2c7-0000xM-Ar
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:27 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2c5-0004s9-Td
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Auz5SfwJN5rtL88b8Xz2eNv7OGrqipLe8/FtC6E6jtWFxct3cgsylHisVJdOUe67yf1LbIuzDLOL0uWjfptCLrO4K/vQ7n2w+iVOsrSfqPEybh5lEvh+Mn+3NRIKP6HQaBh41X2vNoZeGAsnUFfEDnuRLQC4tRsJlNF5p3VgeHzHT7SRCGXInm9ogmQUgo2FJ19DsuQrp9jJNvBPHbSG3y8h9zf/TVj/fEkDgcugDNAnZ/q7/otEwmSh6mnMsFoLLMyxtvutnybgI394pHUT08p6NIbVOHRREwjyEvb9VEqQuLkTgiy/8EK2a5dacG3YzFG3LA8OG7ioJhKeHLWnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzBnGDRyU66W2x50rl7hIybaGOx/maD6IfktlgFZWW8=;
 b=jccuX/HMqL6HWRjaM5PTLww8l1FHzUGQxvylFrkqoe8kRDnI1it/Qr2H0GrvHbv3MluLK3IdLinFVkyVlTUP5JKtVa8iKNzgMO0O0W0NE/sOvCOYp1DVpzoUGZIRzOut/wo8keUczv2hLqizzxzrDDJMOAlxjQXqpup9ySCu+9st2Yic5yqS5jXwm2UJsUXOWw33xMRYDUrU455NvmWDSOfHoFTdevNm0hjN9R09u1AHoHQxVtRESzDDGAYuwtPya/pc7j6OBqQSfB2cyz8HeGzQXKAow6yFoLFuu8osN2Xe0QcqCihEmRxzalUOMJOTRzYr8jg6dl30/MHKYzUPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzBnGDRyU66W2x50rl7hIybaGOx/maD6IfktlgFZWW8=;
 b=v0tYHMfcVD+Nah2mlzsK5ZlEQgTqMn9W5u7x9V6/Sxn7JMV9ekoIc0yahftzuE3p/970Be+jYhyAetRLyIv/XTRtzZ7waydYROZ3UGzogd1kwSYTVVXf0NZi7MfO5xilpiLbtilKwYRGfB2VrnuiIAbQD3p0tTJCRa54J2Aetmw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:11 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:11 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/16] fuzz: Declare DMA Read callback function
Date: Tue, 20 Oct 2020 21:07:41 -0400
Message-Id: <20201021010752.973230-6-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021010752.973230-1-alxndr@bu.edu>
References: <20201021010752.973230-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 01:08:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a90b7bfa-bef2-4517-a453-08d8755dc739
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB23339A80A8371D227D970CFDBA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvV1R51ZtfYpBGiJmm4+PsSkWfJIqIPhn+3gPXDcYMOtM9ZRPHvi+QRLfNS+ARxmwczcybTYon8klR51IKYca0II6s8SMF5iUKOq3zePdm+kBr2yBFfsJqX9YvH8TfYbHd0SaSbpTbZ8a7vUfDnNCnw2VWt+u3ic8x+omysoN5u412qy9b5lEUF99tAPxK9H7ST4IfWQwN8gq+NLGai8nGI3lvamMtZUJg5D0+X6W4khus9j4ugM6CKA8BtsoVT2IY0WyWuK42q9Zr7t9x5UOHhUDlAfCIoUBUG4tvmWAvLLo0YPUwRpRVknxWxubgvDe40bC+caq8bbkVlYXG8gYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(478600001)(1076003)(4326008)(6486002)(75432002)(8936002)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QsF0RNWQn0fIrPOw/pqwaumUSB4z/pss4lG401Ygmuh8yv9s3uBkBPc/Cp4eqWILIFKoe7797WQc5H00DPTro0z6jobjHLtWPYD7h9qBXJTzNtfpLO+az2pTpiG+yZ13UgRq4JyDYKGwF8RlXfwj6dTpmuQS3WvYziTSEwJUAxWDSzzU9HC0Eq9ks3x4Fr2DkbxG/MALv59CitZdjnFd0IhcY7+ydkFQ0BVeESCHuswGC+vsgUDw1P6r2xUZU61GIVYeARn5R+FjtiBZAaW3o7eUCDxQpwFC54r9NXxUWJsw0yGExaR2a2FPYPVaEFWJz9CgtOgsCkpoFZesGulgOVFq/w7XIPXT8VAYkYpn9OMfufd7VcO2IACVYkOPTDkdsNPRy5mJRTVlmMyqXJ01q/qZFMFljFQs9edwC5E5b17CyVLttjfOahb7tgS0Ld0woWUFgV6yDvy/cTjWpxiEZUyJNw58fRcxfW84nMO0cq8t7fTgrjZPjP0z8QSQjSw96UqXL82ctnQa/bGYrwxHLg0JwYX9hWtxel5mJ8vv8ecr6qSkfgDl6crPatB/EmD4ksbRRdZqnbgNQuUZD092uK1e8QD2fR8LxDlXtdsWOV5uKNbV3IY10/CoZplhpV6i+Va+Ii7iRMrkE3c7LTIalg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a90b7bfa-bef2-4517-a453-08d8755dc739
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:11.1375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSNXfo1Wuae5O3r+MOna6+LG82r8i3cJ+aGNXDsCWwz+F/qY1gA98qKZEHCUHyRy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Received-SPF: pass client-ip=40.107.220.130; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 21:08:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.441,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch declares the fuzz_dma_read_cb function and uses the
preprocessor and linker(weak symbols) to handle these cases:

When we build softmmu/all with --enable-fuzzing, there should be no
strong symbol defined for fuzz_dma_read_cb, and we link against a weak
stub function.

When we build softmmu/fuzz with --enable-fuzzing, we link against the
strong symbol in general_fuzz.c

When we build softmmu/all without --enable-fuzzing, fuzz_dma_read_cb is
an empty, inlined function. As long as we don't call any other functions
when building the arguments, there should be no overhead.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 include/exec/memory.h |  8 ++++++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 61c2aac943..854480859d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -47,6 +47,14 @@ void fuzz_dma_read_cb(size_t addr,
                       size_t len,
                       MemoryRegion *mr,
                       bool is_write);
+#else
+static inline void fuzz_dma_read_cb(size_t addr,
+                                    size_t len,
+                                    MemoryRegion *mr,
+                                    bool is_write)
+{
+    /* Do Nothing */
+}
 #endif
 
 extern bool global_dirty_log;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index c46b0c6d65..d3cdb46459 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3242,6 +3242,19 @@ void memory_region_init_rom_device(MemoryRegion *mr,
     vmstate_register_ram(mr, owner_dev);
 }
 
+/*
+ * Support softmmu builds with CONFIG_FUZZ using a weak symbol and a stub for
+ * the fuzz_dma_read_cb callback
+ */
+#ifdef CONFIG_FUZZ
+void __attribute__((weak)) fuzz_dma_read_cb(size_t addr,
+                      size_t len,
+                      MemoryRegion *mr,
+                      bool is_write)
+{
+}
+#endif
+
 static const TypeInfo memory_region_info = {
     .parent             = TYPE_OBJECT,
     .name               = TYPE_MEMORY_REGION,
-- 
2.28.0


