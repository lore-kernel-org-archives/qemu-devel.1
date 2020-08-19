Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3288AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFA92063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Eqns08QU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFA92063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HMZ-0000Pf-4C
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKC-000411-9y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:52 -0400
Received: from mail-bn8nam11on2094.outbound.protection.outlook.com
 ([40.107.236.94]:24608 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k8HKA-0001Y3-6q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBY73N0lLc97JvfpxawWZyc5TNNCsDq0ai42Hoh/QR1XdMPFzrnbJ30G2O8VIZ3EPpzJFB3hr9MYy324Y6EAi3aMh2mx/rJQLiREH1o45bSZYJWXuuOulKEfUhn3CiDzTBiuVROYegQDORKemeN2yLxgspi8odyr8BbQ5jfJxH/FsLrCdTqjLIt78JU9MvRMfCFFkm+4BQEQi4CvhYZLZx67GphWg44lpVcmYdAi+ZOwNyK8ER9GKjgh44OzWbJeb5sop8HilWTVgzAXwdIYARTIN6bbCgOa2xNRyAMeu6kmDe+BlLPb/gfgkc0f3Eg2bAhJ03ticnvhnHwWkvLwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ref5m5sgPAF97HDguwHBZ7XY1CrXwWJNYyIB79SnAaM=;
 b=RWUN9sFqplWJL0PjzWIiQbanVG2oJ2WzyIiTkfg3H6if0OB4cNLY6hYUIO3ucq6YERr9r3Mw33w5YEzeXw0qQi3DfDNnLxNulKCbq7tHa63vnOAA3g7aWl9kQUDt2Zwg9ndBDAJy1NyU3mtqLFrSmSuYEmeooa+YgJsAEtV6J+enFyEcTdfpO3CrO7FPGqeAKyDWgaSeVtWCHQ1MdlSSJZcyNzdQaG8b91VR/fxSaCPVuYfDUzBJnFb6qxxzPkooUj29lQ6CUMFoJ/xG6311Ddg7QIVKb/4s74kqrQusHDxtTRfdBvASFdHIhzo4HXnhc2FeLP6kvDN820sX29jdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ref5m5sgPAF97HDguwHBZ7XY1CrXwWJNYyIB79SnAaM=;
 b=Eqns08QUbF0FK3eDJ6k1EHENFzBHETX3y6zXhLcLMnsW8pPTNifkS7H5Ju3m9oPZqlHomM5BGNRluZw6C0h4ruCZFR43/Cv5QCzvDl+Xnf1KB1ccu/iNYE6ZQ/iR9h6/PMNVSQowCkCgSq5fhQedsVTbGxFs0mUHJaVif5papGg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 06:11:38 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 06:11:38 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/15] fuzz: Declare DMA Read callback function
Date: Wed, 19 Aug 2020 02:11:00 -0400
Message-Id: <20200819061110.1320568-6-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819061110.1320568-1-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 06:11:37 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0da4405-786b-4869-6013-08d84406bb85
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB393470EE5E25F1B1BDED98A1BA5D0@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaO4bSIVuJkf7AXXW8F1F6lGaLA/8IImWXWF9tzXg0H2a+Py+68r+lXbNBZoEolsCyizZeN5LrD4/HMr/TjLCTnoE+6IqcVAC2ryZpq3ePc6lSs3pH8noDBzuGBQZ2CYalG0ZfjrFvxWnyk5xBGNYszHNd6/pwpvfha/ip9J4NK5h9ThRCVuefDPgYXIo4hrf+WDl9bYO72BieyhDkZMbrSAd8L1f3iN97DgoxAl8bqgq6jJ+v65jF1fZW0X5OgkyxS9cYFr3sKsXJbdrYddfmlNqxo/v5clZnOyoTLumQkkzLS5Q8m2SaDjV1R3CiBOQtxVDmEJpwlt625Btpo+oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(1076003)(8676002)(6666004)(2906002)(6512007)(8936002)(6916009)(6486002)(54906003)(956004)(6506007)(2616005)(36756003)(26005)(52116002)(86362001)(478600001)(786003)(66556008)(316002)(4326008)(75432002)(66946007)(5660300002)(66476007)(186003)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QrIuYD1xYliePOWUt4RynnYB+m56N9ZlQzY72cfc1k1pCoHYrR21G+UeOrusJl1ONyFLDYtTbX1t5Li6j7tu01qmpMPOd1u84pwV6NZz5k/bsy0NdRexdPotOVqumiPRArq6Lm7G/iEOp4GJVIc6ItIcnLIq2lbv7ANWslXApJPqzPerFsgNBjEZfc/oERJOTlnY8TOcTSSMi0I2bCO1VUVR9k8qpUmS30jDslYtVcC/SNVXP1SP6UmAiEDvFcjKNlWbQPtCMYwnJ1otJTmFOhZhcSWpod+IZ7fnYo/RZONHLB2cTOGJR1ZHa0PBZLsbGkLNsFwAJ2SrveqZNy4jfjNpsWqGDYZ8o7jbuHCeS78P38ylSwy2+FM2KNeTeEfeEmkwaMpFNjuRHAVs9zqhr4+WlO8YYVe9vJNBWxrouGPa2V7UIC8x7NtsSfmmNc/MgsbcEy85kO/LyrVhS9GNVeAwcSy275NL3jmzlinkEs1++nKrSkVRZdOVYyMLnQFCl8zdgIUDV4Cmz9i2rc3CtgFIxtvhpcVSqUAn8aJlWhmNsmCHhYvgxZyVzUqODcaoCnyTfMV6hTqaubHeocuiXMnezKADNOq4x5c6TJE9rOYwHYpn2Zq0IpGaKsw1q6QmpDG0BQ0Xkfq3+vvw7QBGMQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e0da4405-786b-4869-6013-08d84406bb85
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 06:11:38.3415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AQR+W+9qMDS/sPkP7aTh5xNigiH3adWqQa2TBkhoIypl/Ln0nACvbfsU8/CM4b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3934
Received-SPF: pass client-ip=40.107.236.94; envelope-from=alxndr@bu.edu;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:11:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch declares the fuzz_dma_read_cb function and uses the
preprocessor and linker(weak symbols) to handle these cases:

When we build softmmu/all with --enable-fuzzing, there should be no
strong symbol defined for fuzz_dma_read_cb, and we link against a weak
stub function.

When we build softmmu/fuzz with --enable-fuzzing, we link agains the
strong symbol in general_fuzz.c

When we build softmmu/all without --enable-fuzzing, fuzz_dma_read_cb is
an empty, inlined function. As long as we don't call any other functions
when building the arguments, there should be no overhead.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 include/exec/memory.h | 15 +++++++++++++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527835..2ec3b597f1 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -47,6 +47,21 @@
         OBJECT_GET_CLASS(IOMMUMemoryRegionClass, (obj), \
                          TYPE_IOMMU_MEMORY_REGION)
 
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
index af25987518..b0c2cf2535 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3223,6 +3223,19 @@ void memory_region_init_rom_device(MemoryRegion *mr,
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
2.27.0


