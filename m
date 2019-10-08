Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7732FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 08:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3DC206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 08:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3DC206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHkWb-0001ji-DM
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 04:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iHkVZ-0000k8-Bx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iHkVY-0007lD-4o
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:06:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42180 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iHkVU-0007gY-QQ; Tue, 08 Oct 2019 04:06:09 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 42FE0AF6A3E762B4E9AC;
 Tue,  8 Oct 2019 16:06:04 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 16:05:54 +0800
Subject: Re: [PATCH v18 5/6] target-arm: kvm64: inject synchronous External
 Abort
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-6-zhengxiang9@huawei.com>
 <CAFEAcA-xc2XUq2Kwa1cK=4sAMq8B-2jUFAmxiGOQbmRCp-+UmQ@mail.gmail.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <76f33d58-d9b5-3a68-ecfa-72fd0d7eb445@huawei.com>
Date: Tue, 8 Oct 2019 16:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xc2XUq2Kwa1cK=4sAMq8B-2jUFAmxiGOQbmRCp-+UmQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>, QEMU
 Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/9/27 21:33, Peter Maydell wrote:
> On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>
>> Introduce kvm_inject_arm_sea() function in which we will setup the type
>> of exception and the syndrome information in order to inject a virtual
>> synchronous external abort. When switching to guest, it will jump to the
>> synchronous external abort vector table entry.
>>
>> The ESR_ELx.DFSC is set to synchronous external abort(0x10), and
>> ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
>> not valid and hold an UNKNOWN value. These values will be set to KVM
>> register structures through KVM_SET_ONE_REG IOCTL.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> 
>> +/* Inject synchronous external abort */
>> +static void kvm_inject_arm_sea(CPUState *c)
> 
> This will cause a compilation failure at this point in
> the patch series, because the compiler will complain about
> a static function which is defined but never used.
> To avoid breaking bisection, we need to put the definition
> of the function in the same patch where it's used.

Thanks, I will merge this patch with the next patch.

> 
>> +{
>> +    ARMCPU *cpu = ARM_CPU(c);
>> +    CPUARMState *env = &cpu->env;
>> +    CPUClass *cc = CPU_GET_CLASS(c);
>> +    uint32_t esr;
>> +    bool same_el;
>> +
>> +    /**
>> +     * Set the exception type to synchronous data abort
>> +     * and the target exception Level to EL1.
>> +     */
> 
> This comment doesn't really tell us anything that's not obvious
> from the two lines of code that it's commenting on:

Yes, I will remove this comment.

> 
>> +    c->exception_index = EXCP_DATA_ABORT;
>> +    env->exception.target_el = 1;
>> +
>> +    /*
>> +     * Set the DFSC to synchronous external abort and set FnV to not valid,
>> +     * this will tell guest the FAR_ELx is UNKNOWN for this abort.
>> +     */
>> +
>> +    /* This exception comes from lower or current exception level. */
> 
> This comment too is stating the obvious I think.

I will remove it too.

> 
>> +    same_el = arm_current_el(env) == env->exception.target_el;
>> +    esr = syn_data_abort_no_iss(same_el, 1, 0, 0, 0, 0, 0x10);
>> +
>> +    env->exception.syndrome = esr;
>> +
>> +    /**
> 
> There's a stray second '*' in this comment-start.

OK, I will remove this stray '*'.

> 
> 
>> +     * The vcpu thread already hold BQL, so no need hold again when
>> +     * calling do_interrupt
> 
> I think this requirement would be better placed as a
> comment at the top of the function noting that callers
> must hold the iothread lock.

OK, I will add the comment at the top of the function.

> 
>> +     */
>> +    cc->do_interrupt(c);
>> +}
>> +
>>  #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>>                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>>
>> diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
>> index 5feb312941..499672ebbc 100644
>> --- a/target/arm/tlb_helper.c
>> +++ b/target/arm/tlb_helper.c
>> @@ -33,7 +33,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
>>       * ISV field.
>>       */
>>      if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
>> -        syn = syn_data_abort_no_iss(same_el,
>> +        syn = syn_data_abort_no_iss(same_el, 0,
>>                                      ea, 0, s1ptw, is_write, fsc);
>>      } else {
>>          /*
>> --
>> 2.19.1
> 
> thanks
> -- PMM
> 
> .
> 

-- 

Thanks,
Xiang


