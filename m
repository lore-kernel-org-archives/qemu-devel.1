Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08999C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1B721734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0uRC9Zcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1B721734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JFN-0002Jc-1e
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3Z-0002xj-AZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3X-0000Pu-SB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:45 -0500
Received: from mail-bn7nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::622]:7556
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3X-0000MV-JG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8gP/L1xsxTX/T9gAQ2y9FDnUtvMaDWpIuBT3tep+XLWC5sJ22YxgenX6t63zIxrHwUTHOEiKw3oKd+S8P4FP28tQ9S0lD7gE5IvRYhFfb502nY7+WeDDj3r/DK//l2gksa9EKgpsBXINZKNvCoSQxQijy5A9CY/NKRZ7ECqNZQVZ2NAm8GTw6c4B+A9x/Np/aKOL2XzOpPnxIalf0Nk4gPT61/r5nj6DQg0S6fKDH0h9WNP7AdrH+rjbHXHEqmeNlyZdpt2Ym2LE8NVTVNaCaPo7v5dYea3LtQgE/B3brFTOr++qSb8EkxPDvOye0o0biykBDf2TG5D+lSsuGo2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnTOExsJ/Jimv8Fw2PmiV1c0hO+4wHwPEhw/F14qJDk=;
 b=fr/jjrNJqQqxN+trtb/zQ32Ilwx5xsbzeAdg2fLOgZtQDF5ltBU1CgN6mIThcz9HnXRPc97BUrGaYXf4KivO6eEwSKmOsuaYZOm84GxtCweL6Kbev/ih/tH1qMo7ht9wU/JNgC/9YFCJG1v9+h9Fj/qZvHn3XLXKpZr4WXbjJbceTyTaNgruIe7za/vVKVMyXqGJ3jn4fgQTNbchs+dbQLIf31nqXjOOks1CJyumBXbVShBCuYZOLt925C4hNHfxMcUP7lXOS+9VshIv7k/wlty6i+Esp59LxOD3ZuiVDLJoSsTjlbkXU17xfcRxe97W+YwrnueeZrI6rsv0cfc8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnTOExsJ/Jimv8Fw2PmiV1c0hO+4wHwPEhw/F14qJDk=;
 b=0uRC9ZcpTD4Aku/SC/v5N+4wM3ggXPMnBeyuB0t1sDx8acGO84VU/t0SX2c2P7Eq2q5XPOv+1fIYfffppGtiinCv8N6oaBLRe5do20mXmj7RpabkdF0dZXjz3w8DQaW+PI+mf3t2y+I2LlVuxzMhdZ+00HRKkfeSIwPGAyeIbyk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:17:41 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:41 +0000
Subject: [PATCH v4 11/16] target/i386: Load apicid model specific handlers
 from X86CPUDefinition
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:39 -0600
Message-ID: <158161785961.48948.12596231683203907680.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::40) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR17CA0027.namprd17.prod.outlook.com (2603:10b6:5:1b3::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 18:17:40 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f55cfc0-c67e-42d2-b2bf-08d7b0b10363
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB13184E9DA5699423D0A9ABFF951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /iV5omMBa1tmqJyQAE115ncBdz1RDcpu47dMzpmekMGnJ9D8gSJuKWUoEuBERJkvPX2nsnIwr61Mpt4H84n2/ZDmRLK0X4BYcOee9/zuUYbvpm0e83ILItLdrfRMMZvNG/Ompzp6btOVVTROBBldrkCRxrW1zL0yj5hQRonu9vyAqI7ElrEyvq/rCN+dEsKRXOPmIHvaux1EW3fEY4jD9YtWfrasDPTF3Xg6qi+0HObyrBnZTnpYJWhDv810GVxsrbtJraAdhjUVl1FVxsiGds7od7ckUFIzm4w460LrrzZgqaE3SADSHVBx/6wL66HIOCVMr+quSR9AHuER/ohFBpRbKFERDDV8KzlnCXwv/fN3JjlXGFOzvtv3aCLlFmtf0RtJapvZa0mU6+OJyydnrUkIBNFyiSbztQ0NuoVdCOk8LGQv3Tlf8YZcl+z3FcDG
X-MS-Exchange-AntiSpam-MessageData: ORIB9JBcXZ2voNSJ9nb9aj9HulOCagPQev2NBsYbU7fSELPFH8ajXSxCzHZa7SyYZzPTR3tPNTwZgJHHFYr359Ut1e2IkLkaOF67luLWFxPqyLXhgkFMfAVez32ij1WXtOmE2tc9eTNMYPLvj/tXBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f55cfc0-c67e-42d2-b2bf-08d7b0b10363
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:41.0579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8I66Yyl0UcWYTo32l7+AZHu0K6CeAxNRSw5x4AaaEEO5gMrhzz9nithElYkqGGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e8a::622
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

Load the model specific handlers if available or else default handlers
will be loaded. Add the model specific handlers if apicid decoding
differs from the standard sequential numbering.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   38 ++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |    1 +
 2 files changed, 39 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 19675eb696..389b68d765 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1614,6 +1614,16 @@ typedef struct X86CPUDefinition {
     FeatureWordArray features;
     const char *model_id;
     CPUCaches *cache_info;
+
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
      * Definitions for alternative versions of CPU model.
      * List is terminated by item with version == 0.
@@ -1654,6 +1664,34 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
     return def->versions ?: default_version_list;
 }
 
+void cpu_x86_init_apicid_fns(MachineState *machine)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(machine->cpu_type));
+    X86CPUModel *model = xcc->model;
+    X86CPUDefinition *def = model->cpudef;
+    X86MachineState *x86ms = X86_MACHINE(machine);
+
+    if (def) {
+        if (def->apicid_from_cpu_idx) {
+            x86ms->apicid_from_cpu_idx = def->apicid_from_cpu_idx;
+        }
+        if (def->topo_ids_from_apicid) {
+            x86ms->topo_ids_from_apicid = def->topo_ids_from_apicid;
+        }
+        if (def->apicid_from_topo_ids) {
+            x86ms->apicid_from_topo_ids = def->apicid_from_topo_ids;
+        }
+        if (def->apicid_pkg_offset) {
+            x86ms->apicid_pkg_offset = def->apicid_pkg_offset;
+        }
+    } else {
+            x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
+            x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
+            x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids;
+            x86ms->apicid_pkg_offset = apicid_pkg_offset;
+    }
+}
+
 static CPUCaches epyc_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 627a8cb9be..64a1cca690 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1889,6 +1889,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
+void cpu_x86_init_apicid_fns(MachineState *machine);
 
 /* helper.c */
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,


