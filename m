Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1BCC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CC820CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AYtq8Pmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CC820CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cO0-0000jY-6P
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6cLS-0004XN-OG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6cLR-0001H4-Ef
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:42:02 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com
 ([40.107.236.62]:61281 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6cLR-0001GI-5S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:42:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL0WcmXCCSFGhsRaSWA40M9v/8joY3tlVKqw93O0k7C+nAq7GBPtsGosF6vfCQbubKP62nnatPWN94Rkd7EdH3jDqFJYlrskluEm9uC52GAg0PQaZyiH6GbMPiwv3DPjsRhPpzNRC/Wmm28Mc+8n6vhL2nJ5BfdzlHJFra7somle7kZwJAYxqKs435HPTCduteoG/hJYNTEy2cU4qOVQ9e2B7mmP4UMUxKEE6p15ANvUncC1U9qhjVi4yr995RdqdcrpL421gM5nSbKhPmMGPiMNoeHVtclBc9jaU0yL6UgMXCC3lTHOTl3q79Bzrq4xHMvpTD5HtJHJHxiK4QkOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnlttMfsLEeQ0/rypyHzRpavS8YXrS8ZpzrdTmuEjmE=;
 b=BoUqenNjRLulTzEN0J75jsWepAQMgkraItPcuCOr8gq0JfW687JJ+jxet65B7LVAqM3YBXrWLRuSZS3k7xIs+UKJPQI9FzMqyBdzXtqIBCBa4wCrV3/T3jaiQC9dZQZoBxcb4Z/Y5zLSV4gORhKkLLEX4eu+YWPu5ekSFmW10drQJDcRx75lPBsOsNQoFp4yOvuWrlLlvzSEouDPHc5M/rm+Opoy23N40ETFOHwEt50wgNEVHmYdE3S4LFLgrKdQZ0a/5/7fpK+xF4H0ZfP3bMerLsryqDVBpglxqKvGz9jCX9jXo3kZ76nYy/VT1m+lv6NorFFJ4uC5+bfq9LDKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnlttMfsLEeQ0/rypyHzRpavS8YXrS8ZpzrdTmuEjmE=;
 b=AYtq8Pmm1n2+/VEuocEVEVNlmI9dofDd6uWqJFhH+zQB0Vqa6pPcLnKfYfn5T0F5tHNz8pPQzcdcAYkrEtDAyZ2UySlrJ/D4SzsfHdCg/9y5Vo9W/RX7d4zth/4Mxvypmweut+RQJLvNzv2SfDdztXXkemter2KQBtVIUgVj3mc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 15:41:59 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 15:41:59 +0000
Subject: Re: [PATCH v4 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
To: Eduardo Habkost <ehabkost@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
 <20200224181903.19790bad@redhat.com>
 <1a7b1dae-9600-1d29-d4d4-4fdfb6832b6f@amd.com>
 <20200224223149.GF4440@habkost.net>
 <5931c329-79ea-1f9c-5df7-db06d930a0e4@amd.com>
 <20200225153223.GJ4440@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <3cc2ef5d-55b1-f4a4-d657-2f3728107af4@amd.com>
Date: Tue, 25 Feb 2020 09:41:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200225153223.GJ4440@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:3:7b::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR13CA0029.namprd13.prod.outlook.com (2603:10b6:3:7b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.9 via Frontend Transport; Tue, 25 Feb 2020 15:41:57 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f0fa2b6-f209-4160-21db-08d7ba093fda
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2382C019F977DC63886EC7DC95ED0@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(81156014)(86362001)(81166006)(478600001)(186003)(8936002)(2616005)(52116002)(956004)(8676002)(31686004)(16526019)(44832011)(6916009)(53546011)(26005)(5660300002)(2906002)(16576012)(6486002)(4326008)(66946007)(31696002)(316002)(66556008)(36756003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2382;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sutcLpq0h4CCY85ixDAxgZvrZ7bK9mXUD3+sSA4F8s3WHKnCy9WwJHmKn4QoW2cBfI8tAjAUfQLhVcTHbLn+0ewfxRz8UADQPpDTnaVbG4ITmCIlbC6mNu8NwPamsT8eRlS624QO8B+/MX1y1rce3sI7FBAQHNgztyZRI02v40Q9Zz7PW0yvdecO3+AcuCJI88UK7hbibYJ6QitMo4yjz5VtKsFzKtDRo4DHMLKL6MZ5bCx67NCHegaBGsdtk3Hqn8PiLNN7VVIZd+r8ykIgM6Juyv+1A+63uPkI94qiFSDDfBuyVPm02cLfx5RMKHEbdQAJ7N8pzNEZsm7DxkDJr3RNP/ivKr85Kjm8FJNDlqXURmofMrhI0M9By53B3bWzQLKz+6ZvvZdu65hOWLBKvL7m3EFrX+Ze2oX2zlaXTH6HLmTfpw/jJaP4Z+uOE2xI
X-MS-Exchange-AntiSpam-MessageData: AWUrJwodxuA0d4SscObveViC60Gmk4CbQ6SB4zrt+8rgu9KubJtpIlT2ZSPv8RyqlCqmUplF9cBXIhHcWo7P2Rt8IdpDGn3qWrWFwY6YBAHh1A7VdXZ8dt53LCA4gDzyKiXE1m0qMgqz5BqIfy34AA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0fa2b6-f209-4160-21db-08d7ba093fda
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 15:41:59.3211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iC9RalGaVJyojeVUQcGUvJiwg1x/ylbaQBv5AQLA5dEb2dD1gDaWwLN37xnZFTPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.62
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/25/20 9:32 AM, Eduardo Habkost wrote:
> On Mon, Feb 24, 2020 at 05:13:18PM -0600, Babu Moger wrote:
>>
>>
>> On 2/24/20 4:31 PM, Eduardo Habkost wrote:
>>> On Mon, Feb 24, 2020 at 11:58:09AM -0600, Babu Moger wrote:
>>>>
>>>>
>>>> On 2/24/20 11:19 AM, Igor Mammedov wrote:
>>>>> On Thu, 13 Feb 2020 12:17:46 -0600
>>>>> Babu Moger <babu.moger@amd.com> wrote:
>>>>>
>>>>>> Check and Load the apicid handlers from X86CPUDefinition if available.
>>>>>> Update the calling convention for the apicid handlers.
>>>>>
>>>>> Previous and this patch look too complicated for the task at the hand.
>>>>> In particular, cpu_x86_init_apicid_fns() from previous patch adds 1 more
>>>>> reference to Machine into i386/cpu.c (even though it's just a helper function)
>>>>> and I think un-necessary hooks to X86CPUDefinition (it's not really CPU's
>>>>> businesses to make up APIC-IDs).
>>>>>
>>>>> I'd rather do opposite and get rid of the last explicit dependency to
>>>>> ms->smp.cpus from cpu.c. But well, it's out of scope of this series,
>>>>> so for this series I'd just try to avoid adding more Machine dependencies.
>>>>>
>>>>> All 11/16 does is basically using hooks as a switch "I'm EPYC" to
>>>>> set epyc specific encoding topo routines.
>>>>>
>>>>> It could be accomplished by a simple Boolean flag like
>>>>>  X86CPUDefinition::use_epyc_apic_id_encoding
>>>>>
>>>>> and then cpu_x86_init_apicid_fns() could be replaced with trivial
>>>>> helper like:
>>>>>
>>>>>   x86_use_epyc_apic_id_encoding(char *cpu_type)
>>>>>   {
>>>>>       X86CPUClass *xcc = ... cpu_type ...
>>>>>       return xcc->model->cpudef->use_epyc_apic_id_encoding
>>>>>   }
>>>>>
>>>>> then machine could override default[1] hooks using this helper
>>>>> as the trigger
>>>>>   x86_cpus_init()
>>>>>   {
>>>>>       // no need in dedicated function as it's the only instance it's going to be called ever
>>>>>       if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
>>>>>             x86ms->apicid_from_cpu_idx = ...epyc...
>>>>>             x86ms->topo_ids_from_apicid = ...epyc...
>>>>>             x86ms->apicid_from_topo_ids = ...epyc...
>>>>>             x86ms->apicid_pkg_offset = ...epyc...
>>>>>       }
>>>>>   }
>>>>>
>>>>> That would be less invasive and won't create non necessary dependencies.
>>>>
>>>> Yes. We can achieve the task here with your approach mentioned above. But,
>>>> we still will have a scaling issue. In future if a "new cpu model" comes
>>>> up its own decoding, then we need to add another bolean flag use_new
>>>> _cpu_apic_id_encoding. And then do that same check again. In that sense,
>>>> the current approach is bit generic. Lets also hear from Eduardo.
>>>
>>> To be honest, I really hope the number of APIC ID initialization
>>> variations won't grow in the future.
>>>
>>> In either case, X86MachineState really doesn't seem to be the
>>> right place to save the function pointers.  Whether we choose a
>>> boolean flag or a collection of function pointers, model-specific
>>> information belong to x86CPUClass and/or X86CPUDefinition, not
>>> MachineState.
>>
>> My bad. I completely missed that part. Yes. You mentioned that earlier.
>> I can move the functions pointers to X86CPUClass and initialize the
>> pointers from X86CPUDefinition. Thanks
> 
> See my reply to Igor before doing that.
> 
> Summary is: if the function implementations are provided by the
> CPU, the pointers belong to X86CPUClass.  If the APIC ID
> calculation logic lives in pc.c, the pointers probably can stay
> in X86MachineState.
> 
Ok. Sure. I will leave those pointers in X86MachineState.

