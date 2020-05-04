Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4215C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939B7206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zddWt1OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939B7206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeIh-0003Zc-BK
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeHs-0002xu-3a
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:49:48 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:40615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeHn-0000Lh-6D
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:49:44 -0400
Received: by mail-pg1-x529.google.com with SMTP id j21so731978pgb.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TgBcXjHmfVhw9jMss0cD1aMd51iRW9OjOtY38S0j19M=;
 b=zddWt1OVO1veH1rn7M+f4jgmXxDSAycB7O4kCDNnwjwxsrPcg4E9dmfKcZOr393CRn
 oQkY69WNWn5m6Zk99orn1DTyHB7pbKeNloQokXwFJtgUX/fORe3L3rWdvNegtRF8eL0z
 GcKgPC4/uEzMi10IQ6HFKGxXZSk5bParXTw42Q/FEmodXP/VZPwIjT8235I0vIdxof8b
 n/4bbfIRfGDcwATyGKuxOvc4xdmwdFmBK/NV0aFBCqCHEkp22y2jhE+dh9o2fqopIATX
 PLT3CFHWWGgwPOW1Tifvd4dRKGi4Eb3saQZfS3sonFhX+bk6foYT9VjTv1sUgwyPrHHB
 Jq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TgBcXjHmfVhw9jMss0cD1aMd51iRW9OjOtY38S0j19M=;
 b=ivxPz/cM4kYLqLKOR39LLXw+Zb/ZwTV4m3ZpLwohIKdc1vR7DK7xq31tSETgGyA36m
 JBrGdBRFFQMOCSRPmW4XBHCmGmfBXRFD1OjHUNodGmSyvsr9WD15ZBvrg2EdsZ6mv6Xr
 GcopGeeeEn7eG2nA0IQ5ns14YlBES2Z8bS5yQd6GK3UgiDM3yral2nJw3DnOEgmUTJKV
 zrJuL/kb+ceK/1T9WM/t2fhYMe4pqYbOi+C8tIiqhphz0TrREvsuh7Y0TjhizfLqImuU
 xuab2XCmCWY5IycHvKc6NL2Dw3gTQeyS4svAnbfAY0S4MRILlM9POIjwhdDD4Eq+J0AU
 7cbA==
X-Gm-Message-State: AGi0PuZvyLo2CIsTbavZ1FmU5luCe7I/6USnkZAFxLUmzI4Rlv9VZdIX
 es+STRpZ/jNvTgytMFebZFGgag4KP6g=
X-Google-Smtp-Source: APiQypL2wzoA4AlUmRNUVdymzFR45Sh4IV2Bg4GIDJoqkmxqgfUrUVdp2SHIEfOcqHXaeA2Hcj8UhA==
X-Received: by 2002:a63:34c:: with SMTP id 73mr7900776pgd.108.1588610981342;
 Mon, 04 May 2020 09:49:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h9sm9152175pfo.129.2020.05.04.09.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 09:49:40 -0700 (PDT)
Subject: Re: An first try to improve PPC float simulation, not even compiled.
 Just ask question.
To: luoyonggang@gmail.com, BALATON Zoltan <balaton@eik.bme.hu>
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
 <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
 <alpine.BSF.2.22.395.2005040128330.7227@zero.eik.bme.hu>
 <CAE2XoE93HqZVvFkZzfuC1VsF-Vw88ggSYMU2t7QjPUPWSU-4-Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e93bda1e-ae5f-00f9-0655-f4bb72597ab5@linaro.org>
Date: Mon, 4 May 2020 09:49:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE93HqZVvFkZzfuC1VsF-Vw88ggSYMU2t7QjPUPWSU-4-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/3/20 5:41 PM, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Mon, May 4, 2020 at 7:40 AM BALATON Zoltan <balaton@eik.bme.hu
> <mailto:balaton@eik.bme.hu>> wrote:
> 
>     Hello,
> 
>     On Mon, 4 May 2020, 罗勇刚(Yonggang Luo) wrote:
>     > Hello Richard, Can you have a look at the following patch, and was that are
>     > the right direction?
> 
>     Formatting of the patch is broken by your mailer, try sending it with
>     something that does not change it otherwise it's a bit hard to read.
> 
>     Richard suggested to add an assert to check the fp_status is correctly
>     cleared in place of helper_reset_fpstatus first for debugging so you could
>     change the helper accordingly before deleting it and run a few tests to
>     verify it still works. You'll need get some tests and benchmarks working
>     to be able to verify your changes that's why I've said that would be step
>     0. If you checked that it still produces the same results and the assert
>     does not trigger then you can remove the helper.
> 
> That's what I need help,
> 1. How to write a assert to replace helper_reset_fpstatus .
>   just directly assert? or something else

You can't place the assert where helper_reset_fpstatus was.  You need to place
it in each of the helpers, like helper_fadd, that previously has a call to
helper_reset_fpstatus preceeding it.

The assert should be placed before the first floatN_op call that uses
env->fp_status.  E.g.

float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
{
    float64 ret;
    int status;

    status = get_float_exception_flags(&env->fp_status);
    assert(status == 0);
    ret = float64_add(arg1, arg2, &env->fp_status);
    status = get_float_exception_flags(&env->fp_status);

    if (unlikely(status & float_flag_invalid)) {
        float_invalid_op_addsub(env, 1, GETPC(),
                                float64_classify(arg1) |
                                float64_classify(arg2));
    }

    return ret;
}


r~

