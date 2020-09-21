Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4176C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB0B2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="pUyDt6pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB0B2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBar-0008CD-Rm
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWW-0003BQ-8M
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:48 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com
 ([40.107.93.102]:19201 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBWU-0000aa-Eo
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLnaaMTz+z8c0ITHHZLVuKac4tlscjKYAetommiIPRnWmrnoD6WSBs1rfGpk8FABNvuBgtKyq+Ld74Ds9GW4H3mf22AmqPC7huGGxJSJIvZ5wWEPDuBD7MdNq0vp+boSxth7jGS31qVF2IRsOV5FBDPslpLqSTUtAKTsNlRz88iXbwsTFXClu1YkEiNSR5l16PERX5YQ+Anxw8xps/N0eXss3rWYK/RoyJuYPHz6hnoVQSJ92otdLgtIbBisI7lz01UU9eXz3m6R7iRw/fsy8Ej5lSabtzmVFetQya9jSwTTBtKNpPaSAY3gUrUbMV/pCyfeiRD18H3g2uEnVPWm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfrylThJTtmuehPo+e7uWHAccet6AAc461eseC9qVek=;
 b=ObVxnE6yoaCrWJqZWJDr7wW/IIfOnvtIk1sTLlnv684ZlwI0KcAuVgvQ2QmsDMymPMKDahOACGb7z4NnHrK6Ace2kn7+YMpFKxsxWUQVheYpVr7wzIOjKmUQgTDGqwBaxfxLkSwgnKRF0TfAomVaHKwu/ZKTobMEDxl7q/RFojyI99QYOd/5wwbWfPHwdxdd5ewc3pu+A1wrXqfYru6es0r7yCjWvOA0a8z7U1IPUhnTbUBXJ7wuYn91n6NjIyv3T2jHQPLporEOC7xG38pfPwmJuwIGrxe7guM5NaPdta98rA995MZaJNqRZSN6mruIBqV7/LAUlKEU8BqI06WI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfrylThJTtmuehPo+e7uWHAccet6AAc461eseC9qVek=;
 b=pUyDt6pbKr8OH01Z3KQHSq3jDAsIHbP+Ivm65FEu3bP9WRNgwI/q8DLyOKHqGLRnBVSoWp4v3AkQfGprP8J2zD0lIX97HFSMzj4lAZ/nPJiMJZ3BvI7ce4nT5FEG3kihTX0EJCGQHUOykMTO9uKXj0uKmINEZVF6W3+SQ7OOiNY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2237.namprd03.prod.outlook.com (2603:10b6:804:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 02:25:30 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 02:25:30 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/16] fuzz: Add fuzzer callbacks to DMA-read functions
Date: Sun, 20 Sep 2020 22:24:56 -0400
Message-Id: <20200921022506.873303-7-alxndr@bu.edu>
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
 Transport; Mon, 21 Sep 2020 02:25:30 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe3a0a8-d231-4fac-67f9-08d85dd59c6f
X-MS-TrafficTypeDiagnostic: SN2PR03MB2237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2237336A58FDD5C7401413EBBA3A0@SN2PR03MB2237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thJmUY3DEfo/V8d2zJlQNGxBF8K7/CEu8hlg0hbFvxFcrPI5+0vjnPLoQiwwnzIltXLgEpT4FiY033gIEOLLjt6u5FC5+g0xWi+Tvt3obuYeuL3519e12GY/IzpfIVwXxzjdRr2+3f/Tk3p3rSivdCLCY07TNwgcIPmHPcYsAabGYLtgl45GyTxWDFFVX4eNjqfBn795Zg9o7LBZXzTj1fg7SePLxrJ9vy4T6H4UUNMoiqEGstP+FXpSHdq6IAOAuNWNH3WsU5hDZcpOXVvzlndnYTh43CcTHJJ90Lyd3rW5MBm7xkw1KRXblHMtZCw08V0/tMRs6dJVCAjZ2XCllEsUR4mRfdYpBYpy0g+dYgP7PJLSzAdZMcE5V5InnE3X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(956004)(4326008)(54906003)(83380400001)(26005)(478600001)(16526019)(6666004)(8936002)(316002)(6486002)(66476007)(1076003)(6512007)(186003)(6916009)(86362001)(66946007)(5660300002)(36756003)(75432002)(2906002)(6506007)(8676002)(66556008)(52116002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IrPFgnain0XVZZawOF13UDr+ieY8DMCNA+1gyHU43IMknwodC9Y/XGWd9tKDG+bDZ0rohs6I6goUdRM+xLIwWYoubGNqAE3ofAEN2pV6JRwiKb+yKYijHQx+I7eVjED2VlgLhIueuwVGptBeDw6gLZnOBPAd9o/BR05wgDPTQJe70QMtVmsdL9WPlz5zvRPxuZyZks8sSB5E//QCjYWsGX3N74hDDAeAjrFAoJH1hR53Ju7ryZQcFDPSH9PpI1FUltMBhi0Np7urVUTSk5Z6HXhII/xFxlcvw4VocRqMhlsjjFQ0mXMVjUiFac9zgRT4L3nlp8Tczld6w57w3/+KCPfGcoSBIrNYkoa1zJf6W1NNHpTlNB4E/OqeKoA+WwSABzympid+YZaYyoYPqPupXdyOrxEyOZ0ZR2XfoE//N+9PhLNWpKztVk96rYD+B4Td1cMD+UaIg4N7e8j56gsTXWXct4anIbR/VRAeDXoaDedHM3nLQvfxwbMiN6cdtk2zx+KxM5keXhARHQkAaV43pOzC0+GGKPNTr5+cH5ktyVtP3kiRS+wNvbCfVixhsqPRYCDbAItakGZarH0rGSR+88B+1KpoO96ervPOIqQ2C3ZeV5v9ESmvFX3sZGuNW/fzs2Ra9Y4B5DyTZosiDhaB3g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe3a0a8-d231-4fac-67f9-08d85dd59c6f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 02:25:30.8718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5MvHK4bws795yLuz/bem++TrsRCd3izk3ZW405B8cHcXq/5KobeOy1U7dKkG5f+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2237
Received-SPF: pass client-ip=40.107.93.102; envelope-from=alxndr@bu.edu;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:25:33
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
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should be careful to not call any functions besides fuzz_dma_read_cb.
Without --enable-fuzzing, fuzz_dma_read_cb is an empty inlined function.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 exec.c                                | 2 ++
 include/exec/memory.h                 | 1 +
 include/exec/memory_ldst_cached.h.inc | 3 +++
 memory_ldst.c.inc                     | 4 ++++
 softmmu/memory.c                      | 1 +
 5 files changed, 11 insertions(+)

diff --git a/exec.c b/exec.c
index e34b602bdf..5803e16be2 100644
--- a/exec.c
+++ b/exec.c
@@ -3242,6 +3242,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
+            fuzz_dma_read_cb(addr, len, mr, false);
             ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
             memcpy(buf, ram_ptr, l);
         }
@@ -3602,6 +3603,7 @@ void *address_space_map(AddressSpace *as,
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
+    fuzz_dma_read_cb(addr, *plen, mr, is_write);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
 
     return ptr;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index d5511c7222..988c2866cd 100644
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
index 24e59593ca..1adce47836 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1414,6 +1414,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     unsigned size = memop_size(op);
     MemTxResult r;
 
+    fuzz_dma_read_cb(addr, size, mr, false);
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
-- 
2.28.0


