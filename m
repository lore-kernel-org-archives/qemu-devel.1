Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC01206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpvYHq52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC01206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kankm-0001Vr-7a
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kanfL-0003Fw-GW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:23:35 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kanfI-0004T1-24
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:23:35 -0500
Received: by mail-pg1-x544.google.com with SMTP id w4so2322614pgg.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oCgecgABMT3vecGYQV3jxQa7mWMD45wTRMdBM6Qt5oQ=;
 b=bpvYHq52smGpUuHkQtEZ5WXgFKN1Z39zu5wj0yi2Esc8CV7EI1cnjpiNG9Ud2vHIOc
 kXP1lBvCxBZo8jr6RQK9ONkec529rOSO2/XXyZrfE18GPVkn8x1E98aFcGGb/xnBDf5O
 FAJr2qL5W7DaxYdg1fZ6/0xW34YQvWzGqcQFcVdW2QjNEbagGopcbvKpbW1M/GGmRIxr
 3CQwg/asSI6WrUHaY8SMmCQbGu12BWLZkCK2MoU4c9dEw8brs4gJiVZeMfYDVMB4nl6A
 jAb1m/x7SZiT8y0xVmQlvLiuMDDfXOKczuxoJ4Q8bBoQMGFpnpL+1bGeaSm/ZSbGHlEk
 VG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oCgecgABMT3vecGYQV3jxQa7mWMD45wTRMdBM6Qt5oQ=;
 b=UW+O3i6CHbA7yUHumoy6UoEZYizx4SJ6RtoZ+QvpBC504OIQ1Q5W8a3MuvnMvJUsP8
 X8dZQs5lMwPtu3pOuUdtIWJnXiV+jYDnfcXRq+uOM6jP6zup0Zl9C3Xq8v2zpKs9/uzX
 c4JNZISUuPbFiQLF6NPA3haLjdFFntIWnog5lgaGQaZN8s0I6iO1EViJbLb4oK0aLhId
 nDeNcTi6vf5PlgWLL2o7FlLylEg2ZZDQsBB+JJkghxtIdARQjKSveFFH8QssffIBpeRB
 jnfsawge5XE5WhzUQjIO55/CClWUUxPaK7pzdUGkWONm7nyubktWeoDAqba/PigzwlmF
 eh4Q==
X-Gm-Message-State: AOAM533+bqQckFJ/w75ZzXMYMbsu5yfW5qtZKJhTc+2xtgwGW28AGTYE
 1gJPn9BsHAgIszB2Lih21AjV1A==
X-Google-Smtp-Source: ABdhPJxR3cwdz+xNICRZ8aJE0gGfkmL6q8L3P91dKRgJGuFlXk3MRH5FvfD6YmsYmSbjy1Nsae2ToQ==
X-Received: by 2002:aa7:9190:0:b029:18b:6556:1e62 with SMTP id
 x16-20020aa791900000b029018b65561e62mr4799797pfa.62.1604615009824; 
 Thu, 05 Nov 2020 14:23:29 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id u24sm3655157pfn.205.2020.11.05.14.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 14:23:29 -0800 (PST)
Subject: Re: [PATCH for-5.2 3/3] linux-user/sparc: Don't zero high half of PC, 
 NPC, PSR in sigreturn
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201105212314.9628-1-peter.maydell@linaro.org>
 <20201105212314.9628-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d890a1c8-8f57-4b51-fc32-0e4b674dc7fb@linaro.org>
Date: Thu, 5 Nov 2020 14:23:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105212314.9628-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 1:23 PM, Peter Maydell wrote:
> The function do_sigreturn() tries to store the PC, NPC and PSR in
> uint32_t local variables, which implicitly drops the high half of
> these fields for 64-bit guests.
> 
> The usual effect was that a guest which used signals would crash on
> return from a signal unless it was lucky enough to take it while the
> PC was in the low 4GB of the address space.  In particular, Debian
> /bin/dash and /bin/bash would segfault after executing external
> commands.
> 
> Use abi_ulong, which is the type these fields all have in the
> __siginfo_t struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/sparc/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

