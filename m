Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D77C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC1520684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC1520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYo40-000866-A6
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 04:48:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hYnyd-0003Zd-Cr
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hYntk-0005Hu-KS
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:37:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:59112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hYntd-000506-6t; Thu, 06 Jun 2019 04:37:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Jun 2019 01:37:09 -0700
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.166])
	([10.239.196.166])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	06 Jun 2019 01:37:07 -0700
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20190518205428.90532-1-like.xu@linux.intel.com>
	<20190518205428.90532-5-like.xu@linux.intel.com>
	<20190606025241.GM22416@habkost.net>
	<20190606025456.GN22416@habkost.net>
	<20190606030732.GL10319@umbus.fritz.box>
	<20190606102017.264123c5@bahia.lab.toulouse-stg.fr.ibm.com>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <26cd4c51-2c19-1dab-3287-fec805535c93@linux.intel.com>
Date: Thu, 6 Jun 2019 16:37:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606102017.264123c5@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 04/10] hw/ppc: Replace global
 smp variables with machine smp properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair23@gmail.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/6/6 16:20, Greg Kurz wrote:
> On Thu, 6 Jun 2019 13:07:32 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> On Wed, Jun 05, 2019 at 11:54:56PM -0300, Eduardo Habkost wrote:
>>> On Wed, Jun 05, 2019 at 11:52:41PM -0300, Eduardo Habkost wrote:
>>>> On Sun, May 19, 2019 at 04:54:22AM +0800, Like Xu wrote:
>>>>> The global smp variables in ppc are replaced with smp machine properties.
>>>>>
>>>>> A local variable of the same name would be introduced in the declaration
>>>>> phase if it's used widely in the context OR replace it on the spot if it's
>>>>> only used once. No semantic changes.
>>>>>
>>>>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>>>>
>>>> Any objections from the ppc maintainers to queueing this through
>>>> the Machine Core tree?
>>>
>>> Oops, CCing the ppc maintainers.
>>
>> No objection here.
>>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>
> 
> Just one nit...
> 
> [...]
> 
>>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>>> index ee24212765..c9ffe9786c 100644
>>>>> --- a/hw/ppc/spapr_rtas.c
>>>>> +++ b/hw/ppc/spapr_rtas.c
>>>>> @@ -231,6 +231,8 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
>>>>>                                             target_ulong args,
>>>>>                                             uint32_t nret, target_ulong rets)
>>>>>   {
>>>>> +    MachineState *ms = MACHINE(qdev_get_machine());
> 
> rtas_ibm_get_system_parameter() has a SpaprMachineState *spapr argument, no
> need to rely on qdev_get_machine().

I will fix it in the next (rebased) version. Thank you, Greg.

> 
> But this can be fixed in a followup patch I guess. Not worth holding the
> patchset because of that.
> 
>>>>> +    unsigned int max_cpus = ms->smp.max_cpus;
>>>>>       target_ulong parameter = rtas_ld(args, 0);
>>>>>       target_ulong buffer = rtas_ld(args, 1);
>>>>>       target_ulong length = rtas_ld(args, 2);
>>>>> @@ -244,7 +246,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
>>>>>                                             "MaxPlatProcs=%d",
>>>>>                                             max_cpus,
>>>>>                                             current_machine->ram_size / MiB,
>>>>> -                                          smp_cpus,
>>>>> +                                          ms->smp.cpus,
>>>>>                                             max_cpus);
>>>>>           ret = sysparm_st(buffer, length, param_val, strlen(param_val) + 1);
>>>>>           g_free(param_val);
>>>>    
>>>    
>>
> 


