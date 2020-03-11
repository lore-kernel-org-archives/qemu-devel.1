Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E26C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7C12074D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZmuHYT9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7C12074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAJ8-00011D-Np
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAF2-0000kj-N3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAF1-0006oz-Km
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:20 -0400
Received: from mail-eopbgr750050.outbound.protection.outlook.com
 ([40.107.75.50]:55483 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAF1-0006li-G4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmJjjy7QOB1CkJV1O1v+2bsYkC0u/0+XEin42xQ11u3inzsSYRL2+Hk0Vq7UJOSfKpPxYYvqDsbCL9KTGlpi4dipAEVV/kIQpnNwOkRSmBhek6xIZOXr2fvgvbFkz8burKlNksnOvPP7318eaao6MOPEe9llRusJw1RhsD305KZyuvnNXtN/deJ7Dl0lCcCgSkKk/FZ0btX3UR9NwBLczkE19HBnj105OEmtCd4D/wIIvQusyzNGkaCajy3G+ktn/G6TI/F++ggi8IQS04Kp7rQpljka+8xkznbewmlxVu+ze1dXYxtIbompv9OjfJUiHdCbqcTFxCIV2dza5arCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3hAtBsyOZHax2TzSnDo3xiRQApWy+7dk382bHWpL5I=;
 b=Bj+QJThDewOR7WUExqlyilQgI/8gKEzF2E0uDDWKWA+urmUBbg/iXoyRt5wg1Q9T6RJoM6OFGDHc8W+hqBP9c5IKuc32m9XsAwH4sw1JM3tHqVlrqwXRjsbyUR9ig7InjZGgkyVWTXeWdPa1MjlH3eH4lfUWGnxOQVJZN2mSuKYZhznXIYpSFPRzY9arHyuh+F2vJX+rcKal2bQ90fMWI8zjoxtFSZ8B8/fDj/RhLmruZeuEl1sq2yxj//tUmrciFZ/DRlrczz0jXmYOGV195W27K2dMrhxcD1cFnxJEzb7g/okyTp/oQLmSCGZ3VrX3uKPDIlGnPvZZeu7LC0CPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3hAtBsyOZHax2TzSnDo3xiRQApWy+7dk382bHWpL5I=;
 b=ZmuHYT9/keWZoCJjCiGIEeErfkiheTkgLMz9e3mRtS4oa25ikXi7z+nP4Vy9m2Mk4AEvt2piNlZ7jWIBTE0nCQHo39jxJ7XSWaFBc7uGnU1drm55zHvzlaKTeOAoEBE0TaulH0RLJTmfAewl6MMaChvb2TdNnPD7hq/qL9BEmmo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:54:17 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:54:17 +0000
Subject: [PATCH v7 13/13] i386: Fix pkg_id offset for EPYC cpu models
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:54:15 -0500
Message-ID: <158396725589.58170.16424607815207074485.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:0:54::28) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM3PR11CA0018.namprd11.prod.outlook.com (2603:10b6:0:54::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 22:54:16 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cbd62d5-a70e-40b8-0a35-08d7c60f20db
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2349C1C7B50DE7D3D3A1E86D95FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(44832011)(478600001)(55016002)(5660300002)(956004)(81166006)(8676002)(7696005)(81156014)(86362001)(103116003)(4326008)(52116002)(16526019)(186003)(66556008)(66946007)(316002)(8936002)(2906002)(66476007)(26005)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2349;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWnW/kjKYP/ZUSYNs9vcu6ja6JWejhNUgKhj3bAYsZFrqzhFTIMan0ms4sq1C49ztCaqzqkAdeeZ+clRBPdOSN7dg/rphbAj7QmY1cgRNzlYOyEdkWKK327JRXdE51PXmelDlOC5NvDt0RZpZg5gHa3rrwvW10CCl3cbqna30Y3HqkPfyHONmmf2Nvg0YjodfnAIOxx4YS0cLjCYtXT5VzFtLKvm0q83hwzmpd1oc5bOrH3Rxfld4RJOGKQndMwa1dJQlCYWf8sKQOsrufMB7Xg9taxvgb9tF0IjVMRQhx1J1kF8FfZqeUfBf0jYtjoPV5qMIBilGBQ87zg8aiS9QxPiaUfyw6eOGoh4/aoZI3n/Ig3AR6Yvdl7IzwBOSf5ptofnb1JBD5UpSZNJAW1ij3PFPG8kTqi/NK1TvHZLe4KODlT5GsjP8HwRIvIUv7N9GQodSkoX9YHWLOR+ac9r9RwVHORtHBjuWSvNh/9Rks+p6nQ+KH2f7jredoKa5HK6
X-MS-Exchange-AntiSpam-MessageData: JudJJpX99DRqr9Vf+GP5zxlcOc6gxW2NV59gy6X8CiNNCwYlYfJTnexSef64vHzj472tjUcSO905nvvgmdVuClG8BDsyWB+8crZEOYqTCYg0O02rAMFb9Cg4Y8s+h3EiwdCdk32jD8+dlA9ilNA5Ug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbd62d5-a70e-40b8-0a35-08d7c60f20db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:54:17.5918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JghU9bRb9eJxl27P7veTabw4/wk6h6ogi2CVnVegntJlGnHqYLFk45+yglQYzV1O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.50
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the system is numa configured the pkg_offset needs
to be adjusted for EPYC cpu models. Fix it calling the
model specific handler.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c      |    1 +
 target/i386/cpu.c |    4 ++--
 target/i386/cpu.h |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2d7d611184..ab6da19bab 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1526,6 +1526,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     env->nr_dies = x86ms->smp_dies;
     env->nr_nodes = topo_info.nodes_per_pkg;
+    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9ffaf5e2a0..c58ac38d29 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5610,7 +5610,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = env->pkg_offset;
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5644,7 +5644,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = env->pkg_offset;
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6e522fcd34..92872d2b7a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1610,6 +1610,7 @@ typedef struct CPUX86State {
 
     unsigned nr_dies;
     unsigned nr_nodes;
+    unsigned pkg_offset;
 } CPUX86State;
 
 struct kvm_msrs;


