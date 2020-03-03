Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A6C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BAC2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q7Dmvz98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BAC2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DmF-0003MC-PY
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dg1-0001Vy-CG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dg0-0003Ga-BH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:01 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com
 ([40.107.75.53]:53821 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Dg0-0003GE-6I
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJW2FzYld2CI/NXIB4NCplAiP6ZS6eCLtzljdM/xwfxAY8qZUYJ0MRIusFLmLGacbTA1bTgQuWYhsXbygIXfdkuXYxx2wrS4D8NeOTI6B6LWr7oulOckaO/VHsvEON+6calB+W7MhGA+iZu+1Ybklh+V+UbjtUgeSTi6Z7ZGhKbzanniO3xLiW7WMPxfhI5TiIEU5HuuvO83sLdGIhzMZ64AbQ2Mhs1Zkl4vSyh/ugY1Pvn5dp680J589nE+YaOVHzahUavlJQ0243ieEN53/LS+3VwEKOJRIub6ner6O0Z90AUJf9GH9BmqkHsBM/YukOot/lp1HDI+PECli7cuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cevM5B3yVpPXgT1/wxHDezjkDgPzHj1xYIdaUUb4uHY=;
 b=akYq4xxCQgFeyPgJOR74yG0I3AiEqu4WrGNyPk4rK7CWLBU8MM4hP+uXDfkzhyvUyJcDyr6ak4kvFXTMT4eZn3N+2Q5ESVPLju0JaTu2jhfkymW3dsjxwYIKI9C9nzODKqtea+HiaGKlIR+PuFeJlfdXwujF4N85A3Pz8ylWLtBZUgW6T4V0cKXiHQK4dCPbz2a8gbyDmq4EIugsNTQ1LOE3CAXpiRnU2mGJ4OALAholVb+a3AcMgnFXyLw097Xq24q7BcN/0K+UR0lo1rEtKHndT7WXsglneGTj7TOjhRTLLRRRoAbDrfesq4zYQyaJXMAKv4RYhoSw5w4SgewZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cevM5B3yVpPXgT1/wxHDezjkDgPzHj1xYIdaUUb4uHY=;
 b=q7Dmvz98vgfdz5sozzh1Z5stto+Q9WpiAHVJ9B0n8F5Db9Di+cbZCR4mr+vCoHnaEJBQ63NcWESife0IL49Ogj2sNPfeJyCvrGHWgxHIIhICROiiwJclVy43IwKJNcKJWId39zB7tA1z8MEt4bZrtYyYM1JPnzMIDOyjX/S/ONs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:57 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:57 +0000
Subject: [PATCH v5 10/16] hw/i386: Introduce apicid functions inside
 X86MachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:56 -0600
Message-ID: <158326547677.40452.8049125270383618696.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:805:66::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 19:57:57 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffa12321-b3c6-4871-549c-08d7bfad2b7d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573DDDA67F733B28AC86E9B95E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: np4trQtBKGUTV5qbE3Hgtn2UaaJszcI1oiWhslK5/uatezV0cMCO5jdSKq8N6fZ2FVF3kt3Jm11sOJOfsELxdy+9di6Qhx7pxMOZU5AFjeYOvtPPUrH8QQ5lWb56/MzZtB5rayoDHDofK6MzcZlfm7Iu6G/rzgi3Rk+AVN3g5naWJpwyuHSke4wSd9LigiZNOkXGAt3BpySAtjTkCxqXR4AXUKBQ1RJPWzCpwcGO6h34/6cTmRhDwl/vQw9Sb0l0nL/Lp31VRGm0X9UiYpgBMTYMgLPw4qUtpHgbqk8tKhGVSSKp3vfgQ5KKntAtWLVSAPJQ+XFDOqC0j558uiLkrJZx0QCsrH9geDttqyvTsu88g5UkkbwNlycmchpx3Lay6VkS+/0kV+QahpTl4HdiFjLYXnnJ/NBb3dM68WWFqOuJ+Cl+5eMjMdkY+N611CCB
X-MS-Exchange-AntiSpam-MessageData: tGm9j3zkiNsEYzCMmisQgnn4tHFxgtUn1PIExCS8AyehvKMEj7TnbgYHHIVBVkme36ul/QP18q1eg4GI6IsAMubIAkMOtzWroMkg/x0SPnGoDEZx2iMqLya3o8AJaNGh5lizpuMFhX3j9JQNf9DacQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa12321-b3c6-4871-549c-08d7bfad2b7d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:57.7675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnuA7nrZrcrZirujfcV5ZWRDbijX7VP4WB38bOa+hmZtwweLFeCsJQHOcoWtTUTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.53
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

Introduce model specific apicid functions inside X86MachineState.
These functions will be loaded from X86CPUDefinition.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c         |    5 +++++
 include/hw/i386/x86.h |    9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 929b80c9c7..15b7815bb0 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -911,6 +911,11 @@ static void x86_machine_initfn(Object *obj)
     x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->max_ram_below_4g = 0; /* use default */
     x86ms->smp_dies = 1;
+
+    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
+    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
+    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
+    x86ms->apicid_pkg_offset = apicid_pkg_offset;
 }
 
 static void x86_machine_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 22babcb3bb..2643b57629 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -65,6 +65,15 @@ typedef struct {
 
     OnOffAuto smm;
 
+    /* Apic id specific handlers */
+    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
+                                    unsigned cpu_index);
+    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
+                                 X86CPUTopoIDs *topo_ids);
+    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
+                                      const X86CPUTopoIDs *topo_ids);
+    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
+
     /*
      * Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space.


