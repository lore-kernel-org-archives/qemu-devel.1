Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73EC433EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4200D20714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4200D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqqc-0003b0-J0
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jyqpx-00034T-VW; Fri, 24 Jul 2020 02:05:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jyqpv-0004Bu-8P; Fri, 24 Jul 2020 02:05:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1413044|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0934425-0.00159043-0.904967;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03308; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.I6om39v_1595570734; 
Received: from 30.225.208.37(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I6om39v_1595570734)
 by smtp.aliyun-inc.com(10.147.44.145);
 Fri, 24 Jul 2020 14:05:34 +0800
Subject: Re: [PATCH v2 1/7] target/riscv: Generate nanboxed results from fp
 helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-2-richard.henderson@linaro.org>
 <1aa6cb56-2f41-45c1-2d32-ec8b3b10780b@c-sky.com>
 <9e10c17c-7a9e-5f7f-b1e3-c195d4e30b32@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <ccc72223-d98e-6dd4-6c44-ca30f4e687d5@c-sky.com>
Date: Fri, 24 Jul 2020 14:05:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9e10c17c-7a9e-5f7f-b1e3-c195d4e30b32@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 02:04:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/24 11:55, Richard Henderson wrote:
> On 7/23/20 7:35 PM, LIU Zhiwei wrote:
>>
>> On 2020/7/24 8:28, Richard Henderson wrote:
>>> Make sure that all results from single-precision scalar helpers
>>> are properly nan-boxed to 64-bits.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/riscv/internals.h  |  5 +++++
>>>    target/riscv/fpu_helper.c | 42 +++++++++++++++++++++------------------
>>>    2 files changed, 28 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
>>> index 37d33820ad..9f4ba7d617 100644
>>> --- a/target/riscv/internals.h
>>> +++ b/target/riscv/internals.h
>>> @@ -38,4 +38,9 @@ target_ulong fclass_d(uint64_t frs1);
>>>    #define SEW32 2
>>>    #define SEW64 3
>>>    +static inline uint64_t nanbox_s(float32 f)
>>> +{
>>> +    return f | MAKE_64BIT_MASK(32, 32);
>>> +}
>>> +
>> If define it here,  we can also define a more general  function with flen.
>>
>> +static inline uint64_t nanbox_s(float32 f, uint32_t flen)
>> +{
>> +    return f | MAKE_64BIT_MASK(flen, 64 - flen);
>> +}
>> +
>>
>> So we can reuse it in fp16 or bf16 scalar instruction and in vector instructions.
> While we could do that, we will not encounter all possible lengths.  In the
> cover letter, I mentioned defining a second function,
>
> static inline uint64_t nanbox_h(float16 f)
> {
>     return f | MAKE_64BIT_MASK(16, 48);
> }
>
> Having two separate functions will, I believe, be easier to use in practice.
>
Get  it. Thanks.

Zhiwei
>
> r~


