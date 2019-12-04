Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1431AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF26206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C3GYPh+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF26206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJX6-0003AH-V3
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuC-0005Y0-Q0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIg9-0002vN-2b
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:06 -0500
Received: from mail-eopbgr820043.outbound.protection.outlook.com
 ([40.107.82.43]:44496 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIg7-0002ru-1l
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw1MpLmXKLrUGQ1mmD30hkfz420rUC0FF+1W0gwCLBNXUByG48RAp4RI1r6TMYIZAb2stsICMYFV33OJ/yVI82EbL05Jq8eBvKyqnIkEwxyz25MUtMDN/1ZMLpuQFrWb/66HxQzmGlAezpPAADB2fUkGg4VTieUH+zWUFugqQ+pXUpgHUFhj7zmZluSJ1c7e9JNfa0SZmftU+iPc2khFpp2/KRLtztTKKkbzu6o1XygS45QwOFgNljGgZj0VfC8r6xv6FwMLnpExFd0JLGlTv+DnNokssCtbrMlvxguF+6nFuG18QyjIRJATFGn8PaGq1QUe5W+A4FfP0ptnZOcEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FB7HIlqbpb3quBGIMhCxM/FjIKP1pnriONVKZ7hE7U=;
 b=NF10DF1shljTJbHo/y69Qocy77NNq7bBUJ/Z/th7qGSxSAtfVaywsnaWm8+MAlflI6FllnX7F6jK+Ls8DT644p2fh6tgNuHdmf/SziDbif7x6H7I2KzaLYmkaDXnDfP33dNfzRLhaUYCHy/+lkGy0Fefsw4TUX5buAPrjegvLWnnOMC2HwNoMoopdOXai0ETz80170xq4eYzp2bz5ByL4inwYP1hU60RsHNphEasNgVccTM9a2wAyA2y12fJkDxeFbFtfAp1G559J3Fh9FoPl3wrCWY1yaAIjop6GOFCV89zlOsPvreUUeq5GlSBm+9cqb4Xabb5hsyjK92hVtu/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FB7HIlqbpb3quBGIMhCxM/FjIKP1pnriONVKZ7hE7U=;
 b=C3GYPh+c58Yt3eQFFf68c6bC7NWIMeHFSXkx1LSPXP6h+GM+jdDpB6L54HSC9ZeQCH0oAuSt3Idvl3NPsXyBmb+PPdm4DPMFSG0XNnQvCDu/VvO/sqSUejEjzpBR+9TEMRzdq2vF+V9mFniebng8ntj6Ka2H1q6Ia8sj7ywRxs8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2535.namprd12.prod.outlook.com (52.132.141.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 00:37:59 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:59 +0000
Subject: [PATCH v3 09/18] i386: Add CPUX86Family type in CPUX86State
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:58 -0600
Message-ID: <157541987799.46157.8690212718301117297.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:805:ca::14) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59925e0a-6599-4943-b8ba-08d778523675
X-MS-TrafficTypeDiagnostic: DM5PR12MB2535:|DM5PR12MB2535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2535D5F0940A66CE9D0316BD955D0@DM5PR12MB2535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(5660300002)(76176011)(4326008)(14444005)(6506007)(386003)(3846002)(44832011)(11346002)(446003)(52116002)(186003)(230700001)(66946007)(2486003)(86362001)(6512007)(103116003)(2906002)(6116002)(50466002)(8936002)(81156014)(99286004)(66476007)(66556008)(26005)(23676004)(305945005)(7736002)(6436002)(8676002)(478600001)(58126008)(316002)(6486002)(25786009)(81166006)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2535;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDgKMDZCqbo42dkszZniV9bvDKD2ZHvMRvd/oROybOFcbCwPZ3rMNTLGs35Khs1HBoRb1RpQAY2fd3tJIPnOElOe2rzS64Eld9xtT4kn6h2kMJQtiP67oBg4ek5QmtIAHqMBQaBc6K4DQnMKQyaoLeDwJXgyqybiTVkcdH2eTu28h0IOQfaq0qDyZZRkw5kSzVQCgYa9VKWe3hj1/l/CI/1VgR2B0Cp7KGk/emubAk5QJEApllVdokVwOmqYdEKUYL/20TkB7HhwTx+PH6ayQtb70x1+mUf0gkx4J3DgNMtK4zgJOpxelCK8AGefEJ3UCV8nEldb15l40svLk3TILaKVTQQmwP5eTm7xQOKn58VYPkIhoqit390cpX8zC2jJq8u0PBbTwZ6J+ovXU+wkpsamzd/j7FfbJERvOivfI4PV60Cmlc6bb+09HK7TnqUN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59925e0a-6599-4943-b8ba-08d778523675
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:59.4499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bww8J2J100zZnk32mJwtU2EOVrCKzmQlwzxywadhZea6N83jhbgTeKfgqmAGXo8A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2535
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.43
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

Add CPUX86Family type in CPUX86State. This will be used to differentiate
generic x86 and x86 EPYC based cpu models.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c      |    4 ++++
 target/i386/cpu.c |    1 +
 target/i386/cpu.h |    7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5dc11df922..7f30104a6b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1398,6 +1398,8 @@ static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
     env = &X86_CPU(cpu)->env;
     env->nr_dies = pcms->smp_dies;
     env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
+    env->family_type = strncmp(ms->cpu_type, "EPYC", 4) ? CPUX86FAMILY_DEFAULT :
+                                                          CPUX86FAMILY_EPYC;
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
@@ -2246,6 +2248,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     env->nr_dies = pcms->smp_dies;
     env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
+    env->family_type = strncmp(ms->cpu_type, "EPYC", 4) ? CPUX86FAMILY_DEFAULT :
+                                                          CPUX86FAMILY_EPYC;
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9b2608a4c8..5629c6d4c1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5997,6 +5997,7 @@ static void x86_cpu_initfn(Object *obj)
 
     env->nr_dies = 1;
     env->nr_nodes = 1;
+    env->family_type = CPUX86FAMILY_DEFAULT;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0ef4fdb55f..105744430b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1284,6 +1284,11 @@ typedef enum TPRAccess {
     TPR_ACCESS_WRITE,
 } TPRAccess;
 
+typedef enum CPUX86Family {
+    CPUX86FAMILY_DEFAULT = 0,
+    CPUX86FAMILY_EPYC,
+} CPUX86Family;
+
 /* Cache information data structures: */
 
 enum CacheType {
@@ -1590,6 +1595,8 @@ typedef struct CPUX86State {
 
     TPRAccess tpr_access_type;
 
+    CPUX86Family family_type;
+
     unsigned nr_dies;
     unsigned nr_nodes;
 } CPUX86State;


