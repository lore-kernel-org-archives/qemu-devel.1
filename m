Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F48C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB40724658
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rPnR135M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB40724658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNiQ-0008Q9-5K
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBNhl-0007zw-BN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBNhk-0005cM-3W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:04:45 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com
 ([40.107.243.77]:4960 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBNhj-0005ba-QG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzy/4F+52VKOH29GIbSDPjBAfmBbLilXc6fCyzTPE/XC1V/fLgQdXan/VvINpc5yW+ZA70NXmQCxbYlXxrOl7Y9J7gAxI9am9kVWhN2Xc+fCtk9WDq8d+4Sf0A7uPryVakELi/S09lZmZsf0zzHm2T/SU1eEwX4zF3QHEWAXfC9rK+rELcUF6dXZiSLbZ3iDfZ0xDxwrbuAsE6jVFywjf9SDcP3UsR+fh7/hLML9aDqh8smqa8el7X3sIzy1WGtuQZzu/ZhOupolVe5P1eqPitvlpZYI/jYp+ahWvvaN0JXNO06cmAd5j+rZWhnpp4ubYl7BBKRplY0Alt420U3cNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UijQsqKHlk1lMK/hv2BvNHpclsRbznfA1RFZdPLHQBM=;
 b=cXJgsgsNJ5dMyJQAupPyB86Qdtw9Wcad6To3Dm0ylnuZSGYCPpeA+i3Aphga4IfIamP/srlBAcWmgXC6KnMYLmKA9m7wFeW4tFxIk1qGkTrw6jLDzFD3IyU8QtuwehAUx3xgPI9ccGsldJOvzpBiJkj1Cnqw8Thrn1dV1z/7S3DkgvCUyhdm2l+o9BCjdCQjb1qDqUQ9UmsU3r1t6sWA190p0cqhZbYkfU/e2YJ4NLa88S2z49bHSG0XCxuZMJ84wVral6/ebte0vo096Qu158sQsSuz6C9LXIfg7jYfOfqULpSmkSIZk4oIY4NDGbYco/0ns16+e54pbmVSfxd43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UijQsqKHlk1lMK/hv2BvNHpclsRbznfA1RFZdPLHQBM=;
 b=rPnR135M8k2GWgBi1JOM0qOqKep8bd/dajZ5w6i+7DMjvV7TZSaENZEkwfTY7ZHCTkkdbMTanbeVvArdNZD8U8frsuLPAdjn8tQUgCb8NyFog9Uojqvo81porYDy1g4DBnxcQeGgx9SVyhwHGpxWoIHR9xVYhiBVqgODnFIXevA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 19:04:42 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:04:41 +0000
Subject: Re: [PATCH v5 11/16] target/i386: Load apicid model specific handlers
 from X86CPUDefinition
To: Igor Mammedov <imammedo@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326548299.40452.4030040738160407065.stgit@naples-babu.amd.com>
 <20200309154922.6a523245@Igors-MacBook-Pro>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <f6fa5e13-3680-930f-2e0e-7651125ea309@amd.com>
Date: Mon, 9 Mar 2020 14:04:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200309154922.6a523245@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0401CA0007.namprd04.prod.outlook.com (2603:10b6:803:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Mon, 9 Mar 2020 19:04:40 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 131e6ad7-8728-4e07-917f-08d7c45cb8f9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-Microsoft-Antispam-PRVS: <SN1PR12MB254490AA241441FB225A851D95FE0@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(316002)(52116002)(26005)(31696002)(4326008)(36756003)(6486002)(16576012)(6916009)(44832011)(186003)(956004)(81156014)(2616005)(81166006)(8676002)(8936002)(16526019)(478600001)(53546011)(2906002)(66556008)(31686004)(5660300002)(66476007)(66946007)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2544;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wKIDd8w5dZ7YmXak8y86VRLNXbAcf1KJrDUO+ngQ6C0x/dhzlDynPibqSg73hDFVbPzUWZtGUqNEO1L5qk/rFbVyrhTvYt7lcqqKVQ6L0p30hNe8qQN3Qbk9/DVtZRMPmWYwK4gxdMb11ZGGoKGgypUkjGkTPdWSX4gJQG5bNxuhjLuBAIKuZiK+joLE7qEQJPI8726RrakEqAWCB4byUml3lH6BuwEgVijQ85vN8K9r0u+hWByCv3QvDPk5daqNqBmSv7MOvGk8NA8Z0MHDWLkjfWMBw1h7oQCoxzcwiyGjjvDO9hymKMYXZKgQ5QcrO/K/TRcLnz0C5WtO6ylJMagRx2/QjTKceISc82qYwmtrVLZV8qs/NSPzN6pc9ilwDHuJID8FKFFr5Iu+NCrkGyr7qzqmt4Y4q2KsXatYLRZfCY5Ccbefg5a3bSZ5Ico
X-MS-Exchange-AntiSpam-MessageData: KIdHPBK2gQMXhKJastbVan4sS2jfPl+kEQpOiAkiv8cgARu37NxnZv7v7xBzQl1HHcmLZNOLmg9fKOBoj733ujGs2hnhLf36Qc8QvqQ0Sa+cccdkUY7/jxtsyy093cDoU8nqOl3VyvuMpqLzEtRzvg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131e6ad7-8728-4e07-917f-08d7c45cb8f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:04:41.7502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AY8WmRWEl/4vHyksHAXbVN1EGfadunUThKMM2/33YPTWEsZq7kc0fgnWKQ2ErJ03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.77
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



On 3/9/20 9:49 AM, Igor Mammedov wrote:
> On Tue, 03 Mar 2020 13:58:03 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Load the model specific handlers if available or else default handlers
>> will be loaded. Add the model specific handlers if apicid decoding
>> differs from the standard sequential numbering.
>>
> 
> this is still the old version of the patch and hadn't addressed feedback from v4

Yes. I was confused little bit about it. Will fix it.

> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  target/i386/cpu.c |   34 ++++++++++++++++++++++++++++++++++
>>  target/i386/cpu.h |    1 +
>>  2 files changed, 35 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index c75cf744ab..f33d8b77f5 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -51,6 +51,7 @@
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/tcg.h"
>>  #include "hw/qdev-properties.h"
>> +#include "hw/i386/x86.h"
> this dependency shouldn't be here, see below

ok.

> 
>>  #include "hw/i386/topology.h"
>>  #ifndef CONFIG_USER_ONLY
>>  #include "exec/address-spaces.h"
> [...]
>> +void cpu_x86_init_apicid_fns(MachineState *machine)
> it should be something like:
>   x86_use_epyc_apic_id_encoding(char *cpu_type)
> try to avoid pulling in unnecessary dependency on Machine into cpu.c

Ok.

> 
>> +{
>> +    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(machine->cpu_type));
>> +    X86CPUModel *model = xcc->model;
>> +    X86CPUDefinition *def = model->cpudef;
>> +    X86MachineState *x86ms = X86_MACHINE(machine);
>> +
>> +    if (def) {
>> +        if (def->apicid_from_cpu_idx) {
>> +            x86ms->apicid_from_cpu_idx = def->apicid_from_cpu_idx;
>> +        }
>> +        if (def->topo_ids_from_apicid) {
>> +            x86ms->topo_ids_from_apicid = def->topo_ids_from_apicid;
>> +        }
>> +        if (def->apicid_from_topo_ids) {
>> +            x86ms->apicid_from_topo_ids = def->apicid_from_topo_ids;
>> +        }
>> +        if (def->apicid_pkg_offset) {
>> +            x86ms->apicid_pkg_offset = def->apicid_pkg_offset;
>> +        }
>> +    }
>> +}
> 
> It was suggested to move defaults initialization to x86_machine_class_init()

ok.  We don't need the above changes. I will use the boolean as you
suggested and call this function in x86_cpus_init() to initialize the EPYC
specific handler. Something similar like this below..

x86_use_epyc_apic_id_encoding(char *cpu_type)
{
      X86CPUClass *xcc = ... cpu_type ...
      return xcc->model->cpudef->use_epyc_apic_id_encoding
}

x86_cpus_init()
{
 if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
            x86ms->apicid_from_cpu_idx = ...epyc...
            x86ms->topo_ids_from_apicid = ...epyc...
            x86ms->apicid_from_topo_ids = ...epyc...
            x86ms->apicid_pkg_offset = ...epyc...
    }
}

Sounds right?

> 
> as was suggested at 
> [PATCH v4 12/16] hw/i386: Use the apicid handlers from X86MachineState
> and acked by Eduardo
> 
>> +
>>  static CPUCaches epyc_cache_info = {
>>      .l1d_cache = &(CPUCacheInfo) {
>>          .type = DATA_CACHE,
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 20abbda647..34f0d994ef 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1895,6 +1895,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
>>  void host_cpuid(uint32_t function, uint32_t count,
>>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>>  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
>> +void cpu_x86_init_apicid_fns(MachineState *machine);
>>  
>>  /* helper.c */
>>  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>
> 

