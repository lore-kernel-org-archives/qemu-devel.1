Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D6C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5736B2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="4Fbg1oiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5736B2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBd5-0003kM-DF
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWW-0003BX-8o
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:48 -0400
Received: from mail-dm6nam12on2117.outbound.protection.outlook.com
 ([40.107.243.117]:28256 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWU-0000b7-5B
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA7Foc+S48w1lnh9WPhKNGHDvpJpgicLBbF//5Vse41xPpibYTfaZ/KJBOR0tweaxSdKIE7K79PyGIoJgGWxEgx/3wfvzOR2PWAuRFyrw0+jjpNjvLABhDF6MvyMob/CxJHVhVtNpFtZ3wkXQKwdGYDX0ZGH30Xpivl9O4XvM+HFtculGyrZlsIpD2+oiqzEqW0cBF1QW1NEBXnNZ9SE+kwqWU1x8Ikim6/EHAGMOOU2ArflkeGyHdqLJZbHH88yjMIJV5xf6zfGz8qLM28ctJVnPjI8QQaOISYvalPpGUegCeA+Aa2GgWjJfXBpqA3Qkzu2yZg8XT3DSMsBmg2NOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7ascJrHgiZuqYmVrSZhWk6zqYLMFU6jGYbOISteTtk=;
 b=BBPZTdSwzEgPcs3gR/7NV/mgNthA23ag1sRp07mNOAyrMDx09wVUmyXj3+UUPLTya45Qd955JpBw49EsGMcQX1YLGF2479BTEsGV+21toUS4xyNHIvDGGBVFdNlY70Wp91I/ElXKbo9zDY8goOSBSIdHkJ52OEjn1ByqAkzG3t6ehITgYwfyx022En4M0rIxUvUZI0bZTK9PkW46mMA3oPkltvRaYKL/OgnommjFu8VQstPfgHaBybHLR84xio9iZB5aV7FlJr2l4c3JGC+mI1R13WU96nWszR9/9ilHaI0SRkADaOfWTZuFNyw9kNksiK1SMYljBNDe3aTSx/fjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7ascJrHgiZuqYmVrSZhWk6zqYLMFU6jGYbOISteTtk=;
 b=4Fbg1oiKIrD0T8L4mj+buNKoRtDK4l+XBxx7irtQYiHV0W+FtUaP6shzAc4Br8LUXAfDJDYSgil424/s4uBCy3hMzHA9RzADQv3nSNPBxndw8eMwETnUb58oERoUwjNPCit+tZl5vKNxwWEX5WZX94eEd7DG0QszfhPWhBkEPwE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:29 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:29 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/16] fuzz: Declare DMA Read callback function
Date: Sun, 20 Sep 2020 22:24:55 -0400
Message-Id: <20200921022506.873303-6-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 02:25:27 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d30576a-3a58-486a-2aab-08d85dd59abc
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237DD1AD5FE35DD9F1732E0BA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEQcMl6gAUkCxexlr/imay7xNXE4rRVvfOAef3DMZq4j+sDIX78iC839LnnVcP9P3jS7F1dBt3ZKHAWznupPF9rVCdncFTptUsmzuXIwDnYv3zyBiA6euA3Oex/YiYHu2AyxBTrXBc27oxlY5f8INgaTG+DBbdV5JvjqjNjO4dhqdXYt9lkYU7cNowZo4IX6wySc5l0SNoIOI2StHkSfPEABfMzD0pJQmO601GO9+aMKoZ0kmSokM60YncttNoJ+GHCXTRlmF/9QDs2knchA0I0VLxFj3d0BWYnasX6Tqdye49/oidP/iIWUSQl7N33gcCYzf+W9EG/7Ehtz6dMwH1AxROUZfvlma1syZ2VZEfuRAHdyRBgd7FiRZCGNyYBA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ywtz921CfNzyiQmCiuy04z0kohhXQOyPKrM5b7qTovrciwr40SuY/5tlFjglXmcySV2cBDqsaoe8m3ahVTFF6vca8G7dq3qYr549PFSrwitVmvDhzN+9GzXjrzCTNExW6V/9/+nIsjdsDJAaj8FuSzDTWvAAQjgTEpjNFmIZwZmuY893MFhGwOpFZSQPhMjBmuPwnoaAMk8rwAC1RVrdkay9sGoRDqZDLIMGxYVo7PPgxqVEKJljMZe+wYqFEOPs0tU6wFMG5aY9NizP8HQ+iwTpk8QVnlAKqe//ewnaLjkxYGztO14R+qm4qj4mt9hR9jmggqqwdI6w/S3XiCQVp1PytzWNWN7BKgMrXRsQGTAYhmZ9uhOK3FCV2kXnU7CmUnp9eiAgOquZBmW5rMw/WCCeb17By0bxWcxraHUHyLudqM3AEJaeE5ppGbm0UStKJZ4dZEBAPYgIdgZQAaL2rkVZitt2gpLYo6ONXqkLlp7FwZX+Pmd99HeekRs+d/jHjbla5a13YvF5Ulwm41zUVtyTOd/gh7+Cz9wFvH0iD39ht3iJJGhDP09CLUxt8+/G07MfH2D8SFSU2qnWYZsdQNofJYrmllAY7TaCU5rFBlvzv9XCL+MZ8lWRHyDDziFmUopkpXmpYBQXf2vLGFda6g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30576a-3a58-486a-2aab-08d85dd59abc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:28.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6UA2K/WFEZIEGQxw7xz/j6kplF7GjOtcR7PtIQIUz7PZWxtcADjyV9gJKaDFr5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.243.117; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
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
index 975a90c871..d5511c7222 100644
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
index 9db5fbe43a..24e59593ca 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3232,6 +3232,19 @@ void memory_region_init_rom_device(MemoryRegion *mr,
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


