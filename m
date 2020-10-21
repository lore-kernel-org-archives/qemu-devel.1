Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2695C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EB524198
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0OHseGnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EB524198
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLXi-0004pd-8l
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMh-0003Cm-Hb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:47 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com
 ([40.107.69.122]:45277 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMe-00083h-Ey
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa5BenvrwSlOGtxrw/6HsLywy1V4VSSPy2dNfrGOiWDATT6rvQmVTTcQL4XPqetw3GbBRKVTHknA5fWmJsOl97g8YkrFSsOhMq/t9RRaPPQzQsAzwUDm3WNnXsc4zz1i/kLQ8kLJOi9hv7JBEAEzcLrN5O+Z7usMR5XlNG/8+QWkpefLOHRu4oKBkesRKLqObSkyswEDU0M4wkuE+pEfCyHY05OM2QHFRqb9Qd4fNeAZbjyc6Y8zcouMWlIplVsANH/dZNdWdbFtAQ4WKErIMxGCjysYui/2/5aE/rOq1bWm2YBL12SZe19ZkDTSl8KkRILNq3pyBnfWHHwLBfineQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiwtMOC0J3McpV2DHYYYQNDvnKEIP1ojH0HWlitawLI=;
 b=iw3Zhh9sPZeb+vzht6AT2GSlZ3uLHqi/Iaq0grbld/rdr6+qUYlHXLaUnmO21MVbkXdvDTtTN93//XXRCa47qtMpcTlEQaPGzvOwjW9/T3oiWTSqPLneF2uk8yL5rQUU5AUobAg4AEPE4LPYpJcVDaLpFr9roymtoXARDJy+hW8+E3uyEdHv9F8oamfsMH4erlenndui20DR3rxhBy0T8CE9bmiR2mTpHBucfaISWj8jRNFhcD061JWKwUgo2Ja8LKj7EJ5fp7VGMS+f+BklYWyOEMCJNHeY1PdwoVwe8LoCPD7YAOg2xxy4Fe4f+25YN0KNLncbzN0qyI0ZjD9pcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiwtMOC0J3McpV2DHYYYQNDvnKEIP1ojH0HWlitawLI=;
 b=0OHseGnwEkXMHtHd1rWy1BEqz+a8lHhfztTsRKarAdVvDwwWVZwYcR9sx0DfIwQeNP1jFTxXoJqkUOWBEQXu0Ky2IgB/u9wEMwpzT56SNO9FYRAw5XoXRb/0L+3IoS91IFhFO0o/Us5ukItXPXMzOpKBZ7g5BWj/XixQORbmNG4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:35 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:35 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/16] memory: Add FlatView foreach function
Date: Wed, 21 Oct 2020 17:09:07 -0400
Message-Id: <20201021210922.572955-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021210922.572955-1-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77db1df3-6e1c-4f74-ea52-08d876059cd3
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045A0B0A237D8342EC668C5BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySM1CWnWd2H0suiaQYaCILNH5JlqHIwZpXd+GXnOcu6XFfMl8s25s5jXR7taKEj3mt3HXxos99O0ISZ+pqIvtOrO1HggMusf2lCt3zJwCp7ale1bdx35fd6mkIRiFRcWut466UMV8juqeCb4OFKCsMKx3caQ2iW1SVqC95RaRDCdHq5r3RA98RII+DfmxDm9XeTDYlBLSyyhNx1/MhaAJ8TNlDPCe3OT7FXgfRKvZbnXEYI87SNwUAf7Nj91h/OqJR87KNQA2GfphYyszrC4x4N+w2Ekv52rAxdTRcR59FadARWHPb/D3FQx+HIX4d6iSEf2/5ZD2rFGT+u7NQYeDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Fx+KjYRper504MEy32ChsAAQaVAU2ci0H2Jld5U+28/C7Xgkt1bCvjkeTK0VyqSw5GXU1nbRQbePDC8nWSxryNWEV7lWtGpCkLs65cKHUpY9w5bNcwxjpgcPuEpaHLmSPgoqfP8B44Pt+FPTbxi4LwcI80uw0ZrPtFdKh73rmsiTTVa5/4Kr+ROtc6s7/v3/Jv/cYddryM+CiSK1o9tvQ3lXv4quVxXL24QnKgl8/LyyMKaQD7cpu2Ez7VqnJWHMJdsAH8l33H7WHjST5/+LUZGtPVWi+9UJjaN3fv7mPIDBWrsXljAvgd3BDSpUMuOcLkYeztvrA9+fhGuj0TfyyqZj0sp36ZBevxkAWii4/Udx7Lf/5Lss+Dr2bC+89nGKpVII4UwwkKOL0FHG2TXbvlasMagTNmtvz7hwjnYzwS2Q8SYclh/laf0cL1S7keHjwQGm89HsCJUcSmyVp06WnXLwqbD0S7rXNbRtVXBc8zNRDd7KPxK15xf5OQX8h+FGujnQl3XPS19L1NYFV8JX6LsWwngfI5ft2VaZw4Pp9UYiXCC+7PYLMZOpUHbROw0FTTfMk5gQ4f0O60mF3LV++qHAHr1CzT2zhm93YiYdvLYd9WExn5Xc3YXn7QNERxhr9Cb0HcnXO/ahE0v9SZ3tKg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 77db1df3-6e1c-4f74-ea52-08d876059cd3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:35.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHg0UQVPG9y6JboZWpjyEOBFF9rqAjjGluQi6egwSF2JReEDapTN17pVawPB+pPk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.122; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 include/exec/memory.h | 5 +++++
 softmmu/memory.c      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 622207bde1..042918dd16 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -719,6 +719,11 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
     return qatomic_rcu_read(&as->current_map);
 }
 
+typedef int (*flatview_cb)(Int128 start,
+                           Int128 len,
+                           const MemoryRegion*, void*);
+
+void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque);
 
 /**
  * struct MemoryRegionSection: describes a fragment of a #MemoryRegion
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 403ff3abc9..c46b0c6d65 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -656,6 +656,15 @@ static void render_memory_region(FlatView *view,
     }
 }
 
+void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque)
+{
+    FlatRange *fr;
+    FOR_EACH_FLAT_RANGE(fr, fv) {
+        if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque))
+            break;
+    }
+}
+
 static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
 {
     while (mr->enabled) {
-- 
2.28.0


