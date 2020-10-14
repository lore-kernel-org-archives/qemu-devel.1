Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924BE22249
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXxwYuRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924BE22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnVU-0006Ol-Ce
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSnUM-0005sO-RY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:35:10 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSnUK-0002OK-In
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:35:10 -0400
Received: by mail-pj1-x1042.google.com with SMTP id az3so392876pjb.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PqvYyMnc/sGzizSKoiFDnUsc58ExRT7bydM2RItZLWo=;
 b=pXxwYuRVbZPwS2HSiFbtPa2rAe1Ver/Tq/ShbqqzXfdZLH0IACT9cH0qVilFf5jYCT
 QyrJknV90UAe3rvJ9N/WCSIMpMnSqLsNJDsT/vQ9ZF8+RMyuuB17Bm8KBsxWVF9N6UQC
 Y9kde1OdVPA2sEAfFFnJupXYkkQVyPuPxPRjpinE9zq87vWqYg9gCub8t/XUTgGGdiQd
 leCbg3qGCP+I49yQnRfdSfQjPGnUVX+C2Lr/SDHAXR5HZfglN4bqEKIbm9kq38OuUR5b
 mWZiVUhwoiPY3c6zgA0fFFgV9bLnBk5TPHqKACcSr7pCboohUsWQtEOE42z2LSQLdujz
 C5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PqvYyMnc/sGzizSKoiFDnUsc58ExRT7bydM2RItZLWo=;
 b=FMko9tz3fXznieVZZgq4iFyaNH382WWsWSQO0X3MxvpflL6yonKSfqPZkZRT9KKBtw
 ITkN+BYltTjRB1aTleRdRcES8GReXOaT94LGuiX3StsLL2iqOdA5G503rbGszhY2C7Qh
 dZtCjBf1V2aKZVzrX0D98+/e0bECt/UDZYxJwc2yttK7bApfSh4j/SE4uM25rDvVDDM4
 Exs1AZaTGzqWtcJEBP/UGMwHtQ2aWTGCZK2GLcWBhGphnV4RbjuAw0QSIRVVF8BbRXEv
 +k82zlVcnzqqOQnzYvPkaLYs+bRgnZVV3OxOgr2arugPG1D96EkQLh8PcgFpzu7gqak4
 ZnpQ==
X-Gm-Message-State: AOAM532OQfd7ClSf4Z9H2wiHP/QMBcTnYefiZa9n+P+uiDG17Ju1yxDn
 3HY6jfYp6lN/EKbtXiqFDKct3hHfm6Mb+Q==
X-Google-Smtp-Source: ABdhPJwpOjlvba31WtH2ILtnTDmJCoSFKMIGCwZbBZ1lVbh3YCH1P3uHI1EecF3lZ398MEyDJ6rekw==
X-Received: by 2002:a17:90a:f001:: with SMTP id
 bt1mr888806pjb.116.1602707706568; 
 Wed, 14 Oct 2020 13:35:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o15sm555700pfp.91.2020.10.14.13.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 13:35:05 -0700 (PDT)
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
To: Joelle van Dyne <j@getutm.app>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
 <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
 <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
Date: Wed, 14 Oct 2020 13:35:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:03 AM, Joelle van Dyne wrote:
>>> static int encode_search(TranslationBlock *tb, uint8_t *block)
>>> {
>>> -    uint8_t *highwater = tcg_ctx->code_gen_highwater;
>>> -    uint8_t *p = block;
>>> +    uint8_t *highwater;
>>> +    uint8_t *p;
>>>     int i, j, n;
>>>
>>> +    highwater = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx,
>>> +                                           tcg_ctx->code_gen_highwater);
>>> +    p = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx, block);
>>
>> Why do you need explicit casts here? Can this be avoided by using
>> appropriate type or within the macro (I haven't checked this at all just
>> dislike casts as they can hide problems otherwise caught by the compiler).
> There's the choice between tcg_insn_unit * and uint8_t *. Since it's
> used much more widely in tcg-target.inc.c, it seemed like
> tcg_insn_unit * was a better choice.

False choice.  This is why tcg_ctx->code_gen_highwater is void*.

>>> +#if defined(CONFIG_IOS_JIT)
>>> +# define TCG_CODE_PTR_RW(s, code_ptr) \
>>> +    (tcg_insn_unit *)((uintptr_t)(code_ptr) + (s)->code_rw_mirror_diff)

Better as

static inline void *tcg_code_ptr_rw(TCGContext *s, void *rx)
{
#ifdef CONFIG_IOS_JIT
    return rx + s->code_rw_mirror_diff;
#else
    return rx;
#endif
}


r~

