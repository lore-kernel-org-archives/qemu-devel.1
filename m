Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96CCC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F0C20734
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UaDEMTza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F0C20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2k1-0000zq-Sv
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jC2j9-0000SW-PF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jC2j8-00024X-Mq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:52:55 -0400
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com
 ([40.107.244.80]:10836 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jC2j8-0001zO-Ex
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnw4Tp34TtRQFfPqcSuYwbYQ9wt9rlz+p6h5s0EHfA6VDc7Is3fBZ18KnsgqS1gDUtUxLYYLL3ktM9SgOkvhgrpU/HQYM4JfKZ7wR18B9DYyxer3K2S3Gn9s/4AREe7e3YDpRZ4UI/NDlhfEcOLeZ0+xhKgD3o+aQyRzbGNJtOZypnwCn7lbbUvMeRNFfLCHTp1I7NpablRk8awmDL7pAj09n0JdpcEIMIq4Xy9UgqGZ99SrGhgi5E9D8wxuHJkM90rgTJ0Nnd3TpLVn5+LhCR/MTG6rDwabRoE0Dn5p/4u0jMUNOiZEA2vdBc6nn5y6tWXM171VRTMztME+bnr6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//iPV1IRqFgOd5mZhnmxjShP6/H7FKhETmNYosSrC60=;
 b=Kij5TEs79Q0QlmPauNhI/zEVqGj+3vlRpPP0+EzU6iOI9DC9CcrciPFnIXxyKrw+lMDw2013hPqGyngOn3CF6iP9MJFQwKQgODcWqRTP6vgMQPkFPEZxmizR+YrCX5yVy+zsh2yHoYy67ak0D1FWa5PbM+AzpOGVLuMDgw9rAT0yi8JSqxdAXjSRWVh8NgAAxBW01eG+RQ08PCv/0tGJCUp9YinK9KKylKcUf4MFNkJmjDNoPcqUEiHxuctdYBylhnT9aeNL7GyVC4TqM45dU1hKGVpA0Hf70qsTz6mFNInnUzTRKgacSb69MgofiyYCmRWwG/iWKj2xHlf74NoL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//iPV1IRqFgOd5mZhnmxjShP6/H7FKhETmNYosSrC60=;
 b=UaDEMTzauN8CHaxou7EFtNoSezLsJs2dLNyJsISEYJcOmsVArUMSchitdNUAOXhT/gCdQqFarZ/1VpQatTO7Nl0n2QstM8Ns7voKz67OCYDk3sFNkjbbO1ANiJNwPBokWBIL22O9o9VYiB7DruDgxoUBA3qcKiudMOWgrfTTzUQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 11 Mar
 2020 14:52:52 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 14:52:52 +0000
Subject: Re: [PATCH v6 12/13] hw/i386: Move arch_id decode inside x86_cpus_init
To: Igor Mammedov <imammedo@redhat.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
 <158389407977.22020.8482854741622304295.stgit@naples-babu.amd.com>
 <20200311132930.6408bccc@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <d7ef4bbf-2d4e-bca4-5a21-7ab952af8591@amd.com>
Date: Wed, 11 Mar 2020 09:52:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200311132930.6408bccc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0012.namprd07.prod.outlook.com
 (2603:10b6:803:28::22) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0701CA0012.namprd07.prod.outlook.com (2603:10b6:803:28::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend
 Transport; Wed, 11 Mar 2020 14:52:51 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7272120c-e603-44f2-ae67-08d7c5cbdfa7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575E5402E151D20A47A763695FC0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(52116002)(5660300002)(8936002)(81166006)(31696002)(81156014)(44832011)(66946007)(86362001)(66476007)(66556008)(478600001)(8676002)(36756003)(31686004)(956004)(4326008)(316002)(16576012)(2616005)(2906002)(26005)(53546011)(6486002)(186003)(16526019)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDrbgQVtJBn+3ap5oTzcT3jJVhCHMxBjrwSmcUHYkVEszKDmE+GCcKFkR64MAzLxDTNjcnSySsGVJuMVtAHLkX+aK3ORr0UBQWaXoRpAM808qbYsxcdLJSPrgmRF0VB1/9JSIr59VfvgJrV11OHUFoD6oBHR8uDfVfAOfM/79h1j/7/7z0bLPKdreN5pnnTip38ocDN2xah67w4byQBy4tY7MYixgyfl1vmfOWm9HCcNr0zWZZk5isgHlAtJzUCCu2mgbYl/F4xBrLNMLEu4X6qJp5N/aU62UoDrgdHtqzXPqJc8wxQr9axwqCgwVJLkGLcMdZIwIci099EaD6y7R9gu4knjRhTimWDr0mcNed39JsTS07ZQsIUlTMRbXVmAd5cqtu87fOflWz1Lb4rvSyHIrGWsFaaDurJxiR4PliR7VEqHBrydelLrKCqgiejB
X-MS-Exchange-AntiSpam-MessageData: E3+VXjR9O24OvFW1LFshcTQwm39K5DVUw9U5kMb3Hz16ZndO9lvENNo+1kRgdreGNyrHIEbI4o3BPMYMbE2QxkI+pem7LUxT5yNM8sBxx41EOGvuqJq8kwkHCbT2D/QxClS0g5sZyku27C0aww/AUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7272120c-e603-44f2-ae67-08d7c5cbdfa7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 14:52:52.0234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsIGRpHz4/tAyc3iLQcafZKOJ2yrKrrT4z7dYR9i5yPpuJNdzyZwjTU7New5l0q0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.80
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



On 3/11/20 7:29 AM, Igor Mammedov wrote:
> On Tue, 10 Mar 2020 21:34:39 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Apicid calculation depends on knowing the total number of numa nodes
>> for EPYC cpu models. Right now, we are calculating the arch_id while
>> parsing the numa(parse_numa). At this time, it is not known how many
>> total numa nodes are configured in the system.
>>
>> Move the arch_id inside x86_cpus_init. At this time smp parse is already
>> completed and numa node information is available.
> 
> now it's correcting bug introduced by 10/13,
> which is fine but it leaves bisection broken
> 
> perhaps squash this patch in 10/13?

sure.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  hw/i386/x86.c |   17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index ad85347142..be93c1fd1b 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -140,6 +140,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>      MachineState *ms = MACHINE(x86ms);
>>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>>  
>> +    /* Check for apicid encoding */
>> +    x86_check_apic_id_encoding(ms);
>> +
>>      x86_cpu_set_default_version(default_cpu_version);
>>  
>>      /*
>> @@ -153,6 +156,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>      x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
>>                                                        ms->smp.max_cpus - 1) + 1;
>>      possible_cpus = mc->possible_cpu_arch_ids(ms);
>> +
>> +    for (i = 0; i < ms->smp.cpus; i++) {
>> +        ms->possible_cpus->cpus[i].arch_id =
>> +            x86_cpu_apic_id_from_index(x86ms, i);
>> +    }
>> +
>>      for (i = 0; i < ms->smp.cpus; i++) {
>>          x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
>>      }
>> @@ -177,8 +186,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>>     init_topo_info(&topo_info, x86ms);
>>  
>>     assert(idx < ms->possible_cpus->len);
>> -   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>> -                               &topo_info, &topo_ids);
>> +   x86ms->topo_ids_from_idx(&topo_info, idx, &topo_ids);
>>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>>  }
>>  
>> @@ -212,10 +220,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>  
>>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>> -        ms->possible_cpus->cpus[i].arch_id =
>> -            x86_cpu_apic_id_from_index(x86ms, i);
>> -        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>> -                                    &topo_info, &topo_ids);
>> +        x86ms->topo_ids_from_idx(&topo_info, i, &topo_ids);
>>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>>          if (x86ms->smp_dies > 1) {
>>
> 

