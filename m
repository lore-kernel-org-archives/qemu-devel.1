Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56387C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFFF20836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ljJ0YPPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFFF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HJT-0007EO-Aj
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HHl-000576-4G
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HHj-0001le-Ny
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:12:48 -0500
Received: from mail-eopbgr700065.outbound.protection.outlook.com
 ([40.107.70.65]:2784 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6HHj-0001lH-ED
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:12:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbYBPdYQo5cYkqU9iXNbOymYqCY6RaZKsmW3z3e+gLLbgBiTMX9dXrNVDwb29IPNFiGGyqrtgH85myEh4/Ls7VB+7GenSly6HA29mcAB39/jauUycVOKjpR7orAmfJjwrcXdy8LoLNSlboy4RhlL/Wv15AO+/Em5TqXTyHX/7YhDvYzNM8eOQJ+0e2MIDpOPxGiBJy0TEDrgPBtzQvSCNTxfREu0B7B2w32xjlvhcCIj9kjCXiNU4nZwVmlkreh/gEpAe+dmLPYhgl0HF6ffITMzv9/QqJjr7s5dg148MeblgGn0rbhwv3P6fPxCY7EcJQocr3PBI+S5Zukxt46V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cusyQGuIMq9LAQZW4W40Rxx0iKNjpa2gTQ7R0RmOQ5E=;
 b=TbzZ9J7O2mWQv9xP8c+dNEXOrD/2SiLgubYTdkdGMJUKGGElOpahi/BFnFiv7ONrSDzfUZYEbkiEAS3Zs/R6gYeQDSwhnBchOI93iD2W7oy7yKfAHP3KwDxytTSIwnmb7Qyr/cP2/iSRo6+ZhgVBZSOEuqGSV+plWLS4onhb7p6CIMKSfjsX6OPfE5cfpEe/T0b1Fb1hp0KSQDHwuTSGv5BXe0b3cyJmF/JLRjSdWjWZgZV6am2uC2b5vrfc6MJ+XPpJ5/mXNDkxGqSuO0sYjd7XXRd5WhqYf7jKr44fmTNy1vGSA9Ibjf1NttTt8wouI3g2zfCM31pr6Tu587SJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cusyQGuIMq9LAQZW4W40Rxx0iKNjpa2gTQ7R0RmOQ5E=;
 b=ljJ0YPPDnAekzdDqTn59sdRHc9Qxbp62P2bsQrXbxPTFr378iryienNn7nsyi31L8ODC/GKkwauCNQcqicNMzJL+cD0rWGmOyVfl6SIJraFfG2xEdkvbz6IJPCfhv08JHN3UDJjCi2H2njSqZ6UGuJ2eFJsUzIfzhR2MH3ezzeA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1SPR01MB0001.namprd12.prod.outlook.com (2603:10b6:802:23::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 17:12:45 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:12:45 +0000
Subject: Re: [PATCH v4 06/16] hw/i386: Update structures for nodes_per_pkg
To: Igor Mammedov <imammedo@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161782489.48948.9328710425201785950.stgit@naples-babu.amd.com>
 <20200224093439.5fda5656@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <cdc8255e-b5ef-1635-b59f-44f371569865@amd.com>
Date: Mon, 24 Feb 2020 11:12:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224093439.5fda5656@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0043.namprd14.prod.outlook.com
 (2603:10b6:5:18f::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:12:43 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f070ed0b-439b-46e0-6eab-08d7b94cc3b3
X-MS-TrafficTypeDiagnostic: SN1SPR01MB0001:
X-Microsoft-Antispam-PRVS: <SN1SPR01MB000117F8AE4088BE0FD0374795EC0@SN1SPR01MB0001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(316002)(16576012)(4326008)(86362001)(66556008)(31686004)(66476007)(36756003)(6916009)(478600001)(66946007)(2906002)(6486002)(186003)(31696002)(5660300002)(8936002)(956004)(2616005)(8676002)(81156014)(44832011)(15650500001)(53546011)(81166006)(26005)(16526019)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1SPR01MB0001;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lWtKXWI2G5cc/GZrFOXXAD0brZV2qjxyVxO4WpQhdb0InJxofJXRoieIiJaOlZv6uE90brMN0sX9TvwHeH6pZgeb/roGmL2TIHF23YR+sZB1xAuL0k3wra23H3HUs+JfJ3tKuu7JsMHZUBuvzYFfUhxRjAbqytsqac5dPm86V7zXBIZ3ThFbwSpoeiB7Y0BNH1yXy4W/PqagzxHnlRhnQG5IjcjspkKHkyfgkE8+pbbIPtWXymqUROELxmnA40tQoIZCDFEW4txR/aYg8n4Qcktg6xeo3MC0qeiig3tdGmOLeTQ5mpWV/SNBCaQnkIkzZcTbyuhw/GjZ4TlDNsitxoVuVyTGBJg3o0VoqRyCN8bs+ffWrB8wjqL2yWU89VgYy6uPQcU526Fhx+QVD/hqSmfHTC3RkXhoqAB01szZvuMzQx6zjiWC3jHUtaw27A4
X-MS-Exchange-AntiSpam-MessageData: vvk2j9s72nhNrppbVZR+sSqBkhJ0eKFuDtYnVZtFM0oarLTXvPeCudiwjKfPwgr9+yuadeFjhTQRikUWpTVGKZaMi7R9ODUT9lLk83nl8F+ld/dGkK4lmJeWnPmTV6GR211dQXQIBp4MX88vvHE7vw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f070ed0b-439b-46e0-6eab-08d7b94cc3b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:12:45.0172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Eb5a3tVR0VgeNGxMWVMwr6vE2/V/Pu/vWPz9jQJq65tbcGBvcsHmfW8doBRsBca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1SPR01MB0001
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.70.65
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



On 2/24/20 2:34 AM, Igor Mammedov wrote:
> On Thu, 13 Feb 2020 12:17:04 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Update structures X86CPUTopoIDs and CPUX86State to hold the nodes_per_pkg.
>> This is required to build EPYC mode topology.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/pc.c               |    1 +
>>  hw/i386/x86.c              |    2 ++
>>  include/hw/i386/topology.h |    2 ++
>>  include/hw/i386/x86.h      |    1 +
>>  target/i386/cpu.c          |    1 +
>>  target/i386/cpu.h          |    1 +
>>  6 files changed, 8 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f13721ac43..02fdb3d506 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1753,6 +1753,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>      init_topo_info(&topo_info, x86ms);
>>  
>>      env->nr_dies = x86ms->smp_dies;
>> +    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
> 
> it would be better if calculation would result in valid result
> so you won't have to later scatter MAX(env->nr_nodes, 1) everywhere.

Ok. Sure.
> 
> also I'd use earlier intialized:
>   env->nr_nodes = topo_info->nodes_per_pkg
> to avoid repeating calculation

yes. Will do it.

> 
>>      /*
>>       * If APIC ID is not set,
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 083effb2f5..3d944f68e6 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -89,11 +89,13 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>>      Object *cpu = NULL;
>>      Error *local_err = NULL;
>>      CPUX86State *env = NULL;
>> +    MachineState *ms = MACHINE(x86ms);
>>  
>>      cpu = object_new(MACHINE(x86ms)->cpu_type);
>>  
>>      env = &X86_CPU(cpu)->env;
>>      env->nr_dies = x86ms->smp_dies;
>> +    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
> 
> Is this really necessary?  (I think pc_cpu_pre_plug should take care of setting it)

This does not seem necessary. I can add as a separate patch to remove env
initialization from x86_cpu_new.

> 
>>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
>>      object_property_set_bool(cpu, true, "realized", &local_err);
>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>> index ef0ab0b6a3..522c77e6a9 100644
>> --- a/include/hw/i386/topology.h
>> +++ b/include/hw/i386/topology.h
>> @@ -41,12 +41,14 @@
>>  
>>  #include "qemu/bitops.h"
>>  #include "hw/i386/x86.h"
>> +#include "sysemu/numa.h"
>>  
>>  static inline void init_topo_info(X86CPUTopoInfo *topo_info,
>>                                    const X86MachineState *x86ms)
>>  {
>>      MachineState *ms = MACHINE(x86ms);
>>  
>> +    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
>>      topo_info->dies_per_pkg = x86ms->smp_dies;
>>      topo_info->cores_per_die = ms->smp.cores;
>>      topo_info->threads_per_core = ms->smp.threads;
>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>> index ad62b01cf2..d76fd0bbb1 100644
>> --- a/include/hw/i386/x86.h
>> +++ b/include/hw/i386/x86.h
>> @@ -48,6 +48,7 @@ typedef struct X86CPUTopoIDs {
>>  } X86CPUTopoIDs;
>>  
>>  typedef struct X86CPUTopoInfo {
>> +    unsigned nodes_per_pkg;
>>      unsigned dies_per_pkg;
>>      unsigned cores_per_die;
>>      unsigned threads_per_core;
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 7e630f47ac..5d6edfd09b 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6761,6 +6761,7 @@ static void x86_cpu_initfn(Object *obj)
>>      FeatureWord w;
>>  
>>      env->nr_dies = 1;
>> +    env->nr_nodes = 1;
>>      cpu_set_cpustate_pointers(cpu);
>>  
>>      object_property_add(obj, "family", "int",
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index af282936a7..627a8cb9be 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1603,6 +1603,7 @@ typedef struct CPUX86State {
>>      TPRAccess tpr_access_type;
>>  
>>      unsigned nr_dies;
>> +    unsigned nr_nodes;
>>  } CPUX86State;
>>  
>>  struct kvm_msrs;
>>
> 

