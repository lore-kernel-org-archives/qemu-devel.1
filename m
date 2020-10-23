Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A6C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B48B208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="tSwGXSCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B48B208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVynU-0005ca-1c
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg1-0003vV-8Y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:21 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com
 ([40.107.243.109]:44513 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfz-00076m-Ic
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8T/wVwkGdhsHK2d4anWJIOy6NvKnW4Y5LyKKPjFYLxhXd50Da9o6lpSPaSGJ12uid4OX/S/Pav650W7gjHw76yyRN2XMXTCNG/lurHcCkK35uUUyhbV8oZBoBhDuafgO/psziLKlQXtgCOobZD5icerou77WpHmeJgEFnMChDra3CB20GmAnFbIx+Ef8aM2B3Cji1BKm77JLN+pWN0G/DJoK76TSTIT0Vsnd8N35pnS0ma0FlsAvJBnqjuyWULPFicgdA2U8qmM0uEXiLY+ikHSBC/cRh1U9ANx3lxoq7W/miiCcinknq6F0IqhLL17cYDYNoclTTa2qvX/Evx79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrThrEXIy/m5+pUPzQD82XQDJOsA+TG3bGCe6vBg2NI=;
 b=n2RLLZsCnhqmZtwvNHjZkgLfhwtrFwbup30fPwuXm4zh5cUI5ta2y1Aj5/Aet4ofhEIUDzCxLEEygDeuHhtPi6tIBXUfVbmiGAvtsNK2nqnXrJKcJAQKSCjVCf4rHvXxIIKPFhoxJetU6l2o8fUXR5a0PijczW3la1kJjRLJ6UbgoS78gPlqperx3+hW9bvtYqCiT1oTv4iu5jtsim8A1bKIBv5O/nURUoYRDA6caxtvCBNFnEDRN05jSJVIffVzYT1IKO+dhE5XtfwKQyL+6yYj1vPHGMCBDGWgJTAcqv8BuNjrYsstx4a7/ODnW5UkpRL/tK72G6RN/jHry3o4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrThrEXIy/m5+pUPzQD82XQDJOsA+TG3bGCe6vBg2NI=;
 b=tSwGXSCmVFJ3lm+dOKtVbAItRTlkaWegzNVOJbdt1FgFondQt2gWV7hqBhwYVzrKMUZKEHrX0KD5mcfGAhpNbr2gkxeUjD3pqEeEr4r/dQZTLNRM9C+TvqW4ozEiCcXLhtf9hFgRDi+VR9zip4jqQ7YwMAsF+xJyddtLvoiTD94=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 15:08:04 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:04 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/17] fuzz: Declare DMA Read callback function
Date: Fri, 23 Oct 2020 11:07:34 -0400
Message-Id: <20201023150746.107063-6-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023150746.107063-1-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11edf5ec-9e20-4886-cdec-08d8776570e7
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4368BFBC6D35E13D528C79A7BA1A0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8PX9bTRQUY6MDKnq2yRsSW/pUvpoEqJXliosH6LTHOowg33k4Ra/qu5RNmU2XmV8xDZyEtsEUxBGeBOOuKVd63SlJaoGhUT7TE+KYIWwuVIXtLH69oTCvTq8tbFTNxo17JnqcypMnF8j2c8MdO1pAJus8nGuo9FgrF9pQl2hP5u/s28P4pT7+TEmaDOdq9ZHwskdVG8W4MtuQ3kODaMXZJZKilJbHKmrLKQ+d6E2KA5S9KZ1kgFnXIxVPhEigOzeHMuhaTcgJH2nTDNsiEpkRnvhGwXx2QeVwdjfAABP8RKAnVDKtifudzvFzyywAkUAXOPrZ9xkalMmH683rDCCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(478600001)(956004)(8676002)(1076003)(186003)(26005)(316002)(6486002)(16526019)(8936002)(75432002)(6506007)(786003)(6916009)(86362001)(66946007)(66556008)(66476007)(6666004)(2616005)(36756003)(52116002)(5660300002)(6512007)(4326008)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bqw1ny072CWa7Xvpec9b/yjax5KC8zl9xKV/THxpZH2DcRY5nW9U4jZ7DZQ0/cx1pLJBIR3DGrmQ3HHz1ij9Hh4elLWPu9l62FEMpJADjYao/Bm1AmFRLM5+IlkrYsBmrwi37hXNEcyME/fkCBCe68RYAfz9uSeffDhDe82Kd1k1gjjGUtiuD6RjUv55lnUrRmMO6XMEHUtVHtemwUVtcxRMfMiTtKskMqAr3ybnwNR6TprPeiQe6whu7esYaQBSgQ2onU+wRbHNdL5TjNFC3jNg0kz8yFyJpnyVa2QSOodoFDsq3vmH4VmNdg8MaJml7dENFoipjS9W+ImyEVKyWKmp+HEt61Eo/0m+bxfWrdRlA6XekcD3TSTcKVebAXYJBS9U8xu/sT67vc5yn+D80OJaWxNDPxqwxXBoa7n1UqSZxDGzxLOVpvvJaJ9gWxqdP+1HvnvH7bvXKdbgrlOm1Cq28N4OthxlyOkw/yFCkVWfEwJwB7A24Dcfov9h2AD1ABzbyHe4k34LpoUorOGr6pKYsW38RIX0sRDKAcygrv8k1ScNOqqMBN6dt33Uwwm5RZJpLThMRZjAxlO8GGu9YuXZ86ngyfVHA6Yki6oFj7lkXUhcAgUt5vrcOwCZ6uHBmnAcG3SBOYkoWf1UPswDyw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11edf5ec-9e20-4886-cdec-08d8776570e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:04.4586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bd48sK4JABxSzGzARrMlGQUOg3UOc2xLWYbAGfM3AHsXosoA2IikUCdcAUWVhpWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4368
Received-SPF: pass client-ip=40.107.243.109; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch declares the fuzz_dma_read_cb function and uses the
preprocessor and linker(weak symbols) to handle these cases:

When we build softmmu/all with --enable-fuzzing, there should be no
strong symbol defined for fuzz_dma_read_cb, and we link against a weak
stub function.

When we build softmmu/fuzz with --enable-fuzzing, we link against the
strong symbol in generic_fuzz.c

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
index 93d27bff26..4aaf578ce6 100644
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
index a5d1641820..cec0e0f743 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3246,6 +3246,19 @@ void memory_region_init_rom_device(MemoryRegion *mr,
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


