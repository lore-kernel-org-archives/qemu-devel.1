Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF7E206E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uonarfxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF7E206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJ8c-00022U-8i
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIu9-0005Y0-Ds
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIgg-0004FV-El
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:42 -0500
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com
 ([40.107.223.65]:39542 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIgg-00046e-5V
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDe1olsQMxRVXeKbfes8YeMtI7I9wW5g61BfmHnahB8jrLjiMsd7y9YCbRt1Wu3THtB2xdfv0EmT9VkBEoq//0T2Y5iZ72mqQlH3cqdDaUWqnQ8Nls2Aae4clCwYBUvOagqTwesN8/WzHpT6DZMOPcr7PvZPjHcVAPNEdJAzY7tQuoIveK2nBjo8Uv9dQeHNOfmuM9Th1liNQtPMM4M+FV4faUTWUiVDW+yeKYHDrBfXBMah1PnqUMtSV6jBKdlvq3XUqB7p4ZZi1CPnQgdfIbTXXU7k9zh4rzMNWCFI+Vz714RoWEpndVBrjxt0L3Tz4BhZObfx6cRH9s/g8bmpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU5MGl/BgsqmPX09yEMYAaUyMETAcRTAFDlqaluKi2E=;
 b=F8DCCsND3jMFRddvTkeXqkQq6bOJNLPsJcwKUISCp0PlJ3kJjb95knbe6OHqL0e/y4Bp3mj7RlaHYipHToxMbNfvIznIUlDuHKYwvMSOPZ7rbGXh/YPxS7IWxu4hYig44M58DbmOqo/vmjXWrsU2l2eNivAw5ovvBckhxOFPNy0coMlx4tDAz7DSYshF8zyGpbZhD3K5DJ+VcstsPSXGx1ko+Zug2bit5UQzjctvv0Oz51RWo75C86HkFC/wxSoneSjeaPofkvFRq/jf4EHwG86vYdNtv5Ycg5MQYbI/62RC4B0bUFac7ENIMYkPYtdfSiqNlyTWegtsfO1a8BteiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU5MGl/BgsqmPX09yEMYAaUyMETAcRTAFDlqaluKi2E=;
 b=UonarfxdGQ0Rw5CI0cb1yLmjauvhnXgqyQZGg0DUfHwp5SI4/aDCb25t2WKH3JjNhwGEbf/CvFAUF01KDNNUR1ak3AxHYcnlAO716APW06eGwnNI8mWNA7idlX7/TqxOX2Q4M4z4ASW4pkqzljvnAdIOJHk/V9e3oBOGo2FVoPM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:38:34 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:38:34 +0000
Subject: [PATCH v3 14/18] hw/i386: Introduce topo_ids_from_apicid handler
 PCMachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:38:32 -0600
Message-ID: <157541991228.46157.16916453001605357002.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:805:de::16) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a588a01c-7f56-44f3-6096-08d778524b24
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369AF50BCFF4E3EA832A2ED955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(498600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(99286004)(14454004)(446003)(6512007)(23676004)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpOSWDYsmUc6nVqK2RyJiybCiu7nh9oiTzL0aGUpC9B9QgOdqX1Zs2K8pVcuU+NQTl9SDggTVpsFAm3nGfFJSHhWLtaDj7yEGuOP7PdYWXuV8/3/bfx3hNUg/LfgILtK3LE11u48fx+ddhkC4FBhCe0vjpQN9RXiVI4sTxmA0NEylJN3lYlUzkgH7MUoS6ByCVFsWlbmh34xRKIDeVgihUorATzhp/jtjSg2/txNWNFYrypzvE6nSScqOERzvyLvstfYF5HhHhQojN6VUvi4NncKnvVxLj3qG4xuVQUgB/BIrSqkanhVrB+lB/Fy0WGs9TK21txJBj0PES3sExQrS4rf32JPadWtg1r4dQmAPqkZ6aOfGxPFLUFIbGtgyYgfDM04DQZP6LxEXVuXib54EHml2bm+7/reaYP4kmKEGKRiF4hr3Z+eTbkBf3no0TLv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a588a01c-7f56-44f3-6096-08d778524b24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:38:34.1480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNV+DnmTAKg6lxkq/Zi33X5BfBlEDv9TBh3U79SbnJW4E8PbnBUP7fv74MY6vpxM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.65
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

Add function pointer topo_ids_from_apicid in PCMachineState.
Initialize with correct handler based on mode selected.
x86_apicid_from_cpu_idx will be the default handler.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c         |   13 +++++++------
 include/hw/i386/pc.h |    2 ++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 52aea4a652..b0d58515dd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2312,7 +2312,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+        pcms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
@@ -2333,7 +2333,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    pcms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
@@ -2681,6 +2681,7 @@ static void pc_machine_initfn(Object *obj)
 
     /* Initialize the apic id related handlers */
     pcms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx;
+    pcms->topo_ids_from_apicid = x86_topo_ids_from_apicid;
 
     pc_system_flash_create(pcms);
 }
@@ -2730,8 +2731,8 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
    initialize_topo_info(&topo_info, pcms, ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            &topo_info, &topo_ids);
+   pcms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                              &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -2763,8 +2764,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 &topo_info, &topo_ids);
+        pcms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+                                   &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (pcms->smp_dies > 1) {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 56aa0e45b5..ffc5c78164 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -71,6 +71,8 @@ struct PCMachineState {
     /* Apic id specific handlers */
     uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
                                     unsigned cpu_index);
+    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
+                                 X86CPUTopoIDs *topo_ids);
 
     /* Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space. */


