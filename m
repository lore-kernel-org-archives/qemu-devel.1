Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385982072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385982072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgMFB-0005K1-Fn
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jgMEZ-0004sk-PS; Wed, 03 Jun 2020 01:46:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jgMEX-0006Me-86; Wed, 03 Jun 2020 01:46:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.05565376|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0631394-0.000127326-0.936733;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03296; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.HhSgiM9_1591163185; 
Received: from 30.225.208.46(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HhSgiM9_1591163185)
 by smtp.aliyun-inc.com(10.147.42.198);
 Wed, 03 Jun 2020 13:46:25 +0800
Subject: Re: [PATCH v8 30/62] target/riscv: Update fp_status when float
 rounding mode changes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-31-zhiwei_liu@c-sky.com>
 <7cb2aa5d-833a-8544-dadc-5aabba06ecd2@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <ca1e71cd-c290-5fb9-e9bf-026c73e06560@c-sky.com>
Date: Wed, 3 Jun 2020 13:46:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7cb2aa5d-833a-8544-dadc-5aabba06ecd2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:46:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/6/3 12:27, Richard Henderson wrote:
> On 5/21/20 2:43 AM, LIU Zhiwei wrote:
>> @@ -174,6 +175,9 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>>       env->mstatus |= MSTATUS_FS;
>>   #endif
>>       env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
>> +    if (!riscv_cpu_set_rounding_mode(env, env->frm)) {
>> +        return -1;
>> +    }
> This will raise an exception immediately in helper_csrrw().
>
> According to Section 8.2, the no exception should occur until the next fp
> operation that uses the invalid frm.
>
> You're doing this just fine in helper_set_rounding_mode(), which is sufficient
> for scalar fp ops.  Without looking forward to later patches, I suppose we'll
> need to do something else for vector fp ops.
Hi Richard,

I think you are right.  Maybe I should transmit frm to ctx->frm, and 
check ctx->frm in vector fp ops.

We can set ctx->frm = env->frm instead of ctx->frm = -1 in 
riscv_tr_init_disas_context.
And  remove the sentence ctx->frm = rm; from gen_set_rm.

Is it right?

Zhiwei
>
> r~


