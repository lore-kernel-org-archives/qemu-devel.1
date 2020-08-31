Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B97C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25B02071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jBBsrvsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25B02071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCom6-00079A-1q
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCol2-0005ol-4F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:20 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com
 ([40.107.75.43]:51695 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCokw-0007Sz-Mz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/75WMe8NNbgRBi5a8qhtlyGvgkg7Ukgd3gFvL1xTaKZOhxHfsPGK036jGDf56JrVfKr2aNRJnLejK8CB6qJVPsiPv2IHvli79LCj/lJvoJqLyZGwljbEZy7h8wSrfLQKxf+NnHbbnNYHdxxWcFtFwKX1imTgaJoGkJfcOmQ0LgZnR9ngPtQPAuxlXPsqAKdN/zHWS/Rg/HXjbBKzrZ8XjxZWl3QtlWbZj9jwWsEf7N8zIc3f5xcQUAYKA8PMmlBiVT1t7Re4z3cRA5IM1tXVfRSHcx7ubITc5ov8ynja+HNWrcju3NNWQZKKX9JTS7X6c/YAKZmtGulUNfa3TL+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYYZTgO74ACxkoabLIb2olY7JXFiOKa11FI3TlIZwsA=;
 b=IbCuaCMxKoCN3zzc/XgYblczVf2oMorHLhM9T5jfEIdJ05+ePb3OqyafwfGT7qZX1b6t8pHSByNHUSpNEHNu7ljoUyt0wo0K8ehx1msPTsxBobwheiLYsbTk0v77UT3HGsjcbFs+cBOGWYw4fstfJeavPzV7lJhphegikfW2MEM4Rd0w58jbCZJNrSAja8wHJO5iFF8R2WikSr6T4166CDtZT8NXTrAUg6GNJw7z92KxrPnNwr0wYVH0yogAXfjpKcReydeVcWRK1gsK2HGGKaM3kQL+qmKuY1q7Ang0DYmM1WgvsZE0SLHIQB2OmAN+lMAwRvBkvm0H3j9KaG9svw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYYZTgO74ACxkoabLIb2olY7JXFiOKa11FI3TlIZwsA=;
 b=jBBsrvsjVJXHE0G4c7doBHSc824oKsECUrnj50bEtSy2gOy9JhDcNQWgOpr8NxfHq4m8fZ6FD3ashsQ0mLWZayea2/3/xFAtVTIYos/hPr+9fN0iMtw75/GO+uG/h4OUiCmf8M6hei2qrUR3es3cHVOQmsf9kvJukRLiulIjsy8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 18:42:12 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:12 +0000
Subject: [PATCH v6 01/10] Revert "i386: Fix pkg_id offset for EPYC cpu models"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:11 -0500
Message-ID: <159889933119.21294.8112825730577505757.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:806:a7::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SA9PR10CA0010.namprd10.prod.outlook.com (2603:10b6:806:a7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 18:42:12 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 21708d3a-ee29-4043-6ebf-08d84ddd930d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2559444E1C61CA8D1C70B91095510@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJ5ugb/D2rum+EgUPW7QXRgBmtz0KBvX7ANy6fezXjX9dGr/PF66Awu2jH6VlZaYypIPI3vbex82lDZTEIE1eUTo7BrmlE7sNkJacuOwJgqjfQrLp1Y3aokpMSOIq3Oky+A1ri4t5PngQbTvlnxCmck6wK2m/oQvBLcEulgmDEUQGxS+DdjYOFfAhxiRifYE+tnc/e7uGEaPmMHsFQqHFJswkHBYmu6eIkuSQXvRfQRI6hoUtRa6TW4k4/tZw1zh2edTTuZbfNOHHGcPMXYkGictIbapJ+m7pVdig4XH0UAyee9YF1F30+OnvBipktvdx3zn6wqYfXkS3mbkZgq1eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(2906002)(66946007)(83380400001)(66556008)(4326008)(26005)(956004)(316002)(16576012)(5660300002)(186003)(66476007)(6486002)(8676002)(478600001)(44832011)(8936002)(86362001)(52116002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7aqXeXW+Uetkjkdvgag9S1ez+5H7u5Cbiub4cvZIRXWX6NW3gEuQl1aGseigwZke8gQxNHwxcuPmc6e5xfwIvB2fdq92cA6atAmsdw5+JIjmCB54Ckms2WhmlxoViKIWNGIjYMFq+PE/TlSBOOGKTPmsTOgRaFE7i62SYBp5l4Lf5RF6+Me+CqZFcpsRbxMnyKPO8c++o9k4+vz65VxO0rEsCCRs/MKPUWv5sjVVqa5ruFj7sGKo2gZRJeeTZXT9spEYDF+z9m1vo34ygdxZgbAZ5xTNy5V4jzk1PhMM0c+xiabXGWO+c6VMHoyzupN06TxTcgoGnzfc/Fj99RZUWA00IZrANdxXm1N7WagCMipo063lOTcYpI65ZsgK6A+3ndNRV1qXcRXeqKfi4YhhOPkj5hJr8SEx54vf3AwxtR8KYbhQ0Otx02AB3vZTUKaQdhL7dlRU4bUlmHjAbjcj7zFuJMP6aXFsFt+B2j5T2ZdZMrPXAr07SbNRUaMMDpDVyTWY0Yc2gKSVaS5S7X5UqvlywC/3vCpjG2xcT72YM12w1m1O9DgtIpIs6z61RmmCMloFDlNN20LCQWS9afJVBYKJaFU4NeihJ1FuUgR7/0bphYdhJel/cduT1ubwhpVlztWxVWKYy3T2bIyvf0pV2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21708d3a-ee29-4043-6ebf-08d84ddd930d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:12.4016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1msdWkkKzUYljHDDv+gBx84LPVQJe7i5hMPeFKPIqGVjHLSQMPzxLaODTPkYL90q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
Received-SPF: none client-ip=40.107.75.43; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 7b225762c8c05fd31d4c2be116aedfbc00383f8b.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Also fix all the references of pkg_offset.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c      |    1 -
 target/i386/cpu.c |    9 ++++-----
 target/i386/cpu.h |    1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5d8d5ef8b3..6b708f4341 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1502,7 +1502,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     env->nr_dies = x86ms->smp_dies;
     env->nr_nodes = topo_info.nodes_per_pkg;
-    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 588f32e136..173e6f4a07 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5678,7 +5678,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = env->pkg_offset;
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5712,7 +5712,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = env->pkg_offset;
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
@@ -5889,11 +5889,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /*
              * Bits 15:12 is "The number of bits in the initial
              * Core::X86::Apic::ApicId[ApicId] value that indicate
-             * thread ID within a package". This is already stored at
-             * CPUX86State::pkg_offset.
+             * thread ID within a package".
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
-            *ecx = (env->pkg_offset << 12) |
+            *ecx = (apicid_pkg_offset(&topo_info) << 12) |
                    ((cs->nr_cores * cs->nr_threads) - 1);
         } else {
             *ecx = 0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1a5c174dc..d5ad42d694 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1630,7 +1630,6 @@ typedef struct CPUX86State {
 
     unsigned nr_dies;
     unsigned nr_nodes;
-    unsigned pkg_offset;
 } CPUX86State;
 
 struct kvm_msrs;


