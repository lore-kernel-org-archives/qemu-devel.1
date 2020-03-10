Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF7C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF8C215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pkmYuGmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF8C215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBl98-00039y-24
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 16:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBl8L-0002js-7O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBl8J-0007aS-Vj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:05:45 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com
 ([40.107.220.47]:6196 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBl8J-0007Y1-Jb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDS6GgIBVbODPP6CNV2f3GKVXLXZ/hxp3A3ncE+nRYl1SehMYjQd5wMNrbYXUc+cBQTnNudnhlDfTq8f0UyWeVxS14QC03AtWl8Qi4PHEKEDOHa9Bn2fnaHqQ7U+EM8aMisJYHaP5GKIW1TFsk48ftSMUkgyEBR/xaC+wXt2RAc1bscjZCn82dKB1ydshSRw1J1qQDGE8Z3nz+UpDoBZpgBimM0szTtbW6Fu9up0tn/WJhZySwJbWkw9WxLZhERCfAh7FeNIbRxOj6OL6SWtKQJ+hht/08voEy7RqIcBb+/4AAhcrJWm9Vkr2WJsoVgbEdornLFelPM878koJcgqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/INpZQ28SoNCLeqUtRNVeco3IB/dnaTYaWkusou33U4=;
 b=gbnVuLWSWvvCdRjuAAYqlb07ZlX0kpXRCy3A0foYLcWOdkt/tGlEiQbdK8tWeEVG98zpVjxhX07H1pZcl9XlA1k44CH2JxS+/+e8XM8sMBS07B4n7hONf+2V+quPC6jSg3WpcONii3Nddir9iAtHO5LgGUF9FweQXehE0/kEjHkxB8XOKjNNKAHLyhr4Di2j3hiSBTyfdWwmeVjIMi/JIUz0M5th1eOP9ucB8XcQvTfItQGexek8QaETcoX6QJ/5Gw3BDO52AWKdssEH77nGn80+JT/k/DGeDLDsGbjvZCxaRtht+6r4pXOAf2wHckm7K1jur3NUUdr9o0tN54ZLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/INpZQ28SoNCLeqUtRNVeco3IB/dnaTYaWkusou33U4=;
 b=pkmYuGmFVQL0WcgKsiH4O+2WjSxlk2irMg3Pxcvq65GZ2FI4j4qBgzqcJIgNKvId3efdANn3t21Qlhdk68GoV7Z/XKwMWA25zhT8oCXXZi6sYqEHX2LtGlq4khWB8vHOkMu9cee/kfRB0eWpqOo//BQn0M+IrT3Q0PWUoNuAuoc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2527.namprd12.prod.outlook.com (2603:10b6:802:23::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 20:05:41 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:05:41 +0000
Subject: Re: [PATCH v5 14/16] hw/i386: Move arch_id decode inside x86_cpus_init
To: Igor Mammedov <imammedo@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326550403.40452.15934956681175349815.stgit@naples-babu.amd.com>
 <20200309162123.5ab6a750@Igors-MacBook-Pro>
 <b008461c-d7c0-58f2-1c77-69a2fb5dae3e@amd.com>
 <20200310093537.192f855f@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <da6e2cd9-1d12-d922-2377-82173b4a48b7@amd.com>
Date: Tue, 10 Mar 2020 15:05:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200310093537.192f855f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN4PR0501CA0128.namprd05.prod.outlook.com (2603:10b6:803:42::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.9 via Frontend
 Transport; Tue, 10 Mar 2020 20:05:40 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3acb4a9b-a76e-4eb0-9268-08d7c52e6864
X-MS-TrafficTypeDiagnostic: SN1PR12MB2527:
X-Microsoft-Antispam-PRVS: <SN1PR12MB252725D029F4239509A419DA95FF0@SN1PR12MB2527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(8936002)(52116002)(36756003)(478600001)(2906002)(26005)(956004)(31686004)(31696002)(2616005)(6486002)(16526019)(66556008)(8676002)(186003)(44832011)(53546011)(4326008)(81166006)(81156014)(66946007)(5660300002)(6916009)(316002)(66476007)(86362001)(16576012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2527;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DULQz/2qBK5GWyAvzXXtG0aneZhKf8w4iu9hJE0lpsXmRm+p9b4Af1Mk1rk8HM1Th7t0HWY/34EOWDpkR+hsVSSFW5Im9wX8XVaFfCUUFskKAYN5VJrRk1OxutRPC90thydQQsQU6RLM8qKLoZKgudJNzU6ncr2hVKHr5DcPqKatIOX5JH9saq8GxoPCnHLYZfDHw3z6MLz27P8bG2SBdJmlqVP8AHmgayPLebbtDvLg2AbacofWm3KD0NvcZMFwIRxWGtSNxcO752WJ+EAbJ0R8adfBF+juZliYHILAY+03Nj5FS3J+3T3HRKAdKLYWhwLL+i2H4U0sH8wGbqb41FtgLqdnw7hPTmkumvhk7i8WZLo7vPhI9W2NUpvwJLTKjyhFU2xphG/J8tjHp0gvv1fk47tiN/pX2yu/1QiJxvzlOzVIfQEGbOuuy8R8O+j
X-MS-Exchange-AntiSpam-MessageData: 8CLRtmV+Fl4sCzCUjg/acHNkRn+Sb+xRncxP408jJ7yMBFRek/2sxxc8JcF/IvgBzn1lMxjj19MrSnW/gkwm8pYEcypYCjRNXSqbY6YCqspy3ufXv+4MHNGkLF9mERVHKP0vhobL0c8IpVPQOYvaMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acb4a9b-a76e-4eb0-9268-08d7c52e6864
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:05:41.1530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2meCyCIZJZXy+RZBhGZ5l1NZ+2GInGI2C83i9pXs8wbbJDc4xapBpmsRx5le+wk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2527
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.47
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



On 3/10/20 3:35 AM, Igor Mammedov wrote:
> On Mon, 9 Mar 2020 14:31:31 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> On 3/9/20 10:21 AM, Igor Mammedov wrote:
>>> On Tue, 03 Mar 2020 13:58:24 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>   
>>>> Apicid calculation depends on knowing the total number of numa nodes
>>>> for EPYC cpu models. Right now, we are calculating the arch_id while
>>>> parsing the numa(parse_numa). At this time, it is not known how many
>>>> total numa nodes are configured in the system.
>>>>
>>>> Move the arch_id inside x86_cpus_init. At this time smp parameter is already
>>>> completed and numa node information is available.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>  hw/i386/x86.c |   17 +++++++++++------
>>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>>>> index d46dd4ad9e..66998b065c 100644
>>>> --- a/hw/i386/x86.c
>>>> +++ b/hw/i386/x86.c
>>>> @@ -121,6 +121,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>>>      MachineState *ms = MACHINE(x86ms);
>>>>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>>>>  
>>>> +    /* Initialize apicid handlers first */
>>>> +    cpu_x86_init_apicid_fns(ms);
>>>> +
>>>>      x86_cpu_set_default_version(default_cpu_version);
>>>>  
>>>>      /*
>>>> @@ -134,6 +137,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>>>      x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
>>>>                                                        ms->smp.max_cpus - 1) + 1;
>>>>      possible_cpus = mc->possible_cpu_arch_ids(ms);
>>>> +
>>>> +    for (i = 0; i < ms->smp.cpus; i++) {
>>>> +        ms->possible_cpus->cpus[i].arch_id =
>>>> +            x86_cpu_apic_id_from_index(x86ms, i);
>>>> +    }
>>>> +
>>>>      for (i = 0; i < ms->smp.cpus; i++) {
>>>>          x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
>>>>      }
>>>> @@ -158,8 +167,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>>>>     init_topo_info(&topo_info, x86ms);
>>>>  
>>>>     assert(idx < ms->possible_cpus->len);
>>>> -   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>>>> -                               &topo_info, &topo_ids);
>>>> +   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);  
>>> not necessary if default x86ms->topo_ids_from_apicid were initialized from x86 machine class
>>>
>>> I also wonder if this default contraption we have is going to work
>>> in case of EPYC cpu (i.e. is would generate valid nodeids).  
>>
>> From what I understand, we call this x86_get_default_cpu_node_id only when
>> the user does not specify the numa binding requirements. We tried to
>> generate the default node it for a given config. This works fine for EPYC
>> also. I am not sure about changing this right now. what do you think?
> 
> if it work for EPYC with default x86_topo_ids_from_idx() then it's fine.
> 
> Just keep callback here, given that callback is always initialized early (class_init)
> there is no point to create mix of callback/non-callback usage.

Ok. Done.
We did not have callback for x86_topo_ids_from_idx explicity. Now, I have
added this function as callback and using the callback here.

>  
>>>
>>> Bot instead of than trying to fix it if it's broken,
>>> I'd rather deprecate and drop get_default_cpu_node_id() requiring users
>>> to explicitly define CPU mapping to numa nodes.
>>> That would be consistent with req for explicit RAM for numa nodes
>>> (postponed till 5.1 due to libvirt not being ready),
>>> i.e if one wants numa, one should explicitly provide necessary mapping
>>> or machine won't start.
>>>
>>>   
>>>>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>>>>  }
>>>>  
>>>> @@ -193,10 +201,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>>>  
>>>>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>>>>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>>>> -        ms->possible_cpus->cpus[i].arch_id =
>>>> -            x86_cpu_apic_id_from_index(x86ms, i);
>>>> -        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>>>> -                                 &topo_info, &topo_ids);
>>>> +        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);  
>>> ditto
>>>   
>>>>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>>>>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>>>>          if (x86ms->smp_dies > 1) {
>>>>  
>>>   
>>
> 

