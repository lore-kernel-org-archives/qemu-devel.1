Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C479C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3618120888
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="reJms+EK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3618120888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Wo4-0007j4-G2
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 18:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k8WnS-0007J2-01
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:43:06 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com
 ([40.107.243.85]:64608 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k8WnP-0000Hb-CL
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXhnTsZfAClPaThXCd4npzyeCcSSNB2OfGjop/Z2dNyJsgySZX4Bb6NsYgMQL76Q0lN03dqNBf8t3jeqX++Sg833XFVMlUpXNF1EdexNNQmbsXTYZI91BMdLfHyGOmuWgTVib4ZO2MmjaVUgj+Xw7li030ahEMHwCNBpO0qjoOTbCIm4AViSqGHg/8nvYJJyyNaEKTRTIG1expWt+HPvY6NeuUlFob/QrYROPJK/+Hilz4zL8JEaD+aJUk3lW73BN0g+8i3kBS4Wh6qXeCqMKFKDazbt32cTPn7TiJ99UEbWJnr0UVcrHG0oTom5EmS/bcgR1wi8uJtoOo7QDnhMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjyWikbIz8sDmUSIOlQ3oW8RnAVXZJh/OrzHOyGn4P0=;
 b=CkofkaarUHlxmmDlgIA30KxFJefV5jYYlorptNvmBl0xkEUbHjL/Do378/KjTN633gf4EvFBMVlNeAuXi2y1HGUhigvRPOq1Kkmh5+0IEZ7TcdFFeP6sSCkoCJVzlnB8WUuzJJfCjEPvxSqlyDG6n484xNROIr1R2OVRb18qTCRp/EVaULbzEvVCoi9IDn7+IufFFLMeDlksxNOYKNNIy6JuvgoC5OpMEUJ08poEhSwhwRijrYNXXAIpmEVBjuf3VBj9sxcMl8A88Ko1jlAVczjNP1QCmY/mY+px/EnWAPv1XkftsjjlOMBzajdYj8DMS67EKGrHOl9DaSUiJE2L4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjyWikbIz8sDmUSIOlQ3oW8RnAVXZJh/OrzHOyGn4P0=;
 b=reJms+EKsBXTOVfU6msdUzgS21tVPU1pukSQg9zqo/qOcGdUl9VchQXGQBoApm0DJzqe+OTyd/IefTrFbwgZ0ehPjUOTNlOkc9Pd4eEWrDJ4FgG8otI3Hd4YbwH+13F6+h0NK7quCY296diE5swW8M1qZ64p9Z5GjrgwCLTSxP8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2525.namprd12.prod.outlook.com (2603:10b6:802:29::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 22:42:59 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 22:42:59 +0000
Subject: Re: [PATCH v4 3/3] hw/i386: Remove node_id, nr_nodes and
 nodes_per_pkg from topology
To: Igor Mammedov <imammedo@redhat.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
 <159744118012.39197.535122421806420639.stgit@naples-babu.amd.com>
 <20200819141852.22743dff@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <2709427a-33e5-c6ad-7ebe-8af889f39604@amd.com>
Date: Wed, 19 Aug 2020 17:42:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200819141852.22743dff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0072.prod.exchangelabs.com (2603:10b6:800::40) To
 SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN2PR01CA0072.prod.exchangelabs.com (2603:10b6:800::40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 22:42:59 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3588377-9a60-4cb9-b972-08d844913958
X-MS-TrafficTypeDiagnostic: SN1PR12MB2525:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2525E1D0111DF7983BCBD398955D0@SN1PR12MB2525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7bOzWc3mlVcOudDeku1cNs4D4ieAmG5OEGQmLYGvm5oQE5Grk5TuEp/fFHRgsEzJ/xOoNcH+HOFch1b5udL8MLa4TBiCkCuX3hIc6yhghTRZNOqn0/bTYbOSce0q23kBMs3VIabcfTQTGjUmNi957LTwoXcjljMY80jnPMplkZsj+kePdF23feeQghMwMJHy69wmUpTvfE7Q3W1zGu5SL5ZckY66KU7dLswvMJXBtPPc8iCV/LVDtjgPbpwj5Q8IFlNUvyu9OTRl6oQouDJxsL/3Oa+fsMA5zYDpl/5bBIQIQksIKcSHIq1Ps+BbbEVlzKQp08jjF2SdnqDNEMpLSqNdnPg22k2a/7hKwig/ZRLTZ/pGtCAVSxJoYweCY0iMntvZ1e50kLpjjxVGpdTdqpXLgNPVX3Mm46AZQSXa7141i/cDiD6rvGBdpXThwF1fzC32j4ttNkbF/pTcJX+blROQ73QDlbjztm+rNFA0Ci05XqDbXo/WJPvJ91ViUfr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(186003)(66946007)(8936002)(66476007)(316002)(478600001)(83380400001)(4326008)(16576012)(26005)(6916009)(53546011)(52116002)(45080400002)(6486002)(44832011)(30864003)(31696002)(2616005)(2906002)(66556008)(31686004)(86362001)(5660300002)(966005)(36756003)(956004)(110011004)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RHR/pYve2+3LGyKRcbIMqCqC69412lkxdkmXnXtGID9EzCsflhnSa6tk+FF5y/RQMQuncjk/6JRcI1cpNE/Y6hhF0CUm5tYlMg9ANqR2ZCrN9ucsr2lR4B+N9QPd7KPiPfHYr+QbNOyKwZs8UeSB9qIdkUDpW21gSBXbHqL2RQdZ/V0T2UyNkhhMUsaOZCrnuOlUAxdi4qpzsZxJDTf4V5goqWjKxNyzkploCDpB9nDDz1L3zmzLQvFCTKLPCZG2tO+kEe4GIFTzrGQdOI5NpNdj8w0Q3XHJa6PP8jCirZRu4dNNJMFsUcLn8Kk1BWKqDbDf2RniRmX27nR+dDEIQ+xk6wcQvv3DJZG/zd6tOT7fssBmjIRz4sm79EFQ+VDV7vfFL2DjXPRjWa2QKzsF8OpVQ2Ql+c1PmiY3JWmQxBzQjZMV7SieSVxROg28KuAHYlTsoCrLqFufxM/5oyBXVZv81XBgxvcDsD3r4/Ko543M1kj1CB3XZ7vaCX7yxwhCBrJzd4lhfukSBW7HdTB3rvhZlsMPeZ3qMS6fmrp4Ug3Jr+sRuLSuX04Xx71LrCKwPp7UPJuXXY1pgEbk6rDhuS0rHBvdx1kQ62mxCxMqLYlUJcAp7hFxmi0xA9jSo62QNkpwkZEIvTuMo1t24ssT4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3588377-9a60-4cb9-b972-08d844913958
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 22:42:59.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYipORSwSQk4fS4ZdC4NQpkBFdUSbcZXa1jactbV936TxhirCCxLIuE8k+IbQC4+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2525
Received-SPF: none client-ip=40.107.243.85; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 18:43:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 8/19/20 7:18 AM, Igor Mammedov wrote:
> On Fri, 14 Aug 2020 16:39:40 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Remove node_id, nr_nodes and nodes_per_pkg from topology. Use
>> die_id, nr_dies and dies_per_pkg which is already available.
>> Removes the confusion over two variables.
>>
>> With node_id removed in topology the uninitialized memory issue
>> with -device and CPU hotplug will be fixed.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1828750&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C466254703c904bd4c86c08d8443a0e91%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637334363427680286&amp;sdata=%2Fr7Mucca8Pr%2BrjvwJ6S9zxiIg3HCKAiPp4PvGP3nvZI%3D&amp;reserved=0
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/pc.c               |    1 -
>>  hw/i386/x86.c              |    1 -
>>  include/hw/i386/topology.h |   40 +++++++++-------------------------------
>>  target/i386/cpu.c          |   11 +++--------
>>  target/i386/cpu.h          |    1 -
>>  5 files changed, 12 insertions(+), 42 deletions(-)
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
>> index e90c42d2fc..4efa1f8b87 100644
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
>                                                       ^^
> 
> from EPYC's pov NUMA is always configured, there no 'if'
> 
> but I have a question, is it possible to drop EPYC_DIE_OFFSET
> and reuse apicid_die_offset(), will it break something?

Yes. I am also thinking about it. We can go back to existing
apicid_die_width().

Looking back again, I think all these code changes related to node_id is
causing more issues than fixes. We have added all these code to handle
some non- SPECed configurations like
 https://bugzilla.redhat.com/show_bug.cgi?id=1728166.

Going forward it might create even more issues. Now, I think we should go
back and remove all these changes and just use the default decoding. Most
of the SPECed configuration would work just fine. With some non-SPECed
user inputs, it will create some sub-optimal configuration. If we can live
with that we will be just fine. I did not anticipate all these problems
when I originally started this work. Sorry, my bad.

> 
> The reason for question is that, we (deviating from spec)
> do allow for unbound core/threads number so die_id, already could
> be shifted beyound ApicId[5:4], likewise we do allow for unbound
> sockets so ApicId[6] is also out of spec.
> If we are fine with ApicId being encoded in these cases out of
> spec, then why should we insist on DIE_OFFSET minumum at all?
> Why not just allow existing apicid_die_width() to encode die_id?
> 
> In this case it will produce SPECed ApicId if user has provided
> -smp that matches currently released EPYC's and in all other cases
> it will be out of spec ApicId like when we set sockets/cores/trheads
> to out of spec values.
>   
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
>> index c892432cae..ba0a24f6b8 100644
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
>> @@ -387,7 +385,6 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>                                         uint32_t *ecx, uint32_t *edx)
>>  {
>>      X86CPUTopoIDs topo_ids = {0};
>> -    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
>>  
>>      x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
>>  
>> @@ -433,7 +430,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>       * NodeId is combination of node and socket_id which is already decoded
>>       * in apic_id. Just use it by shifting.
>>       */
>> -    *ecx = ((nodes - 1) << 8) | cpu->node_id;
>> +    *ecx = ((topo_info->dies_per_pkg - 1) << 8) | cpu->node_id;
>>      *edx = 0;
>>  }
>>  
>> @@ -5484,7 +5481,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>      uint32_t signature[3];
>>      X86CPUTopoInfo topo_info;
>>  
>> -    topo_info.nodes_per_pkg = env->nr_nodes;
>>      topo_info.dies_per_pkg = env->nr_dies;
>>      topo_info.cores_per_die = cs->nr_cores;
>>      topo_info.threads_per_core = cs->nr_threads;
>> @@ -6944,7 +6940,6 @@ static void x86_cpu_initfn(Object *obj)
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
>>
>>
> 

