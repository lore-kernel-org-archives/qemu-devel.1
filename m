Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12370C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9D8206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W2byJEKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9D8206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCou4-0003Fu-Vy
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColp-0007It-K7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:43:09 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com
 ([40.107.93.85]:37504 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColk-0007Y8-9J
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+6XsRPsa+1K3X3/NxR8iiTpoTuFYtazsrbwO7CvlpVvCpRc6GZp+/QlSHI9z3sXjlsDJf1pVjXy2+UPD3oqdaTeOz/KCEW3H3Nu60mj1CUm9Q6LWyeXqLHu/YqTTanFhBzq3ay729VrZYF/bqTvDWuqqN2gLoURskbNM4TA+p5jLpZFplJz+3D2Nw5FvUlr/bCYm57PY6W4lfQ5mpwdiW0928USGJ02mJv/UjZJBMACF/XlwaD1G+URyDWPk8eQzaYyd9YhJpNS2Fp7kv7Ygo56swM7YysNhboEdFhIaovK/tPZpshPK317ez3eKLPCLFG0elsvvnnBiJliQYwdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+8KtUav/FQdspK9sDZqTmizubAzUAiaEsaNU3DLNWk=;
 b=gjaUox2nLL5QpU8tqF7MbOIy2BlqybOalI7//S/aUi++gDGQb32I7dNJChLcDpq7bFpT21xPB01p0fe5uq8bhXMXosgzl6EId4gSOPjBmG2Fs0XwU4SRZN2sd/oeK4WHWHPDlFB37w3qS3WSGa91O2duXLcuDVK7D6owc2bw3dGkdLzy3io77kmQeM5vOl4BcWYG7wTIYdBgcbIDTjtFXZTNpXUngnCWCZOu8r94K/q8pJjl5xWZ9QimyFE3Pqpn+OM/GToYC65y9nhgB9LSP4RCFMozvpWYD13RaoTkG0V6gWylD0tShxwQY0gzh73TI234amYGez43O92Q6kbS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+8KtUav/FQdspK9sDZqTmizubAzUAiaEsaNU3DLNWk=;
 b=W2byJEKyEAU8dzv/gJ40gqxm71qbUGDGzrXU5ae9hNmdgLdey8HNKQi6mEygrNQV7KmEdCW4gqgG27rFW7iKz9uk0/IJf1NSUJFl5OWwk5AhTHpfMxe3S+YCPJfOmXYqHRMGFIL7/PTSPwB7QF2PCnjVBPF+jmDZm8WqZ5yJeXU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 18:43:02 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:43:02 +0000
Subject: [PATCH v6 09/10] i386: Simplify CPUID_8000_001E for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:43:01 -0500
Message-ID: <159889938099.21294.9493474163204060713.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0041.namprd04.prod.outlook.com
 (2603:10b6:803:2a::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0401CA0041.namprd04.prod.outlook.com (2603:10b6:803:2a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 18:43:01 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4be18f2-5db2-4cdc-6dad-08d84dddb09b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB438383791BCE460DF0F5A69495510@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+AxekWJJO+4s9PFclE3GP26VPX5n1hKHbBfb4erO/rcwLDFuDYNYtRvTQYP7MZxus5fEX3fogu1C5dSbtvcqmMzy8jpp7K+ZKIUkscKB+2QPvDxLDDGgu1DQNb4oWtI940Vw2cUQxLBqTv80etMFvRG7wtdI7H+FpLPo+0s4L+sD8L2mhVbK7wk36uJ68HbCwTMkF1wDYA6/rB6gDFKmgLUHYeXZobjv7r889hYScuX6fyiK94uzRfAgCyg70LGCBN7PnKeb3mZ+2n9ALKZdu4tWhyeyWEWAvyKbsVTxmKORwzRvHz8SukY+UtqpyiUHJAdrcJ+4m3TaJ8PQwaZ+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(316002)(2906002)(26005)(66556008)(478600001)(6486002)(4326008)(186003)(956004)(83380400001)(8676002)(66946007)(86362001)(5660300002)(52116002)(103116003)(8936002)(66476007)(16576012)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ntNommQdT7tsdh6GkKKaGZp63sD5ybjHSVdVwPgWokEILAt9JBdHS4etdXJTN/sq48Bqa1SRkJF/1+XUYKBjkeLv2UJvFlERaoECDZmK0vA8VlZtfsnVBgBwf/asIqH8ZuAPMwnI04BUDqdp1Y+Fz8u++wJrqPE/sYwvn8eFqqH9RN600tfiQRIy5O8zjGR7SKxkkEgJGw6P7XS4uEN5dDtlRFdZ0E5vA4RBdI/hiLzQz55iFthZiZesn3TzOOvYDr4ULcvVWfePpdCX30Wl1Xri81YTljYDaXs2eWQCe4VQR9gu0LwRohylN4/8zQyPJvNfOlaV1LZADsGdY2nMAvPxmYiGT4pZWAI9uenCPHURABvWIt89/YKfDplpF9vDV7fmBGWH+LeD/DdAn/4kbo5WEpM0wDvFO/eeqK7Bqz54HlY4Vz1lHPEQMDrc74Z/KYRND4Pnq5ytAHx/yJE+FSszG4eUJXSqocb2bHJoJCnTaRHXcfwGTy7MblYzYLzrP4mOLJXPFqByfULD12mc4A+XDyCf6zpF8c+A0W+9El9MkInTWky4FiT7vyGS07WMW9FjRNMkcr/dMwem6wOVE46+XCq75CRwZS6Mwfn0wowCo30ciB5xg6CR66NEguVMc4bA2B1bcpTUB4HQURYNKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4be18f2-5db2-4cdc-6dad-08d84dddb09b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:43:02.0721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOMEzK6KMsf58mjIUOYMcjfIr19sAjUqea2lyhXYwmuWltdzx6OhldzhsHZWygGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Received-SPF: none client-ip=40.107.93.85; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:43:02
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

Remove all the hardcoded values and replace with generalized
fields.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba4667b33c..d434c8545a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -395,9 +395,10 @@ static int cores_in_core_complex(int nr_cores)
 }
 
 /* Encode cache info for CPUID[8000001D] */
-static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
-                                uint32_t *eax, uint32_t *ebx,
-                                uint32_t *ecx, uint32_t *edx)
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
+                                       X86CPUTopoInfo *topo_info,
+                                       uint32_t *eax, uint32_t *ebx,
+                                       uint32_t *ecx, uint32_t *edx)
 {
     uint32_t l3_cores;
     assert(cache->size == cache->line_size * cache->associativity *
@@ -408,10 +409,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_cores = cores_in_core_complex(cs->nr_cores);
-        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
+        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
+                                 topo_info->threads_per_core),
+                                 topo_info->dies_per_pkg);
+        *eax |= (l3_cores - 1) << 14;
     } else {
-        *eax |= ((cs->nr_threads - 1) << 14);
+        *eax |= ((topo_info->threads_per_core - 1) << 14);
     }
 
     assert(cache->line_size > 0);
@@ -5994,20 +5997,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;


