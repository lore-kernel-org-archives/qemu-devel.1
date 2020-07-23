Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CCEC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE2D2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="RSJtcN0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE2D2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS6x-00069v-VQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5s-0004Pc-HL
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:28 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5r-0002Ew-1j
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsMR5mPwnhdXEjOV1vOlpKZOCPk0q7e8jHVWkOPDHvKHmW9CawywNBbrTxazQhdAqTAqtaCUM3T0PQSpwuvSDRfV9POYVK5MOLiSrYzay0lpxHKlsSkczGZiP5bn9IsrY9o+OoRpjWDL5HkjPI19S7QY0LdEg5LUbe4+n4SrZPVrujEx9gyEkeeAP+xaRchvSVTgf84Iv1J5x6ItZwDEujBjmrOkEME9EZtm/YVLKDqBMkH3nTj6GpVa5oxDc8BO6CmtOmMTzA2LHC4H5lAhUpmW/WTIeU9MiH6fIxZ9xcNVJUaBePEpdDKjhYVIBCAsdd83qpF4TUTbBKLiXOE6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ref5m5sgPAF97HDguwHBZ7XY1CrXwWJNYyIB79SnAaM=;
 b=bJZIyPwwau5oTpP5ORA8Z8Uc+N9XksVUoRpCdipDD/6xMiRYcahgWovQjhnFB5+xuKjXb4W45rTAbVMqFYUiQANL/Sp9Y8LVXciv1Qtv1s1zBsvXCuyO3DAjh8zyQlwHzb7oSfPkTxlh1sYcCFSNLx58WtXMWdKNZ2c3oB8DmklKokD6YI82SeA5XErrmugpSsMRntBvShD9hqc2hNbxMzah7x/DlJYdJ9FC2/AmfP7o98+d8KlVmvMCfoHai0QvsFshKY/wTOkRvjZ+zR0Tn9Q0aw78Af4WpRpxPcnvIcAYg96q+eLxETNPhnQs0HNpjlHBLhT02VWfHuv182HLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ref5m5sgPAF97HDguwHBZ7XY1CrXwWJNYyIB79SnAaM=;
 b=RSJtcN0CZ5PBXuO6R8BCFThkVFCz/haXt6/m1mR0otOMXaUgLHLW7N6kC/AnpRxG7FpWqjLBkcMREULpfDE5gdPy3VVP9bfbXb9zn9dooxCn49GZjVq+y3QggoUDqFNecxEsOS2yB8aZfsz5PrcVua4EqXfFmeWgGwbQSUMGJFk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:13 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] fuzz: Declare DMA Read callback function
Date: Wed, 22 Jul 2020 23:39:26 -0400
Message-Id: <20200723033933.21883-6-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723033933.21883-1-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:12 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a7e104-a907-4618-5554-08d82eba1b1e
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39822F4851C25551BB19FDE9BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owEgQV7wivf1ga/NHS5mXds+hpon5H3FAJyPwG/LudE6pFEw8Do+M6IjRE4jPfwK+YlcBarqQMw2OsnaAZKIEOOczUSq0PabYmPtyljR2w+LL2ioJak0RfWniqlBUfNskM3o4lMbr986Yf5wD4KfsbRQVWZrDltSkLUZtHXy71+7w/Am4+Iw3gsR0OboUVoWIz1lIIN/Tdqze+YTEztsDCX5pXOKselh3oAVvl9ujvr65AReMcron0duf7PC5ee/L5fbnEPaYv1SOZr7qxrLIF750aa/Cgvfmuvtq40e7AxJMdauMfXBVELuvatx2LfHkn1r1vCGxvsDfOeW9xMk0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Xyoo6+nNRjqQmF0OU84pXMI/ltDQQufDVOWaodNmQC56FYLUBht1PvL/w2tipwhrYctPEekxgqSeaTYTPgPRybE2fHnp+iDD7+BIVa2mC0qOTsua/JMB/Ml7JguFYAbdlveQUOfQGluF5KUX/klxUmOHo1gGCnp5Hki1Xi1+xqVhlt2ZhvGXS0oIvx51ImRfdldZA+7aDyJWpWZh+1j0RYaZSffnNZoE7pbesCq5Hyl6ZoorR1hNtngcSZ+8LDWQJjmtqLXZZbIb9ko/kZd1pZWQWISMG1RmGk0ccXU0krLOB8NtX1CQyfqJFwmvsRkOwkdt4Q/QidGwIyQqe6tgYVIpSOAb/oomV7KrjBjI8ZK8yY2TmveToTpZ53v4KucmYQBchAOxCnaRUK+Kx32xFCtxrR1BN39wKxPZVJjjZbJCoQaT+3qxPhg2X+NVjSSyISy9KDsTtj03gTbt5/elvRHPg90DlK4CPgBpV6Xqqoc=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a7e104-a907-4618-5554-08d82eba1b1e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:13.3598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFYyZ0wbF10JKIsgjlCIkz62wh0smcxM19Fp308RQrOwwxe4Xtw2V8DdWmrdpKgM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.244.114; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:40:15
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, dstepanov.src@gmail.com,
 stefanha@redhat.com, andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
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


