Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA377C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53C320656
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cOJiM2Sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53C320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJ45-0000Dg-PZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIu5-0005Y0-U9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIh2-0004f2-MC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:39:02 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com
 ([40.107.94.77]:6183 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIh0-0004QT-PH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtV1pINLaETbrOD/A1dzjXWrCR2gy1FqWXFfkjOlKoYf5POjP7v3iMks95sjdI4/7nn6Drcw+G9OHGBLqXVpml+uPTSLE2QWS/qoykVIWszvu1DOIvvZ43H4St6Jm3hgz5EV/JIT5svbqcXhhII1h1yE5Q0R+ulBE69aYi640yOMohWkMtBA5QQvgOtXjjmF5fVoy03B9CY/4+6CiwDyIHMJpKUdiaLlcxJ9zj9wlwM/A1Ee6AxmFpZSFKak4YAx82Dnl2U/E627FC6nzOBKIcXHbQqkP06BsAkTMSOLQgLWCb+3u34RSF/XW9rNmqoJGXpVEIBhjrVdKqUke0ysAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG+VwNz1n/1MmF5MdFaMBtLZTRXlZCy8kc2AVymnt4U=;
 b=b4o4pvBEMb+njWUb4GK1OSxtsFrqpTbfbdbeZvwNktonoyOUs2P0av61BRxb25JjdguVe9pTcw4mQamrMHvc5Hzzzv1dZvEEZAozB5hyOuHxsEz/0HeQUmg7hM+l9Y+j+h2abTwARnQV3surFTdLE9I4GysxYjMthIHOKGIgtJf3uNw8Dx7xWMzcWOH7XJ1kBvuFtyZR4bi/kvyEoqfePIo0SOekE/SKcMKBWxvUxFtP+/9PIQL5wevKrnic1v/UNtUi33Gxthm+OTdM0GnedYDV4icJMaKS3QOijwXM+OOkrJ99874+vNoBLMP99PgLZU5ES6Z9hcHSERWd9kerSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG+VwNz1n/1MmF5MdFaMBtLZTRXlZCy8kc2AVymnt4U=;
 b=cOJiM2SwFeNiCIxKdUWxbvCkzUwLpVnJzppheeInhwv89qAggwvXetqOJfyevpQmhpdGxQETSR4Pp9t+wK1jSTsEonLqEx7K8VChwWNxYMrSqtxVChE/4OTEdahz9jm9DbflaK/G8j2u9/tFzvmGQbctX1kypgcPncXsy0kYHrA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:38:55 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:38:55 +0000
Subject: [PATCH v3 17/18] i386: Fix pkg_id offset for epyc mode
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:38:53 -0600
Message-ID: <157541993357.46157.16412514558085238325.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec901109-70c5-4bfb-c3cf-08d7785257a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13695545AAA8F0651CE77FC1955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(478600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(14444005)(99286004)(14454004)(446003)(6512007)(23676004)(316002)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4+PW5IORMknN/HIh/40XN2FW83GfMHbAQ5tYdOzfIGV8AZt5YxomhaM6xL1O0W0IBhYFdpJvA8mw57F9zDyVFtPoQ2dOqQYrU6Mbyd7bpXDzc/uLtqBgaIgdMZ8BmscnEbW7wwIYQrq4hRHv10j4jNkSKXZVSkrmFBnKp/x3iO/3vw6qSt48/EY5l1uZ8GOwNIOZCuk7ASCtq/lg3qeVvOcBmsTAEyM1JwsKDpXOG77PUUSlMCAXl1uCOKEaeEu4pumfvF9xQFflaHdMkwMfvta3Z9dLq5nrRiZQmFfzV6E0+SyoNdU6OD3kyPLXtFfH6xsM8XOJ8GDOPJXI28jdDACoRwzewdIGNyM/nIuL4p8ellM0FYuF2F/x22FHVO5NH2DVn3TZp5Ekp50gtUYIu389eh8FMTU2Db+CDOZbZ8o3uvlcINhcxV79R1CkiXp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec901109-70c5-4bfb-c3cf-08d7785257a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:38:55.1099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZDUeEwJUxDKv5dRBRVy/PzUdV2FK69D2bbb7MH3zE1+1fAEwEy4XGtY5W+UB41m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.77
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e87487bae3..0eaedeb848 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4456,7 +4456,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 {
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    uint32_t die_offset;
+    uint32_t die_offset, pkg_offset;
     uint32_t limit;
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
@@ -4466,6 +4466,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     topo_info.cores_per_die = cs->nr_cores;
     topo_info.threads_per_core = cs->nr_threads;
 
+    if (env->family_type == CPUX86FAMILY_EPYC)
+            pkg_offset = apicid_pkg_offset_epyc(&topo_info);
+    else
+            pkg_offset = apicid_pkg_offset(&topo_info);
+
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
         limit = env->cpuid_xlevel2;
@@ -4647,7 +4652,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = pkg_offset;
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -4681,7 +4686,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = pkg_offset;
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;


