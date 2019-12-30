Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC39C2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034332071E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034332071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilq9z-0002Mq-Q6
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 03:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ilq9L-0001wb-83
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1ilq9J-00077C-U2
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:11:38 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ilq9J-00070H-Io
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:11:37 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0644554|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.284727-0.00614547-0.709127; DS=||;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03304; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.GSb8fD3_1577693489; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GSb8fD3_1577693489)
 by smtp.aliyun-inc.com(10.147.41.120);
 Mon, 30 Dec 2019 16:11:29 +0800
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
To: Richard Henderson <richard.henderson@linaro.org>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
 <1b1826c3-50e4-2481-56a2-4ebb01e04498@c-sky.com>
 <fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org>
 <ea5d5926-48ba-e204-cad8-7e5260b2e2ee@c-sky.com>
 <9e1c5407-3704-9c34-92d7-fd59e48eb13a@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <a363cee3-b691-6c6a-3ddf-b0b1773b491b@c-sky.com>
Date: Mon, 30 Dec 2019 16:11:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9e1c5407-3704-9c34-92d7-fd59e48eb13a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, qemu-devel@nongnu.org,
 Chih-Min Chao <chihmin.chao@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/28 9:14, Richard Henderson wrote:
> On 12/25/19 8:36 PM, LIU Zhiwei wrote:
>> struct {
>>
>>          uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
>>          target_ulong vxrm;
>>          target_ulong vxsat;
>>          target_ulong vl;
>>          target_ulong vstart;
>>          target_ulong vtype;
>>      } vext;
>>
>> Is it OK?
> I don't think there's a good reason for the vext structure -- I would drop
> that.  Otherwise it looks good.
>
>> However, there are still some differences from SVE.
>>
>> 1)cpu_env must be used as a parameter for helper function.
>>
>>      The helpers need  use env->vext.vl and env->vext.vstart.  Thus it will be
>> difficult to use out of line tcg_gen_gvec_ool.
> Sure.  That's also true of any of the fp operations, which will want to
> accumulate ieee exceptions.
>
> See tcg_gen_gvec_*_ptr(), which allows you to pass in cpu_env.
Thanks. The tcg_gen_gvec_*_ptr is good.
>
>> 2）simd_desc is not proper.
>>
>>      I also need to transfer some members of DisasContext to helpers.
>>
>>      (Data, Vlmax, Mlen) is my current choice. Vlmax is the num of elements of
>> this operation, so it will defined as ctx->lmul * ctx->vlen / ctx->sew;
> The oprsz & maxsz parameters to tcg_gen_gvec_* should be given (ctx->lmul *
> ctx->vlen).  The sew parameter should be implied by the helper function called,
> each helper function using a different type.  Therefore vlmax can be trivially
> computed within the helper from oprsz / sizeof(type).
It's clear that the oprsz & maxsz paramenters should be given (ctx->lmul 
* ctx->vlen) for tcg_gen_gvec_add.

However It's not clear when use tcg_gen_gvec_*_ptr or tcg_gen_gvec_ool. 
I think the meaning of oprsz is the
the bits of active elements.  Therefore , oprsz is  8 * env->vext.vl in 
RISC-V and it can't be fetched  from
TB_FLAGS like SVE.

Probably oprsz field will be not be used in RISC-V vector extension.
>> Data is reserved to expand.  Mlen is mask length for one elment, so it will
>> defined as ctx->sew/ctx->lmul. As with Mlen, a active element will
>>
>> be selected by
>>
>>      static inline int vext_elem_mask(void *v0, int mlen, int index)
>>      {
>>          int idx = (index * mlen) / 8;
>>          int pos = (index * mlen) % 8;
>>
>>          return (v0[idx] >> pos) & 0x1;
>>      }
>>
>>      So I may have to implement vext_desc instead of use the simd_desc, which
>> will be another redundant. Maybe a better way to mask elements?
> I think you will want to define your own vext_desc, building upon simd_desc,
> such that lg2(mlen) is passed in the first N bits of simd_data.
Good. It's a good way to use the tcg_gen_gvec_*_ptr or tcg_gen_gvec_ool API.

Best Regards,
Zhiwei
>
> r~


