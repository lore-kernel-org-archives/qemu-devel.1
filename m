Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2624C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9016920749
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ucYQXrpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9016920749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAFS-0000qk-Ko
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEG-0007ZI-Dq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEF-0005Ez-B5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:32 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com
 ([40.107.94.53]:15297 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAEF-0005DB-3I
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i97Cb0r1Giya38r+/H7NoSxyieRQTecRqTZ7qFyONm8U80FMEat4yzH0I1SsLjPtHefvcirnnPu2Jc7dbrnF+IJLvmE0hEQEzpzEklGBjpei+XsDAF4dscbyLR6qnrYOFjVhR+2sxkKidkgNhHVR6QpE0VqLgTY67kpc9oKCfUJ1ZrqWResgQaDq+q6H0EaOSM7w8Ary7w8mLzTpCRgAkyq5Yk551gAqkkxFsSexDtP3eoEMUjKxNh4XpYPxHoe37vw6qtGIM1S4W5TebGHyvn52OZGAO2+RXX5uX+M+6pDsmzOm/v/US+ji1XEyvXc3EGP7xiXzMoCBvjQZat4+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63ptB0mKqDmSMUHMoADzA/hAHfnxKvcuZJ9bKTT+BsA=;
 b=G2pmTDz+hl3fFUQWrftX+AuNgyx/fs5DPGXCM91M9dRJDZVEowbvBgDWzdu3lhiV6RMYO+BxtKWcDIXzKOJih9vQ/FbOFlpOaK+BDIRzyPtxPLH64iDvoFjp8DEUfVMQJamF++5LR+YsU1RfSBeaLZKiMn4VamZ8j0eZyDO+RugLZAvHmy1BBe9GMtBttSI0vfHhzZExF0a69giec4ZWphbtfuxSTpwMSaWAqc7gP2hJZKZM1lv8rWLo9IQGr0+y9Jw06T1fFF8CUvEPkIgg/XR+bwGnqt/8Cr5oVxjtNcRTmXBt6KVUuoXwSJubT0a/VTUGf1rM+EoYB5I0puupkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63ptB0mKqDmSMUHMoADzA/hAHfnxKvcuZJ9bKTT+BsA=;
 b=ucYQXrpAcX7ebeccrwa4EFsrxxnUUeB+pGG7+Uq+hCaGUIWHgyI/vZYhqaKeY1KSNMFScwC49JrA50y8LTpY/kpTkzGjWlIYmSccytzFyWILqVNSipL8J5mcHmNfZV8K1B8UK4WD5ZBcnN3So1+2WvGTOr1EpTJ4lC+yVYMbytQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:53:29 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:53:29 +0000
Subject: [PATCH v7 06/13] hw/i386: Rename apicid_from_topo_ids to
 x86_apicid_from_topo_ids
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:53:27 -0500
Message-ID: <158396720748.58170.5335409429390890145.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:5:14c::32) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR11CA0055.namprd11.prod.outlook.com (2603:10b6:5:14c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 22:53:28 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25591e6d-bd03-476e-1511-08d7c60f03ee
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB234909686633BA5314D4BAE195FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(44832011)(478600001)(55016002)(5660300002)(956004)(81166006)(8676002)(7696005)(81156014)(86362001)(103116003)(4326008)(52116002)(16526019)(186003)(66556008)(66946007)(316002)(8936002)(2906002)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2349;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEMZkGBmF3pU1muxKRBbRsLlN5FzqhRZF/qNEOPjWfXlKizCynPn2MWjHGohF/hztc5x4nsn1DRdP6xU1p4T+FEurBCQOHAjqGbuwTp9PiTXFIz/1HmUZ6c+J1QmC6K1VAhBxGQtwQhwmHwmfaFshjuE3aNXIqEh0sXoXeDIg1voxL+0ObjLgxbIwllLGHg2O9mJe9+ssKDkc5q8to8Ss3Is5lRR0HG8e2vRXqLdF341rczVTk+qjSDoXrrUKAoBgH7P3aoA2jrMR3iTZDvHD9lqSIr+SWnVJU8Hz4Y4GVJO8fDkQrQNrZ9in3rg060vqXgwFBpwePOiuroQr2rCSQhZWC5QTZ50SIxxsl3flhi1YkApJJ+/CGscze5s92oizkN9Uqsy0RPDb4o9Ph6/oVeTKuybgXCnjFKkb8mrVx8mQuT2EEtP+GaA/2iA/hMs
X-MS-Exchange-AntiSpam-MessageData: GBp2OOP7N2x5gvhR8mmfO5jXeStin2pk6frR7/38Mm3aGMhNC7W9M6MEwhfAxXtQgVgy1iHVNyydZg5c2zkIlVXFR3/lzCsODeOeA2Yvh8TrCgLZb5iFs677owTLH7DBZRBNamsnw3AFQS2M/xsQSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25591e6d-bd03-476e-1511-08d7c60f03ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:53:29.0337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMJrCpMtISLZfTrSXpUWbT6IdJiMJ0KfSbpeuNSCt89sYwGTtpKuC52tsxWK7LfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.53
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

For consistency rename apicid_from_topo_ids to x86_apicid_from_topo_ids.
No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c               |    2 +-
 include/hw/i386/topology.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ee89fcd1c3..98ee763f68 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1580,7 +1580,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 04f01e2a09..b9593b9905 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -112,8 +112,8 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
-                                             const X86CPUTopoIDs *topo_ids)
+static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
+                                                 const X86CPUTopoIDs *topo_ids)
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
            (topo_ids->die_id  << apicid_die_offset(topo_info)) |
@@ -165,7 +165,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
-    return apicid_from_topo_ids(topo_info, &topo_ids);
+    return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */


