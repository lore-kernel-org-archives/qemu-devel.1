Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C1C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D43206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GJxu6Tj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D43206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8fr-0002kg-Vp
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD8f5-0001BB-OE
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:57:31 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com
 ([40.107.220.48]:25055 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD8f4-0003bD-7T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rip46+5BKHnVcxJZZjkTiThngFFqNOxiysCqo0HJCipKMxdTTKKtpDrkG49+e/VoWrdy90npPoFUbKP08WuUfz3bcWTd1z/g4KgHxo6ESv1kojnqjlbnGpPau6yb2RCEPqeI/pzUspTNksEtTSyZyAB4fuCeWlam4E5Wg/thn1pQgdvOgt5uyIjRCoVYjLfyYVJv+fiiM6KgNFQ9woxd8ldcXpzl1fYMr86zX+5VYF3iddcBXrOnj/gIf/S9L2wMfizWvL2VfBUtpz4FbGFh3dwvvFy4s1YWkaAoHGc056cui7O+B4uGJe3c70lTv88qyrePu7TslNRo79jVqAbGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flGgGKqJt0T2Kai0mcbX13Hwc9d5GJGtu1MvenMh4Aw=;
 b=KMNpLAVETwa6/g3t0kdRIdKXX1dbNDNeRRB4OA+Lylaq+XUXMn3XBxwstoLwttkE7Lr91SQVdLWrhkt+wCR2rsLncIwigfQeZ74RB7cwaZrpNgwcFz1kxXIKQ3AMjmS2+xdNtMZP/QtjPUPsPiF5DDlOU3mkFWK62wu78Rq0GWCd/CXisgWhBJjuL3Ye60FpJf8tKdQjVqYhvMgYLskTbMmNkg/KzPJ3Y4ZJc02znu1l8xUs8rhF4EVNnSE97FT4+AAg/m9PCE2CxXGYytYL7QEhreB5f2qQo9FyN22uWTJA4u5F3+9s0lYmF4kK7aCc3kxDLpvllI/xvc7Grp0QLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flGgGKqJt0T2Kai0mcbX13Hwc9d5GJGtu1MvenMh4Aw=;
 b=GJxu6Tj46vLcR2D9wIPzqGhLUb5R4GpLs0Ng6GJ+sGvjaJCtVKMpnQTNfLt4dGjQligoXOOW/wPkeQcVXX0/QU5XmA6YDZwnuC+HnRKOR2nvUOUTzYwE/GfMLRjk9zvXtc+i52MNPJ9J2IzTgjBD1kifzGTXpkHrAyoJUbVZPdk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2606.namprd12.prod.outlook.com (2603:10b6:805:6e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Tue, 1 Sep
 2020 15:57:27 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 15:57:27 +0000
Subject: [PATCH v7 1/2] i386: Simplify CPUID_8000_001d for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Tue, 01 Sep 2020 10:57:26 -0500
Message-ID: <159897584649.30750.3939159632943292252.stgit@naples-babu.amd.com>
In-Reply-To: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0060.namprd12.prod.outlook.com
 (2603:10b6:802:20::31) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN1PR12CA0060.namprd12.prod.outlook.com (2603:10b6:802:20::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 15:57:26 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62fc67b6-0d93-4053-3690-08d84e8fb97c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2606:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26063591D6A1B7674F16EDED952E0@SN6PR12MB2606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QVDuvykvbrrsnelwWbiVNkYUO3/IevJtef2QPQJ5Q91nRPRlxFJcRkHHY/1j+mbjafknhXja+cs1iAMqHQQVlGtNxStQRwCE22HqmV5zr13JJ1Vlz4Ro4CFdtiD5xyF8/IKIdm+eqaLStwCIa39G4RldiUf1cf9xMgtfVL2QYp5qBERalBLXtcu3khg+RxmuFdJbpOl2z3W1UKreSoQVbeCRU1wJzySEGjTR3/N2IHKakQGMj0Q20c0GVug26BgPQSKMnv6grs9WFKFXW0gLzipmrqk4/NA7YCiY423yKggCx8ceNprHz3yuq5WLh/1N6FMOPZea3JPL0GQFPHGUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(16576012)(5660300002)(186003)(52116002)(8676002)(26005)(6486002)(316002)(478600001)(4326008)(956004)(103116003)(66476007)(66556008)(2906002)(86362001)(83380400001)(66946007)(44832011)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MZNgcwWteiaPxx8wKu7iZVl1C+PUn1YMXELoF5kzYi0IH0x4eDeZmfxLM89oBkr8g4npg/7/Gn3eHaDr+OjnGV3Rd+VyXWHdkDTTtiaLnZnQj4BwA5vpAMqrt3N3Z4yUyUyxexpNcCAaMe2/Ghb7v/OfcXf/8e3Z2sD8K3tsVj2opmJyTiH9KxeYa76e3iHgOehzHmbu4wUom9K58ZNFF8VPqxjIu9QDMgUfg1tCa67KSn0/nbzFp5AjCmAi0TJSEuCPA9f+l2wLvWcPZ5s9TnZ7VUsDIT+JeiBKYXDRZC6WkbwsI59bwuy8mwrrOSNuCFcwGeFEpp45IpMnf9orN7kq9rtEnMYqtZI3LUvl0ytdS5uEoj6nm5nuVnqkCl53F6zgqHJEfRuvfrIQEsFyu5azF1qBx7loSqwsIwe4eZklHNqoZDEGhPJvJkLrQf9KG/mYm1zfWrjAbYRt9g5S8zDReSIDogdFvsF0Vu7kRNs4om3/RG+lnPQz2mHJuucnujePOwbF7fGFC0pOizRccBXLpY2GDGmEHhTFdDRmMtIaFFmKUFu55nqbZgtaMtujUOWwGY8y3b+9YVsITE9js4Uovem8iO3h+eVNe9mCDB0ExRCA9nCjM2rCZerqxPbWXacqBQBhmVC5AxbgK7gaxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fc67b6-0d93-4053-3690-08d84e8fb97c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 15:57:27.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6FSLS4w5Vb7SlskFk3FBV+a5lPX5g5q3AjXYILSbK7gqYFWnG5yWsDBy3tkD5jZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2606
Received-SPF: none client-ip=40.107.220.48; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 11:57:28
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
 target/i386/cpu.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba4667b33c..b12addf323 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -395,11 +395,12 @@ static int cores_in_core_complex(int nr_cores)
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
-    uint32_t l3_cores;
+    uint32_t l3_threads;
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
@@ -408,10 +409,10 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_cores = cores_in_core_complex(cs->nr_cores);
-        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
+        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
+        *eax |= (l3_threads - 1) << 14;
     } else {
-        *eax |= ((cs->nr_threads - 1) << 14);
+        *eax |= ((topo_info->threads_per_core - 1) << 14);
     }
 
     assert(cache->line_size > 0);
@@ -5994,20 +5995,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


