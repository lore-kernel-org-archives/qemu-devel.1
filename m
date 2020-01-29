Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A80FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E71206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1kPPSrW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E71206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqGt-0003b7-FY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwqGA-00039z-PP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwqG8-00012u-RJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:32:10 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com
 ([40.107.237.62]:13792 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwqG8-00011u-Ct
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:32:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvzdeLj7hAdPnfRpNbvf43Jq91d1OxB/bvDUVK2GaiF3kYVj4xxK0CxLewQ2Zx7w//3V/Y7Iji7HuW0x9s2IjPcbmmtSfo41H2uakfLh/Bhd+jEDDZd7KNtwK6vGKhJrGRCuk1qQ0/3yRZ9+SkCkfgyl4eK3JgYmFpj3gVAdUTIjaPJf4r8WDNev/1PMpF+qZjDyh5bfiWwkUASJYdx885Zip++4GTLUt0Pls93gr1WnK0+sqkumwy/7XL4DMA/YHUpkT46sz3Fbladx+ISy41jbHQujUwQ4wClJX1q+A32J0tC1j2hfoQpgRuFIBmuqWAMOVMeoRd8uVhN2OjfU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg1i5kijNiO30sozbSrt7oQxZNBSp+jFBv+cpc/55JU=;
 b=kU3Y4XrXIl9zE4hk8YE8qkoep4O3t2WYKcF4zrIFVi/eNkiZVDCN9RnKzU1n+MykPQtONTNQPShdKplokkDf8ks9/xEGeuEZwVcBL/crspg00q2o7Wj87C+JYEXdZ8OtoMMRln0mC3NhWbysNhGDodQdaBlSvk9ginn0w56O8RtP2/4Ge0tFEAqSEEBIzlC7+VNj+j+Z9bqZcoJxRVMRY1BlsqP19RdqPfBBafqwZCQOfhN9TikcPc9wT/tGjAaluT65zWFTD4yjQ7tntIa4mOZLFotvFO6YKuiYoXGR4dSs2PIelXmDZw3KZPh9sMLz4Bq3/ZZ8o646tdmEdz2dZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg1i5kijNiO30sozbSrt7oQxZNBSp+jFBv+cpc/55JU=;
 b=1kPPSrW6zBRtlPD3hIf8+sh9qNWqoo82f4Rcyg+TzI1uf13jWS6rdh3UYVDIdJS61dQ/dOX08tCZIGuxZL6v0/evPGMd1tZVxUCVrlVw5dN0hIk6OpC8o9GzkPAQIXqCq09OBNiMNHpmLuIFiTXPd+dtpknNoqYPk7HnZehdo28=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1191.namprd12.prod.outlook.com (10.168.170.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 16:32:06 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 16:32:05 +0000
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
 <20200129101458.6a108431@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <49869aff-011a-9ab9-6aeb-09c8009b7eb6@amd.com>
Date: Wed, 29 Jan 2020 10:32:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200129101458.6a108431@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:405:15::17) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 BN6PR1701CA0007.namprd17.prod.outlook.com (2603:10b6:405:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend
 Transport; Wed, 29 Jan 2020 16:32:04 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c389b4c-63cf-4fa1-d192-08d7a4d8c727
X-MS-TrafficTypeDiagnostic: CY4PR12MB1191:
X-Microsoft-Antispam-PRVS: <CY4PR12MB11919B07E301E6AAC759C0DA95050@CY4PR12MB1191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(189003)(316002)(53546011)(16576012)(6666004)(52116002)(8676002)(66476007)(44832011)(2906002)(478600001)(66556008)(36756003)(6916009)(956004)(66946007)(2616005)(186003)(8936002)(81156014)(5660300002)(81166006)(26005)(31686004)(6486002)(31696002)(4326008)(86362001)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1191;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjIZwC4PtF4Psc5AL711aG2qOYp312eQAjcPZt1mGGiO83ssvexW8+H3T+FHRj9zee2IsedOVq72rZa61iBg2ti4Lwb4aUYTPiHrEjQdyWSJtsocumZZZ5x11ZZKVhmIYlTYRzMsA03MftEy8HLgR3mSNz5IJnV14pWZH3r2U09xZimeYVp4ehvKAvRVfQzgluMB3Zbt8/ZOvX3yPmiRiPiDXBegVXk49hRh9DFlWTUO00rZ7xDZ4cHIBthSf+Dzpte5oW207tP04dWlXSyiN9Ru9t541944xIiwdn+mFMUT+qtlTxgROzc3EdlOEDCde2cS6YH8n8vS2pppUI4tNhdxkx+740zYNhxLehDQsuTuyplSzClRDOHb4jeckUf/ncb0ZBUVGpA8UI5yy/R2YGsTFujGeEZMjXa9mM32ewV/rd9A1Igx+hU6fHUqHv0M
X-MS-Exchange-AntiSpam-MessageData: R1A1SdAEvFp8uPvjQ3MsQ38xn1TrB13QlUwVyG7GC6wlh+AsRiKpMUTBa4mar8G3966ExS6c8NAxAvZxAvl1OyeekAuFozu7aw57yNax8UvrKTL+r8I1jm/QSw1NGLAjYY1Hi2BPxdCjsAikBhV+6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c389b4c-63cf-4fa1-d192-08d7a4d8c727
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 16:32:05.9100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAqbRRvXig40FSKAouXStKLvaT8nRfyGyFpYWAq6lvmkn1hrKxuh34/VIuBB6FeF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1191
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.62
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



On 1/29/20 3:14 AM, Igor Mammedov wrote:
> On Tue, 28 Jan 2020 13:45:31 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> On 1/28/20 10:29 AM, Igor Mammedov wrote:
>>> On Tue, 03 Dec 2019 18:37:42 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>   
>>>> Add a new function init_apicid_fn in MachineClass to initialize the mode
>>>> specific handlers to decode the apic ids.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>  include/hw/boards.h |    1 +
>>>>  vl.c                |    3 +++
>>>>  2 files changed, 4 insertions(+)
>>>>
>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>> index d4fab218e6..ce5aa365cb 100644
>>>> --- a/include/hw/boards.h
>>>> +++ b/include/hw/boards.h
>>>> @@ -238,6 +238,7 @@ struct MachineClass {
>>>>                                                           unsigned cpu_index);
>>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>>>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>>>> +    void (*init_apicid_fn)(MachineState *ms);  
>>> it's x86 specific, so why it wasn put into PCMachineClass?  
>>
>> Yes. It is x86 specific for now. I tried to make it generic function so
>> other OSes can use it if required(like we have done in
>> possible_cpu_arch_ids). It initializes functions required to build the
>> apicid for each CPUs. We need these functions much early in the
>> initialization. It should be initialized before parse_numa_opts or
>> machine_run_board_init(in v1.c) which are called from generic context. We
>> cannot use PCMachineClass at this time.
> 
> could you point to specific patches in this series that require
> apic ids being initialized before parse_numa_opts and elaborate why?
> 
> we already have possible_cpu_arch_ids() which could be called very
> early and calculates APIC IDs in x86 case, so why not reuse it?

Forgot to respond to this. The possible_cpu_arch_ids does not use the numa
information to build the apic id. We cannot re-use it without changing it
drastically.

> 
>>
>>>
>>>   
>>>>  };
>>>>  
>>>>  /**
>>>> diff --git a/vl.c b/vl.c
>>>> index a42c24a77f..b6af604e11 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
>>>>      current_machine->cpu_type = machine_class->default_cpu_type;
>>>>      if (cpu_option) {
>>>>          current_machine->cpu_type = parse_cpu_option(cpu_option);
>>>> +        if (machine_class->init_apicid_fn) {
>>>> +            machine_class->init_apicid_fn(current_machine);
>>>> +        }
>>>>      }
>>>>      parse_numa_opts(current_machine);
>>>>  
>>>>
>>>>  
>>>   
>>
> 

