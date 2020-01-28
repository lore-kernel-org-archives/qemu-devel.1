Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6384FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0DE2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hpOyFvb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0DE2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTyz-0003Fg-Bf
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwTyA-0002lH-FB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwTy8-0000N6-UW
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:44:06 -0500
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com
 ([40.107.243.85]:6054 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwTy8-0000Lx-Nc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:44:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A045tFLKSH49evRjK26BtQzZWWirmb+1kWG51M1VDjxyUTMylgS7+iSubAaS2dLhUKhI76yykoi2RZYmGWAQ371xKlS7K4BE2hOUfnF9FStLitJmbuO947XJp2pv+9lLIGcLraJ3holU4rO+91ursx5btkNhbYzl1r1d6b/KkOPZxCIiBZWJuM5rSJTtOPDr/R+T1jc0oZOHkWU5QAxrVruxliIufoKv8n6GfLGQqnPgZN9Rix2a/2tOi21hQCN7stvv3grGfkl0bhb8LAKtGnlF1ltybov/6zAAJuHpXupdCJujaAr0haxK5aY2Ya9ESNURJyIPxRVbT8dGlDDM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4cnn/TyCNLHzU5VZY1diDuP8naGSKjuygA474rb84w=;
 b=cZl+Ol4MFhHpb+SHAK6L2Y7/YhzY76/60g8R+avDUEBI6/hjSgpjE0n96EnmVaEz7G4YzuidzYPAoOljNp3zBCx1y8Yu7VcpnebR2QiPRj5H4mZRdlASBkX7VCBUlByaPhcpy1wMxoXGCH9CjY+2QXZsBoRPBMJB2774Mx8z4w14Ngdjw5N2QJJJYj4HLTLvLvBTtLAhQXgnY9baYHf3uWgPJXQ5yNSEY9lRGnARH6pk7qscMJ6ESnaAs+rE/dll6s5r+CbW0bBZD7ERUb99+1iUfiU9ON1x/0Bw83rod1AXbTVaIR2pMBkjPaginroFnhKXgqmollKrIAVj82qFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4cnn/TyCNLHzU5VZY1diDuP8naGSKjuygA474rb84w=;
 b=hpOyFvb6nRZTbNGVsYbyOaqq10L4xtR8QOE5CacWq3wIBEdf/UGKh0KyDzB/wwGMmLTnDv1NjimiN0Sb2FUw1/UH+Pjf1KuSQbeP+3tM0slPos5i9kmJc7gkfVn/3F9iY5u9mGL7dHljJKo/3N18VCdlfXflv3uhPd8rS7LiSdQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 16:44:03 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 16:44:03 +0000
Subject: Re: [PATCH v3 06/18] hw/core: Add core complex id in X86CPU topology
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541985531.46157.16935250205964640126.stgit@naples-babu.amd.com>
 <20200128172759.5215414b@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <bd52716f-d049-8035-00fa-ba2817a410ba@amd.com>
Date: Tue, 28 Jan 2020 10:44:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200128172759.5215414b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:5:14c::45) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR11CA0068.namprd11.prod.outlook.com (2603:10b6:5:14c::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 16:44:02 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f46eac56-9227-49be-5d24-08d7a411482c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1653:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1653440CD2F2B566D4AA698B950A0@CY4PR12MB1653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(8936002)(5660300002)(53546011)(66946007)(66556008)(186003)(6486002)(8676002)(36756003)(81166006)(81156014)(66476007)(31696002)(16526019)(44832011)(86362001)(956004)(2616005)(26005)(4326008)(316002)(16576012)(6916009)(31686004)(2906002)(478600001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1653;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 621/x86QZYB8lGy5sFL6kaJWFpZlrzWgCNvC0gTwcVgp7z76bbjAV4GtdwJmiqtbFDZML+bM09VkOz2DJpPdRMngnIJ2qx6zWgSHrAaeqZgrlPIlIVoybhFYTookZQjCniNMwJpDNPHpkqTMKTRv9qcWJxAlrQePZk31lYxNeDGG5xz3BuVEX9AXPWZj3U5X9cIJq7361ybxEl6JPaL6BVfEvHAuPm0mcAXaXAYSihufbc6Sg/lhASIKFBKL58LxUWonfzD7wN0eRRH3Z6D1KwSvHHjbxNi4MVU2RBaSVi+cYLEbP8qkAtKoxX9B9zGIsbZi7rRLXJg0N5hALdqsDWiNA/MOWEF6148V4weDCeaKv137N6XYr5idP8BdglADb+lKU3Q34NjWu8D75o+oBiw/Dq6cofYdcjw4kwzu9hz/pUmCmt2bp8pDqcZ+huOF
X-MS-Exchange-AntiSpam-MessageData: LJ+ArEljP9ebrkypEqReg0D5aP3MYhImkxN9S+ydbappj5Av3Bfmee2eGVdEw/+IY2o5g5+isTkEaRI/5oVL4pEEUJ5ipK0KUddncLCBcWLQOk2chYhaL8FfiHNaI0N00ftRfZ9apOTTKCvN6pI2ig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46eac56-9227-49be-5d24-08d7a411482c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 16:44:03.0369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ3t1iGjkTxrZxFsslg8v5jNV6DfSgWf6p4V+ZPXW5a4ELQbFLYQUTlvJsaY+1D4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.85
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/28/20 10:27 AM, Igor Mammedov wrote:
> On Tue, 03 Dec 2019 18:37:35 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Introduce last level cache id(llc_id) in x86CPU topology.  This information is
>> required to build the topology in EPIC mode.
> can you add a reference to spec here so one could look for
> detailed information about this?

Yes. Will add it next series.
> 
>  
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/core/machine-hmp-cmds.c |    3 +++
>>  hw/core/machine.c          |   13 +++++++++++++
>>  hw/i386/pc.c               |   10 ++++++++++
>>  include/hw/i386/topology.h |    1 +
>>  qapi/machine.json          |    7 +++++--
>>  target/i386/cpu.c          |    2 ++
>>  target/i386/cpu.h          |    1 +
>>  7 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
>> index cd970cc4c5..59c91d1ce1 100644
>> --- a/hw/core/machine-hmp-cmds.c
>> +++ b/hw/core/machine-hmp-cmds.c
>> @@ -90,6 +90,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>>          if (c->has_die_id) {
>>              monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
>>          }
>> +        if (c->has_llc_id) {
>> +            monitor_printf(mon, "    llc-id: \"%" PRIu64 "\"\n", c->llc_id);
>> +        }
>>          if (c->has_core_id) {
>>              monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
>>          }
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index e59b181ead..ff991e6ab5 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -683,6 +683,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
>>              return;
>>          }
>>  
>> +        if (props->has_llc_id && !slot->props.has_llc_id) {
>> +            error_setg(errp, "llc-id is not supported");
>> +            return;
>> +        }
>> +
>>          /* skip slots with explicit mismatch */
>>          if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
>>                  continue;
>> @@ -696,6 +701,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
>>                  continue;
>>          }
>>  
>> +        if (props->has_llc_id && props->llc_id != slot->props.llc_id) {
>> +                continue;
>> +        }
>> +
>>          if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
>>                  continue;
>>          }
>> @@ -1034,6 +1043,10 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
>>      if (cpu->props.has_die_id) {
>>          g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
>>      }
>> +
>> +    if (cpu->props.has_llc_id) {
>> +        g_string_append_printf(s, "llc-id: %"PRId64, cpu->props.llc_id);
>> +    }
>>      if (cpu->props.has_core_id) {
>>          if (s->len) {
>>              g_string_append_printf(s, ", ");
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 17de152a77..df5339c102 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2294,6 +2294,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>  
>>          topo_ids.pkg_id = cpu->socket_id;
>>          topo_ids.die_id = cpu->die_id;
>> +        topo_ids.llc_id = cpu->llc_id;
>>          topo_ids.core_id = cpu->core_id;
>>          topo_ids.smt_id = cpu->thread_id;
>>          cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
>> @@ -2339,6 +2340,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>      }
>>      cpu->die_id = topo_ids.die_id;
>>  
>> +    if (cpu->llc_id != -1 && cpu->llc_id != topo_ids.llc_id) {
>> +        error_setg(errp, "property llc-id: %u doesn't match set apic-id:"
>> +            " 0x%x (llc-id: %u)", cpu->llc_id, cpu->apic_id, topo_ids.llc_id);
>> +        return;
>> +    }
>> +    cpu->llc_id = topo_ids.llc_id;
>> +
>>      if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
>>          error_setg(errp, "property core-id: %u doesn't match set apic-id:"
>>              " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo_ids.core_id);
>> @@ -2752,6 +2760,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>>              ms->possible_cpus->cpus[i].props.has_die_id = true;
>>              ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
>>          }
>> +        ms->possible_cpus->cpus[i].props.has_llc_id = true;
>> +        ms->possible_cpus->cpus[i].props.llc_id = topo_ids.llc_id;
>>          ms->possible_cpus->cpus[i].props.has_core_id = true;
>>          ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
>>          ms->possible_cpus->cpus[i].props.has_thread_id = true;
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index ba52d49079..1238006208 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -48,6 +48,7 @@ typedef uint32_t apic_id_t;
>>  typedef struct X86CPUTopoIDs {
>>      unsigned pkg_id;
>>      unsigned die_id;
>> +    unsigned llc_id;
>>      unsigned core_id;
>>      unsigned smt_id;
>>  } X86CPUTopoIDs;
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index ca26779f1a..1ca5b73418 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -646,9 +646,11 @@
>>  # @node-id: NUMA node ID the CPU belongs to
>>  # @socket-id: socket number within node/board the CPU belongs to
>>  # @die-id: die number within node/board the CPU belongs to (Since 4.1)
>> -# @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
>> +# @llc-id: last level cache number within node/board the CPU belongs to (Since 4.2)
>> +# @core-id: core number within die the CPU belongs to
>> +# @thread-id: thread number within core the CPU belongs to
>>  #
>> -# Note: currently there are 5 properties that could be present
>> +# Note: currently there are 6 properties that could be present
>>  # but management should be prepared to pass through other
>>  # properties with device_add command to allow for future
>>  # interface extension. This also requires the filed names to be kept in
>> @@ -660,6 +662,7 @@
>>    'data': { '*node-id': 'int',
>>              '*socket-id': 'int',
>>              '*die-id': 'int',
>> +            '*llc-id': 'int',
>>              '*core-id': 'int',
>>              '*thread-id': 'int'
>>    }
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index bc9b491557..3c81aa3ecd 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6222,12 +6222,14 @@ static Property x86_cpu_properties[] = {
>>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
>>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
>>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
>> +    DEFINE_PROP_INT32("llc-id", X86CPU, llc_id, 0),
>>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
>>  #else
>>      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
>>      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
>>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
>>      DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
>> +    DEFINE_PROP_INT32("llc-id", X86CPU, llc_id, -1),
>>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
>>  #endif
>>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index af57fda8e5..a56d44e405 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1711,6 +1711,7 @@ struct X86CPU {
>>      int32_t node_id; /* NUMA node this CPU belongs to */
>>      int32_t socket_id;
>>      int32_t die_id;
>> +    int32_t llc_id;
>>      int32_t core_id;
>>      int32_t thread_id;
>>  
>>
>>
> 

