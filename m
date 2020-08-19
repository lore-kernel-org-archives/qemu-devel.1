Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8402075E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8402075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OU6-0004Uj-5T
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k8OTO-0003cB-4z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:49:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k8OTM-0003HE-Dh
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:49:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AF01CB181;
 Wed, 19 Aug 2020 13:50:13 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 02/14] cpus: prepare new CpusAccel cpu accelerator
 interface
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-3-cfontana@suse.de>
 <83d22792-b436-1332-9457-1110b758f183@linaro.org>
Message-ID: <66ef16b4-aec8-22ef-a190-0242c31fd3f9@suse.de>
Date: Wed, 19 Aug 2020 15:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <83d22792-b436-1332-9457-1110b758f183@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Richard,

On 8/14/20 10:28 PM, Richard Henderson wrote:
> On 8/12/20 11:32 AM, Claudio Fontana wrote:
>>  uint64_t cpu_get_tsc(CPUX86State *env)
>>  {
>> -    return cpu_get_ticks();
>> +    return cpus_get_elapsed_ticks();
> 
> What has this change got to do with creating the interface?
> You said the interface wasn't used yet...

the new CpusAccel interface isn't used,

The cpu_get_ticks() function is changed to mean getting the actual cpu ticks,
while cpus_get_elapsed_ticks() contains the code that special cases icount and qtest,
until the respective CpusAccel enablement patches.

> 
> 
>> diff --git a/stubs/cpu-synchronize-state.c b/stubs/cpu-synchronize-state.c
>> new file mode 100644
>> index 0000000000..3112fe439d
>> --- /dev/null
>> +++ b/stubs/cpu-synchronize-state.c
>> @@ -0,0 +1,15 @@
>> +#include "qemu/osdep.h"
>> +#include "sysemu/hw_accel.h"
>> +
>> +void cpu_synchronize_state(CPUState *cpu)
>> +{
>> +}
>> +void cpu_synchronize_post_reset(CPUState *cpu)
>> +{
>> +}
>> +void cpu_synchronize_post_init(CPUState *cpu)
>> +{
>> +}
>> +void cpu_synchronize_pre_loadvm(CPUState *cpu)
>> +{
>> +}


these are needed for non softmmu builds by hw/core/cpu.c
and by gdbstub.c,
but actually we could get away with just _state() and _post_init(). Will remove the others.


>> diff --git a/stubs/cpus-get-virtual-clock.c b/stubs/cpus-get-virtual-clock.c
>> new file mode 100644
>> index 0000000000..fd447d53f3
>> --- /dev/null
>> +++ b/stubs/cpus-get-virtual-clock.c
>> @@ -0,0 +1,8 @@
>> +#include "qemu/osdep.h"
>> +#include "sysemu/cpu-timers.h"
>> +#include "qemu/main-loop.h"
>> +
>> +int64_t cpus_get_virtual_clock(void)
>> +{
>> +    return cpu_get_clock();
>> +}
> 
> How do these stubs get used?
> 
> 
> r~
> 

util/timer.c needs it for non-softmmu builds (see previous discussion with Paolo).

Thanks,

Claudio

