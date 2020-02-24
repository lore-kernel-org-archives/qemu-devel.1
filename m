Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108DFC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD2720836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T+Jv/kGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD2720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6I0P-0001NR-1S
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6Hzj-0000u6-9N
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6Hzh-00016f-Ld
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:58:15 -0500
Received: from mail-dm6nam10on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::617]:6171
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6Hzh-000156-BB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4tKnzZyBKZ4lTs1lHzxAI1h7Wvz69Y/KGPfF28Dcx0b3tzYvTxiN+IssOjRoXri5VWxosRflsDapwugQW5xi8xLZdXXg9E0yWWWzsiSjbnvHQjT/Ojc9AUJe1PluTZr17uxwOAZhU5zqnYb+WWqtqFSymZ2+dxLfIIJQzFoF4ocLmKDIfjU8utFHs6PrwaeEHfaEEd82cfYBFXuBXxOUY7MFdR6DvYEbdl2VE4aTvj0uoc1S1XzZvplqA+VK1B8AVdz8OP5iDWkjDt5nd1DfXF67gHjW2oW2aTMQYIPj39llgRiagnmXmZhxb/Tt/4g7nbY0QvUPcPsWEjP+HBSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsDPpSouubDD/swcD5uCfdV0iBq0elt1GQdFHjR6RSI=;
 b=GG+/AmVodWLP9MXy9ta7S40If82JcPzWkRWJQJgOJaM8AE5JsZb39aWJkQEfmGxa3FOuWJAXQLcc7SADIJj0VwKy2NJ8GPIWOzlVB26TSse+UdqXy39VO/3kWFVYC5MfpuEFkAtOCW4+gV6TcOwxzS4aTE3a04QHqd26Dk8bfw0nVAwYq7Q55yYKmcSSHaG7xqDCuxDY6VPDllPaJB7SmcOR1D6fVXpx0CEs3H5Obi/y1qxvC5HtOaJNhKwQE9PvcsMZUIIRGzDP7jGpNmwpkpL61A1kKzCN0lHn7lZ2Z3V7aiNb/78O9zVcblHYkaQyIsdtmZHpbDkKG7dNLlEcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsDPpSouubDD/swcD5uCfdV0iBq0elt1GQdFHjR6RSI=;
 b=T+Jv/kGHS3pTBpFh1gyTkzwGslXQiskDwoKaKckutpNvVALM147G8LlxkuhVOhZFlCbHttV0tK0elTOkDPAhFCSafgODlnJ/QeqOIv1zMO2np8qfuZVrB+xSalBTcacJecc3QkANQSdKi51gVE2HMDEqGAZlu9gpj3bR8awuGjc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2432.namprd12.prod.outlook.com (2603:10b6:802:29::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 17:58:10 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:58:10 +0000
Subject: Re: [PATCH v4 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
To: Igor Mammedov <imammedo@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
 <20200224181903.19790bad@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <1a7b1dae-9600-1d29-d4d4-4fdfb6832b6f@amd.com>
Date: Mon, 24 Feb 2020 11:58:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224181903.19790bad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:805:66::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:58:10 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25a5e777-bda6-420c-f855-08d7b9531c69
X-MS-TrafficTypeDiagnostic: SN1PR12MB2432:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2432638A59F14C99FF6F7DA195EC0@SN1PR12MB2432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(5660300002)(4326008)(81156014)(26005)(478600001)(31686004)(53546011)(6486002)(8676002)(6916009)(8936002)(81166006)(16526019)(86362001)(66946007)(52116002)(2616005)(956004)(44832011)(2906002)(16576012)(36756003)(316002)(66476007)(31696002)(186003)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2432;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/2hQzenz12WIqS4dBw6RBf1RC5BDpjw6/MOLP54QdCvNqutNMVajNDWDpX4GB46DpMEreRZTcdyfIcAqXH7qfxHz8BCLfpDLQhnQ5eDbm5GzCTmQFfQmUUL6d7QP166mEro+h9eHspEyZistRi7eu9eLlmrNb71JvvrUysD2+TlpmJMM7vwe5y1wyDPwTkfWTxXSlURlM3ha9c1tYR5ehfc5imuzfuCGOH7sQx2gnKVBtBrbhHfiaHZPJrx9wauZzJd4IyAFTlBGdBrUM+KinU1+6j7rKzHUlcKCXYNHJKm5qPgIYmP//3l/DurB90k3iuF4kBhIT2UuVSNe1HZpiSxbsQmC5MkVRniiuPLUp2QKWA/LaghCYFZc8PhqxtE+bdSK2PamZCrUwY/d9RaIqqPuNtzEJ6o6IO1JaWWr8P93N1xac+5KE1N298vUB1p
X-MS-Exchange-AntiSpam-MessageData: nWj6WG9eIBsz0pV4tPHj4aInBsu5tDbCVBMbwTVz4cl2RvrWYmECxsDdbLOSP7c5Potd7E4j8KVq1mYaIXionaVDN2QUHXRcpC1Vj+Sf0WQL4sV4byxaTQzUzvBjGzAfoJLz2LK4qiuZkvfwYRiqvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a5e777-bda6-420c-f855-08d7b9531c69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:58:10.7854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9lww7TAOn78rtVSnmop5+a6U4rAJp2LDAufX8F5ggmTWAPCEZo736/HFkaRbndA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2432
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e88::617
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/24/20 11:19 AM, Igor Mammedov wrote:
> On Thu, 13 Feb 2020 12:17:46 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Check and Load the apicid handlers from X86CPUDefinition if available.
>> Update the calling convention for the apicid handlers.
> 
> Previous and this patch look too complicated for the task at the hand.
> In particular, cpu_x86_init_apicid_fns() from previous patch adds 1 more
> reference to Machine into i386/cpu.c (even though it's just a helper function)
> and I think un-necessary hooks to X86CPUDefinition (it's not really CPU's
> businesses to make up APIC-IDs).
> 
> I'd rather do opposite and get rid of the last explicit dependency to
> ms->smp.cpus from cpu.c. But well, it's out of scope of this series,
> so for this series I'd just try to avoid adding more Machine dependencies.
> 
> All 11/16 does is basically using hooks as a switch "I'm EPYC" to
> set epyc specific encoding topo routines.
> 
> It could be accomplished by a simple Boolean flag like
>  X86CPUDefinition::use_epyc_apic_id_encoding
> 
> and then cpu_x86_init_apicid_fns() could be replaced with trivial
> helper like:
> 
>   x86_use_epyc_apic_id_encoding(char *cpu_type)
>   {
>       X86CPUClass *xcc = ... cpu_type ...
>       return xcc->model->cpudef->use_epyc_apic_id_encoding
>   }
> 
> then machine could override default[1] hooks using this helper
> as the trigger
>   x86_cpus_init()
>   {
>       // no need in dedicated function as it's the only instance it's going to be called ever
>       if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
>             x86ms->apicid_from_cpu_idx = ...epyc...
>             x86ms->topo_ids_from_apicid = ...epyc...
>             x86ms->apicid_from_topo_ids = ...epyc...
>             x86ms->apicid_pkg_offset = ...epyc...
>       }
>   }
> 
> That would be less invasive and won't create non necessary dependencies.

Yes. We can achieve the task here with your approach mentioned above. But,
we still will have a scaling issue. In future if a "new cpu model" comes
up its own decoding, then we need to add another bolean flag use_new
_cpu_apic_id_encoding. And then do that same check again. In that sense,
the current approach is bit generic. Lets also hear from Eduardo.

> 
> ---
> 1) defaults should be set in x86_machine_class_init()
> 
> Eduardo, what's your take on this?
> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/pc.c  |    6 +++---
>>  hw/i386/x86.c |   27 +++++++++++++++++++++++----
>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index be72a49716..93063af6a8 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1808,14 +1808,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>          topo_ids.die_id = cpu->die_id;
>>          topo_ids.core_id = cpu->core_id;
>>          topo_ids.smt_id = cpu->thread_id;
>> -        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
>> +        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
>>      }
>>  
>>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>>      if (!cpu_slot) {
>>          MachineState *ms = MACHINE(pcms);
>>  
>> -        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>> +        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>>          error_setg(errp,
>>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>>              " APIC ID %" PRIu32 ", valid index range 0:%d",
>> @@ -1836,7 +1836,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
>>       * once -smp refactoring is complete and there will be CPU private
>>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
>> -    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>> +    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 3d944f68e6..b825861b85 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -52,6 +52,22 @@
>>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>>  static size_t pvh_start_addr;
>>  
>> +/*
>> + * Check for apicid handlers in X86MachineState. Load them if
>> + * not loaded already. These handlers are loaded from X86CPUDefinition.
>> + */
>> +static void x86_check_apicid_handlers(MachineState *ms)
>> +{
>> +    X86MachineState *x86ms = X86_MACHINE(ms);
>> +
>> +    if (!x86ms->apicid_from_cpu_idx ||
>> +        !x86ms->topo_ids_from_apicid ||
>> +        !x86ms->apicid_from_topo_ids ||
>> +        !x86ms->apicid_pkg_offset) {
>> +        cpu_x86_init_apicid_fns(ms);
>> +    }
>> +}
>> +
>>  /*
>>   * Calculates initial APIC ID for a specific CPU index
>>   *
>> @@ -70,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>>  
>>      init_topo_info(&topo_info, x86ms);
>>  
>> -    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>> +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
>>      if (x86mc->compat_apic_id_mode) {
>>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>>              error_report("APIC IDs set in compatibility mode, "
>> @@ -148,8 +164,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>>     init_topo_info(&topo_info, x86ms);
>>  
>>     assert(idx < ms->possible_cpus->len);
>> -   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>> -                            &topo_info, &topo_ids);
>> +   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>> +                               &topo_info, &topo_ids);
>>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>>  }
>>  
>> @@ -169,6 +185,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>          return ms->possible_cpus;
>>      }
>>  
>> +    /* Initialize apicid handlers */
>> +    x86_check_apicid_handlers(ms);
>> +
>>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>>                                    sizeof(CPUArchId) * max_cpus);
>>      ms->possible_cpus->len = max_cpus;
>> @@ -182,7 +201,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>>          ms->possible_cpus->cpus[i].arch_id =
>>              x86_cpu_apic_id_from_index(x86ms, i);
>> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>> +        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>>                                   &topo_info, &topo_ids);
>>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>>
>>
> 

