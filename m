Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2CBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039B5206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039B5206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsdSz-0007U9-B2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jsdSR-00071o-4L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:35:43 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jsdSO-0001F2-3o
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:35:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07506576|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.282544-0.00145834-0.715997;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.HzLF518_1594089330; 
Received: from 30.225.208.48(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HzLF518_1594089330)
 by smtp.aliyun-inc.com(10.147.42.16); Tue, 07 Jul 2020 10:35:30 +0800
Subject: Re: [PULL v2 12/64] target/riscv: add vector amo operations
To: Alistair Francis <alistair23@gmail.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
 <20200702162354.928528-13-alistair.francis@wdc.com>
 <CAFEAcA8b7Rk8ZDDu689tRDCqcSKRbCGVf=75e0f0WNd2GJ9dmg@mail.gmail.com>
 <CAKmqyKMSvou0o52CR6Uo0pztsfZMqkVu5x0=HwMSMfkv2w4B4w@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <36f707be-8980-3f15-75d3-240873ab7c5f@c-sky.com>
Date: Tue, 7 Jul 2020 10:35:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMSvou0o52CR6Uo0pztsfZMqkVu5x0=HwMSMfkv2w4B4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 22:35:32
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/7 7:36, Alistair Francis wrote:
> On Sun, Jul 5, 2020 at 11:20 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>> On Thu, 2 Jul 2020 at 17:33, Alistair Francis <alistair.francis@wdc.com> wrote:
>>> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
>>>
>>> Vector AMOs operate as if aq and rl bits were zero on each element
>>> with regard to ordering relative to other instructions in the same hart.
>>> Vector AMOs provide no ordering guarantee between element operations
>>> in the same vector AMO instruction
>> Hi; Coverity thinks (probably wrongly) that there might be an array
>> overflow here:
>>
>>> +static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
>>> +{
>>> +    uint32_t data = 0;
>>> +    gen_helper_amo *fn;
>>> +    static gen_helper_amo *const fnsw[9] = {
>> This is a 9-element array...
>>
>>> +        /* no atomic operation */
>>> +        gen_helper_vamoswapw_v_w,
>>> +        gen_helper_vamoaddw_v_w,
>>> +        gen_helper_vamoxorw_v_w,
>>> +        gen_helper_vamoandw_v_w,
>>> +        gen_helper_vamoorw_v_w,
>>> +        gen_helper_vamominw_v_w,
>>> +        gen_helper_vamomaxw_v_w,
>>> +        gen_helper_vamominuw_v_w,
>>> +        gen_helper_vamomaxuw_v_w
>>> +    };
>>> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>>> +        gen_helper_exit_atomic(cpu_env);
>>> +        s->base.is_jmp = DISAS_NORETURN;
>>> +        return true;
>>> +    } else {
>>> +        if (s->sew == 3) {
>>> +#ifdef TARGET_RISCV64
>>> +            fn = fnsd[seq];
>>> +#else
>>> +            /* Check done in amo_check(). */
>>> +            g_assert_not_reached();
>>> +#endif
>>> +        } else {
>>> +            fn = fnsw[seq];
>> ...which we here index via 'seq'...
>>
>>
>>> +#ifdef TARGET_RISCV64
>>> +GEN_VEXT_TRANS(vamoswapd_v, 9, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamoaddd_v, 10, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamoxord_v, 11, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamoandd_v, 12, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamoord_v, 13, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamomind_v, 14, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
>>> +GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
>>> +#endif
>> ...which in the calls that these macros expand out to can
>> be 9 or greater.
>>
>> If it's in fact impossible to get into that code path
>> with a value of seq that's larger than the array, it
>> would help Coverity if we asserted so, maybe
>>     assert(seq < ARRAY_SIZE(fnsw));
>>
>> This is CID 1430177, 1430178, 1430179, 1430180, 1430181,
>> 1430182, 1430183, 1430184, 1430185, 14305186.
> @ LIU Zhiwei can you please look into this and send a patch with a fix?
Sure.

I will think about Richard's comments  before I send a patch to fix it.

I applied for a Coverity account just a moment ago, so that I can see 
what the CID details.

Best Regards,
Zhiwei
> Alistair
>
>> thanks
>> -- PMM


