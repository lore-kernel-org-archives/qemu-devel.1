Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C29206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uP79eFHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C29206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJXJ-0003QO-Bf
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuD-0005YD-Ge
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIgY-0003iB-Dp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:31 -0500
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com
 ([40.107.94.65]:31456 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIgY-0003Xh-5h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOLBXu92wpSs3kZN6mX5FXf/93SIrNERByhloRvN6x13L08BUBdAht302XiBCXcXdWmAmA3UpreXbsIuCTF8hVKiBXuVvNLE8N2B0NjBnn7DoUioYk/dWGadnwjcaBqPfaOah371dDbY40YC1YfK54YbEIEYDawZEMjxzMN5Kim5rJWEFdjZWCEflTsTBBIClNquVMY/OIhJzSh6D8iLeDl8Eare+ewrDQ3xIf2aHqZyReSHwY2MKDQ68PVqMZigqlTE9vC3XpEWhRt0yYm6PtbQoa/hln00Mev8pNt6Yk562/7vwrw/AUwvQm4bYHjdOseDcAtP6y8AqTTim200UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoIoMSKqAicp4E9S4JATy7CdMZEKfETpQNdRXwMxlrc=;
 b=SLHrhNoxtcGm3gckErbW5HCjeK9b+kzTwNfYCcbeVuZA/47ZgYxHknXwvxUuBIt4O492GLu8Tlmwm6t+2GbEneiYk1QPtnoPCyLg6wGYhgYcvWKGGrn/S6TW+xMw9+q0zKc2IsmCFJyaU8MnPZb1Cv87P9jRDZI9c8RlhOXb7C36+Nmg2GQmpPOptvUZEJ3IkY3fQTxnyQMa/BfeZr4jZNwLz0hOC0VQVMx/vG8krfLprQN+RPMHy1veEtoCCsIl0/e4rL3HzWrTRapylnj3wrG+IrF7dQAaxdFCnursi5tiC47YdEQ4/rwY21xUA4wMTBKrMcyTzwjyWUG09CBZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoIoMSKqAicp4E9S4JATy7CdMZEKfETpQNdRXwMxlrc=;
 b=uP79eFHHK//02zsf5kkPa6TLG3x8dNckG/+ZgoO44lWkjli9RDeCDmIH+7+0ZajMN+LLZhIR/BzVKjUYpebuit5K0aCn19hcdssUjTPHSr3hbZ+/9hcoSbRcaLMhr/5GWol5Xfw6yRa1uQPJCmnEfaaL97w7GmUiqwpsE1Gp0z8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:38:27 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:38:27 +0000
Subject: [PATCH v3 13/18] hw/i386: Introduce apicid_from_cpu_idx in
 PCMachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:38:25 -0600
Message-ID: <157541990559.46157.14383447284580991446.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:805:de::28) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98500976-a085-47c2-8689-08d7785246e3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13694CF624ED110AF17E855C955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
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
X-Microsoft-Antispam-Message-Info: n5RIv1INM42DwJNRjdaS0zmvoHezpFUfesoopf/zIMkH4N2/a81olDbrtM0BVXvA1mUSGe75RKBsk2A5aXKuTxl0wfuaJXPgKEMK1j3Qp0ke4DL0P1yi6Ws77AUg0Upgp/rMBS5+WQBx+arQS9f9+sfeALt+S9PsG+4RTknzVh9oM3ki2/1Ju86IAa26hq1yEzQMVr1rz37BUrFSJnhpmvwkbeF4NcpcxAmmUmwy3b/pFfRmL7G4W+HVLgO7t8VlJF66JFpVIFy/xlDQdH6V9vVB+5/48EvhOveQ67ITY0uph+gq/Mop2ESCE6geoyEpkbPp3zYY23bnCzIvY1Y4bAh3Kz2nnqhOU3NjOZyIFDa+8Ni8Ehq41b6pvilGpY6m4SI8EHnDOiujjH5j3WYTuFnYeXR9C3Ooiab7W9KUEBhImyD+iMsMGjtujqM5FdFD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98500976-a085-47c2-8689-08d7785246e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:38:26.9991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rxB7s+wiDDGV2TZPCrhYueHKKAWeA9EbOlgilEjjttD7LfnKKV3JhA0YitgszFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.65
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

Add function pointers in PCMachineState to handle apic id specific
functionalities. This will be used to initialize with correct handlers based on
the cpu model selected.

x86_apicid_from_cpu_idx will be default handler.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c         |    5 ++++-
 include/hw/i386/pc.h |    5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7f30104a6b..52aea4a652 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -894,7 +894,7 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
 
     initialize_topo_info(&topo_info, pcms, ms);
 
-    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = pcms->apicid_from_cpu_idx(&topo_info, cpu_index);
     if (pcmc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -2679,6 +2679,9 @@ static void pc_machine_initfn(Object *obj)
     pcms->pit_enabled = true;
     pcms->smp_dies = 1;
 
+    /* Initialize the apic id related handlers */
+    pcms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
+
     pc_system_flash_create(pcms);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 37bfd95113..56aa0e45b5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -16,6 +16,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "hw/i386/topology.h"
 
 #define HPET_INTCAP "hpet-intcap"
 
@@ -67,6 +68,10 @@ struct PCMachineState {
     uint64_t numa_nodes;
     uint64_t *node_mem;
 
+    /* Apic id specific handlers */
+    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
+                                    unsigned cpu_index);
+
     /* Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space. */
     AddressSpace *ioapic_as;


