Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C9C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F9120725
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1ukqVH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F9120725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkAN-0000AK-3B
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWk8d-0007Vo-E7
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:16:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:41141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWk8c-0005Ku-6V
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:16:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id 18so3305010pfv.8
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rekBVtsOQR79ipFPsbbh0+J3cKkjzywQV6MJqtQ7Hm8=;
 b=Q1ukqVH4tyNX0IuUd7NF20JFh7HEFNdVz3fYzb0AJ+2ixJamijq6UJAUWihhZPtTiy
 8nHZ8cKnbv4+SMsJnOxTbgbhUI8etSDe0mKJpWV6MVuslija9ltC2M9jX/aKycJHHeCC
 ST3cja/shnaSChfBOC+8DLZsKGQm8whIQt+EFXdUuC+QMY9NIubZ9dJqk863vVwxFddf
 YK3ToXKRO3QOu6u+oApCDFXWdwZybPshiGsHsF/2w/CumfgLnXPt+tD0/o7jquSu9/Kf
 /AvjBMRkfrpk/1qfJz8T0GqNaIRlSvP65U1P85wJJ59vmyAJXmNObDsoRW4HXMRcHWkn
 diGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rekBVtsOQR79ipFPsbbh0+J3cKkjzywQV6MJqtQ7Hm8=;
 b=VXRd5z1RyVzQHHnVJAGxy1uh55BLS799XegjqQcZQ+zzuKS6rKWxzV6M31L1WMhvwa
 CTowxKxNQ1OczR9xWwVj5JvHj+YlV67uLe1SudDgDmrXXg1V3M1bWr3Oqytg2spoxVB7
 PkNNj+JKJ1RyXCRUokodiH0dAXVJ4MjBzr9qAYGvOlOUsoMt2bIBZsN3J3+K8+PZXwmY
 bzbg0eYEGJWzzVOSvRB5R5KrezSJPdovYUy5tcf+/Z73a/58ASrC/ld3lG6xdF8jNguK
 fCt1HiU7B7z8fK9JVCZumG1CWXS6XCezLjS7HJF4lpxGhvRH350MorG/cZo+Nkkl2Epn
 wsNQ==
X-Gm-Message-State: AGi0PubVRQVpb8QDJ1vMqnjbAHByYVk6J5gVkY3CMFK/Emr3NSHlkPVl
 +T/E3/EQAEQZvKKVhNPl3zkWUQ==
X-Google-Smtp-Source: APiQypKJ4MuX8kqWxIAd2eOlKARMqRm0UazIY5eKgXuw2R6w9hc/FUElNUCtz2gVQphVeE1jQvRLEg==
X-Received: by 2002:a62:3287:: with SMTP id
 y129mr15413870pfy.167.1588871804498; 
 Thu, 07 May 2020 10:16:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b8sm307866pjz.51.2020.05.07.10.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 10:16:43 -0700 (PDT)
Subject: Re: [PULL 04/10] target/arm: Use tcg_gen_gvec_dup_imm
To: Laurent Desnogues <laurent.desnogues@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
 <20200506183002.3192-5-richard.henderson@linaro.org>
 <CABoDooPCvC4Y+G4CGBUhPT_ce3rY6_ZZvTnvv8M+sXPkpN4raQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e0ec84f-6f25-5e97-a3c5-bb810a347d0f@linaro.org>
Date: Thu, 7 May 2020 10:16:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABoDooPCvC4Y+G4CGBUhPT_ce3rY6_ZZvTnvv8M+sXPkpN4raQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 7:39 AM, Laurent Desnogues wrote:
>> @@ -2044,7 +2044,7 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
>>              unsigned nofs = vec_reg_offset(s, a->rn, index, esz);
>>              tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
>>          } else {
>> -            tcg_gen_gvec_dup64i(dofs, vsz, vsz, 0);
>> +            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);
> 
> For an indexed DUP, size can be 128-bit so that will fail the first
> assert in tcg-op-gvec.c:do_dup.

Ho hum, quite right.  This has already been merged, so I'll send a follow-up fix.


r~


