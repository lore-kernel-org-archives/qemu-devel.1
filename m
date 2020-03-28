Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0465C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912402073B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912402073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIDbp-0007CS-PQ
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 11:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIDaq-0006E1-PU
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIDao-0001Xr-RF
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:41:51 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIDao-0001TG-Ad; Sat, 28 Mar 2020 11:41:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08403444|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.257382-0.000169523-0.742449;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H6jJR.l_1585410094; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H6jJR.l_1585410094)
 by smtp.aliyun-inc.com(10.147.41.199);
 Sat, 28 Mar 2020 23:41:34 +0800
Subject: Re: [PATCH v6 26/61] target/riscv: vector single-width fractional
 multiply with rounding and saturation
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-27-zhiwei_liu@c-sky.com>
 <9f5fd1a3-f32f-9779-6d5c-abdedc10fd2d@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <02abbce7-b9c0-8708-ee29-117a5c437f31@c-sky.com>
Date: Sat, 28 Mar 2020 23:41:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9f5fd1a3-f32f-9779-6d5c-abdedc10fd2d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2020/3/28 9:08, Richard Henderson wrote:
> On 3/17/20 8:06 AM, LIU Zhiwei wrote:
>> +static int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
>> +{
>> +    uint8_t round;
>> +    uint64_t hi_64, lo_64, Hi62;
>> +    uint8_t hi62, hi63, lo63;
>> +
>> +    muls64(&lo_64, &hi_64, a, b);
>> +    hi62 = extract64(hi_64, 62, 1);
>> +    lo63 = extract64(lo_64, 63, 1);
>> +    hi63 = extract64(hi_64, 63, 1);
>> +    Hi62 = extract64(hi_64, 0, 62);
> This seems like way more work than necessary.
>
>> +    if (hi62 != hi63) {
>> +        env->vxsat = 0x1;
>> +        return INT64_MAX;
>> +    }
> This can only happen for a == b == INT64_MIN.
> Perhaps just test exactly that and move it above the multiply?
>
>> +    round = get_round(vxrm, lo_64, 63);
>> +    if (round && (Hi62 == 0x3fffffff) && lo63) {
>> +        env->vxsat = 0x1;
>> +        return hi62 ? INT64_MIN : INT64_MAX;
>> +    } else {
>> +        if (lo63 && round) {
>> +            return (hi_64 + 1) << 1;
>> +        } else {
>> +            return (hi_64 << 1) | lo63 | round;
>> +        }
>> +    }
Yes, it's an error here. As INT64_MIN will never be  a right result.
>    /* Cannot overflow, as there are always
>       2 sign bits after multiply. */
>    ret = (hi_64 << 1) | (lo_64 >> 63);
>    if (round) {
>        if (ret == INT64_MAX) {
>            env->vxsat = 1;
>        } else {
>            ret += 1;
>        }
>    }
>    return ret;
>
Thanks. I think it's  right and much clearer.

Zhiwei.
> r~


