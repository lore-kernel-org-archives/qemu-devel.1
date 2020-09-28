Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA19C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02CD20773
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GSU3/lV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02CD20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzR1-0007iC-QX
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzPS-0006Oj-SJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:06:07 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com
 ([40.107.94.65]:7990 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kMzPP-0006yf-SS
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnWXgHmGXzSTGEc+w8j4VvQMiH2aY9grDpbNqwhLLhVhz3ZQVVBPM95iT0v6BySqxNfpFOHlB4GXBVY8hP8+nd1OyGFfYl9VAu0X2QHxUXrQzYTle+W8je/M6kUG9iEE7QzKszcxInBBRaKA1ad67KTA4E8svBd7p2KEuKKamM2EfzAbyE5qlxYKIzpMh5TktAFV8vpijyyEAaYWQmw9a+zuPUdMm/mxF9uipdCIpBLPUXY9CYscg4+BElzbGLvk2hZtga8HF8kV9bs3bjcHH81kzZl1MZMLk28TKbdGet04yI1hF373U4d8/0GWG4pLWphVxKbMj26NNkn3wrYTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lGCQG8ohaktYqh4DdntmrGbaibr6BlmrS5abSwHzQg=;
 b=CtXy/sFxBMNtX5q6IynBTXCrMR0cC5z/9FbI3kfU2ro0qNs8HEK6y2uN+3b3VlYgqUat7qCOZR97pWPAoaoaoQaxfvbNEx4cm4SdmmnYjQqkkX0jqo2qy9wDohEbxYX982uFh3ZmJndXtByyDrlEl5MlNoQUFQhJiyBla40vjLSB1bSgFOgwO3K+VWBnWgF3aomBzJmlbIeTtzxg/0vI57ELvQD3KzvVnHpqd7ryHzTDHxeLLcK5r5zYpRULDcvJql7pVtcy/tewXibv+TUKlQQScihgDa9JWhWlxh4sOpBmURTE/L8atBRbWuCTAiJAN0MnYBrc4dT1hc8swGGPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lGCQG8ohaktYqh4DdntmrGbaibr6BlmrS5abSwHzQg=;
 b=GSU3/lV6ZT+U5kL5exerUmJ6ZJrPcaO0JZxeR64I1qZ8Vdo/UoO8B3nxYOgPcabQyfSBq5zvs3MAD39Pp/0iLXoQJHvcFWjdufR7mVZ4RstGvAT7AipiX9Gj+fhPwogLfIDgHIfzh1MgRdrYTpVFaBDR5dD91J+lYPTdLIOrpXs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Mon, 28 Sep
 2020 20:05:26 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:05:26 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 1/3] amd-iommu: Add address space notifier and replay
 support
Date: Mon, 28 Sep 2020 15:05:04 -0500
Message-Id: <20200928200506.75441-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200928200506.75441-1-wei.huang2@amd.com>
References: <20200928200506.75441-1-wei.huang2@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:3:115::24) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx56bbhost.amd.com (165.204.78.2) by
 DM5PR11CA0014.namprd11.prod.outlook.com (2603:10b6:3:115::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 20:05:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4946a599-834f-4fc4-db9d-08d863e9d733
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0023D1F6FC127E96CBCAE0A1CF350@CY4PR1201MB0023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcqEX/7ffe/9I+gGNDWSw2wRUzjxWqimXWjFJdcKsQ5w1CFYK2EWzg6N6SbQ1xOPIzjQraLYuNh18Sw1S1eKgPeGtXsZGST7DhLpdNPGTWtw8bfyH7c6Rk/hHCT5+d4u5N8l3AqH5jkUIaO+gws4y7y4weQCQBTFtATCvWaOd41YmmpElslsCusZmc3vE0BoMx/i3YZlLmx+jXqqiBygCHnFtHRaYOd3+WCKjMqclHgcVDGHJ36MyefM+YI4VrCWNGZbGzF/tuRefsy5X81ggCr3wsDIWA55Tray9iCH7XUQTLL5fv/PEOhMZA3skrfrUszzpGzbfcy854jRQXdz7QUP9ZKpPK/ubgbHVj7fBTnpd3pH8QL+ntH11Nu330vi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(6486002)(4326008)(316002)(2906002)(8676002)(86362001)(8936002)(6666004)(478600001)(16526019)(5660300002)(186003)(26005)(1076003)(6916009)(83380400001)(66946007)(2616005)(52116002)(7696005)(66476007)(956004)(36756003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LjdDq0yUkLYjk0MTFqinzhJaVIZIc8OCMFqS+FWvzgZyaFFW8zXhLkLwx8/9hNroRyvovvh94k2v0fA3WoRz7UglDiTy0cjpC9VYHcOQvJcAHL58Ee3EHrH5qdHrnulst3sqvhnkwIE74L4MlAb+jTmZKjvsFjsDiO9TFeNa5rsYuVCL1DrSsEipk9BmOeNKa3EpD7F430Iu9IvmAiZqMnOTQR8jd2R6X6OOPKPOlni4/bimYqU8lb5P72k+xjj/PssqVRypkCNGnjAm1lxz40zi3lhwaCdUgKwjM1+PkOcQBEa5Kl4bGBobteTfx84vp5L8XO7wItnJnB2x+7mSbhx9i6ceANeVyuXYyoNi2x0XS3PlW5ZFgPyWmCNwBx/V6xITzVuMeTnl1pwzM9ecI2tkpbsEmRm7VT2dSWo21dxemP2Kef7DjXDNygF9GPXMSzydGDvntPswM7gBAzmNvCJjXokXyL1X7HyFuOCQjQGFSdBIomwy+wa2pTWsl5zuMMvYC6/YeTThuYsgcDgHvmaX7N48g5ZGW23Kh33dbbNVY3hh7+eIekcN5+Tw3Q7OQZvf8SNwlMbp4C29+DXu6HD0kzXd2gfB7M7fD2hK8A5ROB3kapDjU1e1uSeo+FXQZrm1B/A6bafmu88IaPbYBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4946a599-834f-4fc4-db9d-08d863e9d733
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:05:26.4863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PO+FZA5i4gPVUqM9eG/UePMMfvi1m70SGmpGpRiikbROzAvDqtnhiwk6xVwgjav
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

Currently the emulated amd-iommu device does not support memory address
space notifier and replay. These two functions are required to have I/O
devices supported inside guest VMs as passthru devices. This patch adds
basic as_notifier infrastructure and replay function in amd_iommu.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 45 +++++++++++++++++++++++++++++++++++++++------
 hw/i386/amd_iommu.h |  3 +++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 74a93a5d93f4..c7d24a05484d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -63,6 +63,8 @@ struct AMDVIAddressSpace {
     IOMMUMemoryRegion iommu;    /* Device's address translation region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
+    IOMMUNotifierFlag notifier_flags; /* notifier flags of address space */
+    QLIST_ENTRY(AMDVIAddressSpace) next; /* notifier linked list */
 };
 
 /* AMDVI cache entry */
@@ -425,6 +427,22 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
     trace_amdvi_all_inval();
 }
 
+static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
+{
+    IOMMUTLBEntry entry;
+    hwaddr start = n->start;
+    hwaddr end = n->end;
+    hwaddr size = end - start + 1;
+
+    entry.target_as = &address_space_memory;
+    entry.iova = start;
+    entry.translated_addr = 0;
+    entry.perm = IOMMU_NONE;
+    entry.addr_mask = size - 1;
+
+    memory_region_notify_one(n, &entry);
+}
+
 static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
                                             gpointer user_data)
 {
@@ -1473,14 +1491,17 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                            Error **errp)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
+    AMDVIState *s = as->iommu_state;
 
-    if (new & IOMMU_NOTIFIER_MAP) {
-        error_setg(errp,
-                   "device %02x.%02x.%x requires iommu notifier which is not "
-                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                   PCI_FUNC(as->devfn));
-        return -EINVAL;
+    /* Update address space notifier flags */
+    as->notifier_flags = new;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        QLIST_INSERT_HEAD(&s->amdvi_as_with_notifiers, as, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        QLIST_REMOVE(as, next);
     }
+
     return 0;
 }
 
@@ -1573,6 +1594,8 @@ static void amdvi_realize(DeviceState *dev, Error **errp)
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
 
+    QLIST_INIT(&s->amdvi_as_with_notifiers);
+
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
                           AMDVI_MMIO_SIZE);
@@ -1631,12 +1654,22 @@ static const TypeInfo amdviPCI = {
     },
 };
 
+static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+{
+    AMDVIAddressSpace *as = container_of(iommu_mr, AMDVIAddressSpace, iommu);
+
+    amdvi_address_space_unmap(as, n);
+
+    return;
+}
+
 static void amdvi_iommu_memory_region_class_init(ObjectClass *klass, void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = amdvi_translate;
     imrc->notify_flag_changed = amdvi_iommu_notify_flag_changed;
+    imrc->replay = amdvi_iommu_replay;
 }
 
 static const TypeInfo amdvi_iommu_memory_region_info = {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index fa5feb183c03..aeed9fd1cbb0 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -364,6 +364,9 @@ struct AMDVIState {
     /* for each served device */
     AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
 
+    /* list of registered notifiers */
+    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
+
     /* IOTLB */
     GHashTable *iotlb;
 
-- 
2.25.2


