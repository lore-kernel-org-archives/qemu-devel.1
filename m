Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0976FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78B9206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VNiX2LU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78B9206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1Z9-000704-2e
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jv1YK-00069Q-Jp
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:43:40 -0400
Received: from mail-eopbgr700064.outbound.protection.outlook.com
 ([40.107.70.64]:2528 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jv1YI-0005lr-CO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEJXC+cTZfojdG6Lz5LJEf41aueYavOTLHhGOZfLwxK9wYM4eSikwi9nA9BcXxNZkKiDH8nULIDf1dZLVoya6+Xtv9yzogm+ReGPdi9ov0xCmOF+1M+hbjHGRgWAi/Q1+N+q72kFTOU7xLcweq9NW06ZhQdAA4bO2GcBtCtJt9EqX7nKS+pIXzWLXR8RA7NG1gqxcCw+uKqhMLETm4sqReJBr85zK7iKbzS+wtERwBfn5h9PUsMZtEK5lVhCjcr52atZSfyICI06g+cYGECTSevkNWmUDEnBio1b7pf1nXWqMIpU9ETtIwBqpSxTmIdIGEu9eSeMHYArPY0Qm/JjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBgpaM/2X/fY9UwIl+Ip6ymcrTsMAOjEtgdFfVvtAd4=;
 b=a7sZ27rKw541219rkAsi0ymVpWFNfgoBoW7atjx9wjN+PqDwfmzBHs0y/N3bSz8znNs1kYodTpjRMjp5ZvMNLE89kMNEisZ3b9ywjze6jgOO5lP/6BDWQiP5x56R+z3fWx44PC3AqHFRq40wclwcq349sraLib0d/W9WxfWN71wQVrSMoyp9DF7YDCfQqffnKL1tDfVDDPznbAZvWzLGEUULKH31nh3aK1x1sDQM47vBkq5XG75CORPkBUvR+U0LYq6PHPn5HjHzrina8BEeHTcBksBK0I4NBWarqL8adJBVtDZnUYoN57crA5WEWRJ10h4Pf3vNgd9EI2pe1Spa9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBgpaM/2X/fY9UwIl+Ip6ymcrTsMAOjEtgdFfVvtAd4=;
 b=VNiX2LU5G8Ivk9I5vw9FJij0E7js/AYkcWZjNF64s5gKVRAUNpAgyYZEN/D/OV9gYCqalhoQgWjgU0L8GJGQ1/QDwjbJZ7g781FnAvOHoPTrM5jz0J3VFZfQXn/O4mu1DSGxPRN4RNlfGPYjgxWAy3dGqU4Q6+Y36fOz/uso4+A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2624.namprd12.prod.outlook.com (2603:10b6:805:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 16:43:34 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 16:43:34 +0000
Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
To: Igor Mammedov <imammedo@redhat.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
 <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
 <20200713181740.16a357a6@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <47dc6238-bb71-d679-f58a-f574eb36d572@amd.com>
Date: Mon, 13 Jul 2020 11:43:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200713181740.16a357a6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:805:ca::26) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 SN6PR16CA0049.namprd16.prod.outlook.com (2603:10b6:805:ca::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 16:43:34 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ead74472-7b7e-4fe3-479c-08d8274be259
X-MS-TrafficTypeDiagnostic: SN6PR12MB2624:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2624CBA5BC3FC2F7D238816195600@SN6PR12MB2624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGRM0ko4OiEN/UELM/9jNKu9aA9xW9wHvtHoaTfAfhTfhdiNbRut9EBumNLdol/TqqYMkZsVTfNFezqgyuU3/laI3Db781tKUXJehgBcp7RZFdEdigjxxfr/8JSeoGXdMsSXJUh42gF8eIWUXL/BBBl6NM85oguQgtrCEf2KbT0Pyffl9D2MCDVx52WfYL27SSd1BH0NiM7nccQaXsbpNt8A54y/O81tfb0usCPO8cJwec2tIrga/iGqfE5Lll+ObNRAyCPoC5VqcJmGtvf41D9HLzyEL5pUp3IiAegEivlAUpFrhMTmGez4LAftECneA6iArQfH8xEoKrRxOdXAQfbP3rYhzNgXacO5CImuvbGrkXVSiIakDplQdqVf9ltA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8936002)(4326008)(2906002)(36756003)(52116002)(53546011)(86362001)(6916009)(316002)(31696002)(44832011)(16576012)(66946007)(66556008)(66476007)(478600001)(2616005)(186003)(16526019)(54906003)(26005)(6486002)(956004)(8676002)(31686004)(83380400001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wZQK2e9rZ8sKyKGhPssHbGcAx8s9lnNV3yf+xp2wyltEOAn30RZloIvfE/VX1C3P+wOSy3jcgYxTS66qcFd7URCnv1mWRvbcI+tGWoTjrj8/wPoH1H/cvYh4zGOKO8giTCe1aM9gMG+N/qFPutqGTGlACUwR/EspUdiTkUT1RBOrc6ZbavSJEXt9n7D90R/OR1RbM2mIbO9uyspfTqMBvUv9jdYMXLBW5aZh+59r2OyE2HFeT43BcqyqYFKdtUPe21x5M+2C1mJYWf+6GYBJZIuNL6S6hS+HNn5IPlEpEB5x3GLyo7ruIN2ITiF2tibByJ46l0nR9HnunO1r32lM2KLbGJLV+IL1sCcsTrWPGxuNaWETX4JQPgk5FdkjToqAbOicTTLEvU4OR4BsuMoQ9SdP69GP/if6RilMO7bgDHQWNIrRYPRYSaa4ySqRoIS26SblIFPNf+dS4fYLiJ+QP2ZpppEiBR826JlNuKtOkFU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead74472-7b7e-4fe3-479c-08d8274be259
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 16:43:34.8376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuNPK+D9Guaikx8NqJbCMRw5CEXqjBmb5QP4r41q6vz/YMNP7lhWvikMmGEMmJ4r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2624
Received-SPF: none client-ip=40.107.70.64; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 12:43:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/13/20 11:17 AM, Igor Mammedov wrote:
> On Mon, 13 Jul 2020 10:02:22 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>>> -----Original Message-----
>>> From: Igor Mammedov <imammedo@redhat.com>
>>> Sent: Monday, July 13, 2020 4:08 AM
>>> To: Moger, Babu <Babu.Moger@amd.com>
>>> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
>>> devel@nongnu.org
>>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
>>> CpuInstanceProperties
> [...]
>>>> +
>>>> +/*
>>>> + * Initialize topo_ids from CpuInstanceProperties
>>>> + * node_id in CpuInstanceProperties(or in CPU device) is a sequential
>>>> + * number, but while building the topology  
>>>   
>>>> we need to separate it for
>>>> + * each socket(mod nodes_per_pkg).  
>>> could you clarify a bit more on why this is necessary?  
>>
>> If you have two sockets and 4 numa nodes, node_id in CpuInstanceProperties
>> will be number sequentially as 0, 1, 2, 3.  But in EPYC topology, it will
>> be  0, 1, 0, 1( Basically mod % number of nodes per socket).
> 
> I'm confused, let's suppose we have 2 EPYC sockets with 2 nodes per socket
> so APIC id woulbe be composed like:
> 
>  1st socket
>    pkg_id(0) | node_id(0)
>    pkg_id(0) | node_id(1)
> 
>  2nd socket
>    pkg_id(1) | node_id(0)
>    pkg_id(1) | node_id(1)
>   
> if that's the case, then EPYC's node_id here doesn't look like
> a NUMA node in the sense it's usually used
> (above config would have 4 different memory controllers => 4 conventional NUMA nodes).

EPIC model uses combination of socket id and node id to identify the numa
nodes. So, it internally uses all the information.

> 
> I wonder if linux guest actually uses node_id encoded in apic id for
> configuring/checking numa structures, or it just uses whatever ACPI SRAT
> table provided.
>  
>>>> + */
>>>> +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
>>>> +                                     CpuInstanceProperties props,
>>>> +                                     X86CPUTopoIDs *topo_ids) {
>>>> +    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
>>>> +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
>>>> +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
>>>> +    topo_ids->node_id = props.has_node_id ?
>>>> +                        props.node_id % MAX(topo_info->nodes_per_pkg, 1) : 0;
>>>> +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id : 0; }
>>>>  /*
>>>>   * Make APIC ID for the CPU 'cpu_index'
>>>>   *
>>>>  
>>
> 

