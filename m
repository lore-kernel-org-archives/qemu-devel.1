Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8650C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748D520663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGs0kl5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748D520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsY35-0007g2-O9
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsY27-0006lE-EI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:48:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsY25-00043h-Mi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:48:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so18931337pgh.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QQdcLgq2cnit/tJSEZhwkdTYdsj/4N3s394I28gfG8I=;
 b=yGs0kl5dx6cfkkBVoytJwQpLekj/EQyytaDA+x9d/ZqzIL9RnWpCcg6l0CiwG3YPlE
 pE9wQxttT4260GSulDiMQAS5+3h9rsgkEwGPWDekbbOFp82VySCERhAvDXcJkBPPNh7L
 Ca1cT3S/WJZ9hfwwbhQ5W4q5AeHYBWlsw1lcA9Fo1v/DZqiNtlRheYwBOtk4UAwwiUgy
 mmAxp4GclOXSSnoONTLQRolkrVz1dbAQs/nWj762+O4vNbCm1vcYdx/ZP9zcyvR9Ipdv
 rwmsiFnstcdyxJQS2P446Ws6nJpnNPbsxeXY9a3nQ2FEmVXjFykuwGQ3HThA3QjTE/1j
 +Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QQdcLgq2cnit/tJSEZhwkdTYdsj/4N3s394I28gfG8I=;
 b=K6szmwwaAVUlWcYxzuWcDjRtetaJjU5W+TsTjL5Ir9ntx39In98HzV0PbzexVzHcI1
 LwLa7o77/GM4wR7VuMsAHjPSI3/TJTiLwzk+AfxAjqeHK43yi/8sJ3gwJg3O78cHpl3u
 uag8Wu5Hk3FBVm3EPVx31DJtuTDfxelF7hHsMDx+ySBZ4u6LocYRkQYfVdbizcUDBocw
 YDDHLqtb/bBCRCzzORnPpYJdg1TLEg/0TJfRtYdOzi++PrTlfzGa0YxC+TuR9oYWP47W
 K85sAJroowRE/opEkX1kq8nta0IIEIeqJPJYpGSxXoz+MfrZTqW5QLEX4ljH3Z0HmtuI
 rxfw==
X-Gm-Message-State: AOAM530WZmJ6Bs4v6vKs1qKznvDeeiDfMz2yx4JzgXE1LwLZu3PqbWp6
 UFdOp2yKcg/B9y3Jzr14R5C/lg==
X-Google-Smtp-Source: ABdhPJyhe7h89DsRQUgbmrMATY6G9P5lijRgNgnhxWMo6g8bzwbXROhF+DPb4QqKAgZOMVstnnodCA==
X-Received: by 2002:a63:c509:: with SMTP id f9mr41975695pgd.144.1594068488017; 
 Mon, 06 Jul 2020 13:48:08 -0700 (PDT)
Received: from [192.168.149.206] (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id k100sm312141pjb.57.2020.07.06.13.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 13:48:07 -0700 (PDT)
Subject: Re: [PULL v2 12/64] target/riscv: add vector amo operations
To: Alistair Francis <alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
 <20200702162354.928528-13-alistair.francis@wdc.com>
 <CAFEAcA8b7Rk8ZDDu689tRDCqcSKRbCGVf=75e0f0WNd2GJ9dmg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e86ece6b-5295-dfb2-6fdb-bf0004ec9b70@linaro.org>
Date: Mon, 6 Jul 2020 13:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8b7Rk8ZDDu689tRDCqcSKRbCGVf=75e0f0WNd2GJ9dmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 11:20 AM, Peter Maydell wrote:
> On Thu, 2 Jul 2020 at 17:33, Alistair Francis <alistair.francis@wdc.com> wrote:
>>
>> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
>>
>> Vector AMOs operate as if aq and rl bits were zero on each element
>> with regard to ordering relative to other instructions in the same hart.
>> Vector AMOs provide no ordering guarantee between element operations
>> in the same vector AMO instruction
> 
> Hi; Coverity thinks (probably wrongly) that there might be an array
> overflow here:
> 
>> +static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
>> +{
>> +    uint32_t data = 0;
>> +    gen_helper_amo *fn;
>> +    static gen_helper_amo *const fnsw[9] = {
> 
> This is a 9-element array...
> 
>> +        /* no atomic operation */
>> +        gen_helper_vamoswapw_v_w,
>> +        gen_helper_vamoaddw_v_w,
>> +        gen_helper_vamoxorw_v_w,
>> +        gen_helper_vamoandw_v_w,
>> +        gen_helper_vamoorw_v_w,
>> +        gen_helper_vamominw_v_w,
>> +        gen_helper_vamomaxw_v_w,
>> +        gen_helper_vamominuw_v_w,
>> +        gen_helper_vamomaxuw_v_w
>> +    };
> 
>> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>> +        gen_helper_exit_atomic(cpu_env);
>> +        s->base.is_jmp = DISAS_NORETURN;
>> +        return true;
>> +    } else {
>> +        if (s->sew == 3) {
>> +#ifdef TARGET_RISCV64
>> +            fn = fnsd[seq];
>> +#else
>> +            /* Check done in amo_check(). */
>> +            g_assert_not_reached();
>> +#endif
>> +        } else {
>> +            fn = fnsw[seq];
> 
> ...which we here index via 'seq'...
> 
> 
>> +#ifdef TARGET_RISCV64
>> +GEN_VEXT_TRANS(vamoswapd_v, 9, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamoaddd_v, 10, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamoxord_v, 11, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamoandd_v, 12, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamoord_v, 13, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamomind_v, 14, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
>> +GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
>> +#endif
> 
> ...which in the calls that these macros expand out to can
> be 9 or greater.

FWIW, I think it would be better to have the gen_helper_amo *fn symbol here in
the macro than a magic "seq" number.


r~

