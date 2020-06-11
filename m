Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB84C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9218C20812
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="xzm6uq7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9218C20812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjGGe-0005jz-Rs
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 02:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGDi-00028K-M2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:57:46 -0400
Received: from mail-dm6nam11on2121.outbound.protection.outlook.com
 ([40.107.223.121]:54785 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jjGDh-0002UZ-PK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 01:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULhqFUfK1W/Xr8lrH8wOM3HGwWOzi5901Y5Z7ywmFfQvNQAoxOVvt/gx5lcH5kprBL8tzl9ZigUD0vYR82B1cZQTZgWOuDY1jzVZkQ9BaCDKcWZEWTG6mDGEyuiZQUyTSNj2q7OcZXH7MWkzEc3xZPFtJYYyi5gTHlrzqajBLwAOhtfSpvUYWG1MFEja1pXwzjBqaFJ0Ofoj83e/yshkhLXfYtNe7Lhm6DBWqNH54SwAC0jr7b1JJRdqZ5McPnn6scWGHYzBXkI0WfakcU8E0NQztND+7S89EBEfJ7doPKTLuq6PxFVpeFVGCOdawQivmbLmdXLA/BH5cLgEbyK6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eckxZVBMxgTCjju9/AB5M/zqInee0ykVizYBAAPi8A=;
 b=GP2gqCmSBYuw7oLuh1g0gvCRI3PXJ1TBnTjEb94MLqGMWR2/Z4n35/VH275dO4kQjTw22jXnj1pR/GH5foQuxo/6Lh9Vxb1w7UZ27hmTDuf2yq52b4NZPbP19jx+pgjXyZdwa2Hw9IHm6K2pGGxVHKcCBvD0WFkVzbVxO946ixqDKRCMT5YPubcGr8eWn3uk4JFQFKyCvloULbAqearya+Co8Pn29zAR3AGUd6BgchToa8UvCxoM230QKetBDXeU2cstyjk3Ui2VoyYfsTAkWZcaIre8H1ijUQzEar6j4om2hgSl4Txsxzf96kRxL5QkMI+R0M/X1zae9D8TVDqQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eckxZVBMxgTCjju9/AB5M/zqInee0ykVizYBAAPi8A=;
 b=xzm6uq7++ramNS+SKoLO2RVmHQPaq119wbX9EtIO3mPXCzgTLT5vQ96Cmi7B/mWytMI7y7fJnAW8izVAenJX5ET2ex4PeFV3HyymrDiJEmlLQJXAkffP5OUaH6S5thi4MSDOQyF7Y4L1TfZxxn+wFweu+862GPLmNFnudmAmo3A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4173.namprd03.prod.outlook.com (2603:10b6:805:c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 05:57:09 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 05:57:09 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] fuzz: Add callbacks for dma-access functions
Date: Thu, 11 Jun 2020 01:56:51 -0400
Message-Id: <20200611055651.13784-4-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611055651.13784-1-alxndr@bu.edu>
References: <20200611055651.13784-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0056.prod.exchangelabs.com
 (2603:10b6:208:25::33) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.20 via Frontend Transport; Thu, 11 Jun 2020 05:57:08 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda63fda-6e4d-40bd-5a14-08d80dcc4729
X-MS-TrafficTypeDiagnostic: SN6PR03MB4173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4173B83459FDEC3778C25546BA800@SN6PR03MB4173.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WyTpLVp2/rKqQE7qCn9NXh8RpgBuJm96ImS23SItqiPqmispF3G13mLOf83dwtdgaQWlL3VRLsvqegqU2AZI+nzV/MKxRsSD3bRHHRklnNq9vBonRd/J1ie8qB0PZYZBcGREBJvI0a+gzk3ZKOB+slAHTEfXU7gUVSb9XfdhcJF9GULAcrigvihvN3EJjTRRPAzTvLyw/ZcP/FhbiPsU5aul0jqaDcxty9eT6D11YEPbpjcDONBHdKWi+9Y052wqxKu8tIAAtjbttYMf3f79uVuLXUGTcxKaDqfwT0ZOMpvVleXvEMHilYnJpwIwxk0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(786003)(478600001)(26005)(316002)(6916009)(186003)(66476007)(7696005)(4326008)(16526019)(8936002)(66946007)(66556008)(8676002)(5660300002)(52116002)(36756003)(54906003)(2906002)(86362001)(83380400001)(6666004)(2616005)(956004)(6486002)(75432002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vjmwRcxJI6hPcrSCIgnxrqFlXb9zMK3LTvIKKuoDIiPfoYTqfggEiHRpxuJkCy0iI5XLqc861by/Obrz57z/GItRWlU6JX8yC+s6KECElgr+cnqtVXIRpiWW58QS9IDjP0A7f/yAJPZF3a10soNxLbFuZ8b/UuO06GTiuV5QxHiGsTwud6eIHoWAh4WXBCQCtWNVJ7b1dkNHNWKuVg6bgPe6i5TZvVv7Jp5VWdQfVotxJJHnZNW6ZodQFtPIAGgcfoXDNMW678x85MXFfH6cxULeA0+L9iUY1oENcQMNzJUs1nF2LsGSymgG8Nb5jNrUl9aAhGlURYm4MfJyZPBDzaPzzruSZAsNIZ1hdg9IoYgVxQU3E1CJsV2xhVpC47zK9C+NfkmQxSd7tzIbShLq+TLgrK31Bor383YlZJACgGXq4/SISzCaRWSIO+HGL0MvsUs7f3j1yLKqNH5fjUc/exl5Y4V7gBdK7Yyk24l5UfE=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cda63fda-6e4d-40bd-5a14-08d80dcc4729
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 05:57:09.2876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGk7gsPxH0UQwpf6UxK6ZBEyVu4Yr9tOsiWeBwtsGPMIekRHd0n+LOLAb0Jp0TSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4173
Received-SPF: pass client-ip=40.107.223.121; envelope-from=alxndr@bu.edu;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 01:57:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 exec.c                                | 17 ++++++++++++++++-
 include/exec/memory.h                 |  8 ++++++++
 include/exec/memory_ldst_cached.inc.h |  9 +++++++++
 include/sysemu/dma.h                  |  5 ++++-
 memory_ldst.inc.c                     | 12 ++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index be4be2df3a..2ed724ab54 100644
--- a/exec.c
+++ b/exec.c
@@ -3247,7 +3247,10 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
-
+#ifdef CONFIG_FUZZ
+    if(as->root == get_system_memory())
+        dma_read_cb(addr, len);
+#endif
     if (len > 0) {
         RCU_READ_LOCK_GUARD();
         fv = address_space_to_flatview(as);
@@ -3556,6 +3559,10 @@ void *address_space_map(AddressSpace *as,
         }
 
         *plen = l;
+#ifdef CONFIG_FUZZ
+        if(as->root == get_system_memory() && !is_write)
+            dma_read_cb(addr, *plen);
+#endif
         return bounce.buffer;
     }
 
@@ -3563,6 +3570,10 @@ void *address_space_map(AddressSpace *as,
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
+#ifdef CONFIG_FUZZ
+    if(as->root == get_system_memory() && !is_write)
+        dma_read_cb(addr, *plen);
+#endif
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
 
     return ptr;
@@ -3635,6 +3646,10 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
 
     assert(len > 0);
 
+#ifdef CONFIG_FUZZ
+    if(as->root == get_system_memory() && !is_write)
+        dma_read_cb(addr, len);
+#endif
     l = len;
     cache->fv = address_space_get_flatview(as);
     d = flatview_to_dispatch(cache->fv);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3e00cdbbfa..e9178b3e0a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -49,6 +49,10 @@
 
 extern bool global_dirty_log;
 
+#ifdef CONFIG_FUZZ
+extern void dma_read_cb(size_t addr, size_t len);
+#endif
+
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
 
@@ -2427,6 +2431,10 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
+
+#ifdef CONFIG_FUZZ
+    dma_read_cb(addr, len);
+#endif
     if (likely(cache->ptr)) {
         memcpy(buf, cache->ptr + addr, len);
     } else {
diff --git a/include/exec/memory_ldst_cached.inc.h b/include/exec/memory_ldst_cached.inc.h
index fd4bbb40e7..dc3ce14a97 100644
--- a/include/exec/memory_ldst_cached.inc.h
+++ b/include/exec/memory_ldst_cached.inc.h
@@ -28,6 +28,9 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
+#ifdef CONFIG_FUZZ
+    dma_read_cb(cache->xlat + addr, 4);
+#endif
     if (likely(cache->ptr)) {
         return LD_P(l)(cache->ptr + addr);
     } else {
@@ -39,6 +42,9 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
+#ifdef CONFIG_FUZZ
+    dma_read_cb(cache->xlat + addr, 8);
+#endif
     if (likely(cache->ptr)) {
         return LD_P(q)(cache->ptr + addr);
     } else {
@@ -50,6 +56,9 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
+#ifdef CONFIG_FUZZ
+    dma_read_cb(cache->xlat + addr, 2);
+#endif
     if (likely(cache->ptr)) {
         return LD_P(uw)(cache->ptr + addr);
     } else {
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 80c5bc3e02..f32d7db7aa 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -105,8 +105,11 @@ static inline int dma_memory_rw(AddressSpace *as, dma_addr_t addr,
                                 void *buf, dma_addr_t len,
                                 DMADirection dir)
 {
+#ifdef CONFIG_FUZZ
+    if (dir == DMA_DIRECTION_TO_DEVICE)
+        dma_read_cb(addr, len);
+#endif
     dma_barrier(as, dir);
-
     return dma_memory_rw_relaxed(as, addr, buf, len, dir);
 }
 
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index c54aee4a95..1935436aff 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -42,6 +42,9 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
                                         MO_32 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+#ifdef CONFIG_FUZZ
+        dma_read_cb(addr, 4);
+#endif
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
@@ -110,6 +113,9 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
                                         MO_64 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+#ifdef CONFIG_FUZZ
+        dma_read_cb(addr, 8);
+#endif
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
@@ -175,6 +181,9 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
     } else {
         /* RAM case */
+#ifdef CONFIG_FUZZ
+        dma_read_cb(addr, 1);
+#endif
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         val = ldub_p(ptr);
         r = MEMTX_OK;
@@ -212,6 +221,9 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
                                         MO_16 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+#ifdef CONFIG_FUZZ
+        dma_read_cb(addr, 2);
+#endif
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
-- 
2.26.2


