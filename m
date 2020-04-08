Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A45C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 07:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85432072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 07:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85432072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM53c-0004wQ-4b
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 03:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jM530-0004Rv-9U
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jM52z-0001is-8u
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:22:54 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:60451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jM52z-0001iI-2O
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:22:53 -0400
Received: from player691.ha.ovh.net (unknown [10.110.103.180])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id B1988278668
 for <qemu-devel@nongnu.org>; Wed,  8 Apr 2020 09:22:50 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id D78A5114D8539;
 Wed,  8 Apr 2020 07:22:44 +0000 (UTC)
Subject: Re: [PATCH v4 4/4] target/ppc: Add support for Radix partition-scoped
 translation
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
References: <20200403140056.59465-1-clg@kaod.org>
 <20200403140056.59465-5-clg@kaod.org> <20200403171129.71c86479@bahia.lan>
 <20200408030931.GB304335@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8c0894e4-43e2-2914-e7d0-e24a377670fb@kaod.org>
Date: Wed, 8 Apr 2020 09:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408030931.GB304335@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8919942014714284952
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeigdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.35.78
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>> -    *raddr = g_raddr;
>>> +    /*
>>> +     * Perform partition-scoped translation if !HV or HV access to
>>> +     * quadrants 1 or 2. Translates a guest real address to a host
>>> +     * real address.
>>> +     */
>>> +    if ((lpid != 0) || (!cpu->vhyp && !msr_hv)) {
>>
>> This check is too complex for my taste. Also it doesn't seem right
>> to look at lpid if the machine is pseries, even if it would happen
>> to work because pseries cannot have lpid != 0. I think we should
>> have distinct paths for powernv and pseries.
>>
>> A bit like with the following squashed in:
>>
>> =======================================
>> --- a/target/ppc/mmu-radix64.c
>> +++ b/target/ppc/mmu-radix64.c
>> @@ -489,22 +489,28 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>          g_raddr = eaddr & R_EADDR_MASK;
>>      }
>>  
>> -    /*
>> -     * Perform partition-scoped translation if !HV or HV access to
>> -     * quadrants 1 or 2. Translates a guest real address to a host
>> -     * real address.
>> -     */
>> -    if ((lpid != 0) || (!cpu->vhyp && !msr_hv)) {
>> -        int ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
>> +    if (cpu->vhyp) {
>> +        *raddr = g_raddr;
>> +    } else {
>> +        /*
>> +         * Perform partition-scoped translation if !HV or HV access to
>> +         * quadrants 1 or 2. Translates a guest real address to a host
>> +         * real address.
>> +         */
>> +        if (lpid || !msr_hv) {
>> +            int ret;
>> +
>> +            ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
>>                                                       pate, raddr, &prot, &psize,
>>                                                       0, cause_excp);
>> -        if (ret) {
>> -            return ret;
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +            *psizep = MIN(*psizep, psize);
>> +            *protp &= prot;
>> +        } else {
>> +            *raddr = g_raddr;
>>          }
>> -        *psizep = MIN(*psizep, psize);
>> -        *protp &= prot;
>> -    } else {
>> -        *raddr = g_raddr;
>>      }
>>  
>>      return 0;
>> =======================================
>>
>> David,
>>
>> If my comment makes sense to you, can you squash the above fix into
>> Cedric's patch ?
> 
> Yes.  I also think we shouldn't be looking at lpid for the vhyp case.
> I've applied the rest of the series to ppc-for-5.1, and folded in this
> correction as suggested.


I explored a solution with two ppc_radix64_xlate() routines, one simple 
for pseries, a second more complex for powernv but it didn't look very
good. May be it will be easier now that the first patches are merged. 

Thanks,

C. 



