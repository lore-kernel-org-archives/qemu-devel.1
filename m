Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F3C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B3720848
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0fCPgezt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B3720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLbg-0000WE-9i
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMi-0003GC-Vs
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:48 -0400
Received: from mail-dm6nam11on2104.outbound.protection.outlook.com
 ([40.107.223.104]:14145 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMg-00083s-C2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5i2zG/bWZrG+C6h7SsQ/gF+Xq7gXw+FQWGrVka37vni0TGM0DnBuAhMxOXDrfKfvF9gpwnbEF5RmRl9Q+TJBGEPqwaiXuRVh2SrlpjwcpS67gFdnlRmJ8a82LfeJBEQsPBY0OsYKH5IXEG7UaWG3DqoUaVPOXel87SS1JsdecMzWhY34oLOjT4h+ZWIXZ7Fha0q+JjopIrHpKRxdpc0Gj+WmtOf0AYgB0Gm8Z3KHhF0YvT3UM6n2SkS19ZoVn9IvXpUy+qL4BMRGZXudIb1IpD5n+E5H/pQX8/F71114IXWopoc3zzW8QQ/8Vo2pVd9Vz6xX8KXpvk2Hesy6N+hEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJWtcKGdCrIgy+DnhGK07FATuF16MbrEOt6/ngD77Is=;
 b=Tc/aA2QaOo4lrBWSbw9v4NLJOkdK1SE2uclirURjQQfBVeYb3x81mTdIfFqDEO5TeD1tGxaL69KsIpHB+iI+1GosCyGWnRIPaV84CQThVSdTRdh7RdskgQTHoIA+Ohj5EwrW/+pPGfH5ic4nrBbo2f6lNGXZV0ThClR+z7vhJ7m1fMxoX0WuRPp1CEjCc+2A3dyzdlY4Rm1itz02UO9XTIGn2S45mV6MgN1rcoRG/QO3F1MW13+6C/Eb8+zJp7EZ+ixq/Bu37clCGo2ibBt5t+XjZCtwNCg3o/wry+NROnhCeu7cQa2jsXEwVRmQJaXppLrqSK8asgknfxfx58BsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJWtcKGdCrIgy+DnhGK07FATuF16MbrEOt6/ngD77Is=;
 b=0fCPgeztKxgKFlFaiLKwSUuw4OtQVVjlt2lu5pNaW6tIvyr5XaGM/bk535arG+mRl9laAUYdOD7NkC0G8Kf3ylOVjqZ14LiBLuXaU3yObBGmDX3Zwz36ZIrPwMlnnBGRfymvR5DttRH+A4dAkir0DGklugZOvWZ5UfwlRf9m3uA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3805.namprd03.prod.outlook.com (2603:10b6:805:76::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 21 Oct
 2020 21:09:41 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:41 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/16] fuzz: Declare DMA Read callback function
Date: Wed, 21 Oct 2020 17:09:11 -0400
Message-Id: <20201021210922.572955-6-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd674818-57dc-485e-1258-08d87605a08b
X-MS-TrafficTypeDiagnostic: SN6PR03MB3805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3805FB91AFF6F6A356C9F9DEBA1C0@SN6PR03MB3805.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBhow8vrWRdO1BK7uwnSQeWwcVFFx/FNpBlCsKpD/PbawEnHeOid3Nx7voGr+5JlJpilNXu3UgmAi+ji+HfzE0q6uewp5pJRy/RyOldjbgm+DTcmbC9fhgysXgCOGDrklp9WffqYOd6F8dZVX9yMWOdskWDNVZPzjJX+CCw5gApyqeBW5HT2q8qVzZaH9XmtNXL5n0tI3aeHOVPaCa2BiLHPb1uQUxfEuOJiLu5GvaiXe6/qI809KwxmMubmEHEyd8kACUVLjF9JYZmtO214z7PFRqllutXFs2JSAEdIMGNTMNjDngBsPgrP6f1ZSVm7lFcYLicTfReashTr5IPkIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(66556008)(956004)(2616005)(786003)(6512007)(66946007)(316002)(66476007)(5660300002)(75432002)(1076003)(86362001)(8936002)(36756003)(6916009)(8676002)(4326008)(6666004)(16526019)(26005)(6506007)(52116002)(6486002)(2906002)(478600001)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mShhr0UwCug/aEK7ELFEOdOCkKRnBxr4zyz10YO6k9E7diYSC+N5OKlHYWD/qtNEYomfUV1RI8a9YZ6tGVdnwBeuJ++O/KqyVtulUuWRYYUaiu6NnM4KwIjsTIrUVOqZgbLVt51s+mEWQpN0Dp8WFWmJkIgKNf2SqCjQ1QnsnfOWC8NVjpzLJVCYJvp/kBXo0J0QoMg9kI5VCyHMtSH5uL5XWH94w2yTg07KwoxDWBzKWTuS8JF6ngiuJ68cwFkOB0hIIf4L8Jky0o8ro9JqKHXuRaZuHOYsNKxGAR84IXmVhxM4QWokdWxrw6Zm4cQFLuuvGcxf3WrgVuANwbwbLuKzlpxN05qM7QUhQWxgQGp8rGcURgIi3BoihhyMudrp9N4bar2M7+1fh3g6q7QTyuaE/gMbvt1dOoCDTZcggByHZMthmd5DgHZ7u1cD+f6yUWmj8wNugqEnSK2A5asN1p05djTLa7KVPyUGZakTq/th5KkqlZK/GXnmcxbcFhvz009kxrJoqRVLG77u5JyLzQy5I9z7wa1VUi6WPZJmeTS5mtbNlnT67T/7NYsl4BPUBSLChNUus4zTX81ceCCKXK+vmmrpWtK0A5jL+/uVVyFW68wXJpfHGNct1yWhuVOTD54Agf6sjkfMEWnf01Z2YA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bd674818-57dc-485e-1258-08d87605a08b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:41.5316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAntzl2wgwEz13hXzV1nJPlfytADKCKQki9m/czYF9ISx5xLRlgbpiz0Zu91YaNq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3805
Received-SPF: pass client-ip=40.107.223.104; envelope-from=alxndr@bu.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
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


