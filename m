Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543E2C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7BE206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6w3jbGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7BE206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcUK-0004Zg-Sl
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZcTJ-0003fQ-Lh
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:14:17 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:44539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZcTD-0006qz-EN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:14:13 -0500
Received: by mail-pf1-x431.google.com with SMTP id 133so11508400pfx.11
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 08:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EnU4BKIreEZVWlWFGVvnUTivgYZHxDgzODZdedSKtEc=;
 b=I6w3jbGhGZ/rdXfEVETHNB+lAsEOY7geZUHnlPdIK+jVG8RB0OTEcsXY1E0QFHOSTJ
 rhhY3QMApcWd7rF3bRNtzuCRl9G6Yq3rBlktM3dRNlXOTq0lea8XBtxqTqI2ZlyPuIaa
 kjuH+2FMRu0BLtDDGpjilwEuvMYFWaOLENucfEvDct/M7gzurT2hNurubExuOYbpYWf1
 B1KIrj6f6H8TkE/900O50/b3k/7zVdoDE4IQnSt6ho0znkZ/+dcWk3coAcY9jHpKBogQ
 JiQ7m1o7W/mWw/sfp7EmST0OhtxdILpVakGlrG62+3asxQisFYnSRn8BJ3vLDGZ67Ekb
 G6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EnU4BKIreEZVWlWFGVvnUTivgYZHxDgzODZdedSKtEc=;
 b=QO31m+XocB3FinLoyCmDXYIaipIg+/TxXPgZst3OX302kT/hp+ZjZpDluuMS7Z3Pgx
 lLziwt6kYBJR23nOJDzncS3LuSyr9TlSvNgsCvpJmF/j/0dM6Ljjo1UFNQEOUFXPH2Gl
 GlsyqQaPD9YonOFxP9mWKG9M4p3iMBbWurC5ihr3BjqU6MjFd6DQZbXLbgO0YPx8tHcy
 piJAMhB6Vr0J12wXcxXKax2rRKI4m52e2dJs5m4xCa1/8b4lzODx29DBE7b3YS50F2jm
 RUQjSf2YoYF+eBLC69cigUOngvYQEtedv2kjO8SnBOHX1p79HNMhGEbJVeaKoyN2GQff
 3+GQ==
X-Gm-Message-State: AOAM5325zylfUi86sGzmh/Xzu6+sjTyramC1CSAgS2QFkzn7R5CUJkx8
 5vEOcTsqCxS/Uh5x6t/kgK5G1w==
X-Google-Smtp-Source: ABdhPJxwKE300g7l74qbRgJmNqnNpLn/K9VZ5HB8X4Sj0T1wmSaPpz8r/YOReeFwW2YpXbQv0qWDtQ==
X-Received: by 2002:a17:90a:5e4d:: with SMTP id
 u13mr11526245pji.171.1604333649824; 
 Mon, 02 Nov 2020 08:14:09 -0800 (PST)
Received: from [192.168.101.174] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id e9sm3713664pgi.5.2020.11.02.08.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 08:14:09 -0800 (PST)
Subject: Re: [PULL 0/3] tcg patch queue
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201027165114.71508-1-richard.henderson@linaro.org>
 <CAFEAcA8GOB1ivDj=JyjJb8Y5gfwSJePrrV1eci823H8FX_74aQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dcbeb059-af0e-2a22-8ec1-56bad92abfc4@linaro.org>
Date: Mon, 2 Nov 2020 08:14:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8GOB1ivDj=JyjJb8Y5gfwSJePrrV1eci823H8FX_74aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
Cc: qemu@igor2.repo.hu, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 5:57 AM, Peter Maydell wrote:
> On Tue, 27 Oct 2020 at 16:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> ----------------------------------------------------------------
>> Optimize across branches.
>> Add logging for cpu_io_recompile.
> 
> Igor2 reported on IRC that this seems to cause a crash when
> using an hppa guest. This is apparently happening on a proprietary
> disk image, so no reproducible test case, but the logging of
> the tail end of -d in_asm,op is at:
>  http://igor2.repo.hu/tmp/in_asm_op.log
> 
> QEMU asserts with
> ../tcg/tcg.c:3346: tcg fatal error
> 
> The TB in question involves several conditional branches; the
> generated TCG ops look OK to me, and reverting the two commits
> b4cb76e6208cf6b5b and cd0372c515c4732d8b fixes the crash.
> (We didn't test reverting only one of the two commits separately.)

Ok, thanks, I'll look into it.


r~


