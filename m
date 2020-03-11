Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B3C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C2420637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OU0xdN2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C2420637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrFB-0005zp-3o
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCT-0000SR-Ke
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCS-0007lm-Hm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:25 -0400
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com
 ([40.107.223.78]:6042 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrCS-0007iP-Bm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUrmyH/t2Fc9fvROjX1oeSZEAWU1MPvz2inOQHQwfHNVYELRoRpVqIDwxpBhOioPl3zi4lGmIpGd91fz6X86e5OSv8P1sp+LWxlLbFHAGC/ga+XxsPUhrHWyjsE0SbJR0p/K+CYcX9oUcA+fKXIY11j1FPoTm9O0yemj+qV6pSHxskDJ5KNVMSjDFKUUL/9ZCehB8SdR2WjpH9xQNYP0tgXJxZipBaZ4FfBaZEBwWpiqQw/JrXZgcWNj0i+oytCljiKqaLM5SKkS/KQX+T5pe2Nb/9vAog8Txo6W8dYH004y6EaXu0DCJBAmcP2DsR2jUTPTTPQfBgMXfMPYvF7JeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNV7gMlgQTAxe/RqRLGxnqKJeH5jczL2I/uZb/zUC9M=;
 b=hW96iDNFVCdILDeAWJvh97oRfYhWMgaP6NDiBPHKkdSRchUqOvGsBZBvHPzeNjNhtTIOR4eO1PThUBmHA3sPzgLQZaIlFU7Woyli2ZS4yq+obwD9ctpznNRzDp9sH45JlEQiN08AAq7DrB4PfPwSBBOEncUDb+IRk+PLDj3ZFSLy9EzdBOIzdr6A9oRVoGqOJOZOlgjoMkopnwzxzRxnTimaSVatZLewDkuhW3ChgJQGHRiu12D5U1voAg5FqbkqGamhWbRexJ5Qeg/QBHVLLbQ4RDZsIOIXyDqsKzvBzkOJ3pIHLF+ex1a+UsSKErP0TlcYbuCTvMpuncBZRx/Kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNV7gMlgQTAxe/RqRLGxnqKJeH5jczL2I/uZb/zUC9M=;
 b=OU0xdN2MYpta83carnWh34jA9VESVvvo2kL/3sVA5kD1r4nGLASg+jYz6NyL/o4NeE0JE1SltgKWgs1P/GNbYsIwsS+ElJNDrnBWXqw5TINgitKKO5aMhKRkn0L/Bf9hj1DSKlVnRuIJt/iEg+pJmcn2XqHi0th40Dzjrwz8zZY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 02:34:20 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:34:20 +0000
Subject: [PATCH v6 09/13] hw/i386: Introduce apicid functions inside
 X86MachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:34:19 -0500
Message-ID: <158389405896.22020.5141725703704378222.stgit@naples-babu.amd.com>
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
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 02:34:19 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75866c0b-5a11-4ce2-6561-08d7c564b413
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25759D9EB5A8D32045E62A3895FC0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(103116003)(81166006)(81156014)(8936002)(8676002)(7696005)(186003)(16526019)(66556008)(66476007)(2906002)(55016002)(5660300002)(52116002)(44832011)(956004)(66946007)(478600001)(316002)(4326008)(86362001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNizpbPY80rKEXN9qqZkXMvvIef1Mz+qzA8ua/VR7RAjC5dX51ihh9j1JxL98KX0KHqSXthVfnAKe/DBB6vfvhxaiiDE1vpcRfHH67Npku8LyoArPOGnkSOU9AQxJdnGLaL4gls9N5efu8IFRIFZUT7259xSm2/396loJGad6sXMfINd20sHHGW+txcMppH4z6SGYMlGfsyZcRuuZWbUmfGHctpWJ+dfN3KKVkbmbkV0v+uevxkmYo5Y26+AYTPgKiF6UycSbPTaz99nklqF+KFl+Pf9j3OJTbhQoe6WnWnCAzcWQgBSWPc+B/1lNm+R2ikPsUe7Cnl4Pi74kiKeL72FVPu3+Yc3W1vJIapd/FgzSagBlYqZyshF4t1wiA821J7/bsFJVG5UGuc2H0CWVyC19DuIkg9z6DzJIxSFp8QkACTPcjE1cAea9J6zcFKG
X-MS-Exchange-AntiSpam-MessageData: /rwog7yx79E86yqdunhqzJfjzp63Plb2dh2RSRpBj3EZrq34i3hRr1QvE8IueFmm5KbztwDJY4Iu3gRkVpM4Vk8GPH6L5RlOeGG7OS/p4HmFGy2573g3h32Zp+pA61Hl5ZDqSr17ppSTnJAGF9u78A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75866c0b-5a11-4ce2-6561-08d7c564b413
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:34:20.6285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvVUOymy7x/F9oLNXKocUPlS7Z1Yzs3TD78iWmXoga52a27DZKtMWIOF6pMKCYMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.78
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
 hw/i386/x86.c         |    6 ++++++
 include/hw/i386/x86.h |   11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 929b80c9c7..7dc237c014 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -911,6 +911,12 @@ static void x86_machine_initfn(Object *obj)
     x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->max_ram_below_4g = 0; /* use default */
     x86ms->smp_dies = 1;
+
+    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
+    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
+    x86ms->topo_ids_from_idx = x86_topo_ids_from_idx;
+    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
+    x86ms->apicid_pkg_offset = apicid_pkg_offset;
 }
 
 static void x86_machine_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 22babcb3bb..57c1d13483 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -65,6 +65,17 @@ typedef struct {
 
     OnOffAuto smm;
 
+    /* Apic id specific handlers */
+    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
+                                    unsigned cpu_index);
+    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
+                                 X86CPUTopoIDs *topo_ids);
+    void (*topo_ids_from_idx)(X86CPUTopoInfo *topo_info, unsigned idx,
+                              X86CPUTopoIDs *topo_ids);
+    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
+                                      const X86CPUTopoIDs *topo_ids);
+    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
+
     /*
      * Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space.


