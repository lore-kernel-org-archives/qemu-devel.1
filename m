Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A5C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E780521D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="upJUvEJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E780521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNmg-00018f-4P
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBNlv-0000ib-BL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBNlq-0008QJ-8t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:09:03 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com
 ([40.107.243.82]:6152 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBNlq-0008PV-2i
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:08:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7ML5bXOZkWyJuXkxxo6lOMks57mA23nCXbO9E4+SFYOf5+yyfDPB9RI6uk0xxWlePp2H6aa3hd1WnAsZNUWQWTYL4i02FHhRzxiTenXfeektcda5kfyrN8w9DbblAKk7wSlcdYdTzpxe/sHnSiWHf2WUf8AWxqMBDRkPQYZynyLnlhDadf7tfobnmpeus7B4+FgikwCDxGhbQj00VBZ1ESGwHUvxX1Y5Djd/sAmHxxaWB/qYqyql8OgPac91wCJ11ruAx3bQqnlY+XYmcQ0e6aRNGVyKfSLoKmoLEwmc7pAbIPAkOEgNyaAeK6tpmDw+X2GaT7DcaE4KkyftFd4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGvA3ltQ99Rjh+ry9ismNYbkxVXAvDgmTRcC/1zMysw=;
 b=OidTtiwgQwqnmv3HNOWYhzc7OlWxPYMv+eRZAFVOjVQuTcSbm9MbcrWN3Xnl10RWQ8K2Z49iPS7RGkbVuWxXEwiE5Kw0i69GS2mYZnhNtJ8lK881nuXOWe5CtrJ55dlvP2CNNCFKhG30bGjsLoi1pqcrVDFNvc0C5yKxiYtBvdF98I0qmaPny2fKaqjLE8z1ucF/LO7qoYIUWBVq+GJxe/3J7fG3SAXVS0M1WhsIdpUG6AY7YU6BpAjm/HXA2B4hK1n+IJOHfrFIhcF5RDf+d7+dyWdGi39Ftcxpsg7/7FOFQgEPkopUEpBatKFFmjE63dY+RDQp+IjFTCACHXRs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGvA3ltQ99Rjh+ry9ismNYbkxVXAvDgmTRcC/1zMysw=;
 b=upJUvEJLKov3/Ybyh4nnWbMGZkdlO/Hwf0JvY32HOGHDFeRUUYKujElH5Q+MTisFhinNBEqs/9HWcsX599+jdzJ3daLwzVSIeV6x4oOvHn8eHbIbKiffFJrK5Vv86Yai2tw0KGysn3Y3YC85z9w3xgd7WJlKey3yuzg8dZXoYX0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 19:08:55 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:08:55 +0000
Subject: Re: [PATCH v5 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
To: Igor Mammedov <imammedo@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326548999.40452.9247570542382737462.stgit@naples-babu.amd.com>
 <20200309160157.0509fa8d@Igors-MacBook-Pro>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <a7c44aaa-cc0f-68be-6183-5f6bfb6a3ec3@amd.com>
Date: Mon, 9 Mar 2020 14:08:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200309160157.0509fa8d@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:805:de::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN6PR05CA0007.namprd05.prod.outlook.com (2603:10b6:805:de::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.6 via Frontend Transport; Mon, 9 Mar 2020 19:08:54 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69d8b21e-ce28-4382-16c9-08d7c45d5020
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25442C2042421D1E771514A495FE0@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(2906002)(66556008)(66476007)(31686004)(5660300002)(16526019)(53546011)(478600001)(86362001)(66946007)(6486002)(36756003)(16576012)(316002)(52116002)(26005)(31696002)(4326008)(956004)(8676002)(81156014)(81166006)(2616005)(8936002)(44832011)(6916009)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2544;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93csmDgYZIAp5gg3DSUz8g6vyScfXNNa3vMk0h4MWFsrH3rNAGBPgeEyEX+lrso1gCQ0Qh7+IBYj/0WmhIjYJmcpvnJIa7q2AOHrMYTjqlIfDj3b0hfWVg6YsfOaWey0D9+fbgyAGa0TezC4WdNaOxFjLaUVPvVjTI/CqI6pPSuczegPrd/j1cF63CRVe3+JqXA/eZrjlcgr/AZcJJPnTxWc0zKcIBi5BRI1OzzCgVHc7L7zFWU8zSiP6xjUJgSwW0+7sjVsyowjbmtE7jgM8SvB2kUo3rVqJY5hOVNgiYqzUlk0nxFagBMnlP97I15R780yq1DVQo11HQoVaV52xZzjFb7zRPbXYs3ZYwImWiXNAFrVSHqtciA90VuvHeQoJafhVCwHgpMFXR4TTj46UqYCDQLGjPr0Kv11l89R4/jcYA3ZC4t9xpw1KGzwSIhM
X-MS-Exchange-AntiSpam-MessageData: R388zAfgzaVdBgTvwC0/QVkJuOL1K2Pj0QAQnYhgZvwg2B+RZn+wkleRIw53i55YkVDN18DbioruhgDFm0dSbZw1jXAGd1crZq4a4nf4Gko2yvTDnaIIRGXmYZHPFb1yO4Sdn+s7yFbewDX8WIJqxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d8b21e-ce28-4382-16c9-08d7c45d5020
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:08:55.2736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLB+Ge/n0CGwY+usSEBlliDrmAe5lySYxrJYj1uDorG3xsn3gqHvKyufDAZXafEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.82
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



On 3/9/20 10:01 AM, Igor Mammedov wrote:
> On Tue, 03 Mar 2020 13:58:10 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Check and Load the apicid handlers from X86CPUDefinition if available.
>> Update the calling convention for the apicid handlers.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> 
>> ---
>>  hw/i386/pc.c  |    6 +++---
>>  hw/i386/x86.c |   11 +++++++----
>>  2 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 17cce3f074..c600ba0432 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1581,14 +1581,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
> this (including other similar) change(s) to callbacks should go to 11/16

So, you mean patch #11 and #12 should be squashed together. Is that right?

> 
>>          error_setg(errp,
>>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>>              " APIC ID %" PRIu32 ", valid index range 0:%d",
>> @@ -1609,7 +1609,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
>>       * once -smp refactoring is complete and there will be CPU private
>>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
>> -    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>> +    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 15b7815bb0..d46dd4ad9e 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -86,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>>  
>>      init_topo_info(&topo_info, x86ms);
>>  
>> -    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>> +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
>>      if (x86mc->compat_apic_id_mode) {
>>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>>              error_report("APIC IDs set in compatibility mode, "
>> @@ -158,8 +158,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
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
>> @@ -179,6 +179,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>          return ms->possible_cpus;
>>      }
>>  
>> +    /* Initialize apicid handlers */
>> +    cpu_x86_init_apicid_fns(ms);
>> +
>>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>>                                    sizeof(CPUArchId) * max_cpus);
>>      ms->possible_cpus->len = max_cpus;
>> @@ -192,7 +195,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>>          ms->possible_cpus->cpus[i].arch_id =
>>              x86_cpu_apic_id_from_index(x86ms, i);
>> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>> +        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>>                                   &topo_info, &topo_ids);
> 
> not aligned properly
> 
>>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>>
> 

