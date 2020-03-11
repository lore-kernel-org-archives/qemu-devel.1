Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCEC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B4120691
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TTl2bmwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B4120691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAMS-0007Zr-CQ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEb-0008GX-05
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEZ-0005qP-Qg
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:52 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com
 ([40.107.94.88]:13073 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAEZ-0005oo-JR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOfsA0wM+wW5F8eEHGpi6AB0mrgQhomK8RHw9y98KtK+ky/TmIw3j0MtaOLsBGkrtnDXcseE2jK1mMCLVSBU5DjqwQZ61uit9ykHZ3tMQozeQYYF8qnubGq9WHhhw9SLudrlS2n4djoRuOeAPXD9+jg00Cmh4HH7AwsIndXzYxkIIvLAGf+m4MV2Gku78bHp+n7GcjSL6A+vaySm3wJeGpjtA9WNJywa7Qn9Xq72vrZ7paVw4WKqBzBkgPsx3KhqRHSWp/hZ7XVuYTWfB/2smc4ghI5lNNB5BWPfRKwcQOLL7GRyK0/woAZ7ocuXGMDxKyuosJk+CfCNQzKIym1y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jL99VGkfcRbB+EqOxtVeg5pk8K+8yW8QfYVQaD3IYI=;
 b=QGhwMBiYkQ1WeZwCnnyfA4O90E93soU51uej+G5KFnSM6Hy5nPklzQvTccOJWU96xfG+ZUUY+oWQ3xH6J7LMqay3DHlZQ+nJmlSk9SdL2EHbglfJrsbLZ2wkjDSc5UjxudVz3oIx0T+zJKHsGhf2D1hp17xXtP4kf5+QCYhqYU9myZzvMhtWZyYkwSTXZBY3DzXjdAkcCGJA5XxRg6E/BcRbmBicC9ekodbYS9RCBefRmp/qtCThalNIelLNtBhJAzjcfgJZAi9WybneANuqDNF3xEASEDlmTnSQlx1fGWlXw9EOttnYuqQxrpcd1MkiDnaJP12Gy2SVOHa+j2uf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jL99VGkfcRbB+EqOxtVeg5pk8K+8yW8QfYVQaD3IYI=;
 b=TTl2bmwZo+G5Dv9ps6ImMaH9r4n6OJMHmGoerQpOIev9sU+Ga/3EKgD6SfbZVXGjawb+aMSQqsocb8ELPO+1t1IPn3ecVoOdnbkTsZ4+fEWt1O1jEpizS9WHo7XhBvgrMwR87+zah9pEcJkDqK0dJ0T/ijQBrvzxCEElyk9C7U8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:53:49 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:53:49 +0000
Subject: [PATCH v7 09/13] hw/i386: Introduce apicid functions inside
 X86MachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:53:48 -0500
Message-ID: <158396722838.58170.5675998866484476427.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:5:54::26) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR06CA0049.namprd06.prod.outlook.com (2603:10b6:5:54::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 11 Mar 2020 22:53:49 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49a33800-c13a-4aeb-79d5-08d7c60f105a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2349B7292C644B93D95F19CC95FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
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
X-Microsoft-Antispam-Message-Info: XRAkyZLh5nk7VJOA4Wdc1PTtw1lbWVaaCUBmSfj6HD5OKg+jhe6YIPt00Dg+YYDFixBobq/fK4KHlweqvwJE+Xj2LpLKz9LPJjsbyBUL7POyN1sR1IJswH5zOGc8RaPAoty0EEEjoODWvknv8rbg2nlGHWTh5J5hDqULxl4VANMazYpIljAgWHToKW+XFcTwqBhOD5xS/cWlthvkIESu+MbThxiTJAweMPWU5NiNPbxQma+nrNSd5bJRgw1HHi0YN7j+2fzVD5ceFxMv1dNIVBYHFbPfCDsE9cXNbAtYzhwbVMv9HHsbH2Z7GhAKrCl+TzWWZXDe2J4xqZ90qDnB3+U1phnuZJP8P2yA5bWFGZ0vmhww9oZdsAR6qLthM4Eq5r2DQ/Y5Blk/5BgZbANDC3BhI1SkQiDuTqs/OkYT/eP7sYSSDp9z+pGd8ZLmFD4R
X-MS-Exchange-AntiSpam-MessageData: HJ2Bazm14IGFtlW1poh8VJTy3zTFT1DuhCYIyWDzrhJW6U8wH5Mtqa1Q0XuHeaBqhBjVp06u5IF8RxbfIADG0Db5SdX0TrTmALjiX7u9xww2eeFJzIwr5iHplwm7CUJT04vVM+ZLJpakIgfyZtFqlA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a33800-c13a-4aeb-79d5-08d7c60f105a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:53:49.8837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk9/F7HoE+R3AfO8v1fSsFxJwFtcYGD0E1CO2j1L7m70Ug1spZod2WF76b31Lc/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.88
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c         |    5 +++++
 include/hw/i386/x86.h |    9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 42834d2319..0a81ab5151 100644
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


