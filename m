Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50235C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EF92065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQP2q6jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EF92065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7m6R-0000kw-6i
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 16:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7m5L-0007yY-Cp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:50:27 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7m5J-0003eb-J2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:50:26 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ep8so8227169pjb.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YUVrd+KlvpvEQ5W2yX2stbHmmSTvPtCI1aQ/DJWgdu0=;
 b=gQP2q6jxC4NHQ4Ra2ODrTRV/tqyi+pdQ5U7ZbC60trhT0ZAcA/XoZFfxx+WYyJbpW3
 vmoKG+5U322YteGJevnI+xfWZp3uxYVT/WFHdWz2MJCGQ/HZN2e9et4p6n9RwUJCiO1o
 UF4NXGJJbKsovmo7EaGTDhq70LMX2InRC40WP/pBCj1UbElNQRFdh1+5+TiJHGbo3PT7
 BGvuZk8NMpobPy41egq981bFWN1k530Q5DyS2MfwEWQUFUwPE5daLKJz2xqu9TX7gCgp
 QiaCjwpoVjB0bVpkw/rOuG00iXrsXoVWrEDlg7iCTqc/o1xQt8K/KitOcGXBIkAQJM3Y
 J45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YUVrd+KlvpvEQ5W2yX2stbHmmSTvPtCI1aQ/DJWgdu0=;
 b=lxmTxp+NCXI37C7siDqk6dM3UB7hf3oCsEexe5LWcGMnwZDJUzP/cX5eDZR5dG8748
 kePOk6j9SgmKFJWng3tVne4tZm7y+rT/MLurFLpFnQjX3wrpOIfLndpv2Cb9trWCBKtL
 /Eu+uRx5ShCMUsksXX+HWAgmXWEG+trLtaF6qkuTZ6Q5knoFtYOvhQoT8HvIwoo/TLxB
 XMMMAg82lv56oORaREIMS+5tl3wi08lQ9CfnPc+OUvdzJLyIs4q8i40cTVgxMKJqXYFm
 WAlGmu9vfR+hJHXKqx6++vv1wwYvRktSZWtvGnMkidKP4e7AdIUobcnCaMA6qbnjfYNe
 s47A==
X-Gm-Message-State: AOAM532jwBeEjtDHpArr81IXOTrrhwf/++l8GBgtSqSFd2dodVOh/i7M
 aKakfFdS0SK3dD977p700JzShaAW3KorBQ==
X-Google-Smtp-Source: ABdhPJzKnUOSgCKvG/IliVsm01PTCuwfeA5hUabwIqeAkc4x3DUjisS1VAjTWjZlsFize6Efti+q+Q==
X-Received: by 2002:a17:90a:b986:: with SMTP id
 q6mr14392515pjr.54.1597697423775; 
 Mon, 17 Aug 2020 13:50:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t25sm20649033pfe.76.2020.08.17.13.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 13:50:23 -0700 (PDT)
Subject: Re: [PATCH 01/17] crypto: Move QCryptoCipher typedef to
 qemu/typedefs.h
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-2-richard.henderson@linaro.org>
 <20200817164801.GK4775@redhat.com>
 <01f1a99c-9983-9b92-b91d-bd117055cf21@linaro.org>
 <03d945f7-bd4a-8f55-433c-b5c9ab7080c4@linaro.org>
Message-ID: <9b3a8dd6-067f-4813-1415-1b74ce1c8754@linaro.org>
Date: Mon, 17 Aug 2020 13:50:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <03d945f7-bd4a-8f55-433c-b5c9ab7080c4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:42 PM, Richard Henderson wrote:
> On 8/17/20 1:38 PM, Richard Henderson wrote:
>> On 8/17/20 9:48 AM, Daniel P. Berrangé wrote:
>>> On Wed, Aug 12, 2020 at 08:25:21PM -0700, Richard Henderson wrote:
>>>> This allows header files to declare pointers without pulling
>>>> in the entire crypto subsystem.
>>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>  include/crypto/cipher.h | 2 --
>>>>  include/qemu/typedefs.h | 1 +
>>>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> I'm not in favour of this change or the next. Using #include "cipher.h"
>>> is not a burden on the users of the crypto code. Moving typedefs away
>>> from the associated struct is a step backwards IMHO.
>>
>> Consider if you put a pointer to QCryptoCipher in a relatively generic header
>> file (e.g. "target/foo/cpu.h"), restricting "cipher.h" to a portion of the
>> implementation (e.g. target/foo/helper_crypto.c).
>>
>> This sort of thing is exactly why "qemu/typedefs.h" exists.
> 
> As for the next patch for QCryptoCipherDriver, I could easily see not moving
> the typedef to typedefs.h, but instaed to "crypto.h", where we do in fact want
> to declare an incomplete structure.  I think it's a real mistake to be using
> void* there at present.

That said, I can drop this first patch because, in the end, I'm *not* going to
put QCryptoCipher in target/arm/cpu.h.


r~

