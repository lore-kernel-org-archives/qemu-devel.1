Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457FEC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DAE2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OOjr0KG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DAE2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygQK-00057J-84
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iygPQ-0004gK-TE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iygPP-0004bI-1C
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:25:20 -0500
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::623]:13024
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iygPO-0004SD-FD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:25:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DudgR8SE3Z7V7kaYTj19GLdhL7eR2wD8eESOjyZaEeDsU54OhrweMPxpc/G7WVFbBTstd64AQOiurTfLeILYqPjRXNSl/ryRG4u4wN10TPTScjtVhDHESwugEkNoWxjvcGbo9lV8UR4dz5uUj4R2BWJExFWlStaTESUsfWV+n4XjdjA8qn5GumBaqy557L/1HCePQKx/n45qvhCd9rso1Ef3nprxPcg3hu74u4ERZA4xi//MzMI940MCcuUMRGwBwMruQHOZzvHzka9qq7hSxXohh6n3wJ/IWFbvnQX1tSXHtIXxP2lQPNCsJGUf97LIKDfV7ePmJw1cWJXCp5B2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0OO3oHD00R9lXV3A5fd74ANSGtAMjRibGcmBhBqLuM=;
 b=jmgIpJXZJqRsj1odXpI4tSCiJ1W7imWOWYUWaDU+GPy3+wX0X66zSNeQDizy135KtAcxxufGaJTFZpJ9RoTGa1RGBLjOwy1IuWwl905hQOveiUTDcF9TEL3j/1RwkQOur23+2RV21Ozht4guF/332SHIL1c2L9oz64iL3abML1yqeGjc45hOdfHCNcdmzMvgeepXx7YGCMEfaAVPmhLdn8/DHch2TFBVPb7Kb5uOv2bm1pe41Xgt9GvYOLRynou8SrSUtKSbjXJrLQGDrprK7nXzMXYWwAn0afOhgjXBsTie2hQ16WvPeVtciJVmKAfSRXQYsvxvJutkld67xq7Kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0OO3oHD00R9lXV3A5fd74ANSGtAMjRibGcmBhBqLuM=;
 b=OOjr0KG3jFxOMXdsP0cMuO8BfKAPvxltcnRGPupDCCDtI+f+HZgbyd/0Fb+DXrgqbHwAlPbCLjIaGyT4wX4QVjBkBBH+wGZpvEaKFAeVR1zKsqrdDl/Mw4prTHGXDkeUnfzQyaA5fGMxd8L43mxqzW2lO2R1UK8VPkO22hgFR3w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1591.namprd12.prod.outlook.com (10.172.72.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 18:25:14 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 18:25:14 +0000
Subject: Re: [PATCH v3 01/18] hw/i386: Rename X86CPUTopoInfo structure to
 X86CPUTopoIDs
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541982144.46157.2428083754645928332.stgit@naples-babu.amd.com>
 <20200203160816.50d0409c@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <3ee9253b-a6a8-f243-9123-16bbe6bc903a@amd.com>
Date: Mon, 3 Feb 2020 12:25:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200203160816.50d0409c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:0:50::27) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:0:50::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Mon, 3 Feb 2020 18:25:13 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8443230-b1fe-45ab-6360-08d7a8d66970
X-MS-TrafficTypeDiagnostic: CY4PR12MB1591:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1591529FE0D55FBC5C6A2B8A95000@CY4PR12MB1591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:191;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(5660300002)(478600001)(66946007)(53546011)(16576012)(8936002)(316002)(31696002)(6916009)(66556008)(66476007)(30864003)(6486002)(31686004)(52116002)(2906002)(86362001)(956004)(44832011)(2616005)(8676002)(4326008)(16526019)(186003)(26005)(81156014)(81166006)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1591;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlZMusXMcCGeJpL1fGEtJUqzLf2bpDzBjX8ZyTvqlE/HrlxvESUy6vmQiIg3Z0ct1YkirR0TEPj18EjxsUfQoCYUVa7hNaP3Y5MuQ8Fqhbi92ovR9eg6K+lZO1+OFTjKpQfpfU1kKAjtmvyaiJUFbtr92a2OY7fc607tR2pLdDsiwPoSpqP1LBa3WSB7yLwLhVqMNbk5oVJ+vX13lT4LVA2dUtV2k7Z4BNhfCK0IEZefUWZ0chKjJiyseVOTXtXVPfbB8NQwq5S1Rb57j4Jqu5bPWuduBHKFQRMSr9cWqpy5m04tMEI/p/kYs5Pklm7Oj/OkJ7LHOnqwpI1yO/ObinXeRf6tG3ZvC/N2mDD+GmdERnm+i4jwFBF9NmhMImHTe/nOqoHvlXPTlVFWH1ufbLdVhryyhzFo1sYDCKWQUJjqoVeef48F0e1hC6CzNEU7
X-MS-Exchange-AntiSpam-MessageData: 4gZSgsswxmYIiwk3tstTTQ8hMZWq5BeGZ3ro//kBsjnugcMEc/4//GtdNy9KQIB4pIlxt4Lm0MjOSbC1OQRYVVTqujNxu15u4WLJJ1gsuT3N0SOqcE7eF2iCTwlkNIMVbSoNqoqUnJgw00yRjiHBuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8443230-b1fe-45ab-6360-08d7a8d66970
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 18:25:14.5693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45jke+qrELG6UJV1TUngMuSp1gP91fN8fgQWHa0xr4quyniD2qtacEqug5FduuDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7eaa::623
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



On 2/3/20 9:08 AM, Igor Mammedov wrote:
> On Tue, 03 Dec 2019 18:37:01 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Rename few data structures related to X86 topology.  X86CPUTopoIDs will
>> have individual arch ids. Next patch introduces X86CPUTopoInfo which will
>> have all topology information(like cores, threads etc..).
> 
> On what commit series was based on?
> (it doesn't apply to master anymore)

I used git://github.com/ehabkost/qemu.git (x86-next) to generate the
patches. It may be bit off right now.

> 
> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  hw/i386/pc.c               |   60 ++++++++++++++++++++++----------------------
>>  include/hw/i386/topology.h |   40 +++++++++++++++--------------
>>  2 files changed, 50 insertions(+), 50 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 51b72439b4..5bd2ffccb7 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2212,7 +2212,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>      int idx;
>>      CPUState *cs;
>>      CPUArchId *cpu_slot;
>> -    X86CPUTopoInfo topo;
>> +    X86CPUTopoIDs topo_ids;
>>      X86CPU *cpu = X86_CPU(dev);
>>      CPUX86State *env = &cpu->env;
>>      MachineState *ms = MACHINE(hotplug_dev);
>> @@ -2277,12 +2277,12 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>              return;
>>          }
>>  
>> -        topo.pkg_id = cpu->socket_id;
>> -        topo.die_id = cpu->die_id;
>> -        topo.core_id = cpu->core_id;
>> -        topo.smt_id = cpu->thread_id;
>> +        topo_ids.pkg_id = cpu->socket_id;
>> +        topo_ids.die_id = cpu->die_id;
>> +        topo_ids.core_id = cpu->core_id;
>> +        topo_ids.smt_id = cpu->thread_id;
>>          cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
>> -                                            smp_threads, &topo);
>> +                                            smp_threads, &topo_ids);
>>      }
>>  
>>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>> @@ -2290,11 +2290,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>          MachineState *ms = MACHINE(pcms);
>>  
>>          x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
>> -                                 smp_cores, smp_threads, &topo);
>> +                                 smp_cores, smp_threads, &topo_ids);
>>          error_setg(errp,
>>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>>              " APIC ID %" PRIu32 ", valid index range 0:%d",
>> -            topo.pkg_id, topo.die_id, topo.core_id, topo.smt_id,
>> +            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
>>              cpu->apic_id, ms->possible_cpus->len - 1);
>>          return;
>>      }
>> @@ -2312,34 +2312,34 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>       * once -smp refactoring is complete and there will be CPU private
>>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
>>      x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
>> -                             smp_cores, smp_threads, &topo);
>> -    if (cpu->socket_id != -1 && cpu->socket_id != topo.pkg_id) {
>> +                             smp_cores, smp_threads, &topo_ids);
>> +    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>> -            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo.pkg_id);
>> +            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
>>          return;
>>      }
>> -    cpu->socket_id = topo.pkg_id;
>> +    cpu->socket_id = topo_ids.pkg_id;
>>  
>> -    if (cpu->die_id != -1 && cpu->die_id != topo.die_id) {
>> +    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
>>          error_setg(errp, "property die-id: %u doesn't match set apic-id:"
>> -            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo.die_id);
>> +            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
>>          return;
>>      }
>> -    cpu->die_id = topo.die_id;
>> +    cpu->die_id = topo_ids.die_id;
>>  
>> -    if (cpu->core_id != -1 && cpu->core_id != topo.core_id) {
>> +    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
>>          error_setg(errp, "property core-id: %u doesn't match set apic-id:"
>> -            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo.core_id);
>> +            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo_ids.core_id);
>>          return;
>>      }
>> -    cpu->core_id = topo.core_id;
>> +    cpu->core_id = topo_ids.core_id;
>>  
>> -    if (cpu->thread_id != -1 && cpu->thread_id != topo.smt_id) {
>> +    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
>>          error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
>> -            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo.smt_id);
>> +            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo_ids.smt_id);
>>          return;
>>      }
>> -    cpu->thread_id = topo.smt_id;
>> +    cpu->thread_id = topo_ids.smt_id;
>>  
>>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
>>          !kvm_hv_vpindex_settable()) {
>> @@ -2692,14 +2692,14 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>>  
>>  static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>>  {
>> -   X86CPUTopoInfo topo;
>> +   X86CPUTopoIDs topo_ids;
>>     PCMachineState *pcms = PC_MACHINE(ms);
>>  
>>     assert(idx < ms->possible_cpus->len);
>>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>>                              pcms->smp_dies, ms->smp.cores,
>> -                            ms->smp.threads, &topo);
>> -   return topo.pkg_id % ms->numa_state->num_nodes;
>> +                            ms->smp.threads, &topo_ids);
>> +   return topo_ids.pkg_id % ms->numa_state->num_nodes;
>>  }
>>  
>>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>> @@ -2721,24 +2721,24 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>>                                    sizeof(CPUArchId) * max_cpus);
>>      ms->possible_cpus->len = max_cpus;
>>      for (i = 0; i < ms->possible_cpus->len; i++) {
>> -        X86CPUTopoInfo topo;
>> +        X86CPUTopoIDs topo_ids;
>>  
>>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>>          ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
>>          x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>>                                   pcms->smp_dies, ms->smp.cores,
>> -                                 ms->smp.threads, &topo);
>> +                                 ms->smp.threads, &topo_ids);
>>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>> -        ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
>> +        ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>>          if (pcms->smp_dies > 1) {
>>              ms->possible_cpus->cpus[i].props.has_die_id = true;
>> -            ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
>> +            ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
>>          }
>>          ms->possible_cpus->cpus[i].props.has_core_id = true;
>> -        ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
>> +        ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
>>          ms->possible_cpus->cpus[i].props.has_thread_id = true;
>> -        ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
>> +        ms->possible_cpus->cpus[i].props.thread_id = topo_ids.smt_id;
>>      }
>>      return ms->possible_cpus;
>>  }
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index 4ff5b2da6c..6c184f3115 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -45,12 +45,12 @@
>>   */
>>  typedef uint32_t apic_id_t;
>>  
>> -typedef struct X86CPUTopoInfo {
>> +typedef struct X86CPUTopoIDs {
>>      unsigned pkg_id;
>>      unsigned die_id;
>>      unsigned core_id;
>>      unsigned smt_id;
>> -} X86CPUTopoInfo;
>> +} X86CPUTopoIDs;
>>  
>>  /* Return the bit width needed for 'count' IDs
>>   */
>> @@ -122,12 +122,12 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
>>  static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
>>                                               unsigned nr_cores,
>>                                               unsigned nr_threads,
>> -                                             const X86CPUTopoInfo *topo)
>> +                                             const X86CPUTopoIDs *topo_ids)
>>  {
>> -    return (topo->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
>> -           (topo->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
>> -          (topo->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
>> -           topo->smt_id;
>> +    return (topo_ids->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
>> +           (topo_ids->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
>> +           (topo_ids->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
>> +           topo_ids->smt_id;
>>  }
>>  
>>  /* Calculate thread/core/package IDs for a specific topology,
>> @@ -137,12 +137,12 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
>>                                           unsigned nr_cores,
>>                                           unsigned nr_threads,
>>                                           unsigned cpu_index,
>> -                                         X86CPUTopoInfo *topo)
>> +                                         X86CPUTopoIDs *topo_ids)
>>  {
>> -    topo->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
>> -    topo->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>> -    topo->core_id = cpu_index / nr_threads % nr_cores;
>> -    topo->smt_id = cpu_index % nr_threads;
>> +    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
>> +    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>> +    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
>> +    topo_ids->smt_id = cpu_index % nr_threads;
>>  }
>>  
>>  /* Calculate thread/core/package IDs for a specific topology,
>> @@ -152,17 +152,17 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>>                                              unsigned nr_dies,
>>                                              unsigned nr_cores,
>>                                              unsigned nr_threads,
>> -                                            X86CPUTopoInfo *topo)
>> +                                            X86CPUTopoIDs *topo_ids)
>>  {
>> -    topo->smt_id = apicid &
>> +    topo_ids->smt_id = apicid &
>>              ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
>> -    topo->core_id =
>> +    topo_ids->core_id =
>>              (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) &
>>              ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_threads));
>> -    topo->die_id =
>> +    topo_ids->die_id =
>>              (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
>>              ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threads));
>> -    topo->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
>> +    topo_ids->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
>>  }
>>  
>>  /* Make APIC ID for the CPU 'cpu_index'
>> @@ -174,9 +174,9 @@ static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
>>                                                  unsigned nr_threads,
>>                                                  unsigned cpu_index)
>>  {
>> -    X86CPUTopoInfo topo;
>> -    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo);
>> -    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo);
>> +    X86CPUTopoIDs topo_ids;
>> +    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo_ids);
>> +    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo_ids);
>>  }
>>  
>>  #endif /* HW_I386_TOPOLOGY_H */
>>
>>
> 

