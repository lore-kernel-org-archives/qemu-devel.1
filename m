Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2BC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A2C2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A2C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqS5-0005Qi-SB
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcq3N-0005Fi-DZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hcq3L-00008v-5x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:44:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44761 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hcq3K-0008UX-VQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:43:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id EFE021A1E5F;
 Mon, 17 Jun 2019 13:43:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.132] (rtrkw870-lin.domain.local [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id D4E1E1A1DFA;
 Mon, 17 Jun 2019 13:43:51 +0200 (CEST)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1559816130-17113-9-git-send-email-stefan.brankovic@rt-rk.com>
 <7879c550-f333-7703-e47f-ca734ad47bf7@linaro.org>
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <5eb76d01-ecf6-b915-5c8b-92de38b64cc0@rt-rk.com>
Date: Mon, 17 Jun 2019 13:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7879c550-f333-7703-e47f-ca734ad47bf7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH 8/8] target/ppc: Refactor emulation of
 vmrgew and vmrgow instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6.6.19. 22:43, Richard Henderson wrote:
> On 6/6/19 5:15 AM, Stefan Brankovic wrote:
>> +/*
>> + * We use this macro if one instruction is realized with direct
>> + * translation, and second one with helper.
>> + */
>> +#define GEN_VXFORM_TRANS_DUAL(name0, flg0, flg2_0, name1, flg1, flg2_1)\
>> +static void glue(gen_, name0##_##name1)(DisasContext *ctx)             \
>> +{                                                                      \
>> +    if ((Rc(ctx->opcode) == 0) &&                                      \
>> +        ((ctx->insns_flags & flg0) || (ctx->insns_flags2 & flg2_0))) { \
>> +        trans_##name0(ctx);                                            \
>> +    } else if ((Rc(ctx->opcode) == 1) &&                               \
>> +        ((ctx->insns_flags & flg1) || (ctx->insns_flags2 & flg2_1))) { \
>> +        gen_##name1(ctx);                                              \
>> +    } else {                                                           \
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);            \
>> +    }                                                                  \
>> +}
>> +
>>   /* Adds support to provide invalid mask */
>>   #define GEN_VXFORM_DUAL_EXT(name0, flg0, flg2_0, inval0,                \
>>                               name1, flg1, flg2_1, inval1)                \
>> @@ -431,20 +449,13 @@ GEN_VXFORM(vmrglb, 6, 4);
>>   GEN_VXFORM(vmrglh, 6, 5);
>>   GEN_VXFORM(vmrglw, 6, 6);
>>   
>> -static void gen_vmrgew(DisasContext *ctx)
>> +static void trans_vmrgew(DisasContext *ctx)
>>   {
>> -    TCGv_i64 tmp;
>> -    TCGv_i64 avr;
>> -    int VT, VA, VB;
>> -    if (unlikely(!ctx->altivec_enabled)) {
>> -        gen_exception(ctx, POWERPC_EXCP_VPU);
>> -        return;
>> -    }
> This appears to drop the check for altivec_enabled.
>
Thank you for spotting this, I will fix this bug in v2.

Kind Regards,

Stefan

> r~

