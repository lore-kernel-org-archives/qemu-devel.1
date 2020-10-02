Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B06206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p4Df2cpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B06206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kON0p-0006x9-8Z
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kOMWy-00050x-Kp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:59:32 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com
 ([40.107.94.40]:54752 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kOMWw-000697-BN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:59:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhdOMM0Az/ex3udkBsf+e5v7/3z1dbogKopPIFE0VyS2VTgUe2cCf6bsQs6euejZLvpyJxa4YNNsobzkjLzakjkU8z3rJARRL3+NZoTEEjpUuyU937m9FEML3rt9XlLTX32jrsDQX43g87ptliRLZ7ESq8cPipHDNfInkK2eWap6iUJKnhL8Z43RpEeGGmPjfM+7qS0J+cHtZ3Fgcxz+o2th06LdPeU4vMkqoZ6mxp4Qs7KZIFMS+Gt723HEA8U0/QmSzyit0xSf1uko0jbTMqvuWU7YSo0zT0UJVotbk6gqyMx3E/nXFV5SGwQAi0S6qgPBUm1wotv4RmF0eiy4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNNsBUn4y/o7d+6Z8NXW8vQrO0e0grqSGqKKJahg11I=;
 b=hOGYakoyULm+nU7ikBjIJQ9S2trPI/JsefE+9bbTc9RsteFprgTHw+LtlloaQqyb+uMhiIcZz3QsQKqrNN1DMOYcBN4qVl2edRaluvDwMxif92rANL3TgGLCoZvNJVtZrVnrCW8Mz7UmlddBuDWxsqwZAbV7a/9v2SKuIi/DKNhrUQvItFdnhyff8TSLcxghJtdA/Gsy6biGXcqJ9x6P8MSuyFu8+rgpaOOGHdhtHAAXoXmRdbrRlT8y8wPdUrJRgJJkCi16YcTZCvwTeSKpywgOyGxoRTGQ2KdnNREOWT1xYS6WmQsKenQJ6wCa9FX5IDbAcXsYU8SGD5xPteJiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNNsBUn4y/o7d+6Z8NXW8vQrO0e0grqSGqKKJahg11I=;
 b=p4Df2cplqfEZtSH5cdt8WAilJxFSukzj92utJrQzkHE5ScuTI+J9bRQP69g35FAVU6BpTtWBMBhvpAGgxjzib+SW5sR2qYlmH4pgOrJJgn88vwnwedXni5Q430IcT2fewY5gidGc6Kiu4aUFxEjtnqzgIPiI2DpaOODf8IJmIVo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0149.namprd12.prod.outlook.com (2603:10b6:910:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Fri, 2 Oct
 2020 14:59:27 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 14:59:27 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 1/3] amd-iommu: Add address space notifier and replay
 support
Date: Fri,  2 Oct 2020 09:59:05 -0500
Message-Id: <20201002145907.1294353-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20201002145907.1294353-1-wei.huang2@amd.com>
References: <20201002145907.1294353-1-wei.huang2@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:5:80::25) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx56bbhost.amd.com (165.204.78.2) by
 DM6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:5:80::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Fri, 2 Oct 2020 14:59:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d47b796c-dc8d-407d-13ff-08d866e3c1ec
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB014956C0BB4C048101771512CF310@CY4PR1201MB0149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++kjrPnFyu0yLia5zt/jso6gVeUi3Pf+BQBK2Y2IBbbxBDmrJduZjNGQiabZOzUKqcNLGnRb6jC2k8Gzk+iQ9gPal8xOs8I6M1uYFEq4hi2x05z9Cd5HS7Bn7HQ3w/LCi0Q8CXXy+ZMKF+yDgNloCg45oyBPRb31/2WvXmv6//gpJEfiVKjCwNJUsRohVlilMJs6CdVbSsiL8/SnzqbasUEKPgeCSVEjgwrYt0Bx4fmdV8iSYEZR+sGRiSqLg7RGOYCXDZUON7/olLb6lgASNtonZQnWaBQgqJZ/Us8X6WQG08mAXkSTKcTpMrze89puE2xyujbKNiOvdT0Q8Fhccg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(66476007)(8936002)(66556008)(66946007)(956004)(8676002)(2616005)(316002)(83380400001)(4326008)(26005)(86362001)(52116002)(6666004)(1076003)(478600001)(186003)(36756003)(6486002)(2906002)(16526019)(5660300002)(6916009)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DLVMSGDBAZdXpct/AvHLvO92FwAue7LO7G7oTiXpHjHYAXGgWowNgMtqBNfxZk+yozUZSRknMqFWYqoZZbaklV5/SZUTnLGAIGnSm8QjBiq/LD13mIYoafA19NXYldLhy55vpBLC0OEV/nX3084HydCTe5J30+y8tQtkvhhz9YXixEkDu051grOcXcT3STsXoK6yucSLzNgche5DmAKlV2EAO3mw6zNV5lr15cGZ/YbDX1KR43ZIBd37meSFQKqJuRuwf+/955vA7zyL2DtUojrqqah6AQZ7sUoo4aRjdGenoGBQkSSVTBEDLck6NKypS+82Jed21Z7YyV6N2ArzqhoKxtkrbfj3B+QD6CUo1UqzSavUZFOdMLY2aMjbQzDnobQmoeDntKfla7Gc3NrPkKmeFKO3WTMsqXNS012X9jtCAksK5tBaTKLJS8YqyDmktY2Z6NDi16yxvAYae1n4K3ToZWiGaV4vOwGnYWxNfjyY9ZKSkJHgjsNTkR47YWxyHsETIIYfhV+TNbWVkBJljGc0SDWGy/42tB30ZfxOFttOeJ565wIBDyERjDNCVer/h4IerN5/LYVZzvPYg+6Yvn4r7iHOlyqpEiA5SEn5MKYtrRIbhvtFbtIOBIW/xnPdutIAmpKQKNEEadJFtwougg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47b796c-dc8d-407d-13ff-08d866e3c1ec
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 14:59:27.2067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzFMxC43K1whjhI1WEcVHIH+ax58SWQb0RF+tlBUSYcP2Y1tLdMX6DvKKDLIzzX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
Received-SPF: none client-ip=40.107.94.40; envelope-from=Wei.Huang2@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 10:59:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
index 79d38a3e4184..29b7a35a51a5 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -362,6 +362,9 @@ struct AMDVIState {
     /* for each served device */
     AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
 
+    /* list of registered notifiers */
+    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
+
     /* IOTLB */
     GHashTable *iotlb;
 
-- 
2.25.2


