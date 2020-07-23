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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDABC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B74D20825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="aO2ryo2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B74D20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyS8e-00015s-Jo
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5u-0004Tl-LB
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:30 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS5s-0002Ew-SK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo7UVnzKhEtbLrJ+2lChiQG8CoYlAOD4HoVIgq52smPdPZ41L7QO9B8aewvMljyjCT+5WrBApXHQYsEXNQNO1qL7XX4hF8y055LW/yfRWluvwWbf0jamwuUl+BsKQehUrPcTG82ZRUhjy1ZVYW9/sJJmFIC+W+N13SSPt+G75cWCxjnY8Cy8jWpeHQPMHPWpkcDYGOL00XKv/LfVehxOOM5eB2KaA46SuMwbBUcLOQ26hgtpl0IchDJ1uhGXvRjVjIJHfgxPBNdxIzHosH0QIx1YiyttVdVQ7A0mTpILHGpb0VZ38/HgVE9mKcDJY9p5+uCJ6NiJ3W0vx7lEXZZnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff9MU1Kq13m6LLsmZu6ZkehKiVltjsuKRGgEge+Z9Ys=;
 b=B1RSc3b3XHtstpKKAy6qXhW+oNwgRKBHqibiuOQFWqlj36BvTGmLVoEfmhcuU7FNO1BVnt+Ay3ILhTyY2tb01li3/n3sbWD5rFpvsU2fc6+xLM5mU+w/PmKkwHAKPaodfYPrcyhm1+UHf1dQrcNyMJddmtc9HctM083KG52wOV0Slr+WPkecOurkeEuk2mXg71JeFK2/s0iKZaKEsEfcJfcRtuZywMESvnSK3IrCnEoDcRCINSPG3Z+VlwsywhwBWIWCGUUQu0R/kv69ylUjWOkCC3hD0CKkiDutARL9YI742IHcQulR4Wn8ZkLmUaLEdiGcUQLdtgpz0nfFJcYcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff9MU1Kq13m6LLsmZu6ZkehKiVltjsuKRGgEge+Z9Ys=;
 b=aO2ryo2L0BS3jKce/G0ue2jfU0cS8evglp2PCO4E+0RLjhNxv5f3EMbIqKM9e8vBl/nCodCggE0VjBWDFvBiDElPvB4IgnZJ+Lfsg5RQf1N47WzPie1vDllNtQvcNenZBjulm7w4VvCmzkdNO1tMDPMTJ3ubvZFsbS3BX4GiGe8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:15 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/12] fuzz: Add fuzzer callbacks to DMA-read functions
Date: Wed, 22 Jul 2020 23:39:27 -0400
Message-Id: <20200723033933.21883-7-alxndr@bu.edu>
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
 Transport; Thu, 23 Jul 2020 03:40:14 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ee16a09-eec5-451b-c22d-08d82eba1c99
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39824AFC8BA83AA08DEDD396BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpjpqtg1x3A0qCYdX3fK/PVsKAFoXRsUnqPIMNU4/EdM6of90zOczHd8IKMlzJ/2sd1l9AfW5Fm1iYWnrAvvVNB8q3gVyrX7Fxq1lJJIdWZoqXTLP6BqOdSOg7y0N9KS3dAtX94lLlf8YrdBos2UbBkO9Y19uYOaAuk2hZZDbuKQ8eEf5sQn5s251Pz+5sWhOU0Guj5/LiMxM9VgEX5fBFzT8Vwykr0pgdqXxzDIUt+LGLiyiTkvEkuw9Qt5FuyPb3De5BuopQGLJC8W+Lo6xdgOERZbpwjFJUfN1dc7v8SuGeHqfos0Wuc0fEhZnxih
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(7416002)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JntkGvadzgpe8A1/d2eFVCZCV6197ISwH6YO+EED6V5mkYeyHRB6LkehtRrNbDzmWIxpsLZUk64cTBHDsxcbzylFr3ZbZ5X7bZJ4QtObP3RAbaVwCBoHjywd0ayngGHzthEZTANvb3CzcV1gz9zpzqYBrgW5qriogOPE3IFqio0eCJ4YhG2OftY7w8OGRm9uctHBWms7bpM2ahGArAZUfM2binaC1i6teo4oFj/aVbfYBL3AEy9F/LfhToqrxa6VSPnaVbr7ZjW81S7FborN/hePJ26zDzCRmo25wWsF8u6k5i7oX0k0ufTJHfFGBQ0myU5+uLeELuxjTmdfUqlhkJXXfFO5K4A9CAeshnBNgxXM9A5Fqj3i3RYDOHwxV0+ZNXT/dgS6OM4C21uIJVXsep/8dR7AKiKyCPin6LlpEsWLmRnk2/10h3DJvgxdyESSg+UJpCgl/oGIIWUyYhZeNOYoYv6v33kBt/Hh9d9oxM8=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee16a09-eec5-451b-c22d-08d82eba1c99
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:15.3427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7zmAL1kbbP7D8BngUNrGDXOBILvE6DnVQIOb0EHv0YwxlY/yn+KiVATdyQFuX0N
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
 stefanha@redhat.com, andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should be careful to not call any functions besides fuzz_dma_read_cb.
Without --enable-fuzzing, fuzz_dma_read_cb is an empty inlined function.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
I'd appreciate another set of eyes on this. Basically, we only care about
DMA reads to RAM. This is why I assume stuff like "addr" or "cache->xlat
+ addr" is an absolute address.

 exec.c                                | 2 ++
 include/exec/memory.h                 | 1 +
 include/exec/memory_ldst_cached.inc.h | 3 +++
 memory_ldst.inc.c                     | 4 ++++
 softmmu/memory.c                      | 1 +
 5 files changed, 11 insertions(+)

diff --git a/exec.c b/exec.c
index 6f381f98e2..c81f41514d 100644
--- a/exec.c
+++ b/exec.c
@@ -3241,6 +3241,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
+            fuzz_dma_read_cb(addr, len, mr, false);
             ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
             memcpy(buf, ram_ptr, l);
         }
@@ -3601,6 +3602,7 @@ void *address_space_map(AddressSpace *as,
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
+    fuzz_dma_read_cb(addr, *plen, mr, is_write);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
 
     return ptr;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2ec3b597f1..f8b943521a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2444,6 +2444,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         memcpy(buf, cache->ptr + addr, len);
         return MEMTX_OK;
diff --git a/include/exec/memory_ldst_cached.inc.h b/include/exec/memory_ldst_cached.inc.h
index fd4bbb40e7..aff574039f 100644
--- a/include/exec/memory_ldst_cached.inc.h
+++ b/include/exec/memory_ldst_cached.inc.h
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
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index c54aee4a95..8d45d2eeff 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
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
index b0c2cf2535..be87044641 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1405,6 +1405,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     unsigned size = memop_size(op);
     MemTxResult r;
 
+    fuzz_dma_read_cb(addr, size, mr, false);
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
-- 
2.27.0


