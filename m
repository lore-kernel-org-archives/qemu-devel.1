Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB994C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 00:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25352074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 00:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25352074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqQSQ-0004nu-V7
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 20:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqQRf-0004Mo-9z; Tue, 30 Jun 2020 20:17:47 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqQRc-0003re-GV; Tue, 30 Jun 2020 20:17:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1038864|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0204555-0.0355056-0.944039;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.HvSiHYq_1593562652; 
Received: from 30.225.208.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HvSiHYq_1593562652)
 by smtp.aliyun-inc.com(10.147.40.26); Wed, 01 Jul 2020 08:17:33 +0800
Subject: Re: [PATCH v1 3/3] target/riscv: Regen floating point rounding mode
 in dynamic mode
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
 <cd66f31b-2c07-da29-c14c-5f1079e016e3@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <de03f2b1-ea30-e02d-1511-2de95e5dab5e@c-sky.com>
Date: Wed, 1 Jul 2020 08:17:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cd66f31b-2c07-da29-c14c-5f1079e016e3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 20:17:36
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/1 5:51, Richard Henderson wrote:
> On 6/30/20 1:12 PM, Alistair Francis wrote:
>> When a guest specificies the the rounding mode should be dynamic 0b111
>> then we want to re-caclulate the rounding mode on each instruction. The
>> gen_helper_set_rounding_mode() function will correctly check the
>> rounding mode and handle a dynamic rounding, we just need to make sure
>> it's always called if dynamic rounding is selected.
>>
>> Fixes: 1885350 ("RISCV dynamic rounding mode is not behaving correctly")
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index ce71ca7a92..a39eba679a 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -490,7 +490,7 @@ static void gen_set_rm(DisasContext *ctx, int rm)
>>   {
>>       TCGv_i32 t0;
>>   
>> -    if (ctx->frm == rm) {
>> +    if (ctx->frm == rm && rm != 7) {
>>           return;
> This should not be necessary.
>
> It was my understanding that after the set to the csr, that we would end the
> TB.  That's certainly what I see in RISCV_OP_CSR_POST.
>
> The next TB will begin wiht ctx->frm = -1, so we will reset the rounding mode
> with 7.  It would be good to understand what's really going on here.
Agree. I think the 'bug '  is false positive.
Although the round mode process code is  confusing, it it right.

Zhiwei
>
> r~


