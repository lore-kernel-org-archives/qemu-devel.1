Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54578C11D32
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD8F20836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3NkskxUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD8F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6H0X-0005iO-B7
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 11:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6Gzv-0005H1-OI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6Gzu-0000eJ-JE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:54:23 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com
 ([40.107.223.54]:6092 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6Gzu-0000dv-7s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:54:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+4r8QXcuXJx2ZoB+ByMvOFer4N3H97B8K6/mnoavm/WFPNJdAmnp8o4bwtHPFsv+vSUbav09ycn5tCvgj02oMTqXWYHLhX5ZktsM0jMNY7Zo3VT2DaXldKrFqIy3egYTyeVdfRisnbZhG889GNjnYdzvIrX+7qpbkYnQjuDIWAi3r5zCsCfSfNdd/6zWgHIeRkDbYGjJvg8q/orMejX5i7DTLPzloMZajivWHfd8FkGQsfDDnlw131reCztzJN7ILFWmDEQ6KmIUtLqB7Mi+vnhgYYDyneWt/QJUZlMO8pnpiF3pU/9HeGTJqagk8DE2Fv9j0Vt3sEPRX8G88xzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAqdQZixbY4/Cd8sWHJTdQfrCT6519oGYXv+XvaCbnU=;
 b=Z8iMEvJ0A/KsrSF6uxdokc15r8kuetKWxXorw9O9gP9kro2ERQGBU50hgYdl28PiSL2RxrYX+qtEYbCcxNAZfUH/NmWVtbvijbPG7sc5+kXP6Bse4O88RuA/VaR2cQ6wtjLBiMQVdfCgHacUtXq+MZrGDiKLDbkBnGTe9aQu8zUtvveNyTrD4FBFmOIzrskC6RY7pxcmrPXxEgjeSVIp8BMpS6sW1XM4l046XRzPrDPf7sShrbTvBZUtGXL6BlsulFIMrqEbGlCpzjHRUuGBkUvtyKIgi076+kAK4QXwBsrmt+59/BccsrVuZf6mzbdSaFKVyRdqTfbOzqiGLQHi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAqdQZixbY4/Cd8sWHJTdQfrCT6519oGYXv+XvaCbnU=;
 b=3NkskxUt0Evgk99AHnGE179iMiLDSLdCY1Ic3aUynpdiXr6PEipi6g6SO8r8Tobn2LMu8UhJ3tftZvNXv2rS7T99Djkv3iFsaJisU3zmGRPJNnr7JBErw1VefUD0iVL94NkhwanQKm07dAzToZ/wXQ1zmDGKTJp/7LA0mm6AlmI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2478.namprd12.prod.outlook.com (2603:10b6:802:23::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Mon, 24 Feb
 2020 16:54:20 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 16:54:20 +0000
Subject: Re: [PATCH v4 04/16] hw/i386: Introduce init_topo_info to initialize
 X86CPUTopoInfo
To: Igor Mammedov <imammedo@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161781120.48948.3568234592332597800.stgit@naples-babu.amd.com>
 <20200221180501.72e4ff3c@redhat.com>
 <3188d0e7-7f1c-aa03-d3ec-f512d9905158@amd.com>
 <20200224091833.2d3dec7f@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <47d531cb-1f52-f9b4-dcf2-24f119baadff@amd.com>
Date: Mon, 24 Feb 2020 10:54:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224091833.2d3dec7f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:805:f2::37) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN6PR04CA0096.namprd04.prod.outlook.com (2603:10b6:805:f2::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21 via Frontend Transport; Mon, 24 Feb 2020 16:54:18 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 199772b3-e6e3-4296-5ca0-08d7b94a30f8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2478:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24787FAFFB974520623FB2BE95EC0@SN1PR12MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(16526019)(186003)(66556008)(66946007)(6486002)(2906002)(66476007)(26005)(36756003)(53546011)(478600001)(81166006)(86362001)(31696002)(5660300002)(956004)(81156014)(8676002)(2616005)(44832011)(316002)(52116002)(8936002)(16576012)(6916009)(31686004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2478;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvv1L0rN0XIvPMGBUayiPGurXHgSLzO8I9ThGFVt/eLXuMYcDIanSFFHKy8c4j67n7IA6Aavff3Pta8fzKV9VMJMPUg8TAmK2rkxEuwgaY5UMcXXRSOHXVyaLguEeJWmqz5uStaGCvavck1AyRbh5XjfPdQwrgNn645AQkDoi8dvH4SpY1ry0Es8IOqzhK2VuzUROPaYE1fAW2blq8Rq7ZLDwMfNElq6hUa4I6qCEhWYtD4FpGikPzf5ZKkvPJ2fg7FXAw+/LcCF4j9I7PL1Jd3QshsscbHZUJ8VESfwstsTJEkL9JJxeuNxoAx7wNBNZYromgBaSunuj8FRKe5VnpU51l00xZEh2uLKsPhC9hu//JMn7m8cRqhVJpqLrH0UTJWTonPMjbpygBcOACuDly6WzH633/IInSpb95sf2Rn66GpRmy1YAUsjbKztU11F
X-MS-Exchange-AntiSpam-MessageData: F+vlR+5hU1DnAOZ4c3BXv+mMH4cuSrAI83ogR9XYPoLW7FofO0n6aILkbC/v2pRmKEhTYxrRI6SAgTvgfaYYRtMgU2mS/3aGVdid/YdjM6afUnTLDVN5MVa23VvNFXsEGUNUr+8+N6+YgPPzt8iMjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199772b3-e6e3-4296-5ca0-08d7b94a30f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 16:54:20.0573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tvn1lFG8RWARVE9pyNGP1n4i7twVaj1QukI1ql/DhZwvVVwRc8WKSx/egGHaSECJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2478
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.54
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



On 2/24/20 2:18 AM, Igor Mammedov wrote:
> On Fri, 21 Feb 2020 11:51:15 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> On 2/21/20 11:05 AM, Igor Mammedov wrote:
>>> On Thu, 13 Feb 2020 12:16:51 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>   
>>>> Initialize all the parameters in one function init_topo_info.  
>>>
>>> is it possible to squash it in 2/16
>>>   
>> Sure. We can do that.
>>>   
>>>>
>>>> Move the data structure X86CPUTopoIDs and X86CPUTopoInfo into
>>>> x86.h.  
>>> A reason why it's moved should be here.  
>>
>> Apicid functions will be part of X86MachineState data structure(patches
>> introduced later).These functions will use X86CPUTopoIDs and
>> X86CPUTopoInfo definition. Will add these details. Thanks
> 
> why not just include topology.h into the X86MachineState header,
> and keep topo structures/functions where they are now?
> (I dislike a little scattering consolidated pieces across multiple files,
> but what worries me more is that it makes target/i386/cpu.c via
> topology.h -> x86.h chain pull in a lot of unrelated dependencies)
> 
> So I'd keep X86CPUTopoIDs and X86CPUTopoInfo in topology.h 

Ok. Sure. we can do that.

> 
> [...]
>>>> +static inline void init_topo_info(X86CPUTopoInfo *topo_info,
>>>> +                                  const X86MachineState *x86ms)
>>>> +{
>>>> +    MachineState *ms = MACHINE(x86ms);
>>>> +
>>>> +    topo_info->dies_per_pkg = x86ms->smp_dies;
>>>> +    topo_info->cores_per_die = ms->smp.cores;
>>>> +    topo_info->threads_per_core = ms->smp.threads;
>>>> +}
> 
> this is pure machine specific helper, and aren't used anywhere else
> beside machine code.
> Suggest to put it in pc.c or x86.c to keep topology.h machine independent.

Ok. Will do.

> 
>>>>  
>>>>  /* Return the bit width needed for 'count' IDs
>>>>   */
>>>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>>>> index 4b84917885..ad62b01cf2 100644
>>>> --- a/include/hw/i386/x86.h
>>>> +++ b/include/hw/i386/x86.h
>>>> @@ -36,6 +36,23 @@ typedef struct {
>>>>      bool compat_apic_id_mode;
>>>>  } X86MachineClass;
>>>>  
>>>> +/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
>>>> + */
>>>> +typedef uint32_t apic_id_t;
>>>> +
>>>> +typedef struct X86CPUTopoIDs {
>>>> +    unsigned pkg_id;
>>>> +    unsigned die_id;
>>>> +    unsigned core_id;
>>>> +    unsigned smt_id;
>>>> +} X86CPUTopoIDs;
>>>> +
>>>> +typedef struct X86CPUTopoInfo {
>>>> +    unsigned dies_per_pkg;
>>>> +    unsigned cores_per_die;
>>>> +    unsigned threads_per_core;
>>>> +} X86CPUTopoInfo;
>>>> +
>>>>  typedef struct {
>>>>      /*< private >*/
>>>>      MachineState parent;
>>>>  
>>>   
>>
> 

