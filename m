Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 02:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A25320738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 02:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A25320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh2SI-0000wI-IF
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 22:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jh2Re-0008Qp-8S; Thu, 04 Jun 2020 22:50:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jh2Rb-0000se-TP; Thu, 04 Jun 2020 22:50:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04444096|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.196904-0.0113071-0.791789;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.HiMOiST_1591325446; 
Received: from 30.225.208.46(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HiMOiST_1591325446)
 by smtp.aliyun-inc.com(10.147.41.138);
 Fri, 05 Jun 2020 10:50:47 +0800
Subject: Re: [PATCH v8 30/62] target/riscv: Update fp_status when float
 rounding mode changes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-31-zhiwei_liu@c-sky.com>
 <7cb2aa5d-833a-8544-dadc-5aabba06ecd2@linaro.org>
 <ca1e71cd-c290-5fb9-e9bf-026c73e06560@c-sky.com>
 <7ec3d397-bf9a-07f5-3014-4acf47a4fd6e@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <ba7ef161-8bc6-516f-b5a7-8133e3a89998@c-sky.com>
Date: Fri, 5 Jun 2020 10:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7ec3d397-bf9a-07f5-3014-4acf47a4fd6e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 22:19:39
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



On 2020/6/5 4:15, Richard Henderson wrote:
> On 6/2/20 10:46 PM, LIU Zhiwei wrote:
>> I think you are right.  Maybe I should transmit frm to ctx->frm, and check
>> ctx->frm in vector fp ops.
>>
>> We can set ctx->frm = env->frm instead of ctx->frm = -1 in
>> riscv_tr_init_disas_context.
>> And  remove the sentence ctx->frm = rm; from gen_set_rm.
>>
>> Is it right?
> If we record frm in tb_flags, then we also have to reset
> env->fp_status.rounding_mode for scalar fp insns which encode a rm != 7.
> Depending on the exact mix of fp insns, that could result in more changes to
> rounding_mode than we do presently.  This is something that you'd want to look
> at closely to make sure you're not making scalar code worse.
Hi Richard,

I don't think so. It will occupy  three bits in tb_flags.
Another reason is the scalar float codes have fixed rounding mode. The 
frm field in tb_flags is useless without vector extension.

If we really have to put it in the tb_flags,  one bit INVALID_FRM is 
enough. The scalar code will still be the same.
The vector code will check the INVALID_FRM.
> I think the easiest solution in the short term is to have the translation of
> any fp vector insn call gen_set_rm(ctx, 7), so that we are certain to install
> frm as rounding_mode.  This will happen at most once per translation block,
> assuming no scalar insns that would also require changes to rounding_mode.
Yes.  Only some csr insns can change the rounding mode. And they will 
exit the tb immediately.
So no scalar insns will require changes within a translation block.

I think there is a error in gen_set_rm

static void gen_set_rm(DisasContext *ctx, int rm)
{
     TCGv_i32 t0;

     if (ctx->frm == rm) {
         return;
     }
     ctx->frm = rm;
     t0 = tcg_const_i32(rm);
     gen_helper_set_rounding_mode(cpu_env, t0);
     tcg_temp_free_i32(t0);
}

I don't know why  updating ctx->frm in this function.
>
> You can work with the risc-v folk to examine frm handling more generally
> separate from this vector work.
OK. I will send a separate RFC patch to handle frm. Then merge it to the 
vector patch set.

Best Regards,
Zhiwei
>
> r~


