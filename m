Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E12C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47872071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HtcnZvPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47872071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqqc-0007J9-3q
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 12:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwqmC-0003CW-6R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwqmA-0003qr-V7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:05:16 -0500
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com
 ([40.107.92.56]:8844 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwqmA-0003mJ-KS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:05:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv+nm+DkxnJo0JzbUWS/C0UfFmZVmSJvAKadXi1nCPKZmDjVyAK0ZL5UV1bbrYhDbOQqtfzLhOe8DL8oLk8AqlD/rmet5YkNXyYIbwgu/XK8T5jLRfnM9Zu3MtrvpMjLs7bR2M5c+gP+YPQ+iBAqz84GcJqBNU8GA2vMXzs/O6kwKhe/0LYGisl5ENjb9aktgAO52wRM7A60adU8nmc2kyj1CxRXCRGeOE7PjmqBOZxbAV+HzRFPfMQbcUsZXdEUyslWwU8/cd3XRW4L4+LPYzzRk1OXf9talE6MQAd+zKbrO0cmBnmN+3hsAblV2OeyzsqDsDdMYy2l9tKiNUbUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJGJaA1x2iAQ3kWwdV0Ka8kk5ejKfYkmGvJrSRH2224=;
 b=B6rGgsy0W0HJ4ZkddiwqggTePbHcgsGhFD0wP91iHqm8unhkzlIEsM8t0+YWZTsVyF+k6WaMZt/4xEA7ZwDxjNq/wcwCItH+h+Qtf3Y/n7V2ND9Ft8cadCVMiNwf0gSfk0N5lHsTXCgos9H8Ae/0RoeBRxg8FUJ0//Zl9kiOw2yrBC/hJzURnublfHImkKZzjheXCBCk5yeRT6iMdHDCQauv2U+WZ05XTGa63U1rGa6tLW5Yc858z6+HW4J7oucsprsUjVnJK6DF2SNElkQrT/0ONRRl0YR9C5dEU7zRqFSR12af/vuFLInYdSfY8IgPrzqwNvFJjSKfSwZHyExQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJGJaA1x2iAQ3kWwdV0Ka8kk5ejKfYkmGvJrSRH2224=;
 b=HtcnZvPJJMA6z7HK7HRYcjTEEwqqLxP3tG77UmFIp0cot6iopFrcB/FJZ5OdqjqDJRRVn+y5Q2MydrNxbcvdGKGxeA3xB/SIt5CVD4ozwuf1bjtSkIK5VGufpk9N/NwkOjOi+CQ50RyXLuMhgaTEkX7p/5csi9HetMoR+C34LTQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1942.namprd12.prod.outlook.com (10.175.82.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 17:05:12 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 17:05:12 +0000
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
To: Eduardo Habkost <ehabkost@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
 <20200129101458.6a108431@redhat.com>
 <49869aff-011a-9ab9-6aeb-09c8009b7eb6@amd.com>
 <20200129165133.GR18770@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <f930f097-2b75-799a-f2cf-3aaa9164c798@amd.com>
Date: Wed, 29 Jan 2020 11:05:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200129165133.GR18770@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:404:f5::11) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 BN6PR16CA0001.namprd16.prod.outlook.com (2603:10b6:404:f5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Wed, 29 Jan 2020 17:05:10 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72c2f282-266a-45c0-67ab-08d7a4dd6706
X-MS-TrafficTypeDiagnostic: CY4PR12MB1942:
X-Microsoft-Antispam-PRVS: <CY4PR12MB19429A452C61EB9AA7CF0BDD95050@CY4PR12MB1942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(5660300002)(4326008)(31696002)(31686004)(36756003)(66946007)(81156014)(81166006)(66556008)(8676002)(66476007)(86362001)(6916009)(8936002)(6486002)(53546011)(478600001)(2906002)(44832011)(52116002)(956004)(2616005)(186003)(16526019)(26005)(16576012)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1942;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xbzz6SpQwtbB/CL6mynmG593SvTUUoKhgHkB9qiAUfDmpb5IWJWbfyc2aW1xRRawSl0q12lDtaV7KxgwEH7BNy5VYto5rXIg2RPixEvkTYUuPzX+0W1hCtKobSaSE/mq0uXcvfkioTkzxGygsIZv69jdnNZdCLnxtwqI+SAiNLmAKOa9P9+/IVLK84ucTh30gkMkK59rX1z9w1EpU98mtbwiQHfrpd09xR1JP/NhuhKIy2jGNGZzAwuOPCdbtU0Mtc6VX+VIGoM1aLkTAWhG9iAcjM0UxTpmL5ed0N4tAWU5etVzjT7cKm6A+u6nBX6WAhuCGdAAstvcoKSFFT4Gd4dSyFbM9cfMNNNG3U/MCT9MU9NeudBG5kULYuFvvW4MBs6/AxCFUpjblLmetyF+SwiUuDRDmeXOBhluyjGUOAA8m08dwif/KkxYa2Yub9tP
X-MS-Exchange-AntiSpam-MessageData: N5+5bLWGqSZ5gUB0CplLQiYUn2P4uWk7Jn1CJVHtWIuXFjzMfn0IKh6/cDadhs5brlHqT721MaENSHQLm4sYYXt1IsqyiIlvvm/7Rge3ooj4UrFDZPu3LPH5vla6TgyFrrKXqYMHVBAWApOXJK0dkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c2f282-266a-45c0-67ab-08d7a4dd6706
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 17:05:12.1174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQuhLuaaBLCx2s6Kp2+qbSFFHDqugm8pxZZoyk4NfMgnZjgRywvRsaxjmyrDlusT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1942
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.56
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
Cc: mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/29/20 10:51 AM, Eduardo Habkost wrote:
> On Wed, Jan 29, 2020 at 10:32:01AM -0600, Babu Moger wrote:
>>
>>
>> On 1/29/20 3:14 AM, Igor Mammedov wrote:
>>> On Tue, 28 Jan 2020 13:45:31 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>
>>>> On 1/28/20 10:29 AM, Igor Mammedov wrote:
>>>>> On Tue, 03 Dec 2019 18:37:42 -0600
>>>>> Babu Moger <babu.moger@amd.com> wrote:
>>>>>   
>>>>>> Add a new function init_apicid_fn in MachineClass to initialize the mode
>>>>>> specific handlers to decode the apic ids.
>>>>>>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> ---
>>>>>>  include/hw/boards.h |    1 +
>>>>>>  vl.c                |    3 +++
>>>>>>  2 files changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>>>> index d4fab218e6..ce5aa365cb 100644
>>>>>> --- a/include/hw/boards.h
>>>>>> +++ b/include/hw/boards.h
>>>>>> @@ -238,6 +238,7 @@ struct MachineClass {
>>>>>>                                                           unsigned cpu_index);
>>>>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>>>>>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>>>>>> +    void (*init_apicid_fn)(MachineState *ms);  
>>>>> it's x86 specific, so why it wasn put into PCMachineClass?  
>>>>
>>>> Yes. It is x86 specific for now. I tried to make it generic function so
>>>> other OSes can use it if required(like we have done in
>>>> possible_cpu_arch_ids). It initializes functions required to build the
>>>> apicid for each CPUs. We need these functions much early in the
>>>> initialization. It should be initialized before parse_numa_opts or
>>>> machine_run_board_init(in v1.c) which are called from generic context. We
>>>> cannot use PCMachineClass at this time.
>>>
>>> could you point to specific patches in this series that require
>>> apic ids being initialized before parse_numa_opts and elaborate why?
>>>
>>> we already have possible_cpu_arch_ids() which could be called very
>>> early and calculates APIC IDs in x86 case, so why not reuse it?
>>
>> Forgot to respond to this. The possible_cpu_arch_ids does not use the numa
>> information to build the apic id. We cannot re-use it without changing it
>> drastically.
> 
> I don't get it.  I see multiple patches in this series changing
> pc_possible_cpu_arch_ids() (which is really expected, if you are
> changing how APIC IDs are generated).
> 

My bad. I mispoke on that.I should have said the current decoding
logic(x86_apicid_from_cpu_idx, x86_topo_ids_from_apicid,
x86_apicid_from_topo_ids) cannot be used as is.

