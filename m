Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80696C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1313208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="CnqOPcnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1313208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyhD-0005Hs-FV
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfp-0003RZ-LY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:09 -0400
Received: from mail-bn7nam10on2090.outbound.protection.outlook.com
 ([40.107.92.90]:50400 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyfn-000767-Fl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxgETuMcEX9uNCYQU5rcDm6M7yFjx3aTq61Lp6sU1apl8xg1lp7/20OqkVNIjyb6eleYqZgcSghDrsLIWCsl7wgwW55fbo/D3SZsYYhu498sliFcvZrAPoiDmtj/ERglvICuuRFyc4X1yDBiXFOa5A7lwkERzcB8kewBMn1TvdkArjDv/wMb3Hfr1TAh+uerKdbrZdKEsqvaLKrTeGSAJn8MPh9C6Gf9a6ZQtsazqKzkMjwInsHmt40tYdpKyrO8SeejJgIzVCSuwkviJ3P+ys4F6KFcpf49YWYpyYh7S7amKnTnHvnOvzoOTEHU//VsLmOzC6Sn+4josbaly61bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfU0YUJm6e42MqiA0sP0ieULgwK672yOxRQSk4yJWHI=;
 b=KkrJTN2Lu9iFRrRekOkauAl8KfWeUXNUPYm9NSakdXp4suulsL2VJv+0yZwxDYqvoaImPU08LrCp5GSSZ8XHRaEJYW+ObWDx3MJJBzTUfKJnc0DsKeXlT9pbCN3tfeXULchJobSRV32odHTdjuwGwR6HCFAKiRN58TKJHJsxs/c/5E0Zr2wDK0KFd5Zy2JUhlx8ArdEG3/0tb8l8iBJtWbIB20+PRYPda4MAFJMpN8ZOCzTDoHTQE9LORcq0ZTCh0Lb6N3oSs8VfCVwaQW8Cv25uwjWaMdVgu9T6Gs/eX2OnQZnOd75LpsIVmByo78PdmuVOmvfzC+f86zl1u4zp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfU0YUJm6e42MqiA0sP0ieULgwK672yOxRQSk4yJWHI=;
 b=CnqOPcnVX8PZgaf6ffl+JfEzgr8j9yg0/7lLEWN3eMjL33Tkp2PbrFjt/UNzPaRHJeY3gzJVbvrjja/GPKf48D27o+FlQoCn1rg++4i7Y645TFlnVXcVVcceyoBapFXAikmeNMfa0imWN1LPP5jFp6P5AW6oWBjrHzzbpMFGyYo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:05 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:05 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/17] fuzz: Add fuzzer callbacks to DMA-read functions
Date: Fri, 23 Oct 2020 11:07:35 -0400
Message-Id: <20201023150746.107063-7-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84123db-4709-4b96-6888-08d8776571ba
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB55164B58DA588B648F0B2E7CBA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vf75SrdFU6Byoi7g7JXy7wK4esprfGBkqEkZ9psznLHh9bLMKGOa18zyc6mjqa2OtmkVD9k9VODK6UuVs3+8kz6HQSjp2fQp4XpL9Qz7/25iDT8CoHfEf3KIXU9N7iK/EdZjFw1Wjw4Zro3VI9Uc8o50FUyRELvi63Pm5Jp7sLNqg9E8GQPqiXL3Rh5KGVbX8tHzdzfDtYkPNeYtVBaBXfia2Fq214ezIOpf/YuMzLpyP7CCoA3Vfji1nRfPgSImClXnXyWcxNe2Ry9uQDKk3Vixw/11ST5uYm08e65xTCRmQ8kfLGwhhZ7MdTp6DB3WUXK0/tk6mnuuWvizh0pS1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: koILefOSOUWPyWtzTJKD/d1N0ceiku9MfPTz7zvQDk0hPRUQj1KgE5/Eq6mADlVeaEtXDJosLHz40EPf2UsibK3zfDi/PkB+XBz2J41fJ02Pd3UqYJ2oyol5D2bYvLHm6INcNKN1emXpR2G4wfEVj0W3RSWVVG9U7pTwm/Fm+J+coi2GNWSd/BEL7XvosqEJisR/cDxEBxfy/Juv1o279Jev2G47+O2ERKwZWLdxwGMaGszP8mdGo3kRy/XUQfg4L9EaEc7KGT5E9YZtWb8Z9/7cvhJZbx8D26lblcgs3au1k/gb6MKh1A8i6CDys/eig47msCX1yac0/nf8hBgCqFLj8jPdZfgOm11vn+tw6hCW/Zgp91Gkheyh5FxG2dWmG9ksJtmWFO8tMr+SE2aqnREJ0Fx2KSvMQyKv6D7mjf/5HFkUh0LDOezXZQQfryCtfnfjG5jWlufNrzQWIVf4mSvhh/YJJjSazwLPdP+2o5mL0J15Vb34U6AVOqY+xYOsA5Cz3ryisoLZZVmbwvwOr0JxnOMpsZL4HAYD+EKMgINTO8G4DS0xIj4Sm5q03Nf7DEtulpBFHiD5KsSTM66s/2XKyBnF67sp/rmV76n3q+uFpLwlnA/lt+ArKt5iKnXzp61oYD5WPr9ap5TPDRgpnA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e84123db-4709-4b96-6888-08d8776571ba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:05.7788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEPu11tFJBW/dXhPysexT3tXPpdJSCq834mMqNJZ8wMDATyl/Z1TM8Ho1w0F8DHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.90; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:06
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
index cec0e0f743..ee4a6bc168 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1433,6 +1433,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
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


