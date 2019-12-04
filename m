Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8967CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD4F206E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XIBkNi04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD4F206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJFj-0004gj-BM
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIu6-0005YT-BD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIh0-0004dP-6L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:39:00 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com
 ([40.107.94.77]:6183 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIgz-0004QT-B9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpfNJ6UPA6Ek7vXGbeE2p0lT9+ttScOs5068cvpkoSyzS6P6RkoRZeb30AX6neuHkd9LUamxE4r1XtG5z0yLUg2qGOfETnqx+Ua9ijKj80co7i+hN8KGqsENwg7HsX5c22kWlLfeQ9PuSr+qH4G/LFNnN9Y/a5PVTfpdRwaa2YYj45OeTYoh+KZKXFmPKEL5FXaVAHN/LxUjJSI/0XSRVviMDllHI6kp2uPTxnjNBXk2HE+2MW5c8tNp9PqoM45Woyd45eg6kA/49FKDfngEC4t/v1V39d/NO/onssgXEdIH3zy2FxECOxLXCXEQqvgwjyC5Ci2Bh7xf0cZ/AfCe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLR9qeQKLQ1UcPNyf4Tdp8YnrBxDCpScgpgYG9dZKPk=;
 b=OkruOu+gwwsbCNTgR7ZprX/L0LpMnumjiCoUKRKqzotNyo12GwJknQ5SF/zu7gX7xBmgwHGZWDRyBJXFijPWFTEHgWf7p329VOY7KlluRMBKVHG0Rae5KY9n+5ODQB/rc3Q+qQ7W/ZgLFXl8uCbNyCX1j+ijAjSRQ8VRA74mE80baAP1HX1yxrzi3JYVygckMintFEoIlFunQktFIPrNk0TBodjoh/PRANzWer+hFkJfU0VKyRivI87bdmVj6tvLFhZThuUtVdFz9rSr4Ggos5/dybwuNDe9UvjzfHqC1dknGYy6WDnBUzGSZ1dWMfwFZh1E+fN3hbAcuBauBpI7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLR9qeQKLQ1UcPNyf4Tdp8YnrBxDCpScgpgYG9dZKPk=;
 b=XIBkNi044MIgZ28UZwJiH/TXMfAPzJOOxmJ8ckxr3448/5wvZK3OvfWph/5Iq3ZQ1qLBazLD57twrG6yot/nEWHjcCKKhy05SZMG4FMBEaCJY5DADuyiKpSPFrrpNd0UR4SjnLystj+DmXWOTFIcAVOxAqX5/xFY238/sQeX+Qg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:38:48 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:38:48 +0000
Subject: [PATCH v3 16/18] hw/i386: Introduce EPYC mode function handlers
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:38:46 -0600
Message-ID: <157541992659.46157.18191224973398213624.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0002.namprd05.prod.outlook.com
 (2603:10b6:803:40::15) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9accf511-0ec6-4d89-1f82-08d778525387
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369231C661155CC02DAA41C955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
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
X-Microsoft-Antispam-Message-Info: TkO4wc9H6/JTE+2QBymN+lXeAqgq5P1f1H/0/1864NzDjX49+71J48Eza5QUrE5C365KU0ljvdFva94yc1PhIEShAlyj+Evb+ZUYog5YFSfLo0cX7GRqUjg/Ja0uW945ixWSPHHhN+oZ/DU9xA16soI2zlJpm3Xb+Fjem79kKbtHNsYYJgMjbgYt6dTRSjbjMsu2E7fXstlWrnJibFm9eS8oZk80o16PkFbB/N8P5gClKvT47yThOzlHT1+enNm5VY4gDq0TamNcntUT5UjLckvDPafcwbJbZdlhgWbsPd+G1g6TcN7MkyeixKzr9HEnTio1VB9YSfuKeS+KUpYqS2dugSATX9AoTp+xAMSYalZ59mx5vpN6lSq4kkF38XusuwcFy7N70NDgpiIhs/mEmMoIO9UY5EI+RGoEJ0bTcLcr6PtsJTlaeJC8QRNT72HT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9accf511-0ec6-4d89-1f82-08d778525387
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:38:48.2648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3r8S6NEfSkIUZoAAbOnd6YjbsWGRXn/hZM+gTs3/LCUlRdjzuklqIywyXui1ivNd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.77
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

Introduce following handlers for new epyc mode.
x86_apicid_from_cpu_idx_epyc: Generate apicid from cpu index.
x86_topo_ids_from_apicid_epyc: Generate topo ids from apic id.
x86_apicid_from_topo_ids_epyc: Generate apicid from topo ids.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |   12 ++++++++++++
 include/hw/i386/topology.h |    4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e6c8a458e7..64e3658873 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2819,6 +2819,17 @@ static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
     return true;
 }
 
+static void pc_init_apicid_fn(MachineState *ms)
+{
+    PCMachineState *pcms = PC_MACHINE(ms);
+
+    if (!strncmp(ms->cpu_type, "EPYC", 4)) {
+        pcms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
+        pcms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
+        pcms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
+    }
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2847,6 +2858,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
+    mc->init_apicid_fn = pc_init_apicid_fn;
     mc->auto_enable_numa_with_memhp = true;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index b2b9e93a06..f028d2332a 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -140,7 +140,7 @@ static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
+static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
                                                   const X86CPUTopoIDs *topo_ids)
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
@@ -200,7 +200,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
-    return apicid_from_topo_ids_epyc(topo_info, &topo_ids);
+    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
 }
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *


