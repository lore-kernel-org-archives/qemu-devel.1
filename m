Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78813C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58BD2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w0qKoxxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58BD2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzRF-00088u-IW
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzPU-0006Sg-VG
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:06:09 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com
 ([40.107.94.65]:7990 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzPT-0006yf-31
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHK9xv9DaqLl2CV+8Cu9GFqGbbOMus9O4FnyWKv8TpKQpsXwG8ZsxMYKaZGu7NL20PcolX6OZDx5wKN53YRp3AKHVK+zLUZqwsfESEZfIsOaiatv6U3g7ZRGo/KJtCvxUtSWOfhc1pV6BNfxL3e9vsFdKf2XNzhd0xIROqif7XY7YwYrDxsYbh8AQEbU8np45wG49PJv7puP6jFC46MEshEt6IRCeuVkDatGeFQl7jAaQrxHTWCpppSqbfaiJFn/n7KXAuiIQJLQEc5w06X2e5tRtAN13zLpRQYp+fOuz8FPYgq9f2rHnz99APjjgofoCUTfHhQIQZcJD8H/4urbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWK0AiE1R7OpfQL0YgCijwIzf5o0BJZYlHT8WKEqxbg=;
 b=XJHigPgcoh/jjpDp3uyKYiUGSEFIAaN5Q8F4mCobHXp0w+6jMvcHYiB6TOgr8z/bVXw1sUablQhGEzHevBfYmeILkNRi6MUNuF4Uq/lsvXPFzMKSmsLbDoGKOd1scV6UoOcZzCR2/2JwjrUih9Hi/8CzFoI30UCzM3R9ERnc0+Sz93du4sW7wPCfxHmh0zzkwG2c+/5x4SPISoqtD0x2JvqUvqfIv8ntXQwgGhvwNDk2kCYphWX194+eQ6OTKrBz+O1KYwbePy00TQxsNOz+m7vBN0CUqzI2wVd5K4ivloCnv9evBFI4RxNfMzVP3GUkosrlkJqSCRm5N0ztqmAPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWK0AiE1R7OpfQL0YgCijwIzf5o0BJZYlHT8WKEqxbg=;
 b=w0qKoxxUxTe5OVptsaV/9P+Gqpm97f+tHcmC4/tal9abZDIGaaZ/Cv8eFQ/lgq8If1lPanMsjthLBQBJ8DSIetDWCThUrx+x9JYozEIpprmXkaS6XPxeyqJBxoEUWMgMFej0GND5VZ5LXD24ZmMoW3OLqqe6Kv2i/2gTaUY6Kck=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Mon, 28 Sep
 2020 20:05:39 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:05:38 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 2/3] amd-iommu: Sync IOVA-to-GPA translation during page
 invalidation
Date: Mon, 28 Sep 2020 15:05:05 -0500
Message-Id: <20200928200506.75441-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200928200506.75441-1-wei.huang2@amd.com>
References: <20200928200506.75441-1-wei.huang2@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:805:106::36) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx56bbhost.amd.com (165.204.78.2) by
 SN6PR2101CA0026.namprd21.prod.outlook.com (2603:10b6:805:106::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.8 via Frontend
 Transport; Mon, 28 Sep 2020 20:05:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7be42512-eb61-4154-ec08-08d863e9de6f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0023C088E7A44BE481C4048BCF350@CY4PR1201MB0023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UD1kJJLJ3+C+6bKMfquTEADb/A38AH5bLpth7hImjEHwXFV0SmxFZM3ozbB2Be+egPrT9M+bScytdsjzdQu9N4o9hCCV0h8+1Gi2aGt4Dt6WTl9oh5khM23J4Qh/pwaBpN1dwuBUlTrWJyS5Iv+0GuNNywmiBB+/jZciCUKxPKZpEe4OhugZmoZEkWW5WN+eMx9Z1OBgEgGd3teyclsBXqILW8d3RYNpNd0JGXQ3Vt3Xgm99pOczv2I3FhPoZc554dVzW9O7qJPTlz/vTEZSfCly1nQlcI/7EXQZDlOZ1LPclFIZtMBZ12170dHgz5rS1P+k8JZj3+ZGLyVgv24iU098qfwKUWXCKo7hBitvizd+xnraMOWSnzZSCwzxJ7kaFvXJ9nrRc4UxgnKEf1wAzZcagt56mEHGi/M0BhIbxA+uQzbbP/h921URkFn4fYXQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(6486002)(4326008)(316002)(2906002)(8676002)(86362001)(8936002)(6666004)(478600001)(16526019)(5660300002)(186003)(26005)(1076003)(6916009)(83380400001)(66946007)(2616005)(52116002)(7696005)(66476007)(956004)(36756003)(66556008)(473944003)(414714003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LKJm6DnZ+xZ0HKlaBqNLuBQK6rcAjrizhhrWXRB3+vhRLnioGX4OEg8CxpkSrS4dfhBhGObe0cLetEqmnTKPVSfHuLbM7fMOLyxU/kDGFrkfJszoxQ/RLV+ExgI1MBnqBgah2HIDSyggJbJmmXV3R/YA92N2QW/t54hMZH2lKPjdEKoS8XtUkYCkSycgDRTIbqdCxexZkAEPgZNIalHCnldY5reGmMLy9deduaWFeJtWGiNKAEyCIWaFmp04eBO6KIKgjBA6WTURHEyO4w0QHcfNsN+ojDTUbrPoKtrWcFg8J5tYTU3FAtBZEHLm0LPAeePmXdrEhtHFSFw7ZE4IPM1BDt8/OeKkIQjUtXYTmf4Cbs4Jc5V2AzZ7a+6iqsGT6bO33OCb8kTTGkAlFt9o5bAmDejwkevQglxuS/caxss6RkXJJHySaAz+9LBWTyLe22Qgm+MRkWIrbwXhthf5CE2HIOBT4Lq4j97e4JIh1fDh7OfYik093dh29FE2MZODvLa0E8adwQilQjlcA5XUphx6Do3LclaD47PmpPPHkmpNtqeu/B7UIO9dotKsMjBGnWmmjnHizpc87ZSOXQDrtF2Kqbfcqc/rUO1huvG/O+vFA3JxlqX/o1djVOdsGYxUSXjQOpaJOrS8lsAdv/VpHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be42512-eb61-4154-ec08-08d863e9de6f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:05:38.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYBJ03RjjNPUPB7/uYYlZzbEKEUHpFtKvpzUv+GX/np0XsSrKKDW15PcKgES7lHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
Received-SPF: none client-ip=40.107.94.65; envelope-from=Wei.Huang2@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 16:06:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, wei.huang2@amd.com, peterx@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support to sync the IOVA-to-GPA translation at the time of IOMMU
page invalidation. This function is called when two IOMMU commands,
AMDVI_CMD_INVAL_AMDVI_PAGES and AMDVI_CMD_INVAL_AMDVI_ALL, are
intercepted. Address space notifiers are called accordingly.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 177 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  10 +++
 hw/vfio/common.c    |   3 +-
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c7d24a05484d..7604e2080595 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -76,6 +76,12 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry);
+static void amdvi_sync_domain(AMDVIState *s, uint32_t domid,
+                              uint64_t addr, uint16_t flags);
+static void amdvi_walk_level(AMDVIAddressSpace *as, uint64_t pte,
+                             uint64_t iova, uint64_t partial);
+
 /* configure MMIO registers at startup/reset */
 static void amdvi_set_quad(AMDVIState *s, hwaddr addr, uint64_t val,
                            uint64_t romask, uint64_t w1cmask)
@@ -443,6 +449,78 @@ static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
     memory_region_notify_one(n, &entry);
 }
 
+/*
+ * Sync the IOVA-to-GPA translation at the time of IOMMU page invalidation.
+ * This function is called when IOMMU commands, AMDVI_CMD_INVAL_AMDVI_PAGES
+ * and AMDVI_CMD_INVAL_AMDVI_ALL, are triggred.
+ *
+ * The range of addr invalidation is determined by addr and flags, using
+ * the following rules:
+ *   - All pages
+ *     In this case, we unmap the whole address space and then re-walk the
+ *     I/O page table to sync the mapping relationship.
+ *   - Single page:
+ *     Re-walk the page based on the specified iova, and only sync the
+ *     newly mapped page.
+ */
+static void amdvi_sync_domain(AMDVIState *s, uint32_t domid,
+                              uint64_t addr, uint16_t flags)
+{
+    AMDVIAddressSpace *as;
+    bool sync_all_domains = false;
+    uint64_t mask, size = 0x1000;
+
+    if (domid == AMDVI_DOMAIN_ALL) {
+        sync_all_domains = true;
+    }
+
+     /* S=1 means the invalidation size is from addr field; otherwise 4KB */
+    if (flags & AMDVI_CMD_INVAL_IOMMU_PAGES_S_BIT) {
+        uint32_t zbit = cto64(addr | 0xFFF) + 1;
+
+        size = 1ULL << zbit;
+
+        if (size < 0x1000) {
+            addr = 0;
+            size = AMDVI_PGSZ_ENTIRE;
+        } else {
+            mask = ~(size - 1);
+            addr &= mask;
+        }
+    }
+
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+        uint64_t dte[4];
+        IOMMUNotifier *n;
+
+        if (!amdvi_get_dte(s, as->devfn, dte)) {
+            continue;
+        }
+
+        if (!sync_all_domains && (domid != (dte[1] & 0xFFFULL))) {
+            continue;
+        }
+
+        /*
+         * In case of syncing more than a page, we invalidate the entire
+         * address range and re-walk the whole page table.
+         */
+        if (size == AMDVI_PGSZ_ENTIRE) {
+            IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+                amdvi_address_space_unmap(as, n);
+            }
+        } else if (size > 0x1000) {
+            IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+                if (n->start <= addr && addr + size < n->end) {
+                    amdvi_address_space_unmap(as, n);
+                }
+            }
+        }
+
+        amdvi_walk_level(as, dte[0], addr, 0);
+    }
+}
+
 static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
                                             gpointer user_data)
 {
@@ -455,6 +533,8 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
     uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
+    uint64_t addr  = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
+    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 12));
 
     if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
         extract64(cmd[1], 3, 9)) {
@@ -465,6 +545,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
     g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_domid,
                                 &domid);
     trace_amdvi_pages_inval(domid);
+
+    amdvi_sync_domain(s, domid, addr, flags);
 }
 
 static void amdvi_prefetch_pages(AMDVIState *s, uint64_t *cmd)
@@ -910,6 +992,101 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
     return pte;
 }
 
+static inline uint64_t pte_get_page_size(uint64_t level)
+{
+    return 1UL << ((level * 9) + 3);
+}
+
+static void amdvi_sync_iova(AMDVIAddressSpace *as, uint64_t pte, uint64_t iova)
+{
+    IOMMUTLBEntry entry;
+    uint64_t addr = pte & AMDVI_DEV_PT_ROOT_MASK;
+    uint32_t level = get_pte_translation_mode(pte);
+    uint64_t size = pte_get_page_size(level + 1);
+    uint64_t perm = amdvi_get_perms(pte);
+
+    assert(level == 0 || level == 7);
+
+    entry.target_as = &address_space_memory;
+    entry.iova = iova ;
+    entry.perm = perm;
+    if (level == 0) {
+        entry.addr_mask = size - 1;
+        entry.translated_addr = addr;
+    } else if (level == 7) {
+        entry.addr_mask = (1 << (cto64(addr | 0xFFF) + 1)) - 1;
+        entry.translated_addr = addr & ~entry.addr_mask;
+    }
+
+    memory_region_notify_iommu(&as->iommu, 0, entry);
+}
+
+/*
+ * Walk the I/O page table and notify mapping change. Note that iova
+ * determines if this function's behavior:
+ *   - iova == 0: re-walk the whole page table
+ *   - iova != 0: re-walk the address defined in iova
+ */
+static void amdvi_walk_level(AMDVIAddressSpace *as, uint64_t pte,
+                             uint64_t iova, uint64_t partial)
+{
+    uint64_t index = 0;
+    uint8_t level = get_pte_translation_mode(pte);
+    uint64_t cur_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
+    uint64_t end_addr = cur_addr + 4096;
+    uint64_t new_partial = 0;
+
+    if (!(pte & AMDVI_PTE_PRESENT)) {
+        return;
+    }
+
+    if (level == 7) {
+        amdvi_sync_iova(as, pte, iova);
+        return;
+    }
+
+    /* narrow the scope of table walk if iova != 0 */
+    if (iova) {
+        cur_addr += ((iova >> (3 + 9 * level)) & 0x1FF) << 3;
+        end_addr = cur_addr + 8;
+    }
+
+    while (cur_addr < end_addr) {
+        int cur_addr_inc = 8;
+        int index_inc = 1;
+
+        pte = amdvi_get_pte_entry(as->iommu_state, cur_addr, as->devfn);
+        /* validate the entry */
+        if (!(pte & AMDVI_PTE_PRESENT)) {
+            goto next;
+        }
+
+        if (level > 1) {
+            new_partial = (partial << 9) | index;
+            amdvi_walk_level(as, pte, iova, new_partial);
+        } else {
+            /* found a page, sync the mapping first */
+            if (iova) {
+                amdvi_sync_iova(as, pte, iova);
+            } else {
+                amdvi_sync_iova(as, pte, ((partial << 9) | index) << 12);
+            }
+
+            /* skip following entries when a large page is found */
+            if (get_pte_translation_mode(pte) == 7) {
+                int skipped = 1 << (cto64(pte >> 12) + 1);
+
+                cur_addr_inc = 8 * skipped;
+                index_inc = skipped;
+            }
+        }
+
+next:
+        cur_addr += cur_addr_inc;
+        index += index_inc;
+    }
+}
+
 static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
                             IOMMUTLBEntry *ret, unsigned perms,
                             hwaddr addr)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index aeed9fd1cbb0..22f846837a95 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -123,6 +123,8 @@
 #define AMDVI_CMD_COMPLETE_PPR_REQUEST    0x07
 #define AMDVI_CMD_INVAL_AMDVI_ALL         0x08
 
+#define AMDVI_CMD_INVAL_IOMMU_PAGES_S_BIT (1ULL << 0)
+
 #define AMDVI_DEVTAB_ENTRY_SIZE           32
 
 /* Device table entry bits 0:63 */
@@ -148,6 +150,9 @@
 #define AMDVI_EVENT_ILLEGAL_COMMAND_ERROR (0x5U << 12)
 #define AMDVI_EVENT_COMMAND_HW_ERROR      (0x6U << 12)
 
+/* PTE bits */
+#define AMDVI_PTE_PRESENT                 (1ULL << 0)
+
 #define AMDVI_EVENT_LEN                  16
 #define AMDVI_PERM_READ             (1 << 0)
 #define AMDVI_PERM_WRITE            (1 << 1)
@@ -198,6 +203,11 @@
 #define AMDVI_MAX_PH_ADDR          (40UL << 8)
 #define AMDVI_MAX_GVA_ADDR         (48UL << 15)
 
+#define AMDVI_PGSZ_ENTIRE          (0X0007FFFFFFFFF000ULL)
+
+/* The domain id is 16-bit, so use 32-bit all 1's to represent all domains */
+#define AMDVI_DOMAIN_ALL           (UINT32_MAX)
+
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 13471ae29436..243216499ce0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -346,7 +346,8 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
      * the VGA ROM space.
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
-        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
+        ((errno == EEXIST || errno == EBUSY) &&
+         vfio_dma_unmap(container, iova, size) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
-- 
2.25.2


