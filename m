Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B461C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B84A207DE
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B84A207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFK3r-0006F1-Nx
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kFK2m-00056Y-57
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:31:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:37584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kFK2h-0007PE-TV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:30:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 01F03AFD5;
 Mon,  7 Sep 2020 16:30:55 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PULL 3/5] softmmu/cpus: Only set parallel_cpus for SMP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
 <20200903214101.1746878-4-richard.henderson@linaro.org>
 <1f573d2d-b3bb-21ab-bbcd-b759fc14ad2b@suse.de>
 <3dfae924-34c9-e36a-77bf-f3abcdeaf268@amsat.org>
Message-ID: <7454d121-3ebd-623a-55a3-4ba6e7e870dc@suse.de>
Date: Mon, 7 Sep 2020 18:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3dfae924-34c9-e36a-77bf-f3abcdeaf268@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 21:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.825,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 12:20 PM, Philippe Mathieu-Daudé wrote:
> On 9/7/20 12:05 PM, Claudio Fontana wrote:
>> Hi Richard,
>>
>> currently rebasing on top of this one,
>> just a question, why is the patch not directly using "current_machine"?
> 
> For user mode?

In user mode I'd not expect softmmu/cpus.c to be built at all...

Ciao,

Claudio

> 
>>
>> Is using MACHINE(qdev_get_machine()) preferrable here?
>>
>> Thanks,
>>
>> Claudio
>>
>> On 9/3/20 11:40 PM, Richard Henderson wrote:
>>> Do not set parallel_cpus if there is only one cpu instantiated.
>>> This will allow tcg to use serial code to implement atomics.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  softmmu/cpus.c | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>>> index a802e899ab..e3b98065c9 100644
>>> --- a/softmmu/cpus.c
>>> +++ b/softmmu/cpus.c
>>> @@ -1895,6 +1895,16 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>>      if (!tcg_region_inited) {
>>>          tcg_region_inited = 1;
>>>          tcg_region_init();
>>> +        /*
>>> +         * If MTTCG, and we will create multiple cpus,
>>> +         * then we will have cpus running in parallel.
>>> +         */
>>> +        if (qemu_tcg_mttcg_enabled()) {
>>> +            MachineState *ms = MACHINE(qdev_get_machine());
>>
>> MachineState *ms = current_machine;
>> ?
>>
>>
>>> +            if (ms->smp.max_cpus > 1) {
>>> +                parallel_cpus = true;
>>> +            }
>>> +        }
>>>      }
>>>  
>>>      if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
>>> @@ -1904,7 +1914,6 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>>  
>>>          if (qemu_tcg_mttcg_enabled()) {
>>>              /* create a thread per vCPU with TCG (MTTCG) */
>>> -            parallel_cpus = true;
>>>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
>>>                   cpu->cpu_index);
>>>  
>>>
>>
>>


