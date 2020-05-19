Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B95F20709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RR3aBnup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B95F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4Tu-0007r6-81
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb4T6-0006k0-2c
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:47:48 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb4T5-0007zi-1e
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:47:47 -0400
Received: by mail-pj1-x1041.google.com with SMTP id q24so1623474pjd.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4tJuNsa1CrgbchWLOyDwISv6NSHiYDEyQYcOKTxUj6w=;
 b=RR3aBnupSkJ+sHuA+Tkq9M/FJ2ubP8KR/A+6yMn4IRoNeljIwEeHi1eQooJY5yJvwr
 clEXBxdURbGef7orZ9swA5ZAr/Wv0yHJvYwXgLS4JbnzjnT6Nx05msoTNUhzvql1PRDf
 OlR8pZod2HCwadkod05/opyfT5Zsrwz8sPx1/H7SP+I4KtHAhHnN1fUXVPzF+MniTsGA
 iIpqVRG+wjJKOrT5w0W2dN9KqN/FS0VeZXKvcQkxUqlY0y0NhQ/+wANpj0dNx4Z/85g+
 RVoh0kMOP/3Wwr547z//nLA4RCxwe6Jr3eXGBtHY+ie5sS1g1JUkdF/h972TmHblyGRn
 Bbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4tJuNsa1CrgbchWLOyDwISv6NSHiYDEyQYcOKTxUj6w=;
 b=B6Ntr/iH5jduGGds189Su6GdgouNzLWwBiePw9g6d43i1ntHjihTMNZg3HXCo2ZA7k
 qMM1GNEyAYoV8OUlJE8AKFgrIN2rceV8Pxg883G+/rbAFcTL/Dc89EcO8X4BVm3vNO3D
 WWO80aH4WvK5XwwKFhfHUABUCI2sw310RGpLJ9XozMTrd91NtXvLK/RE04LddxR73iwm
 P9Q297YkqY6GDV8QIHmAroNWo7Kb8Tpi0egGVTaCyUcCfwJ2Vc1/L0muwNbu4Aqz7YWV
 5COVxQnwfou18aNL6uUMQBaUdUdNJ+gUiV733KnHMA1ObE6YhkbNjMJA5MlmKbm5wFcj
 zZQg==
X-Gm-Message-State: AOAM530lCg/96EGzTZd8+14xDwkKSWOH0afl4K5bYRdi3eOuDetccJ9J
 WtXZgXKnxU4Y/D4HudihozQgaT7vqEw=
X-Google-Smtp-Source: ABdhPJwOUsGkkv/3IrwJmb8oMI0wsetjBJxJygAWHQyQ4t8WjD57BRvYJwQylso+opzP1x1XHf1dZQ==
X-Received: by 2002:a17:902:760b:: with SMTP id
 k11mr140118pll.19.1589903265063; 
 Tue, 19 May 2020 08:47:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gd1sm26601pjb.14.2020.05.19.08.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 08:47:44 -0700 (PDT)
Subject: Re: [PATCH 10/10] softfloat: Return bool from all classification
 predicates
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-11-richard.henderson@linaro.org>
 <87k118i6be.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa0cb6fc-df2e-3578-827f-96152a9f2c23@linaro.org>
Date: Tue, 19 May 2020 08:47:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87k118i6be.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 3:10 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> This includes *_is_any_nan, *_is_neg, *_is_inf, etc.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> As an aside do you think we'll see any benefit from rolling up the
> classifications with the decomposed versions? I would hope the compiler
> could drop the stuff it doesn't need but I guess we loose the ability to
> inline in the target helpers?

I think these classification macros are simple enough that we'd lose if we
tried to merge it with the decompose stuff.


r~

