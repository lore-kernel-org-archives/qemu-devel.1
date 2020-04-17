Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF38C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A47520644
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FwxfZyWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A47520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPSid-0007Bh-6t
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jPShV-00064t-Nt
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jPShS-0006RG-Mg
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:14:41 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com
 ([40.107.92.54]:6265 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jPShS-0006QK-By
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:14:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWrZ3KtzWMTrzj+8K1lQ9BXThzmSZQahxYFXNqswcVgCaiv9+mP3TAFs51c7PWIQdWkGNSUa4FB+sbcUY49o01Y92FId1S+DA6YJ3I5hJNOxdC3bOuXyMKZRgmINknwk/t4KX8GLCC5Bdc7c4Tr6tGw81qak/wGwyyvIUFA1XOlciFi87TLP9HuNIDQQnFwdIL/YVTh7YnL4zqVZM0OcWH+NKYnz2cJzNY6pELXzfy/87Wgc7lZ4DZoG1quBBCNRGjaIyxVuyK0blAipMDI8YJUSkDHQn9bR6qCv1LMWfh6OSdxorj74jCnBLy8gUTgjEBbQWSVxhQUVkqsHMWU9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDJyhGqpCEf/DXyKcMQHTetCi/NEGzYHQZVu/ePxgAA=;
 b=TR7zv1soQ4oGj3SIvKf1ucpbeoNu02YuQp/UoDHUocx1PGBN8KIBhVouvJVz0g62q0Jzila4ANeLT76QiZ89rYBjGzmhGgJEVdHrTCGHWLIgF806aw4wHzorxEY/GmoKKU/AWaU4U2KQY4jlNw2usN7Le4mhZspnQDgu+aE4DDxycvFCUjlzvngfX8XlmJY1dMu+OEsoQKzX/Ub0eIzaT5qVq44PvYF4LDZ3f7C7NkbrQJsmUXVXxprTG8gG3oCT8x86jU/C39+sh5bP9kTFXesUQe1upgB8ZsgoX0M2dY5AqzZdsiD9G0f+AYf7a9F7AV0AsRgOTMAgkkSFBOlaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDJyhGqpCEf/DXyKcMQHTetCi/NEGzYHQZVu/ePxgAA=;
 b=FwxfZyWv5DTwzUDVS0rRHiquBair9ZhLGi34nzzoHKSM6ttnkIrKLVGZeh306HXp+flpIUr0reIyOyGsEK6X4nty5uHQUhJ9q8PrZ8fimTMLTx6XqzDyWFOzPkRwajWx5dakffq0pJ8FjcRh6b6Ze2z3u+u9dC36JU7s5ZDa6A4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Fri, 17 Apr
 2020 15:14:34 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 15:14:34 +0000
Subject: [PATCH] target/i386: Fix the CPUID leaf CPUID_Fn80000008
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Date: Fri, 17 Apr 2020 10:14:32 -0500
Message-ID: <20200417151432.46867.72601.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:4:4b::31) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.78.2) by
 DM5PR15CA0045.namprd15.prod.outlook.com (2603:10b6:4:4b::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 15:14:33 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b415a434-edb8-46d9-2d06-08d7e2e20948
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:|SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254289B67F18153C36F1E29D95D90@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(8936002)(81156014)(966005)(16526019)(8676002)(26005)(2906002)(6506007)(44832011)(956004)(4326008)(7696005)(103116003)(55016002)(9686003)(478600001)(66946007)(86362001)(66556008)(52116002)(5660300002)(66476007)(1076003)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gENML88wyiiuzM/ab53XTX6akIYWG7LRL3q7VDhoJEgwuvNipGLkaDadaOL+eyurBVnZjn2qHfiftSPSOFg/qnsbxMm6UjC1ZWyNr/agEdrh+a5vvp+HL1wH303wazscKrwBTvlC68iAqC4+LWT1Qc4sba+0mJFDLcPpfpLhhQ8AX3bIyF4wFnBM/eGGaov4u4SwuOmIc1RJl7LMW72ZbFUmXaqnKclScq3r4DbbTltq4PKWC9fBFze8Db7hk7ZgIsE3OufiUHevlsV1kUEUZHM9xW3C5thJtcaKbAHO4Q0nnrQEIJSlWaSqeoGaI8MKnDbGuaV9vvyYTtT4p/i0gLICnmvFWO785OVOyf5T/sZE2b9z5Wy2nUdDS9+osioxL0qxiYSEb8KXvYZN8oFPj+U+CEA4E7E2PUcCaagvG9Y722B8nWScOXAsgzs5wv3pxiOLUlUI9wntAWAfsTm7ennWtwyONnKPg+Kd1p78chr7IGT/v8GQ+g2wvEGUSdIBYPCgO5EGE1zaenejXu7KA==
X-MS-Exchange-AntiSpam-MessageData: dc+2PBXhxTPZyGdFKt4eto0a2uqhRswRcN41WPId7kBwr3i1DvZSCJrzOvFGaBkHZwG3XZW56tBz3hhyLjI75iVsidw8zw3okeJS8xIAO4w+SX73gxArprHhE93IX3KI1E5CVcatI65CKUNoZTjwoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b415a434-edb8-46d9-2d06-08d7e2e20948
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 15:14:34.6033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVdYePrUf+FC8nFXmqQ+qPe82iv3Bu77ykEmbDTdrWnutVQdxWldoAZ7S3KTcOan
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.92.54
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, 1871842@bugs.launchpad.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPUID leaf CPUID_Fn80000008_ECX provides information about the
number of threads supported by the processor. It was found that
the field ApicIdSize(bits 15-12) was not set correctly.

ApicIdSize is defined as the number of bits required to represent
all the ApicId values within a package.

Valid Values: Value Description
3h-0h		Reserved.
4h		up to 16 threads.
5h		up to 32 threads.
6h		up to 64 threads.
7h		up to 128 threads.
Fh-8h		Reserved.

Fix the bit appropriately.

This came up during following thread.
https://lore.kernel.org/qemu-devel/158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com/#t

Refer the Processor Programming Reference (PPR) for AMD Family 17h
Model 01h, Revision B1 Processors. The documentation is available
from the bugzilla Link below.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

Reported-by: Philipp Eppelt <1871842@bugs.launchpad.net>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f..68210f6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5830,11 +5830,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = cpu->phys_bits;
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
-        *ecx = 0;
-        *edx = 0;
         if (cs->nr_cores * cs->nr_threads > 1) {
-            *ecx |= (cs->nr_cores * cs->nr_threads) - 1;
+            unsigned int max_apicids, bits_required;
+
+            max_apicids = (cs->nr_cores * cs->nr_threads) - 1;
+            /* Find out the number of bits to represent all the apicids */
+            bits_required = 32 - clz32(max_apicids);
+            *ecx = bits_required << 12 | max_apicids;
+        } else {
+            *ecx = 0;
         }
+        *edx = 0;
         break;
     case 0x8000000A:
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {


