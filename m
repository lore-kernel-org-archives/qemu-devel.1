Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF8C56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2188A223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="7ZB3MyQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2188A223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLiZ-0007Cb-W1
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMs-0003gY-SE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:58 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com
 ([40.107.69.121]:59894 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLMq-000854-FK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:09:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRpeKA4gZ+4tVuMpY+1Na7XNC364UqgoctsKxC0b26ZjSUUgML7R7WIRSMtRMe0XZiyTVEu6wwXGAIAuwkj7H5KdqY4Z2OgbHnyIVc+mFslrpoQ8bV/eGm5u1DN1Cmehe58GddGjJ3mOhbnvt1Xs2IXDtvnKU/qcS67bwKn7w1dk96W1o+g48zW4CeeLbRWm0EZ1PpT0D0lR/+5vPtlGI9Hmkitqy+++7xhnpROinQpBqXQJjtqzmjs7rZtKr+EMq+M8duoNvzf29nf4BfAcuesG2FmcPioXcIbFEtXfRmxYkRndUFFgRWLNqL35W3R+Ygf8o774dfnoaNES46Swgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c62lnWo4TMSHlW70n/U5wErlOVj2YlTkB4zrOCMyrTo=;
 b=XOs6sd7v3RdZpYMx7bx9TNx54WgjTviPAHy7DfAyxVOf81/0hdzi7jYw6rP3PKwm5S/+KVDCBg+pk1amydRkkKEFPOISD52F4pIehprmP+gPQKuVm9y+OCGBrUZIU1URelf042puu4ofIEb86du3l+K6cZ51gbrta6Qognmm86b7fMJYXWgypDIXatVuDB/ELOq7wK8AznMb7r5MMEurgMk7ozzYXIWQeTG8+ybe9vMb4iq3Ab9/JIZPvEK4jOLnRup2D9y/JIQx2fSo5sZ1zFF5ldFxewo2wUBsCRzil4cwARTl4lt29elNQblxMWJsSOlyZxCQ44CEOjl7SwE2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c62lnWo4TMSHlW70n/U5wErlOVj2YlTkB4zrOCMyrTo=;
 b=7ZB3MyQqzQmrPPt/swiPAvuxxqC4e7ZzGPhUktC5gUDpyPES5M7jTBO971SvVvUXGjev2cE03rLLuUyuRRE9TfCgbMEiv1cY+lopqzOhgy45UnoypV0a6rPAH/WP6MaLdQXBB53AiFR+nYKBiEOXu2Bv9GzLjF3RFUP17jX+cdc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:43 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:43 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/16] fuzz: Add fuzzer callbacks to DMA-read functions
Date: Wed, 21 Oct 2020 17:09:12 -0400
Message-Id: <20201021210922.572955-7-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cfaba74-4753-407c-b81b-08d87605a13e
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045F4D1E0D2AEA2CF38A478BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMbI7rEC0gvWKUgIST/dUBHXUje9VUMipmqDmCfs1cDW3z0p/wiMg512HysTGXYodG8fIUONaOVCpmxDt8h9Va+6NrgbxMSqksjYwNDtn0BAMiTI1SWjhnmW5opZpxq6NQpQX6NfxWLJ5PRezIL4FoSb5/M8yLV7DlKI3JqpIrhY7pc8yKD/CiqVyORKfFzTufpN18XtT5fKMv6oWQZxKHZT11D8OuZjK53v/hZIeAKzMSwVDxp4NUXTSPSqk8HdA8P+1dSm809zXXsqJaUSXl+fHGybTD6wX1AzINu4+Ap049tQzMuUV6tQfXfTGRjYaO2rKl1l10dMuV5r/OYoag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(83380400001)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HZjd58nB4wka6es+Tg206MpE+Ntoe88vjfVEwJqY2cyLHkhgundkFa49n2K/c+YfQg5MEeiYxQK8f9qJENtjI2f3jFtCRaOESWA40DjwPIYwA7Fa1lijjnA2kGlCe39QTh+608Xb4IGgrtu5VH/ChWziruikkbb4fEfkhckJmspuEvSNhRRdLzoGkAnVXTiNgsRa/0FWbFDQMdAafZLBcMeKqb+nvlgSq9T1o3D/dWccUHZUjyAfleDao7oWhNjMIZmVdyLQNL+j+pvEEkFc2HnmmBlhWdJHsP6iCocqgbno6gukUJ+ZYyunvKCt/Q7m9ySHbWNIxBn0eDomPuTzAnKqJKf/EECi5DWE3lW8Xw3iiONXE/ydpf6EqwV30Oee189ZLWXe64kcaQQhBoP2+FFrpFqLxWtgc2jf8a9MnYiX9/kHK23NtuXDkj++d6aeTrdKzti8p7nCGDwDnUWUcNpHdyOEzg9yoTCeMHckh5s4tAEjdQOWzKUt2SLNKK7LtTkFNslFJA0gGHTHn2lhmXQ4XDf3QtW1vJgCsC3dCXz3CWmeRpk/fYUhcNAvnEzbFDftqyTwar+8zUVIxbXC+5fW621Ukpad49/GMrEgn3+Ddih7jIHZylbin4RO3M9p7iw3mz/V7GCMeDZuks+4jg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfaba74-4753-407c-b81b-08d87605a13e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:43.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJz05KFb6KQM5kW7mAFNsAuvs1YYgcAinPRZyovhPPTb3xDCprWlwvMUrniOIRPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.121; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:54
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

We should be careful to not call any functions besides fuzz_dma_read_cb.
Without --enable-fuzzing, fuzz_dma_read_cb is an empty inlined function.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 include/exec/memory.h                 | 1 +
 include/exec/memory_ldst_cached.h.inc | 3 +++
 memory_ldst.c.inc                     | 4 ++++
 softmmu/memory.c                      | 1 +
 softmmu/physmem.c                     | 2 ++
 5 files changed, 11 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4aaf578ce6..aff6ef7605 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2462,6 +2462,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         memcpy(buf, cache->ptr + addr, len);
         return MEMTX_OK;
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
index fd4bbb40e7..aff574039f 100644
--- a/include/exec/memory_ldst_cached.h.inc
+++ b/include/exec/memory_ldst_cached.h.inc
@@ -28,6 +28,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, 4, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         return LD_P(l)(cache->ptr + addr);
     } else {
@@ -39,6 +40,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, 8, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         return LD_P(q)(cache->ptr + addr);
     } else {
@@ -50,6 +52,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         return LD_P(uw)(cache->ptr + addr);
     } else {
diff --git a/memory_ldst.c.inc b/memory_ldst.c.inc
index c54aee4a95..8d45d2eeff 100644
--- a/memory_ldst.c.inc
+++ b/memory_ldst.c.inc
@@ -42,6 +42,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
                                         MO_32 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 4, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
@@ -110,6 +111,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
                                         MO_64 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 8, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
@@ -175,6 +177,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 1, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         val = ldub_p(ptr);
         r = MEMTX_OK;
@@ -212,6 +215,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
                                         MO_16 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 2, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
diff --git a/softmmu/memory.c b/softmmu/memory.c
index d3cdb46459..d7fdca2603 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1429,6 +1429,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     unsigned size = memop_size(op);
     MemTxResult r;
 
+    fuzz_dma_read_cb(addr, size, mr, false);
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index e319fb2a1e..a9adedb9f8 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2832,6 +2832,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
+            fuzz_dma_read_cb(addr, len, mr, false);
             ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
             memcpy(buf, ram_ptr, l);
         }
@@ -3192,6 +3193,7 @@ void *address_space_map(AddressSpace *as,
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
+    fuzz_dma_read_cb(addr, *plen, mr, is_write);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
 
     return ptr;
-- 
2.28.0


