Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B70C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AED20714
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xbAiA/Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AED20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DpA-0000DP-8K
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dge-0002jz-1L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dgc-0003QG-Tu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:39 -0500
Received: from mail-eopbgr750058.outbound.protection.outlook.com
 ([40.107.75.58]:7696 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Dgc-0003PT-Ox
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RalJ8o07Bn7sSvZYq6lHvCOkLPOvFtPDgeQCUeMfcuao1HRjH6ihSUh7RnCUE6O0vZOee1jHQpANVzKFDr6c1IOzk3nf5zpG17PUahMogbbDEFt3bWSxKjrOq5IBXSz2iJa1zpk7JdsTR+88q08mLxpCjONMiOMlvCFVsowt7jNpWFDjEM46JetOPZJIQ0PdXdCFlDxp+MQ698yw+Aqp83D4+6ceM0bnvKcAibS9GEk6/UytYlxA/UNqxy4XpCMUl+d1P3N/MRxQHeeZDe0EqG0REBUG3xc+/sFcXWpuNOozpvJLyTHCRShbURNEY73TJPsdwP3zJT5mvCimKcxjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVIC4sKeLph2g2hFlW3C21w+T30yPZ7S6kn+xYiiAnE=;
 b=UU48yQAhGk/gRwXXwAhWUm3NYJDYf4W/06BwY5Pu/m53lDa7CyMh78r/eGYoHo2BuLdEYkIoV4lZZnYSGl9HWOx/zTl6Oy2d1bwDOR/HDyLq8LBfodc4gfSEcnoOGljkEa3hJTfT5wmE7sNWmEGeR9y0x+40hrGUAObUc6gZUNKqCZr0grMKzu1gPjNHLUCvi6NF6Miwbe2FiBLWbdsBQE52Ymvb5r7tpLo+GdMZMJF2aAyG4orBMMKP9iyKGYr9lptITNWVppWcIKu+xzMgF7ofh3tN0j3LUUPRqBqOub6Ps7dLZVcpCYHlWJuKQob31tl0j02f8qkTIkaPVelZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVIC4sKeLph2g2hFlW3C21w+T30yPZ7S6kn+xYiiAnE=;
 b=xbAiA/Z0YcgZpa6ZdIBaIzotZ9RycNtzTmsZk6lhdGlZ6/iPNM0If6JZdNZ0I0FUXpnSJZ2tCtTUAW+HPg/J0gT4f4os0+HFDzwna5zj/IjhoT00r4G433uV47Caog2rPgk7N2JtUsX+nyggWTUjaknznIC6VmSF7GjiVO1zMX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:58:32 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:58:32 +0000
Subject: [PATCH v5 15/16] i386: Fix pkg_id offset for EPYC cpu models
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:58:30 -0600
Message-ID: <158326551090.40452.9028312447486758348.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:5:80::36) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Tue, 3 Mar 2020 19:58:31 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46607dfa-31f1-4869-78f5-08d7bfad4055
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573D39BDEB33842B12224F795E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZo3Vo/ktCfw1czcjXmPyvH/xzVB/u47bGIOw0wL7tPUdN5jR1EdNgMqLuRVbY4IIXuub/TTEqZBgx7s0cqMlsnovQqM4Cm2es538OIGo5wUw6eievaZ6L511RTKCRG9SempfVuqV5aVoU0nuJcTfkdXeJ4rBTr6P2yFlg7tTR++89CzTdktxkxA+f2jaBgWhLAMcn3ld4ZD7Rvlv0cVPxw8m98BRXV1R+W42MBH0vXvK1tqxrnBmQJUjG77kU6eXprvhUcxAXInhq1MfvGDL/J/u1YsAU2Ou82ATrxOHiyhUybULdpGlYfzomN8l8vqx052sGM8aFK6EM8uOyBwZi2msFI9tfrENYzctvFruk5/psQ9kKIeYjNE9HzvuClaumg8oKg4enljYKvPjXw15IjJn/slEoQ5ZFesrhAZWSmkCOjwH4SReXjcOq5tf28bfe+XbuLvkbpuws/VuUv4rGbbExMBi2LxqmVFNb+LI6IsC01Ro38xDmL0q74oXFPH
X-MS-Exchange-AntiSpam-MessageData: ScA3+5/uG5YxfM0xsax/i3fEX5YRZd/HzBjnLMYH3LkgbGfu1yb49NRgPAW4ozYH/HJoLo3BQJ+aRq3TYke3NpZqU2UJEZnBYfLuH7eyMDB4FALVg69vbDw/4p9IsXzJYEDN2DZkzdmQVrPfGMnLFg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46607dfa-31f1-4869-78f5-08d7bfad4055
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:58:32.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tivWkLo+E0LXC05s6m0ct5Rie6QtQ0RXn/uyZzak5KpG58pNiTLZ8MkRvEPfYHzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.58
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
---
 hw/i386/pc.c      |    1 +
 target/i386/cpu.c |    4 ++--
 target/i386/cpu.h |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c600ba0432..b6237a3a14 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1527,6 +1527,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     env->nr_dies = x86ms->smp_dies;
     env->nr_nodes = topo_info.nodes_per_pkg;
+    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f870f7c55b..9b160cbdd1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5503,7 +5503,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = env->pkg_offset;
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5537,7 +5537,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = env->pkg_offset;
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 34f0d994ef..aac86af5cf 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1608,6 +1608,7 @@ typedef struct CPUX86State {
 
     unsigned nr_dies;
     unsigned nr_nodes;
+    unsigned pkg_offset;
 } CPUX86State;
 
 struct kvm_msrs;


