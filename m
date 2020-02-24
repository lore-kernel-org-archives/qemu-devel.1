Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBCC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6F720838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R5rQNJS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6F720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Hf5-0006we-MY
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HTI-0005Uy-4R
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HTG-0006su-Jz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:24:44 -0500
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com
 ([40.107.92.72]:40225 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6HTG-0006sf-86
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:24:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYMkFlSmadpHyeXmrmzZ+D1xu6rqf3ta4faUt+mo4dPdYghyJoBzCgaljB1u4JaCa17RebzqU6xxnyqNY32mhLzN9BqqGYPQMcKzPiNMC05lhpKCP5m5TkEWStRGi1ATxfgQWOvPJcyygDE9O2ZoYSqmBk5xJ4tanVbWaSmHmWxHKSTdzlAqwlvI10OuuBTb8IrJhQJsF819Gpnby7/VPY4vig7jJ+/HgByIuK1jtZYMBUr3ycKpU3R9jnd4tjqQ7hAIxQINJhhATKProBy/At2RYdJZiiu3PeIG1RzT5kup1Kdocu1vYzfr5KbWti7/evwWRFSs6w54Wkj/6hM6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dv77kXqje34ziA54vOgjYp7Oyr1kfGYr3WOLNPGiqM=;
 b=XO2aEo0hDv6vDCB7QeOJ5jiClKNutPeKNlTYicZjUu8/myi0+LCrmeBEwrDR9Wr/0GhRGNwLbsPhH0gLbVDDkDC2vTOr6jKN0xoFkS0TXPYDv30tZsHWJWZc2Zn5DGKAhMCOT1pUFxtvXl8Dg8RLAvLKbu/bxK0k/NkA0ICQXlcm1hgHlOx3FmFRR4hkS5SfdKABRgqoC9FVtN8LLFW4U8nG5oNQkrdTZzdHCVkBaDCRCIjI4idII/gNJnr++RXteNsB2wV8THAT8B0X3xzrU0zAYVNgaMGhFzWOMWycU3P2mnTdeLUVo9FqlfuBj4u/SqoHzeKNvi3Jeetnt+UCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dv77kXqje34ziA54vOgjYp7Oyr1kfGYr3WOLNPGiqM=;
 b=R5rQNJS+9Hjpr1DjJlJM+Lnz6+s84yuIri73RK1Yo/5MHV0d6PPGgQEkOH2YaMqTwqIPf3r03iPQWm+3BhTYu/TkTqKoXncRx3Q/sV2zKAj/qH1YcELOA+7oW9clN858KGpgXDR2WSHId/mGsebcI4lhY+MTrmp2T7clWOTG8Yg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 17:24:40 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:24:40 +0000
Subject: Re: [PATCH v4 08/16] hw/386: Add EPYC mode topology decoding functions
To: Igor Mammedov <imammedo@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161783872.48948.1827981450074223928.stgit@naples-babu.amd.com>
 <20200224095021.78472314@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <1e23d802-8e88-1eec-f220-1e0d6b2e4839@amd.com>
Date: Mon, 24 Feb 2020 11:24:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224095021.78472314@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21 via Frontend Transport; Mon, 24 Feb 2020 17:24:38 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da288ad1-953f-4bd9-6ecd-08d7b94e6e39
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2397B279B14CA5C885E5A74095EC0@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(16576012)(186003)(2616005)(956004)(16526019)(26005)(8936002)(44832011)(66556008)(66476007)(66946007)(81166006)(81156014)(8676002)(52116002)(4326008)(31686004)(6916009)(6486002)(966005)(316002)(5660300002)(36756003)(86362001)(53546011)(45080400002)(31696002)(2906002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2397;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iriXnuYbgwhFUKzRLEIUqz7c82LNK6dZqFgxVF+QHUVvIns1tllGQWCL3AlFcQtATJibjpBSacl1fSpZU26uo9ylcUt1BBUsYOKu4sbtixAc0hTourfiLfSpWkGU+GDB0geojsRE3MixP9Co0nY+VDpiirTpxeIFg8ypcOeGAzySPFrqcqw71VwsgDg5Uu0HY8hFT2+C0kiCRzb8AKdfHuHmJFmWC8f0U1z9FGOHmoq3UofY647A3E/zotIPuSR+/nEqQo2N4RnnnEbTPAhUQqfu+LzN2dYWEf38ZBHV6FW9dg1Gx3CLMPGmEktCOmUALKVDF6SlCDqaoPTnaV8m1EA/brYK4PYhvX8ra3VtUxkkoz1rPowi0rxJbk0e1EWFmSq8cGp633nYP+hvr5NgGVsYElOKK/LAMfF//wuSS9ps4yynxkMgTj3YXUK0uDieHkBglOVENZ2DC+7QRM0uFCDIPeH9k/Gj9fqul11PjU7LMb+l88T+dsUHDwlNkqB5MJh/sMxTWLTpVye4zhboUQ==
X-MS-Exchange-AntiSpam-MessageData: l4XLB9JtZbdLVGeW+fkrhDzO+t2e/ONUSYzeoHAwYBHuqXkEf7gVdOoppanzQwNy7ZFy5b3lc//jSj8ER0wpIUnYXBR2fjuetrQW5rSWHzo3UpJADOhMrEx+Bni1gcKKCTt4XVhUye6lFLPCLEVEjQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da288ad1-953f-4bd9-6ecd-08d7b94e6e39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:24:40.6308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLBdLAfyyu9kOo74C6QHaTqImRH1rTtZilQEczDcektaxNEEToLdoRtSEUqy22/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.72
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



On 2/24/20 2:50 AM, Igor Mammedov wrote:
> On Thu, 13 Feb 2020 12:17:18 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> These functions add support for building EPYC mode topology given the smp
>> details like numa nodes, cores, threads and sockets.
>>
>> The new apic id decoding is mostly similar to current apic id decoding
>> except that it adds a new field llc_id when numa configured. Removes all
> 
> llc_id/nodes_per_pkg

Good catch. Thanks.

> 
>> the hardcoded values. Subsequent patches will use these functions to build
>> the topology.
>>
>> Following functions are added.
>> apicid_llc_width_epyc
>> apicid_llc_offset_epyc
>> apicid_pkg_offset_epyc
>> apicid_from_topo_ids_epyc
>> x86_topo_ids_from_idx_epyc
>> x86_topo_ids_from_apicid_epyc
>> x86_apicid_from_cpu_idx_epyc
>>
>> The topology details are available in Processor Programming Reference (PPR)
>> for AMD Family 17h Model 01h, Revision B1 Processors.
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F55570-B1_PUB.zip&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C07f6ec6272fa4a0bb44608d7b9069ef6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637181310409402221&amp;sdata=nPUTNqiXVSihj8mHt%2FO6sSGCL4uTtPsfvIiEJ0WosaM%3D&amp;reserved=0
> 
> also checkpatch doesn't like this patch for too long strings.

Yes. I saw that.  Some are bit tricky. I may need to break the definitions
like this below.

static inline apic_id_t
x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
                              const X86CPUTopoIDs *topo_ids)


> with that fixed
>   Acked-by: Igor Mammedov <imammedo@redhat.com>
> 
> 
> PS:
> similar checkpatch warnings should be fixed in preceding patches

Sure. Will take care.
> 
> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  include/hw/i386/topology.h |   93 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/i386/x86.h      |    1 
>>  2 files changed, 94 insertions(+)
>>
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index 3158157430..d9319dc2ac 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -83,6 +83,11 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
>>      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
>>  }
>>  
>> +/* Bit width of the node_id field per socket */
>> +static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
>> +{
>> +    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
>> +}
>>  /* Bit offset of the Core_ID field
>>   */
>>  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
>> @@ -103,6 +108,94 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>>  }
>>  
>> +#define LLC_OFFSET 3 /* Minimum LLC offset if numa configured */
>> +
>> +/* Bit offset of the node_id field */
>> +static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
>> +{
>> +    unsigned offset = apicid_die_offset(topo_info) +
>> +                      apicid_die_width(topo_info);
>> +
>> +    if (topo_info->nodes_per_pkg) {
>> +        return MAX(LLC_OFFSET, offset);
>> +    } else {
>> +        return offset;
>> +    }
>> +}
>> +
>> +/* Bit offset of the Pkg_ID (socket ID) field */
>> +static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
>> +{
>> +    return apicid_node_offset_epyc(topo_info) + apicid_node_width_epyc(topo_info);
>> +}
>> +
>> +/*
>> + * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>> + *
>> + * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
>> + */
>> +static inline apic_id_t x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>> +                                                      const X86CPUTopoIDs *topo_ids)
>> +{
>> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
>> +           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
>> +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
>> +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
>> +           topo_ids->smt_id;
>> +}
>> +
>> +static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
>> +                                              unsigned cpu_index,
>> +                                              X86CPUTopoIDs *topo_ids)
>> +{
>> +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
>> +    unsigned nr_dies = topo_info->dies_per_pkg;
>> +    unsigned nr_cores = topo_info->cores_per_die;
>> +    unsigned nr_threads = topo_info->threads_per_core;
>> +    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
>> +                                            nr_nodes);
>> +
>> +    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
>> +    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
>> +    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>> +    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
>> +    topo_ids->smt_id = cpu_index % nr_threads;
>> +}
>> +
>> +/*
>> + * Calculate thread/core/package IDs for a specific topology,
>> + * based on APIC ID
>> + */
>> +static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
>> +                                            X86CPUTopoInfo *topo_info,
>> +                                            X86CPUTopoIDs *topo_ids)
>> +{
>> +    topo_ids->smt_id = apicid &
>> +            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
>> +    topo_ids->core_id =
>> +            (apicid >> apicid_core_offset(topo_info)) &
>> +            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
>> +    topo_ids->die_id =
>> +            (apicid >> apicid_die_offset(topo_info)) &
>> +            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
>> +    topo_ids->node_id =
>> +            (apicid >> apicid_node_offset_epyc(topo_info)) &
>> +            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
>> +    topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
>> +}
>> +
>> +/*
>> + * Make APIC ID for the CPU 'cpu_index'
>> + *
>> + * 'cpu_index' is a sequential, contiguous ID for the CPU.
>> + */
>> +static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
>> +                                                     unsigned cpu_index)
>> +{
>> +    X86CPUTopoIDs topo_ids;
>> +    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
>> +    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
>> +}
>>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
>>   *
>>   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>> index d76fd0bbb1..38c2d27910 100644
>> --- a/include/hw/i386/x86.h
>> +++ b/include/hw/i386/x86.h
>> @@ -42,6 +42,7 @@ typedef uint32_t apic_id_t;
>>  
>>  typedef struct X86CPUTopoIDs {
>>      unsigned pkg_id;
>> +    unsigned node_id;
>>      unsigned die_id;
>>      unsigned core_id;
>>      unsigned smt_id;
>>
> 

