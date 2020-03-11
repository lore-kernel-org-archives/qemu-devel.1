Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4F3C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314F920637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q97jvbb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314F920637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrG2-00089J-DB
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCx-00013g-GD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCw-0008W7-6Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:55 -0400
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com
 ([40.107.223.46]:6160 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrCw-0008UC-0V
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjUjk+RTs9c19vLsAiIUQRN4+tpSLQZzEik18VH1JBE08nz2qVGW26ypjP9b7GbDhm29GbJgWfNmtoGuPQT3RcPEICRjQ7AcIUFOwKcnOCwr3SVSjwAt0DCeyXz7tbTtfsnC543g7SxH2V5v99bK4ukA/NBtOw7kcmGdvs4JUIK7cwGUBK5FdmG224N3/ivTdPvAywT1T5x0eOKovdQcUd3hg9ZY2FnZoBHqbFqFawWjLpc0SOatxWiclQarlCw/o6pCuF5jtZW+JKuIZZ3ZKFpUgrnREotEtUpfEn5m6wfwSa6P1FUt5DRUY3i95dnJhJFI8GaR9qyO+yl0Dwr1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y3EZPQT1+kPHd47k2sB9bSXOhJOGW8qf3ckr7LOuCM=;
 b=gm0MhxZ9VjYqkyLEzSKe7jEl4ZL3g/5z0VRUekoFptA+RcOLAtcJ4UzHu12FVVS58v62lfqqzJmW9AQfjrc9EpHzilHYR6JA8O6NY/pDsEUEBBQCBzmRNjILQ3xBBkYF1FOkUSBT8qSui9/rSU9y5vyUnMtN4C/btvNVtaeKupbXUHT7nf74D8IvqAsqiXXfvy+x2ED/YWyEJ91613bSTvyBxm5vcY6I5l4ub5VvtAMPjiB1hco8LngMYyRaE2IeWGJHAZZackCylufjin8GHUMja6Xy6kBgWQ7CqyRcLK8SCJvfcLjw0IYRGYqD5/7nFuNHAdTncw4F2EkB7aCcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y3EZPQT1+kPHd47k2sB9bSXOhJOGW8qf3ckr7LOuCM=;
 b=q97jvbb5V39VZ85F6v6JUffTYb88VEkc6ZyCBv0gUBjGh4h63gf+KkDYlmbIQC6eRhocUqs/677MUVWKn4pB4pVl9yo2HI+4wii05t6yOP5UBSMhkAOF2Xqg1cAELyEo3RcpxoPzBajTPMxRMJRAAH9xNMXFGXhSoJ5fCwZJJdI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 02:34:48 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:34:48 +0000
Subject: [PATCH v6 13/13] i386: Fix pkg_id offset for EPYC cpu models
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:34:46 -0500
Message-ID: <158389408668.22020.13850625601123630051.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:3:37::33) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR06CA0071.namprd06.prod.outlook.com (2603:10b6:3:37::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 02:34:47 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d64cd573-3cdd-4d69-4900-08d7c564c49b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575824D72D603266CB1BAED95FC0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(103116003)(81166006)(81156014)(8936002)(8676002)(7696005)(186003)(16526019)(66556008)(66476007)(2906002)(55016002)(5660300002)(52116002)(44832011)(956004)(66946007)(478600001)(316002)(4326008)(86362001)(26005)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCK01dbJUvIJ0iVHaxRgzsfOx8Cvw1pU4902r0g17P47TBPnVvbGKL+VjmN2gHxorpaj8fe/HwQTix0u88bSydISBF5Bvhb3et+v6MbT9OrG/Azw00Hr8EYCa4LhDhzyV+RNmXSdlFtqNzcgdhK29o/HP39PnZ+JNNxvOtoM0pZgnxnsVbr5g4O5ZL2N9aAmUCbmbBnOTMsNv9aXPZck7SG69T5dNInugNjbRwm4Xo95o/JzryLuUpeyqJps02/gWM2gJ2CtSKphtJAWFnI5yXnwMRWfl8KjM3ky3LL5BLtV3PEMSRqUh0AahFQx+wBa597VaC914vyw7gatq/p23X1y05U45lVoRuo3xB+kUDERkjF+pbx4zZBCZhaXk6D1gxy66g3dVrFagF7QsRayn+6NoQI6l0PtNPe7gemno0f7FvYMC33is9LNqeJe0hBSHTtco9MxV+3ndzn+qT8+tsk54bOGsb7UY8t/6CCsqFvyRszWUbSz0ZG5th7Vz4h1
X-MS-Exchange-AntiSpam-MessageData: jA5ga0pbh8Q0j4CQTKI3z/Wo8BHdrzHSXMgrKt7kp++ewt8mwhjEfoP7R7Yq8x81O+6OOYsVtIzBlot8V69Ou671ivEUwjzzHmDRFr8fVyUZYii/iOJbS7oqCCfrYeC+pGDUYHTuvFe1hIgDaqUygg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64cd573-3cdd-4d69-4900-08d7c564c49b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:34:48.3506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWoTQecdLn9OF+4cvm43uB8X3BuEKRo+Y6yUj8tcPxPFQVp5EyybRrSrzTdBV4hz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.46
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
index 5d5734af76..f205c56f9a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5606,7 +5606,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = env->pkg_offset;
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5640,7 +5640,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


