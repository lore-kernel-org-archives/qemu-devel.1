Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35879C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DB62078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pw7rrjpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DB62078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAzHc-00063I-6r
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kAzGf-0005JQ-Ut
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:31:25 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com
 ([40.107.220.46]:45505 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kAzGc-00084K-Dz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:31:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkjCq7/Lt4xg2VjDaK2f8ZE0xsmhFoLKpUuwXxlp38xI4aOldhsi/1aQ1J9mzLqjaXGr0y6cRVvk41Lr8sCDYEXXFU6kUUm6c6MHYnbyWtL/cC2Io+FVedRKqg2nEH+wxwQtiT2c8Ey7/ZIPFuJmWTHEFjsVXIug+k+4NNURf+kAp7RAtPVCD6OzS2LHcY17YtIlR7shsA1WFuWkq81ZG48KlHPDX2VrH+q07qgpUVhQ2j/4/UCFWiTb+JMhd6HdPB4d664tqX7BdEHcHVChAKXCMlvQZ+3VD9sm82Ij/Fq14YmM04VKzdzQc3zt9kXUn/K/QdhYmaQbgM9IIWcBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFlH7aLld4dBbPFFY39in2tTSMBfzoav7pH44nK481o=;
 b=cD/M+Xav8TS1cTwcs7DgMgy0tvfAGU5RIx/7ljsZBWKusxhh8+ijHTmv0Ff/8aqCwnHVDqLCI8HKbSztGRaILzmiBEzDQohkbuit/AxgLG+O7GZApmg7NIQJwBYz+UZbuJyx/m8wrnL162+Ek8DVAA+clKYNgbe40jJcvfiZ0YswGbRvtkIQEdqk+FMr19RiH2LNlawN8XoQfv/3LNqv4F7cWP2f02sWmyATPx241LK9VJh5MQZSz79cexnJ6oJ0Q0wwfg8zhE1KnDNajCHhbzFxfu1hSSEc0+nywqw9W3Qk4+PbdWMvElJ/aexlA9SeLDd04jh0ZSobRKo3YVZbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFlH7aLld4dBbPFFY39in2tTSMBfzoav7pH44nK481o=;
 b=pw7rrjpiwOMt9pBvd1yzVgb12LWt6iY0ZUHLSjosAsrgtJN6m2Av5zBDiF5ZsbG5bQH6Tg9CF35Ay0jTXWNqpfKKWEqsV/ddwd72ca1QJJwDTmmhHv8+7EmG5PmR932A8cxnokJX9/8ivDn1hAou/AOegqx6CU5qgmcPv8T+jIo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Wed, 26 Aug
 2020 17:31:17 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 17:31:17 +0000
Subject: Re: [PATCH v5 1/8] hw/i386: Remove node_id, nr_nodes and
 nodes_per_pkg from topology
To: Igor Mammedov <imammedo@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <159804794520.39954.435753698576266461.stgit@naples-babu.amd.com>
 <20200826115755.558f5ab0@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <c6ad9f8a-ef2c-3c73-1f70-76f43332e4a7@amd.com>
Date: Wed, 26 Aug 2020 12:31:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200826115755.558f5ab0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17)
 To SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 17:31:16 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acc5eaff-e0dc-4e8e-f8fa-08d849e5d68a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4543:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4543FAB3611FAD9AB49E77D195540@SA0PR12MB4543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/J0ppTDIPb33x3/5xax+YInrqku1f3ACeSClYU7uvOmGwHapr9+hNG4kCcHskC5dSptklzvpnk9XRk4NPdfDeHMbWUc9vyeEWRgW2yDDtW+kn3BSPwb3x2xXiVAoXCvuaalRc5IWpd0CrTNB7ZzxCYRqjgeWFmtK3dRNtk3WdtJEFu7UD1XpYBNQ4xkzGH+rPPJe8VMsfXp5Emw0o6swKDkJxQ+X/g51SsQfz1VJjuXc30x2b2uHgI6ZOjz0xo6brmhmcS1/w827FXSf01ssl0/oYZO85jxrOhC/sAfrl+FE7EbAO111oRmWaJofdm2oWZYGdWru6yGNxC9mGeau2+6WO1153DL2osEk17oW7QvsqCNzcY0Z3C3DXc4SWieELn22NSSOPyq6KT9enRbY+gMcKVOlFF0G4qcFjk8yozTr5hrHSMmMsVpgZ7DZNk3U6PqKOww9UpnOg8FLfw5qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(966005)(16576012)(86362001)(6916009)(6486002)(956004)(31696002)(186003)(2616005)(83380400001)(52116002)(36756003)(5660300002)(8676002)(2906002)(66946007)(316002)(478600001)(66476007)(66556008)(30864003)(44832011)(8936002)(31686004)(53546011)(26005)(4326008)(45080400002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nRq0TwDpjwqUc/n21bZmG4sahWfgvP3xkezLG9AyXSTr0mGnsTzR/PzTkLmVI9UwaFHNxKA3F21bFgiqya3MG6KWWJ0UwzGM53b7i+uhggtp53y5HWIWGYDe/T8xvb8g7F0ueL/UtUNVvziAwpH9rtF5q4MiJDwJDAVRPTwjUODlnjYG45YtOSZ79UW2Stog2hq2QmkqVCFwkA6wwkxw6AwY0UKYupgfxJ4VNg0oLOp3oGf4d6ZndlQBM+2p1lTsFv42O3c91/liLfBlZhWcg1dKXiU13TTpOrLg1AKz3J1oS+Hk9l5MP1y/GtgDwSa3zk7XKqJpr3umUga4qm6NCyrUILXyusGOyDTxNa59FEjnHFyY6Y4J/SK6iynqIRTDgPY7P/UfjT2Xf2/8oqXpDA91dilwlEEcxWoRhXuuFWSp4CYaD8bHR2PXim2/zhMyy6BPldCH885lxHPzT3w7ETkB8iVbIyTxLIQiwgCa977iIq84/t45VpyR+hoHKvJkbg2VXJ43Rxwb1xZEedDbQWDBRxxpkdK2i6/Mgsy4gqSqabFpPQ74zcBtlC75lUOFvQxQ1QG29UWTSAnhKHuqgCByXBKrO1ilLLw+7qmcjl7CFTMrXXeqHeXkDQ2Rx0IZQtB3lJyy9h5IlKy5fn31Ow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5eaff-e0dc-4e8e-f8fa-08d849e5d68a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 17:31:17.1543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oy+fT7GAyVGRw9LhTRg1RamLdb2KjnnOtZMsm0W/ZY6xmu4TOy7YECPUwJi8M9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
Received-SPF: none client-ip=40.107.220.46; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 13:31:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-2.239, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/26/20 4:57 AM, Igor Mammedov wrote:
> On Fri, 21 Aug 2020 17:12:25 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Remove node_id, nr_nodes and nodes_per_pkg from topology. Use
>> die_id, nr_dies and dies_per_pkg which is already available.
>> Removes the confusion over two variables.
>>
>> With node_id removed in topology the uninitialized memory issue
>> with -device and CPU hotplug will be fixed.
>>
> 
> it would be easier to review if you first put all reverts,
> and then this patch on top.

Ok. I will change it in next revision.

> 
> well, to actually avoid that request from others,
> I'd suggest just to do that to avoid issue with merging.
> 
> other than that patches 2-7/8 look good to me.

> 
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1828750&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C65d4a3950e1a4e88f3bb08d849a687c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637340326880983397&amp;sdata=PGZoE4AmYuFVELCuU81M3OaLewN3BlHpjszc4uCokr8%3D&amp;reserved=0
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/pc.c               |    1 -
>>  hw/i386/x86.c              |    1 -
>>  include/hw/i386/topology.h |   40 +++++++++-------------------------------
>>  target/i386/cpu.c          |   24 ++++++++++--------------
>>  target/i386/cpu.h          |    1 -
>>  tests/test-x86-cpuid.c     |   40 ++++++++++++++++++++--------------------
>>  6 files changed, 39 insertions(+), 68 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 47c5ca3e34..0ae5cb3af4 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1498,7 +1498,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>      init_topo_info(&topo_info, x86ms);
>>  
>>      env->nr_dies = x86ms->smp_dies;
>> -    env->nr_nodes = topo_info.nodes_per_pkg;
>>      env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
>>  
>>      /*
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 67bee1bcb8..f6eab947df 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -62,7 +62,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>>  {
>>      MachineState *ms = MACHINE(x86ms);
>>  
>> -    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
>>      topo_info->dies_per_pkg = x86ms->smp_dies;
>>      topo_info->cores_per_die = ms->smp.cores;
>>      topo_info->threads_per_core = ms->smp.threads;
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index 07239f95f4..05ddde7ba0 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -47,14 +47,12 @@ typedef uint32_t apic_id_t;
>>  
>>  typedef struct X86CPUTopoIDs {
>>      unsigned pkg_id;
>> -    unsigned node_id;
>>      unsigned die_id;
>>      unsigned core_id;
>>      unsigned smt_id;
>>  } X86CPUTopoIDs;
>>  
>>  typedef struct X86CPUTopoInfo {
>> -    unsigned nodes_per_pkg;
>>      unsigned dies_per_pkg;
>>      unsigned cores_per_die;
>>      unsigned threads_per_core;
>> @@ -89,11 +87,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
>>      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
>>  }
>>  
>> -/* Bit width of the node_id field per socket */
>> -static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
>> -{
>> -    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
>> -}
>>  /* Bit offset of the Core_ID field
>>   */
>>  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
>> @@ -114,30 +107,23 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>>  }
>>  
>> -#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
>> +#define EPYC_DIE_OFFSET 3 /* Minimum die_id offset if numa configured */
>>  
>>  /*
>> - * Bit offset of the node_id field
>> - *
>> - * Make sure nodes_per_pkg >  0 if numa configured else zero.
>> + * Bit offset of the die_id field
>>   */
>> -static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
>> +static inline unsigned apicid_die_offset_epyc(X86CPUTopoInfo *topo_info)
>>  {
>> -    unsigned offset = apicid_die_offset(topo_info) +
>> -                      apicid_die_width(topo_info);
>> +    unsigned offset = apicid_core_offset(topo_info) +
>> +                      apicid_core_width(topo_info);
>>  
>> -    if (topo_info->nodes_per_pkg) {
>> -        return MAX(NODE_ID_OFFSET, offset);
>> -    } else {
>> -        return offset;
>> -    }
>> +    return MAX(EPYC_DIE_OFFSET, offset);
>>  }
>>  
>>  /* Bit offset of the Pkg_ID (socket ID) field */
>>  static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
>>  {
>> -    return apicid_node_offset_epyc(topo_info) +
>> -           apicid_node_width_epyc(topo_info);
>> +    return apicid_die_offset_epyc(topo_info) + apicid_die_width(topo_info);
>>  }
>>  
>>  /*
>> @@ -150,8 +136,7 @@ x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>>                                const X86CPUTopoIDs *topo_ids)
>>  {
>>      return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
>> -           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
>> -           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
>> +           (topo_ids->die_id  << apicid_die_offset_epyc(topo_info)) |
>>             (topo_ids->core_id << apicid_core_offset(topo_info)) |
>>             topo_ids->smt_id;
>>  }
>> @@ -160,15 +145,11 @@ static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
>>                                                unsigned cpu_index,
>>                                                X86CPUTopoIDs *topo_ids)
>>  {
>> -    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
>>      unsigned nr_dies = topo_info->dies_per_pkg;
>>      unsigned nr_cores = topo_info->cores_per_die;
>>      unsigned nr_threads = topo_info->threads_per_core;
>> -    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
>> -                                            nr_nodes);
>>  
>>      topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
>> -    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
>>      topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>>      topo_ids->core_id = cpu_index / nr_threads % nr_cores;
>>      topo_ids->smt_id = cpu_index % nr_threads;
>> @@ -188,11 +169,8 @@ static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
>>              (apicid >> apicid_core_offset(topo_info)) &
>>              ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
>>      topo_ids->die_id =
>> -            (apicid >> apicid_die_offset(topo_info)) &
>> +            (apicid >> apicid_die_offset_epyc(topo_info)) &
>>              ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
>> -    topo_ids->node_id =
>> -            (apicid >> apicid_node_offset_epyc(topo_info)) &
>> -            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
>>      topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
>>  }
>>  
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 588f32e136..3c58af1f43 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -345,7 +345,6 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>                                         uint32_t *ecx, uint32_t *edx)
>>  {
>>      uint32_t l3_cores;
>> -    unsigned nodes = MAX(topo_info->nodes_per_pkg, 1);
>>  
>>      assert(cache->size == cache->line_size * cache->associativity *
>>                            cache->partitions * cache->sets);
>> @@ -355,10 +354,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>  
>>      /* L3 is shared among multiple cores */
>>      if (cache->level == 3) {
>> -        l3_cores = DIV_ROUND_UP((topo_info->dies_per_pkg *
>> -                                 topo_info->cores_per_die *
>> +        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
>>                                   topo_info->threads_per_core),
>> -                                 nodes);
>> +                                 topo_info->dies_per_pkg);
>>          *eax |= (l3_cores - 1) << 14;
>>      } else {
>>          *eax |= ((topo_info->threads_per_core - 1) << 14);
>> @@ -387,7 +385,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>                                         uint32_t *ecx, uint32_t *edx)
>>  {
>>      X86CPUTopoIDs topo_ids = {0};
>> -    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
>> +    unsigned long dies = topo_info->dies_per_pkg;
>>      int shift;
>>  
>>      x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
>> @@ -408,7 +406,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>       *             3 Core complex id
>>       *           1:0 Core id
>>       */
>> -    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id << 3) |
>> +    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.die_id << 3) |
>>              (topo_ids.core_id);
>>      /*
>>       * CPUID_Fn8000001E_ECX
>> @@ -418,8 +416,8 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>       *         2  Socket id
>>       *       1:0  Node id
>>       */
>> -    if (nodes <= 4) {
>> -        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
>> +    if (dies <= 4) {
>> +        *ecx = ((dies - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.die_id;
>>      } else {
>>          /*
>>           * Node id fix up. Actual hardware supports up to 4 nodes. But with
>> @@ -434,10 +432,10 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>           * number of nodes. find_last_bit returns last set bit(0 based). Left
>>           * shift(+1) the socket id to represent all the nodes.
>>           */
>> -        nodes -= 1;
>> -        shift = find_last_bit(&nodes, 8);
>> -        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
>> -               topo_ids.node_id;
>> +        dies -= 1;
>> +        shift = find_last_bit(&dies, 8);
>> +        *ecx = (dies << 8) | (topo_ids.pkg_id << (shift + 1)) |
>> +               topo_ids.die_id;
>>      }
>>      *edx = 0;
>>  }
>> @@ -5489,7 +5487,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>      uint32_t signature[3];
>>      X86CPUTopoInfo topo_info;
>>  
>> -    topo_info.nodes_per_pkg = env->nr_nodes;
>>      topo_info.dies_per_pkg = env->nr_dies;
>>      topo_info.cores_per_die = cs->nr_cores;
>>      topo_info.threads_per_core = cs->nr_threads;
>> @@ -6949,7 +6946,6 @@ static void x86_cpu_initfn(Object *obj)
>>      FeatureWord w;
>>  
>>      env->nr_dies = 1;
>> -    env->nr_nodes = 1;
>>      cpu_set_cpustate_pointers(cpu);
>>  
>>      object_property_add(obj, "family", "int",
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index e1a5c174dc..4c89bee8d1 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
>>      TPRAccess tpr_access_type;
>>  
>>      unsigned nr_dies;
>> -    unsigned nr_nodes;
>>      unsigned pkg_offset;
>>  } CPUX86State;
>>  
>> diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
>> index 049030a50e..bfabc0403a 100644
>> --- a/tests/test-x86-cpuid.c
>> +++ b/tests/test-x86-cpuid.c
>> @@ -31,12 +31,12 @@ static void test_topo_bits(void)
>>      X86CPUTopoInfo topo_info = {0};
>>  
>>      /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 1};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
>>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
>>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
>>  
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 1};
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
>> @@ -45,39 +45,39 @@ static void test_topo_bits(void)
>>  
>>      /* Test field width calculation for multiple values
>>       */
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 2};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 2};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 3};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 3};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 4};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 4};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>>  
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 14};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 14};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 15};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 15};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 16};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 16};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 17};
>> +    topo_info = (X86CPUTopoInfo) {1, 1, 17};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
>>  
>>  
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
>> +    topo_info = (X86CPUTopoInfo) {1, 30, 2};
>>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 31, 2};
>> +    topo_info = (X86CPUTopoInfo) {1, 31, 2};
>>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 32, 2};
>> +    topo_info = (X86CPUTopoInfo) {1, 32, 2};
>>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 33, 2};
>> +    topo_info = (X86CPUTopoInfo) {1, 33, 2};
>>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
>>  
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
>> +    topo_info = (X86CPUTopoInfo) {1, 30, 2};
>>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
>> -    topo_info = (X86CPUTopoInfo) {0, 2, 30, 2};
>> +    topo_info = (X86CPUTopoInfo) {2, 30, 2};
>>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
>> -    topo_info = (X86CPUTopoInfo) {0, 3, 30, 2};
>> +    topo_info = (X86CPUTopoInfo) {3, 30, 2};
>>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
>> -    topo_info = (X86CPUTopoInfo) {0, 4, 30, 2};
>> +    topo_info = (X86CPUTopoInfo) {4, 30, 2};
>>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
>>  
>>      /* build a weird topology and see if IDs are calculated correctly
>> @@ -85,18 +85,18 @@ static void test_topo_bits(void)
>>  
>>      /* This will use 2 bits for thread ID and 3 bits for core ID
>>       */
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
>> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>>      g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
>>      g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
>>      g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
>>  
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
>> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
>>  
>> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
>> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
>>                       (1 << 2) | 0);
>>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
>>
>>
> 

