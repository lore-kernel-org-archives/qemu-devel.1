Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8DCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA03520724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F2ie0pjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA03520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FJi-0007s6-1Q
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHW-0004EC-U4
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:06 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com
 ([40.107.220.76]:40513 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHV-00027r-Di
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBi2ja7TXHapD+cyS9W7J0e1a4NBPeJzXtRGaVgFxTCqv0VwYG5HzH6aWvKB82oraKjD6wCAIF5cT1q6XAuR9cBsjW6azScjMrD5u1gq2ncl+QNvHtY3SE+zos57E90N+9qucP+8haMsWAc6CX9wmOGkvunL2dvpZFrJ3nd0VxZ3lE8ozEHutuwduL7x5ZzzUrutqp70r7MsPt1S2eStGTa1RhsMkZK0TZa0cDJwM7KG7hgdRp6M9OYxuCOsNrWizaJ3pgb2SVCa1PFNwgo/ZNCYaGnfpZDW2LcqW9RNSwfyj8qdaqKMBfqkR1dpwQQCnQ4hh5dcIotb3QYzgvYmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRB2EacYzITbRHvEUQQ3PMzS9D+xC703UcygNoIIGZ8=;
 b=RlXCutVEnm+R6OEOYbcx1v93btHzSG2e16sqEfnVt5gPH2S7q2UAye8kVwgR84YkY2gxJTNXedS753aOc7YN7oXMFrM58reXSh6TJ+0fYjuMKf4R0UgyThRut/Ce26WoqqPiMFdbtakgP0DHEH67/xyRuiTkVOyd1mUbsLRmcjeBsQL2kYW5R+aub7uauh10+e+Sy92Hc4eQ9s46GU6MJKLg8rBVmTGsAMymWPqZSvQsT+aG8WPOBs6up2CkpvwMvQ7Tmz+5laeT+guc/qtdAwwZ09pvoUKIpTL5AdHs0qdVShx7eTPY6X+qpKERi3XNy4LaXWBpNUojMNWpfOxP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRB2EacYzITbRHvEUQQ3PMzS9D+xC703UcygNoIIGZ8=;
 b=F2ie0pjkIsljEK5scCoxEGr1IVSYEVJoKM8HAyHb3bLxWOhk814lLWAqCokv7XTeUiF+2xWs+Y1MPeHexSHXlEADWfnBh6Dsovb275WsVEEubdv8ao7sQ8pBqORvmxBavhXE2RH6n66nbBk69VcsTYLheC77gXy9gvy41j0m92M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:12:32 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:12:32 +0000
Subject: [PATCH v5 2/8] Revert "i386: Fix pkg_id offset for EPYC cpu models"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:12:31 -0500
Message-ID: <159804795162.39954.4500271462124021596.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN6PR05CA0019.namprd05.prod.outlook.com (2603:10b6:805:de::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Fri, 21 Aug 2020 22:12:32 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27e01fd6-56a6-4e4f-28ae-08d8461f4d19
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2383DE2F17AECB1302590C16955B0@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgTBw9dH8SsvDpKu87sh8Z7cdDQr1Fz/hrhDQhQPTrfP5pceWL7MUZSbwx/mpP5dy66D6yNwmzRQKuFeU0MH/3tuWCV+WeglHAjEEbS8ZojFwY7PFppRR88dPWDSqNurWxGLZPofFWJrrLMrnZQnXQjP8kliljuMBMcwINMVHbJNzCTacZylqOIqJwx/uyfxHeP3f/XBRcDxCA+y5KHQQCJaScvgK3LGVIyH0Guj2GMAPAFYBW/7jGtWCdaVKVR3ycPQMSZmj6Q2+hu9jMAKKT5lRrx7bxaQ7gFkraxnCqyh7J+CWaaurJUlX9q3aU6zZqLcXjm0if2JGdcKm3a7yzq79VXkw6R/z4P8ZLuUbP5shpaLM4Xs2WUXxco49Mnp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(6486002)(2906002)(8676002)(103116003)(956004)(8936002)(44832011)(110011004)(26005)(478600001)(86362001)(16576012)(316002)(52116002)(66946007)(186003)(66556008)(66476007)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VJzDXHmYbrFhmDNGi2/DD0YSWXp+/WPs+o5lvSOT6MennK8a8emQDpmDQCmz7B5QtjCyFa//aQdA8NNPneFsckoFPjc5K0tyn0WWtLhDe9aYbqGhFXRtjSoQ4rZd4uGTrrQfM/Cp+e6VG79ulBxmtM3fPWxiTIlT99byRCLWPJKhPpbowTXE1RV7mjUObn1vm4wflfRL3pTvtzt8w+Vp4ertRcMRf9PVJKDcIQ0Bdb68tufZTXgmMUBy5gJvpdv4QS6H6FVrx0DuDgn3xWVBnspZ4WMtc5Jvsj34cwOH9uz8sxclAErdzkiCbxVbAC9axHR//5LsK1tdOEQEisK7ZoJtosKqwFdbMeeeoYaB2U8MFLunIWmucKvv0GTjGlcsfoVW93VKjv0aLE8iKs/MFesR5/mSYwkStFv6iMsAUkgbXQPbHjdQ+dDLWPn2tO0WT5MOxDGzZwf0maKFBEJUU2HVEolCL6k8QCMxLxtEFsH8UXCfNwI4qcOuJTzBZvbt0aqmzR6R1DG+iY8ETihUscXpLU+T5QK4tjuOBnoZQUZyghk+/r1h0IJiZ7kQ1QODce8W2nqC8+0zNHtWHnmLqeOu+mJyo8ZWtqTiMU2G7QinzLuUQ+2S9dUyYwbMjd672cJqNacFLJ5Xo3asIR+Srg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e01fd6-56a6-4e4f-28ae-08d8461f4d19
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:12:32.6378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC8eoYTxuXn8DuctgvUdwvGiZuhFoDfeXtt/5b4h0F9OvR8C6u8bz+XYOpPb9J6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
Received-SPF: none client-ip=40.107.220.76; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:13:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the EPYC specific apicid decoding and use the generic
default decoding.

This reverts commit 7b225762c8c05fd31d4c2be116aedfbc00383f8b.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c      |    1 -
 target/i386/cpu.c |    6 +++---
 target/i386/cpu.h |    1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0ae5cb3af4..e74b3cb1d8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1498,7 +1498,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = x86ms->smp_dies;
-    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3c58af1f43..83acbce3e9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5675,7 +5675,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = env->pkg_offset;
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5709,7 +5709,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = env->pkg_offset;
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
@@ -5890,7 +5890,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * CPUX86State::pkg_offset.
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
-            *ecx = (env->pkg_offset << 12) |
+            *ecx = (apicid_pkg_offset(&topo_info) << 12) |
                    ((cs->nr_cores * cs->nr_threads) - 1);
         } else {
             *ecx = 0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c89bee8d1..a345172afd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
 
     unsigned nr_dies;
-    unsigned pkg_offset;
 } CPUX86State;
 
 struct kvm_msrs;


