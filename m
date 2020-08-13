Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2422120829
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xuMnFwW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2422120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JFy-00018G-An
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 15:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JF5-0000UU-5M
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:50:27 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JF3-0001Eb-EQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:50:26 -0400
Received: by mail-pg1-x542.google.com with SMTP id t6so3356161pgq.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=93WAs4bDlDYfH0qiEUHkGS//zU40N+nk24uRMrrsv4g=;
 b=xuMnFwW8hx4/aqunkRBgzrbubKZwkwu6GC13G9JDBeSwCEYkbrRO96mi1Y33J/Ff3c
 LIijjw60yuSLaCcqr+UMyqlSkm6AOYB8uXJ46IkSOF+8DGj7UwZdjTwtpdVRrqe21wDg
 u7vbfQ6nGZMn+u742WJ/OQDJdxYG6eZx8UD+wjwdOtAYMpWtKLE+bc4LwoUe/C1M0hV5
 XQJ+ShTQYshsyodpPDMIouFy72jjkBMPInFlAP4emngsdlx8QLxSYcmhH5SGZiuzqm7Z
 ib31B7soTbm55mZd1fSEYXORIqEHaUB0eV+7oJC/7ELBOzvVbgmklM7sAMaG3y4YvVZp
 E0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=93WAs4bDlDYfH0qiEUHkGS//zU40N+nk24uRMrrsv4g=;
 b=bRA+bs9cyTknhRwPzthGnuUn+EyW2ENoKSddGcJhq4deXny2mRZUeSn8JH4OKzquAT
 5+pxtUz0P4q2f7Xyej91MjTKLsFxr9fAWzNhCFncx/aAHlBfADMTvM6oyIk5fOGl3kxM
 RtyyhTjBse4SAmSYak7BUoIDwHBbyqAou5ZSnk8LlPsr/u/tr47nyQOrRaxxZ9XGdN88
 VfowdrQCTimARK7d9hlNBF3R/uNBSOTbWK5lFwg3DdaD9R10EsShNgmnzjdf1lv+eyVy
 d9kp/lohtxlf0gny5o8/I0TQavgZYNuckXDe+OHklUFbm7iXkFaKkc9DUGLPnJcTToWk
 o6CQ==
X-Gm-Message-State: AOAM532YYHvvX60wp6dJ9Ko05bLqDEemtPoFhcUFPJ8n7kSQvicYwSxs
 084ol84tgPz3yg4OJcd6f4J+BA==
X-Google-Smtp-Source: ABdhPJxEhLtUfvQWwCJvr7kzgL+5drIyS6KMW0n/s7qyHqDnYA2fC2XPG726z2kMiQHgsSPLNQg9yQ==
X-Received: by 2002:a63:2e87:: with SMTP id u129mr5114074pgu.347.1597348223874; 
 Thu, 13 Aug 2020 12:50:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f6sm6281652pje.16.2020.08.13.12.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 12:50:23 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/3] target/mips/op_helper: Log unimplemented cache
 opcode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200813181527.22551-1-f4bug@amsat.org>
 <20200813181527.22551-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0b13561-4be9-acad-5178-1f9c74d079a9@linaro.org>
Date: Thu, 13 Aug 2020 12:50:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813181527.22551-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:15 AM, Philippe Mathieu-Daudé wrote:
>  #ifndef CONFIG_USER_ONLY
> +    static const char *type_name[] = {

const char * const

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

