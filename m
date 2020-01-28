Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C37C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB612173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BRo5qn2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB612173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTxM-00029B-Nx
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwTwZ-0001i0-UE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwTwX-0006s4-KC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:42:27 -0500
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com
 ([40.107.93.73]:20449 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwTwX-0006rF-BH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:42:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2S3HTdTP7R8Jg1GmPaXvXIGDLTEPlbTrDYv53mmTRgf9OJICgv+yy9t0Zz/6BrQZmwd9sVbgAWFYwlUU4eBRGvPuufNfpSk1On2p6ZSiK5GQlo0NTgOYXxXFd50FtUkYDoeAUQ5gRO6MDiQ+kuldy0Ioecg9TfK3MsqISB+aUCPwWqjUVNFiXnqZGWEwoAcoW1NXtG4OQhQsbmQcnsY0U/rseM7EyGlLfv/XIH9iNjhmHxvUzZGmoOcZ9Lnei2dMcKbYGsgzNnFWouY4LoeSJm3CtVe0krLlebYdSDvPpSRgNw1X7AqA06FGxm4SAts+HbC7d5LhEIBCv1NQcEyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtwZyT2tAQiRIIqoMjpzr1/+gjPN4zC40TKat6QOZbQ=;
 b=Fc4T9CbaJuZ3QNiN4j5UETRfoOunkZmXMeKZPVtjoN5SmOROoETVArpHe9QaQsC5wSGglws4wfhLJ4Dol3ZwErSl4FhumQku3TV0R8uReFAgMDUVPnSML537XLXC4qPlXLHVSAkcRQlh23csJlPZ7Aj/UzDKwsExtI16zNoQ5BBAcnQx5PGEsOu4sz4dtCADPK6dsM7wxzxioheSe22NvAPZUb2/hHWnxKoHnjOy2WgYxcfEKVD05Bn6f+NZ0DXbthOlr9twviy47bjX9k5bR1ILlz4JVAVReL3F8LlrkSRRkpL8thbf635t7xa/C6R/seDn8KvXZ22yUQ+YJjRq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtwZyT2tAQiRIIqoMjpzr1/+gjPN4zC40TKat6QOZbQ=;
 b=BRo5qn2pdamENOjW4sJeZfx4YBWoDuZxoiZITBFd3rhvD1iSJUF3k31+r4TH0ZRnIuudA22yYxOb/WDlYW+cd1X6BWPsTwl+x5Ky5v5VBjjSmHusHxlIndiI8pgCk+RqZrrL2iEOMsARVfCnjW2siT90hG+QErvCA1if5oGARzo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 16:42:21 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 16:42:21 +0000
Subject: Re: [PATCH v3 04/18] hw/i386: Introduce initialize_topo_info to
 initialize X86CPUTopoInfo
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541984181.46157.12341489595513709747.stgit@naples-babu.amd.com>
 <20200128164958.6e97de19@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <0882dd16-9d2f-5a38-c599-5a47a90d9f55@amd.com>
Date: Tue, 28 Jan 2020 10:42:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200128164958.6e97de19@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:5:14c::30) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23 via Frontend Transport; Tue, 28 Jan 2020 16:42:20 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d698ab2-da6f-4539-4fe4-08d7a4110b69
X-MS-TrafficTypeDiagnostic: CY4PR12MB1653:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16533AAB1279F753433AE602950A0@CY4PR12MB1653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(16576012)(316002)(4326008)(478600001)(52116002)(31686004)(6916009)(2906002)(66556008)(186003)(6486002)(81166006)(81156014)(8676002)(36756003)(5660300002)(8936002)(53546011)(66946007)(2616005)(26005)(956004)(31696002)(16526019)(86362001)(44832011)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1653;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MftKvuHFiMFIDqB7LB3a+Xy7NIk44HNzKRjBkhC4p3cQsU4WubUr4qpe29CW3jUB8nxf1H8Cw1i9Zl/DzVdbkz1FZXfrC+ra3whVbfKarrUfXtFZR0jxbV4dBCATN56bbD/0PTrjqJfmVdS0YfyNBKXjl3tLCC/VtwLoiAf9NIZI9oybZU2hp3fyGBqeM1IBOYyIaglsNAHrG903MgkI4K9YxVIqvduCwvHIaLuagVdGEG6R+v1ZWBK8LXxEDpKvfzErrLpzuSHKKUeEp1mTZHVyONEeLzSTzVvdwHs3DrL5mL/jG4/06ko5Gi4DXK4QmaLDnAixGTy3PNskuSnIyIFIG+aopyRGuNzadqWsVCEvtHzubhoku4sIVRhd1Jp8a/wl7YCmNw9R+oVBgIZkzRjM7IJ5xDqozr4JJVEknCu97FWdL8qsMIhEg+5wMWG
X-MS-Exchange-AntiSpam-MessageData: kkmS3slV3PyJa72Hz8IwfcXoLnomPGtcoZENAZOhoj+5kCW3y65f+yQu2qJGMKRxqXGJOZ+26CWrSm2ClkmEVNDIWuafoRYHqbcwY9RTmAU+3guCrm+nJGc2kOCmgXo1bpr7F6aRii54qqmwhbxwDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d698ab2-da6f-4539-4fe4-08d7a4110b69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 16:42:21.0894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKZzzCDmvEjL/acAJsEZVl6GpfgKpupSH3bj7/1GwwC3m1AST30fe7v+PVuvbEx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.73
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

Igor,

On 1/28/20 9:49 AM, Igor Mammedov wrote:
> On Tue, 03 Dec 2019 18:37:21 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Initialize all the parameters in one function initialize_topo_info.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  hw/i386/pc.c |   28 +++++++++++++++-------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 8c23b1e8c9..cafbdafa76 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -866,6 +866,15 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>>      x86_cpu_set_a20(cpu, level);
>>  }
>>  
>> +static inline void initialize_topo_info(X86CPUTopoInfo *topo_info,
>> +                                        PCMachineState *pcms,
> 
> maybe use 'const'
> 
>> +                                        const MachineState *ms)
> 'ms' is the same thing as 'pcms', so why pass it around separately?
> 
> you can just do
>    MachineState *ms = MACHINE(pcms)
> inside of function

Yes. We can do that. Thanks

> 
>> +{
>> +    topo_info->dies_per_pkg = pcms->smp_dies;
>> +    topo_info->cores_per_die = ms->smp.cores;
>> +    topo_info->threads_per_core = ms->smp.threads;
>> +}
>> +
>>  /* Calculates initial APIC ID for a specific CPU index
>>   *
>>   * Currently we need to be able to calculate the APIC ID from the CPU index
>> @@ -882,9 +891,7 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
>>      uint32_t correct_id;
>>      static bool warned;
>>  
>> -    topo_info.dies_per_pkg = pcms->smp_dies;
>> -    topo_info.cores_per_die = ms->smp.cores;
>> -    topo_info.threads_per_core = ms->smp.threads;
>> +    initialize_topo_info(&topo_info, pcms, ms);
>>  
>>      correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>>      if (pcmc->compat_apic_id_mode) {
>> @@ -2231,9 +2238,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>          return;
>>      }
>>  
>> -    topo_info.dies_per_pkg = pcms->smp_dies;
>> -    topo_info.cores_per_die = smp_cores;
>> -    topo_info.threads_per_core = smp_threads;
>> +    initialize_topo_info(&topo_info, pcms, ms);
>>  
>>      env->nr_dies = pcms->smp_dies;
>>  
>> @@ -2702,9 +2707,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
>>     PCMachineState *pcms = PC_MACHINE(ms);
>>     X86CPUTopoInfo topo_info;
>>  
>> -   topo_info.dies_per_pkg = pcms->smp_dies;
>> -   topo_info.cores_per_die = ms->smp.cores;
>> -   topo_info.threads_per_core = ms->smp.threads;
>> +   initialize_topo_info(&topo_info, pcms, ms);
>>  
>>     assert(idx < ms->possible_cpus->len);
>>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>> @@ -2719,10 +2722,6 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>>      X86CPUTopoInfo topo_info;
>>      int i;
>>  
>> -    topo_info.dies_per_pkg = pcms->smp_dies;
>> -    topo_info.cores_per_die = ms->smp.cores;
>> -    topo_info.threads_per_core = ms->smp.threads;
>> -
>>      if (ms->possible_cpus) {
>>          /*
>>           * make sure that max_cpus hasn't changed since the first use, i.e.
>> @@ -2734,6 +2733,9 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>>  
>>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>>                                    sizeof(CPUArchId) * max_cpus);
>> +
>> +    initialize_topo_info(&topo_info, pcms, ms);
>> +
>>      ms->possible_cpus->len = max_cpus;
>>      for (i = 0; i < ms->possible_cpus->len; i++) {
>>          X86CPUTopoIDs topo_ids;
>>
> 

