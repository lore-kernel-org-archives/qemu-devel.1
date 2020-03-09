Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8612C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F132465A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vkmlevpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F132465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOAU-00059v-T5
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBO7q-0002lz-IA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBO7p-00075K-9c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:31:42 -0400
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com
 ([40.107.244.71]:19914 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBO7o-00073r-V8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:31:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYPmWoHADhDF89lBpa4DeyllG3s88ncJdjOKTHWi3+X7lxSOiCKipZV5MNMfIp/kJ9LJtA2FmkePX79bHDH1Too7MxAJFo8I3WdzhjEDh3HWUWNpz19ixmP+zwxZ3uUgjq22xLDIQHUJ8ldnb1cYBIFQqX/14tFonB/rmzSnkC/LPWXKQW7EnXoa6fraFRzUKFw7+V6Gjo6lBlv/v34TemJN4pCbt7HP8EcVnNRmFy7DLfUnC6S3639ggoN1526OdaEfKeFYijIQgmCylIvYKhYFP7w81mwwR1eEP8jEkaK5xnzQV7gJJzniQo+MCUDbkRhlqX22fIcQ2NkRX8Koxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl+EIHkb32oyI35tbO2yRW7tb43f3Dx3ujrmluFuAyQ=;
 b=ETHR6TNw9m1mr+m+5LdqY7N7vxeFJwstXeys+cKBXfb+WvBGBQKDvRCXvEYgpW8+swGhXRep2np8XjLjUKjhdaKK4rVVieR3CTzKPbLf6jSXZIyA37aZqEVvFHaVhRxja3eZ3RsxHjHq2pG+udE2at6Yxu7nKUtOaQGwiL3FCGuq3odBPbPKkQCMy5DTtp/+UhaUxG6d0oUNsMoFo0LMbRLw5cTGtKi/VjjEWBm/kWUk1bxz++Ww6gigjgfTtVhmjytyRhwFfG9NoW8n5PQG7P7z36tvBWmggxgmj0zrLcctLssU86+VUrlx/a0Fah1TXVPZ+clvtiEXdX3rXtIzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl+EIHkb32oyI35tbO2yRW7tb43f3Dx3ujrmluFuAyQ=;
 b=vkmlevpNsgP6vbQooUSumd4oAn49C+G+7k4YX831n2FWL9Ndt3sdOZjiKJac9qHHSSpQlST2u8JR32Oi2QhvZbO7RKaVvxBvL74KT3D80FYK01DRSRoWB7FpYUNCHDxILTocTHxJUEP62btprLF4Lu5fLRP2oHjG0oVInHHRlcI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 19:31:34 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:31:34 +0000
Subject: Re: [PATCH v5 14/16] hw/i386: Move arch_id decode inside x86_cpus_init
To: Igor Mammedov <imammedo@redhat.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326550403.40452.15934956681175349815.stgit@naples-babu.amd.com>
 <20200309162123.5ab6a750@Igors-MacBook-Pro>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <b008461c-d7c0-58f2-1c77-69a2fb5dae3e@amd.com>
Date: Mon, 9 Mar 2020 14:31:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200309162123.5ab6a750@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:4:16::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR2001CA0010.namprd20.prod.outlook.com (2603:10b6:4:16::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Mon, 9 Mar 2020 19:31:33 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92a00db9-6897-4712-2832-08d7c4607a0a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2528433EF1D32EF72AD9D19195FE0@SN1PR12MB2528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(2906002)(2616005)(316002)(4326008)(956004)(36756003)(52116002)(53546011)(16576012)(44832011)(6486002)(5660300002)(478600001)(6916009)(81166006)(81156014)(31696002)(66556008)(31686004)(66946007)(86362001)(8936002)(8676002)(186003)(66476007)(16526019)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2528;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wi1DNtGDzY2kCmWerA1bh8kTtOeSAa7KckgfXURku7VZ2E6BB2q7RONQ0ikwATjgySkeR7dJZtyD2CIZS0pju2mITKimXt5p54/zNy6KiVangolYlNSKb57M6fQybxwHzwFglc2BtktDb8fg9g34H/7eFGuXw3he0cqROE8a8aaEcTXRlbIg+jRtLFzEKO1tc6UWxI51lBt+3SjCC8iAkIYDu9LREtrlOlqMcPVOvGVZp24BqK+4rcBdeJ4BJaa0ZHmR98LVX7XWRDNr9Br2G95KODE9C9IX7aH+8hg6Iyt7yESqibsNOO0IRzfwrRVUFoa2gvTwePw8UyhaEjbTA2VzAdJmqFel1oD5rRRlBhI0TzJe2uZ/iRMjyJPoSfdzqyjEAKlmeIO1Z7J9PMm9cJnBTRx1S6cZgCKthrncVMZ4sumWfyoY+toY6BMXDqM/
X-MS-Exchange-AntiSpam-MessageData: Q3ZfhnsKxqP5XC3JLQSFx16cCCMoqd3qfn0oHNr9wLkMVV0Atv/l25Vf+n75j7I7z3rWPWh/EgXxnurbyyY2nU2CLK2ogQW0S1PtzDI/V2sviVG3HbcIhZRBP0hrGepvrlyt7IEKUWcfHztjc2yJ6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a00db9-6897-4712-2832-08d7c4607a0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:31:34.5331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeE5ri9ozSmhWjql8+upTuAAr1iMcqED3oqgbUusN1edaVU+atiN/ZXl/5Gvix8t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2528
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.71
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



On 3/9/20 10:21 AM, Igor Mammedov wrote:
> On Tue, 03 Mar 2020 13:58:24 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Apicid calculation depends on knowing the total number of numa nodes
>> for EPYC cpu models. Right now, we are calculating the arch_id while
>> parsing the numa(parse_numa). At this time, it is not known how many
>> total numa nodes are configured in the system.
>>
>> Move the arch_id inside x86_cpus_init. At this time smp parameter is already
>> completed and numa node information is available.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/x86.c |   17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index d46dd4ad9e..66998b065c 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -121,6 +121,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>      MachineState *ms = MACHINE(x86ms);
>>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>>  
>> +    /* Initialize apicid handlers first */
>> +    cpu_x86_init_apicid_fns(ms);
>> +
>>      x86_cpu_set_default_version(default_cpu_version);
>>  
>>      /*
>> @@ -134,6 +137,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
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
>> @@ -158,8 +167,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>>     init_topo_info(&topo_info, x86ms);
>>  
>>     assert(idx < ms->possible_cpus->len);
>> -   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>> -                               &topo_info, &topo_ids);
>> +   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
> not necessary if default x86ms->topo_ids_from_apicid were initialized from x86 machine class
> 
> I also wonder if this default contraption we have is going to work
> in case of EPYC cpu (i.e. is would generate valid nodeids).

From what I understand, we call this x86_get_default_cpu_node_id only when
the user does not specify the numa binding requirements. We tried to
generate the default node it for a given config. This works fine for EPYC
also. I am not sure about changing this right now. what do you think?

> 
> Bot instead of than trying to fix it if it's broken,
> I'd rather deprecate and drop get_default_cpu_node_id() requiring users
> to explicitly define CPU mapping to numa nodes.
> That would be consistent with req for explicit RAM for numa nodes
> (postponed till 5.1 due to libvirt not being ready),
> i.e if one wants numa, one should explicitly provide necessary mapping
> or machine won't start.
> 
> 
>>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>>  }
>>  
>> @@ -193,10 +201,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>  
>>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>> -        ms->possible_cpus->cpus[i].arch_id =
>> -            x86_cpu_apic_id_from_index(x86ms, i);
>> -        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>> -                                 &topo_info, &topo_ids);
>> +        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);
> ditto
> 
>>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>>          if (x86ms->smp_dies > 1) {
>>
> 

