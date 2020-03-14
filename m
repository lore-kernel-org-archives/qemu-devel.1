Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D671C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BEA20674
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BEA20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2uA-0002h7-C3
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 05:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jD2tJ-0001wd-Kf
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jD2tI-0006G5-ID
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:15:33 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jD2tI-0005xL-4F; Sat, 14 Mar 2020 05:15:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07440776|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.163918-0.000573851-0.835508;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03267; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H.I-jki_1584177323; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.I-jki_1584177323)
 by smtp.aliyun-inc.com(10.147.42.253);
 Sat, 14 Mar 2020 17:15:24 +0800
Subject: Re: [PATCH v5 39/60] target/riscv: vector floating-point classify
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-40-zhiwei_liu@c-sky.com>
 <6710853a-3354-1064-a7f8-4c2378bd680d@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <de78aac2-42d6-52ec-8e7c-5e59ef1e06fd@c-sky.com>
Date: Sat, 14 Mar 2020 17:15:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6710853a-3354-1064-a7f8-4c2378bd680d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/14 17:10, Richard Henderson wrote:
> On 3/12/20 7:58 AM, LIU Zhiwei wrote:
>> +/* Vector Floating-Point Classify Instruction */
>> +static uint16_t fclass_f16(uint16_t frs1, float_status *s)
>> +{
>> +    float16 f = frs1;
>> +    bool sign = float16_is_neg(f);
>> +
>> +    if (float16_is_infinity(f)) {
>> +        return sign ? 1 << 0 : 1 << 7;
>> +    } else if (float16_is_zero(f)) {
>> +        return sign ? 1 << 3 : 1 << 4;
>> +    } else if (float16_is_zero_or_denormal(f)) {
>> +        return sign ? 1 << 2 : 1 << 5;
>> +    } else if (float16_is_any_nan(f)) {
>> +        float_status s = { }; /* for snan_bit_is_one */
>> +        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
>> +    } else {
>> +        return sign ? 1 << 1 : 1 << 6;
>> +    }
>> +}
>> +static uint32_t fclass_s(uint32_t frs1, float_status *s)
>> +{
>> +    float32 f = frs1;
>> +    bool sign = float32_is_neg(f);
>> +
>> +    if (float32_is_infinity(f)) {
>> +        return sign ? 1 << 0 : 1 << 7;
>> +    } else if (float32_is_zero(f)) {
>> +        return sign ? 1 << 3 : 1 << 4;
>> +    } else if (float32_is_zero_or_denormal(f)) {
>> +        return sign ? 1 << 2 : 1 << 5;
>> +    } else if (float32_is_any_nan(f)) {
>> +        float_status s = { }; /* for snan_bit_is_one */
>> +        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
>> +    } else {
>> +        return sign ? 1 << 1 : 1 << 6;
>> +    }
>> +}
>> +static uint64_t fclass_d(uint64_t frs1, float_status *s)
>> +{
>> +    float64 f = frs1;
>> +    bool sign = float64_is_neg(f);
>> +
>> +    if (float64_is_infinity(f)) {
>> +        return sign ? 1 << 0 : 1 << 7;
>> +    } else if (float64_is_zero(f)) {
>> +        return sign ? 1 << 3 : 1 << 4;
>> +    } else if (float64_is_zero_or_denormal(f)) {
>> +        return sign ? 1 << 2 : 1 << 5;
>> +    } else if (float64_is_any_nan(f)) {
>> +        float_status s = { }; /* for snan_bit_is_one */
>> +        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
>> +    } else {
>> +        return sign ? 1 << 1 : 1 << 6;
>> +    }
>> +}
> These need to be moved out of fpu_helper.c so they can be shared.
I will add an internals.h and move the declaration to internals.h.

Zhiwei

>
> r~


