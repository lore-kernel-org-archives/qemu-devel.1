Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E48C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9D22078A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bCdsd6Kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9D22078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3ar-0004P3-HL
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WM-0007WZ-0D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:18 -0400
Received: from mail-eopbgr750112.outbound.protection.outlook.com
 ([40.107.75.112]:30180 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3WK-0000kr-GF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:42:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp3IElWanH9wbVjokiT2MZoXZvWRQJaF9Omc0qrkeDEgkYJcJpHdOM8S63zXY2jSmfMLmtl8WjxUyPdVc0aYZi72vAgtwyCbhYtWFMANVfpQI5pMArPhfwTrlHsoAWLVY7EHOXywHbWrBMpT0j2UkrB1X+aEPPSaP20u/ACDdd/MTHyjYnGdb5jlcwU+V61ZnxMjWxOaQnC6WyvaoQjcsKM09RIBzXgBNRgQsWyda0WZDr0hV9dHYyA3SamvDaTKTbJuDVv44uivgKrqk+jXNC5mbGBdfGinyw4y8wGnogGrGGtMqa5MEALxWryJxTsDuibY5V9435Pb42s17uQl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci22B9+CiUjNTUCVGBkXaJ8wImRg0THcFTXNJ0jdLzU=;
 b=SWUjFmHIx3HLr6OHHkxBc6xLSJ1grt5/BxmMM0CDJotG2cO3/dxKh9tBGIvY9477a+wYh9FrOpXMPMf/W12RVenXGOgMPTEk5+XMLA8iae2Jrmmf7vmbMI+fMiKatRmRWMC0utmFnonf3YLT9S8Y/4aCCBfr8byDd8dw6vHOabi9WlLZzWrHOC18k4p8N7YLFG+F8co/Lh4zKC5jhBTwdA6pK7RiJ9LMvIJOEua/Woi5JRtfour/OE/1VhqtP4v0h/d4I7XPN08WYTYuSfUKgDWZaGdEbEjfOBIR/JmIE1S8pnQ4Ef7Ua+2MLjAAGGqvdAzr+8eV5APGu4bylQvxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci22B9+CiUjNTUCVGBkXaJ8wImRg0THcFTXNJ0jdLzU=;
 b=bCdsd6KctmYP/fDGA3wwOCuArZ8XlCeQ3yObaQ9/AN0fvsaGDaGHr0gQI+OqZM5V+dgrMkuFZGzaIi7hSttvrx/C4hGWrXak+byahUZN3QyY02S7OTitnDf8u2qSHU357yCOMKyhG+ITUgZhyqm7mWResBB0Z9bXXLGeq7YMFlA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 13:41:59 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 13:41:59 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/16] fuzz: Declare DMA Read callback function
Date: Thu, 15 Oct 2020 09:41:25 -0400
Message-Id: <20201015134137.205958-6-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015134137.205958-1-alxndr@bu.edu>
References: <20201015134137.205958-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:208:257::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0055.namprd13.prod.outlook.com (2603:10b6:208:257::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Thu, 15 Oct 2020 13:41:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e478b00-6671-46f8-b6fd-08d871101632
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5465A715AEA5BB4BDE097C4CBA020@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ES0Wx64JuWNVB+HJWyfzVSSxB/zdKE3bxIQMkDHxEXSD4jqL5HGaLO7s7cxTP3xGaCfJF1NwRtadZjoaN4jbBB3fGznwNPse9Zr0tUV7cAAaIMOMYwW5maL8bl9ulacIF3MgAGrTVAFclqe+YzCXzGUs4Y0noKKi2FAtavuVQPQk9FYOL9C5Qa4HosXJgkWSL9kHYL0rrXA6WoF8Sq5QgvysYbjmLrA+5uIlt+WzmihMp9zKZh4jhqkGqU/I89TfXYJ4kfDN593R4HX7SOmYcZd4tRR1cyqmHCfs8oNNH32Wi61vNd6JIstFVgkkMzdcI3QgKqTWCquVk7cB6bMWl5qPcxGo36RbzRq+SL6BX5DwcmnUIcYV98QkycP8ACHS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(2616005)(8936002)(34490700002)(1076003)(66476007)(66946007)(6666004)(956004)(4326008)(6512007)(6486002)(8676002)(75432002)(6506007)(26005)(6916009)(52116002)(2906002)(86362001)(186003)(16526019)(786003)(316002)(66556008)(478600001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DhFQwOdOtY82kqFkLDOOqxG8dUBrUVLD6jIhlzgsh17JhatclT0pio1e+0wIFhq36e371r/JlSz/5cAnRnk5c11HhnDfY+XYCWHlZKZPOQh7yLXYbs8einM+npGgvAoBdM//fGPBUU9AYiw+ZYDZGGEp9O5ttRrShcRD2jsMTon4fWYQmrnroCO/sjxsNBBRNwmyXU4cp9FDBQsLXk8CCkcqZQ6CbI3avDFGprqz5fnY0eQruuXFJVATpUfV9RXUaftYQxkmX5y6+fb1O0lu7UM2bLg/WtAnwO1sogHm1biQ2udrxYYYkf/0VjvopJu3uNO/dSFu0d6pHZpV6NFd02n/N6TTN5IWtoI4Si85K5zhVJqIQ9ZTs35lHKO554G+xOMSfiSnkm5YfDYUFcqQr4nu1LQr67iDMx8gxyEYygLaRI6d3tOOIqqUGP1f8TBhvuDSImSz1hUkOTCckSMXOMtBoMzzWRNUnDgEhJxJE54bA7TG6JPu1NiqFfgKtPdiIySXPgMrlDn6Ocg4iIVW4sH0tqY+irIvDal1Q+2djpicp5EU2a7ffCEjX6SmO38zX2rW4e0+z2+4MEXXBkY/vr8+/4yZGAMDAorLt09dLlGy7eS1wK0xIy97iPIy2ZZYrFhIl6PDL6+UXNf0wrkBUQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e478b00-6671-46f8-b6fd-08d871101632
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:41:58.9746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9EdnZAIhQsaq6pqkW5kIN15EvRryJgUqntS897ZRnGrA37eyIsUPTaO4U/Mso2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.75.112; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:42:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
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
 include/exec/memory.h | 15 +++++++++++++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 233655b29a..854480859d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -42,6 +42,21 @@ typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
 DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
                      IOMMU_MEMORY_REGION, TYPE_IOMMU_MEMORY_REGION)
 
+#ifdef CONFIG_FUZZ
+void fuzz_dma_read_cb(size_t addr,
+                      size_t len,
+                      MemoryRegion *mr,
+                      bool is_write);
+#else
+static inline void fuzz_dma_read_cb(size_t addr,
+                                    size_t len,
+                                    MemoryRegion *mr,
+                                    bool is_write)
+{
+    /* Do Nothing */
+}
+#endif
+
 extern bool global_dirty_log;
 
 typedef struct MemoryRegionOps MemoryRegionOps;
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


