Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6681C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EFB20715
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QStdI42h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EFB20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWv9-0003sy-Sg
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jPWuL-0003RN-4A
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jPWuJ-0003uj-Og
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:44:13 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41]:53857 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jPWuJ-0003t7-Di
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:44:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1i2Qy4yv2AxhNSInu9FNDEOdB0BhLy7SHcvBHcKLO+SS02Oi46m+5dUmCZSeucCEJGWjkfd1XxBe+ZMQ1QGXkohJi5kJQU2stjzfrHRm/HOaxKoSMxkBXwSxM6/UfsKALi34dKAfzdnxE0tLY0rm9NcPDbqdmaLmDM8r+bOwAIQhmakcfvB0qM1/S5RuJh32PiTKH7+B8d1LRoZkFM0xa+O74wRLlTICQCREW/eiRHEsMXl0fHbOrZGv46JYZdYG31Y4KoPTe8w2vEGHvgKJfzd2rjLIelweDlGZs30rzk43LrtYTwU2ebHozUxAT6uslpWg2cP1zWxLC6ZtcvUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB8C+lL13yITcLxWdkAP34d7mDAQpyETOxEglH/jf7k=;
 b=ns527izVoVVkdbzDsHIsgcUWpV4BVdxDyVJJbe2xzpKutqsXdysxscR+EvQNn0G4tHUImpmc45jM5WQIwWSxOGHnCCODc8kT7mClcLO4U6glYafxXpbHpnVnIbvduTfAkAeJXB79QlOEIaApDk2Cpjiw9KaZd+H0FZn0Je/J8cBGTnDLqsmOtDN/m7MAeOrFempl28TQvU50yfVQtJ0f5/Ly/43mO3QlMd3n/0A7uD6C7nm2eUTG/mMUDnskT7D0TSajl+X5qLqhn6m6AG5wk3r2ov/PbgHMxm/R6HUgR0ivPxvotCkeARD1T+XQUOSsfYTGcxF63T+dJEABoCX6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB8C+lL13yITcLxWdkAP34d7mDAQpyETOxEglH/jf7k=;
 b=QStdI42h1t2R+GXEWbcj6mNVC/6d5LLytmNIBORLdCem73M2jIAlY8lm7BV93MEj/RLrVq6FmKXLlPBQIWsG0B2xZbChZLtlTaN3ANuJ4z6sLeYq/GLVK+5yybMUBdtCoC7wXIeed8xaGAGgGGgFvf7AcWAqOSlCLbHAQn3iQZM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2399.namprd12.prod.outlook.com (2603:10b6:802:2b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 19:44:08 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 19:44:08 +0000
Subject: Re: [PATCH] target/i386: Fix the CPUID leaf CPUID_Fn80000008
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200417151432.46867.72601.stgit@localhost.localdomain>
 <20200417191513.GD4952@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <114b32f5-6557-4d94-a212-f44137ccf003@amd.com>
Date: Fri, 17 Apr 2020 14:44:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200417191513.GD4952@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:3:103::28) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR12CA0066.namprd12.prod.outlook.com (2603:10b6:3:103::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 19:44:07 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a350ad59-3798-4f4e-c47d-08d7e307b1ed
X-MS-TrafficTypeDiagnostic: SN1PR12MB2399:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23991D161F18120ECFA9D28695D90@SN1PR12MB2399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(2906002)(2616005)(956004)(5660300002)(316002)(8936002)(966005)(31686004)(16576012)(81156014)(8676002)(44832011)(6916009)(66556008)(66476007)(66946007)(36756003)(186003)(53546011)(52116002)(26005)(478600001)(4326008)(16526019)(6486002)(45080400002)(31696002)(86362001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HY7qtr2eWlAWDyKmjEbVZdJUv33H9w8Kqp7e+37l6TToxX+wEwstdirJe2rQG/ikfaCNJPWL2NOYzysLFx5Qe7CMTENswW53WK8trq7Sg9vV0xtPBz8745L1nzEOLRmk7ONapU2MLeDuagjjDb5ysSIC3hdZd4FI4295Hb1ecPMg+QwceMXIdskY7i7jsWjaFuaUEelW0za+w+dkcc2GINKpNBPwApDnQc+2WSckMacUCnQKgnoce7GeVaQcf6hAMT7vgXPEQPxm3yFlJi3Nwf3N/WFJxq7HjQ6hmx9UHb0BeKI2OLoS4aiLvYNPc3HfLazneQJhL5Ch6/pON1DaZhsSb/B3Nf/qlnaynfrhbnnvmP/FvcsQaltDijZFxYYpH5s0S0jwDrl120BHo+2jNOPaWXAOj9AUPglkf0Ya85DX3TQmhBkM0KjdNlmSPOHo07XhirTzIdVnbCsFkVIEJ7UeXYpnly92NrUkfQ1XXaZMeB18ds5RFFIxpRqEqcYT4iGLbbJzNL2jLvkC2s5voQ==
X-MS-Exchange-AntiSpam-MessageData: nKVSA4Sbzbz8yRsOzBNtBChzEQyTfdlhTtOWZnIU9VTQfJkvfiObg4Jo61MVrdQ9PiLclCzZfiFNCC/q2afIFt2n8dlLq0yWqF+WyYHlWxx5Egf/RCe/aHH7wZOUn4abj+L+YnKL4xwGNlWTy9hDew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a350ad59-3798-4f4e-c47d-08d7e307b1ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 19:44:08.8198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BFk3fcf5RZ2uPaNl6TZTEKh8nYTshTFGNySTVfHzKtFl6RFvKVSrPut8fTOlOqf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2399
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.41
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
Cc: pbonzini@redhat.com, imammedo@redhat.com, 1871842@bugs.launchpad.net,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/17/20 2:15 PM, Eduardo Habkost wrote:
> Good catch, thanks for the patch.  Comments below:
> 
> On Fri, Apr 17, 2020 at 10:14:32AM -0500, Babu Moger wrote:
>> CPUID leaf CPUID_Fn80000008_ECX provides information about the
>> number of threads supported by the processor. It was found that
>> the field ApicIdSize(bits 15-12) was not set correctly.
>>
>> ApicIdSize is defined as the number of bits required to represent
>> all the ApicId values within a package.
>>
>> Valid Values: Value Description
>> 3h-0h		Reserved.
>> 4h		up to 16 threads.
>> 5h		up to 32 threads.
>> 6h		up to 64 threads.
>> 7h		up to 128 threads.
>> Fh-8h		Reserved.
>>
>> Fix the bit appropriately.
>>
>> This came up during following thread.
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2F158643709116.17430.15995069125716778943.malonedeb%40wampee.canonical.com%2F%23t&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C1b8d59370cdb403dd54308d7e303adb7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637227477274521298&amp;sdata=NZHLwOkQrbjkGeqYSI0wgRNUd3QHRCf7lBtdqoR5XfI%3D&amp;reserved=0
>>
>> Refer the Processor Programming Reference (PPR) for AMD Family 17h
>> Model 01h, Revision B1 Processors. The documentation is available
>> from the bugzilla Link below.
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C1b8d59370cdb403dd54308d7e303adb7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637227477274521298&amp;sdata=oNLqu0J49eTrJ8pQ6GKg64ZUDfV3egZN2VVkU0DwMaU%3D&amp;reserved=0
>>
>> Reported-by: Philipp Eppelt <1871842@bugs.launchpad.net>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  target/i386/cpu.c |   12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 90ffc5f..68210f6 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -5830,11 +5830,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>              *eax = cpu->phys_bits;
>>          }
>>          *ebx = env->features[FEAT_8000_0008_EBX];
>> -        *ecx = 0;
>> -        *edx = 0;
>>          if (cs->nr_cores * cs->nr_threads > 1) {
>> -            *ecx |= (cs->nr_cores * cs->nr_threads) - 1;
> 
> I'm not sure we want a compatibility flag to keep ABI on older
> machine types, here.  Strictly speaking, CPUID must never change
> on older machine types, but sometimes trying hard to emulate bugs
> of old QEMU versions is a pointless exercise.

Not sure about this. But it seemed like nobody cared about this field before.
> 
> 
>> +            unsigned int max_apicids, bits_required;
>> +
>> +            max_apicids = (cs->nr_cores * cs->nr_threads) - 1;
>> +            /* Find out the number of bits to represent all the apicids */
>> +            bits_required = 32 - clz32(max_apicids);
> 
> This won't work if nr_cores > 1 and nr_threads is not a power of
> 2, will it?

It seem to work. Tested with threads=5,cores=3.

> 
> For reference, the field is documented[1] as:
> 
> "The number of bits in the initial Core::X86::Apic::ApicId[ApicId]
> value that indicate thread ID within a package"
> 
> This sounds like the value already stored at
> CPUX86State::pkg_offset.

Yes, it is already in pkg_offset. We can use it.

> 
> 
>> +            *ecx = bits_required << 12 | max_apicids;
> 
> Bits 7:0 are documented as "The number of threads in the package
> is NC+1", with no reference to APIC IDs at all.
> 
> Using ((nr_cores * nr_threads) - 1) for bits 7:0 sounds correct,
> but the variable name seems misleading.

I can change the variable name to num_threads.
> 
> 
>> +        } else {
>> +            *ecx = 0;
>>          }
>> +        *edx = 0;
>>          break;
>>      case 0x8000000A:
>>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>>
>>
> 
> References:
> 
> [1] Processor Programming Reference (PPR) for
>     AMD Family 17h Model 18h, Revision B1 Processors
>     55570-B1 Rev 3.14 - Sep 26, 2019
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D287395%26action%3Dedit&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C1b8d59370cdb403dd54308d7e303adb7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637227477274521298&amp;sdata=UsM3h4vp3dTgigqOvt7GrGiIUHvH8Kn1g%2BO%2FfGMav%2Bc%3D&amp;reserved=0
> 
> 

