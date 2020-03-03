Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2B5C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A8A2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i/C7D8e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A8A2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dnp-0006a3-GS
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dg7-0001in-RS
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dg6-0003Kd-JO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:07 -0500
Received: from mail-eopbgr680064.outbound.protection.outlook.com
 ([40.107.68.64]:28798 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Dg6-0003KY-Dj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2xnSEx9m5SDQYn/jDDyq2eoNzVxjhKhZeTGdWMMynGN44h9qXoMTwhL1KZqtIiLwTaFWlN8k+AjY5X7aX04pT6T9ofvy8J4zSx3IPWGiv3ul6XrfXlOttl9r91ANZJUwd5XhbH2vOBzAcGKjWzy5GNiLB0ri+/+U6ezf0cdYZLEzvl5AtELYCFdjimqPi1VBzkNR8vRt5pHAZck1Tfwj4HXvYj9Mrf4+DvvMLxHeF6lmQrVnlyHXEWRFX/zDRk9g+gLrRUGDM4k6X5OrWdGwWbPFOrCeStAd08zsixtpc8KwWBnSJdMUpMPjU9DXMlqyoYXV3FMbxy59ZPht4KT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXycWrgZU9tV/qv3XlKKeojqrHBuZ+t7B3SlRDM9nDY=;
 b=j7XAxGNWLQzbSlNvVJ0BgNqPxzWOWJP33q3Ce69WdHQB/s+WjFjFA26lA7wszuR6XKUNAT+m5LmJBNoroPuHtq/OvntZfFqyOMF3+u5nsDoCnfzFItsU1YnMHQtjE90f75/LDoN3QGpBa4iY1ZbNFoNJDqNJe0bFSyPk/hS54kfDlIA1JILdkrwLPyGnSWebm2Xd2cyXGb5u0rUH7fcz8NBdQ5aIi3dDMQVNWEKdjf3VoUWBXPG7hiyDcsjNjOrQzxUaVcP87gCi2NK3QtYK3raat6ny/Ke1IyR/kEt5zz0yELBiXBa8gQDTAc1Hv9DoUiDkELhqmV5IE7Ea4y+A7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXycWrgZU9tV/qv3XlKKeojqrHBuZ+t7B3SlRDM9nDY=;
 b=i/C7D8e2DVCVTr+x1TLNjZqbY/cW0J2389UF9CwNkfJfwn3cqVItd1ArOYfdWyMGaT1nqKeeiBsmi4eRtcFhkocI//jk4H1C2F639gq5rcSSBsWqrg2jv6umHijme7jlQXkEUgaiLImr9CaE/KUg4jsn7ZVtYIpqmJfBeih9o0o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:58:04 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:58:04 +0000
Subject: [PATCH v5 11/16] target/i386: Load apicid model specific handlers
 from X86CPUDefinition
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:58:03 -0600
Message-ID: <158326548299.40452.4030040738160407065.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:5:bc::44) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:5:bc::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Tue, 3 Mar 2020 19:58:03 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4353582-fe5f-423f-2f72-08d7bfad2fa0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257384EF997C6A363D4EBFAB95E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
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
X-Microsoft-Antispam-Message-Info: JTnx5G9CUSKtDGr88JDRFIFSEQng3GpxJQKxAoi5iK9vqrp7Wjq5r1uLA0vIFaFoYYKW7KcHNarBcV7/jV4XXg9t7PwfsDg6lMd/zbjf2klr46A0O0Xuyy7vWreoj5qsSRyrBhm0hIbFYXvRInSZ/3hahHTEi1DgJvivkCD7FuiKZjVLkrOGifjV+s/Q+ss6Wp9kXg74wifHIgfgFkW8fEfb/Hid6WrNG46WUs0biVn5gi8IgFNxnYHl6vF6YC7sJkHXuQdLejn0UwKfdCAWmYOPk/BgJohc8Nd126+VsS7VBEs1ewdq7/xKVJmgfOkOc72wxhHGGhdCTyQAlXh36Cll6rdfkAtE+9ECHFXPSI5UewU6eKZaOagRFIxpdXI4bKNYGxmIybXNK91jhfrVUReJqYtLEWoDxzqsOmWFat6ESZg/t3oFEP4lOyzSD+fo
X-MS-Exchange-AntiSpam-MessageData: pnlU7TP9BAtvvB0vyCSmdrZqVAyL9xR32PVD3RkpjK3oyr0Tn+bn/V9GSKzVIJtY6FDvjA9KKfiOYOc3BvqxngmBeGJNnaD3mBZljfif9UWnxyP6Q2tF1an5XciD+Og+REX3SpC67xikDsvTwLUI0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4353582-fe5f-423f-2f72-08d7bfad2fa0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:58:04.7348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwAHxphApZ6hUJjTx3GLsWQvfMv3Rcf0PLPkg5e8oPMu4u8Oj+1PND/ejJBxN9/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.64
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
 target/i386/cpu.c |   34 ++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |    1 +
 2 files changed, 35 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c75cf744ab..f33d8b77f5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -51,6 +51,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "hw/qdev-properties.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/address-spaces.h"
@@ -1614,6 +1615,16 @@ typedef struct X86CPUDefinition {
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
@@ -1654,6 +1665,29 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
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
+    }
+}
+
 static CPUCaches epyc_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 20abbda647..34f0d994ef 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1895,6 +1895,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
+void cpu_x86_init_apicid_fns(MachineState *machine);
 
 /* helper.c */
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,


