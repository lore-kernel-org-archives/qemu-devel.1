Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E6FC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C88F20722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x6jYz6B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C88F20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CTb-0006rh-QY
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j5CSR-0005o9-NB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j5CSQ-00078I-Bm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:51:23 -0500
Received: from mail-co1nam11on2087.outbound.protection.outlook.com
 ([40.107.220.87]:39136 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j5CSQ-00077Z-0w
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:51:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmQKwtPonSygMquxqMNI8NnmFUMb8C9IUdnY72AcZaz/4GgoLF76OkH7FT5reWHm7LQSo0+T4vEQTVNRw8wrj9GSv6AqzdLWquF9zuM2JGnDRTnpQjFxISt5L1Nay/R+K2fDotBF25sfZPDd8G5AK9HoQTcsQbboHBd1nNdj4SVbciEobGnibKLamaTedcXNiKOUfI9wG7x2f9HTf5FWODRJtyvJp0IhzZcwZw8EOkqlh4qXe5ssfKRxJ292qHFlTwJnPJxMI25onKTc01CT4gk2rZVqV+Wkx1P/6R/jbjRx//RzT5QFoNTGGqkojJdzw5dCuNrqrkUSDkv6zVHXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igTcMoNPdBPyrU4r1PmHi0i+zgZ04ZVLVvSkhYX4/cw=;
 b=USpryO/POQuohOSZ5ZoYHPvBGOLWJxC01zDopc94CnNyFfj+vYD8gl4r/TaTtMiwMrtwSor4l39brlypOw0mr82FEMbiKRak8k2r0V9bgmp+DSiRs1K6xauIjAt2B33gXMYuUo45EhalK2p6sdvAHYdqnTvSU3raQOhSyy20a0PKSqV56AL25+lZmCq1CMVI0B2A0WmMDhziIuQQB7PUbh8hibAnCWt8gxNHTUbcgbbWdkS4MmnxAxgHQ3OqpvnLp6XcCqpujCBtSSKB+THVlzpLQtdR2JQp7Fknxc3Oa2JA2tpepAcMc+not4oLak2K2YIhjV8IQSrSeJ8J+v/J3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igTcMoNPdBPyrU4r1PmHi0i+zgZ04ZVLVvSkhYX4/cw=;
 b=x6jYz6B/V+zAACT0x0OqT67O/V0GjPqyx8AqIlSvN8kMLAZvRsaxmTZrq259s6PZbv4Ftu+tb6H/HEcV/Y3QnRfVrTHJ4kgCxDWUTbsyqddqGsM0axyn1tTOq2gBsGVk/jXh72XdZ2X7cbRr4oyky71nCK/4EMzii/1Lqzt8i7U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Fri, 21 Feb
 2020 17:51:19 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 17:51:19 +0000
Subject: Re: [PATCH v4 04/16] hw/i386: Introduce init_topo_info to initialize
 X86CPUTopoInfo
To: Igor Mammedov <imammedo@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161781120.48948.3568234592332597800.stgit@naples-babu.amd.com>
 <20200221180501.72e4ff3c@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <3188d0e7-7f1c-aa03-d3ec-f512d9905158@amd.com>
Date: Fri, 21 Feb 2020 11:51:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200221180501.72e4ff3c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::21) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 17:51:17 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7744dabe-4635-4e75-ef9e-08d7b6f6a7d2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2560:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2560EAFD702A8C029EB57E8595120@SN1PR12MB2560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(36756003)(4326008)(44832011)(16526019)(86362001)(31696002)(478600001)(5660300002)(31686004)(2616005)(6916009)(16576012)(81156014)(956004)(6486002)(52116002)(53546011)(8936002)(8676002)(186003)(66556008)(316002)(81166006)(2906002)(26005)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2560;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68po04jmVSObHiZXWfLA5OVY8wuVBbI/7S1hL4SYmEVnCk0Fz8NalGJ7PKqPrfsauCaP/HQ5Lm3K5+uSS1bTGoRyBKIEVN8BIx42D19JN/nnbkBVVAv1rxMRbc02fnq09dCijHp1cjJiURhIhlm6YrAVnY8oKmo+MMeU3zRYfNuWhdYD83PTxoc/r7skHcrqKNKq23ZyFR9daIPZIOUmPmJppJb9GP1qoeh68yPtk25ZT2H31GqfSnL383twb5+3blTOg74HmRFy0ka5zsuqqGdkxKcF6ZpAf+LE+9tuDG2JDqy+dIeFiUG/WVoDknkM8/ubXmfeImjzLXq0VLZDEdLQgQkGIkyAyxiozraKBH6EtYEDrjNk79Eii4tkdsV4CTNtzqMGhuxhxcYxG8rTjRLO0pM0sGDhkn6t6rF/tBhhjH3+B4Kw1pcSAobhpXhF
X-MS-Exchange-AntiSpam-MessageData: P3t2dhETppWn9ETKqIx20luWUdsWAAwpuCHOermnNt4AfIjSki2LSHYIa/n7MZDvlKZZ4y/MK07Oke/xkyiMG7gdq79FST1ed1v24ULyBoe9iPbidyB7cnJKJsSdQKPv+VDXFYaRi8rp1KRjvoqdqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7744dabe-4635-4e75-ef9e-08d7b6f6a7d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 17:51:19.1142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/l+fRNW7hF3iPP/2P8vPf+u3EMm+H3Vb0JiYC5x94sUNCEBX0hCTTo9P091u22b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.87
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



On 2/21/20 11:05 AM, Igor Mammedov wrote:
> On Thu, 13 Feb 2020 12:16:51 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Initialize all the parameters in one function init_topo_info.
> 
> is it possible to squash it in 2/16
> 
Sure. We can do that.
> 
>>
>> Move the data structure X86CPUTopoIDs and X86CPUTopoInfo into
>> x86.h.
> A reason why it's moved should be here.

Apicid functions will be part of X86MachineState data structure(patches
introduced later).These functions will use X86CPUTopoIDs and
X86CPUTopoInfo definition. Will add these details. Thanks

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  hw/i386/pc.c               |    4 +---
>>  hw/i386/x86.c              |   14 +++-----------
>>  include/hw/i386/topology.h |   26 ++++++++++----------------
>>  include/hw/i386/x86.h      |   17 +++++++++++++++++
>>  4 files changed, 31 insertions(+), 30 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 2adf7f6afa..9803413dd9 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1749,9 +1749,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>          return;
>>      }
>>  
>> -    topo_info.dies_per_pkg = x86ms->smp_dies;
>> -    topo_info.cores_per_die = smp_cores;
>> -    topo_info.threads_per_core = smp_threads;
>> +    init_topo_info(&topo_info, x86ms);
>>  
>>      env->nr_dies = x86ms->smp_dies;
>>  
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index f18cab8e5c..083effb2f5 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -63,15 +63,12 @@ static size_t pvh_start_addr;
>>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>>                                      unsigned int cpu_index)
>>  {
>> -    MachineState *ms = MACHINE(x86ms);
>>      X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
>>      X86CPUTopoInfo topo_info;
>>      uint32_t correct_id;
>>      static bool warned;
>>  
>> -    topo_info.dies_per_pkg = x86ms->smp_dies;
>> -    topo_info.cores_per_die = ms->smp.cores;
>> -    topo_info.threads_per_core = ms->smp.threads;
>> +    init_topo_info(&topo_info, x86ms);
>>  
>>      correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>>      if (x86mc->compat_apic_id_mode) {
>> @@ -146,10 +143,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>>     X86MachineState *x86ms = X86_MACHINE(ms);
>>     X86CPUTopoInfo topo_info;
>>  
>> -   topo_info.dies_per_pkg = x86ms->smp_dies;
>> -   topo_info.cores_per_die = ms->smp.cores;
>> -   topo_info.threads_per_core = ms->smp.threads;
>> -
>> +   init_topo_info(&topo_info, x86ms);
>>  
>>     assert(idx < ms->possible_cpus->len);
>>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
>> @@ -177,9 +171,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>                                    sizeof(CPUArchId) * max_cpus);
>>      ms->possible_cpus->len = max_cpus;
>>  
>> -    topo_info.dies_per_pkg = x86ms->smp_dies;
>> -    topo_info.cores_per_die = ms->smp.cores;
>> -    topo_info.threads_per_core = ms->smp.threads;
>> +    init_topo_info(&topo_info, x86ms);
>>  
>>      for (i = 0; i < ms->possible_cpus->len; i++) {
>>          X86CPUTopoIDs topo_ids;
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index ba52d49079..ef0ab0b6a3 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -40,23 +40,17 @@
>>  
>>  
>>  #include "qemu/bitops.h"
>> +#include "hw/i386/x86.h"
>>  
>> -/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
>> - */
>> -typedef uint32_t apic_id_t;
>> -
>> -typedef struct X86CPUTopoIDs {
>> -    unsigned pkg_id;
>> -    unsigned die_id;
>> -    unsigned core_id;
>> -    unsigned smt_id;
>> -} X86CPUTopoIDs;
>> -
>> -typedef struct X86CPUTopoInfo {
>> -    unsigned dies_per_pkg;
>> -    unsigned cores_per_die;
>> -    unsigned threads_per_core;
>> -} X86CPUTopoInfo;
>> +static inline void init_topo_info(X86CPUTopoInfo *topo_info,
>> +                                  const X86MachineState *x86ms)
>> +{
>> +    MachineState *ms = MACHINE(x86ms);
>> +
>> +    topo_info->dies_per_pkg = x86ms->smp_dies;
>> +    topo_info->cores_per_die = ms->smp.cores;
>> +    topo_info->threads_per_core = ms->smp.threads;
>> +}
>>  
>>  /* Return the bit width needed for 'count' IDs
>>   */
>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>> index 4b84917885..ad62b01cf2 100644
>> --- a/include/hw/i386/x86.h
>> +++ b/include/hw/i386/x86.h
>> @@ -36,6 +36,23 @@ typedef struct {
>>      bool compat_apic_id_mode;
>>  } X86MachineClass;
>>  
>> +/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
>> + */
>> +typedef uint32_t apic_id_t;
>> +
>> +typedef struct X86CPUTopoIDs {
>> +    unsigned pkg_id;
>> +    unsigned die_id;
>> +    unsigned core_id;
>> +    unsigned smt_id;
>> +} X86CPUTopoIDs;
>> +
>> +typedef struct X86CPUTopoInfo {
>> +    unsigned dies_per_pkg;
>> +    unsigned cores_per_die;
>> +    unsigned threads_per_core;
>> +} X86CPUTopoInfo;
>> +
>>  typedef struct {
>>      /*< private >*/
>>      MachineState parent;
>>
> 

