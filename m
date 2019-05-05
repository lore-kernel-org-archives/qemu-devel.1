Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596B6C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 17:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D20F2082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 17:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hACxmFMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D20F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43741 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNKWV-0007KM-CQ
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 13:01:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKVZ-0006cy-Hk
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKVX-0003XI-BY
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:01:01 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:44876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKVV-0003SG-HS
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:00:59 -0400
Received: by mail-pg1-x532.google.com with SMTP id z16so5224567pgv.11
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=IpnnHFH6yS8Xz4HScJR5/N58UXo0YWsW1s4UrwiJe4M=;
	b=hACxmFMHQJ3CEn9UcrLQ++jnF7gpNpcFXTegUcx3M0wKmrIudvSfbk2FZYLvBPzDpv
	ZvNtU8QfNIz8nkaoZFXuaFmeGFcsqkSamkvATEx4u54iilgtYbWIX1rm3CRUV+Ija6Db
	gf7FLhJwT60vNgW+aqDJpJmGDOOxHh4e7NB73wUck6BaWSwXUKQHnYmh3H+nLCHxeJBH
	NMw49agtV+T0NUZLsIdNpW5rLwVsVg3MiR7O9VsM/4izWA8W4F3SYC02PWM+gETqdQJq
	O7Kbe4rI3Y3mURfUiWUmKSPtdsr5hFRtu+jYD1Eg+5Pfc7QFsiCsu4Xw5JU6gjKV67C4
	zbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=IpnnHFH6yS8Xz4HScJR5/N58UXo0YWsW1s4UrwiJe4M=;
	b=tGwwIIWYqdXwC1fGvC2OrvnLAW9hmngLUngW7LwdjFs0BHspqzs4qHPMlum1HcYZtl
	2Vi/ghj5yGzi9Bshq1VmjWcu21NwH2jtt5WhQ7DVLoT0+JPuOTMka6Mn8RruxtI0czFy
	T7lZkN1ELi1oOSkdw5l8NvHcdkhYkxczWXkRRtlVF8tsWGrLR6+Lky9Shxy1F5mg6t+T
	0cWCYdpy2PKnl3oEhj2v3F6zuDcF1G2OVtYz7V4C7V2SY93qdP1E53qOyBEvMOz95ksM
	AUM6VkfYpC3CD84Gmlkb+4wCkDi3HQ+tM9GkGoShUeksh1O7lAgL6UzdsKRPkdhamgu7
	S2BQ==
X-Gm-Message-State: APjAAAW3t10lpd/Tkrax/4fBcXmpYY7f2h0R5BoVazIkdJ01JvVnj/nY
	6vSqTEYg3wi4EDZqwWbEUA1ptg==
X-Google-Smtp-Source: APXvYqyf9k1AXw07eof1Q8KaYYVC480LgD9rHrM5XjfaPNp26jJRxIbb0IosDQBMiRMlDN42dW027w==
X-Received: by 2002:a63:1b04:: with SMTP id b4mr25937594pgb.305.1557075653760; 
	Sun, 05 May 2019 10:00:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	b9sm10525084pfd.32.2019.05.05.10.00.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 10:00:52 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c5f2f531-34ce-d7b2-a6d7-1a2399466cf5@linaro.org>
Date: Sun, 5 May 2019 10:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-5-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::532
Subject: Re: [Qemu-devel] [PATCH 4/9] coroutine: add host specific coroutine
 backend for 64-bit ARM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, cohuck@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505170050.XKdSEwiWWMs9ZuZ5shgYSVQXwv64FNMme3wqrP4jmt4@z>

On 5/4/19 5:05 AM, Paolo Bonzini wrote:
> The speedup is similar to x86, 120 ns vs 180 ns on an APM Mustang.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                        |  2 +-
>  scripts/qemugdb/coroutine_asm.py |  6 ++++-
>  util/Makefile.objs               |  2 ++
>  util/coroutine-asm.c             | 45 ++++++++++++++++++++++++++++++++
>  4 files changed, 53 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +        "ldr x30, [x1, %[SCRATCH]]\n"    /* load destination PC */   \
> +        "ldr x1, [x1, %[SP]]\n"          /* load destination SP */   \
> +        "mov sp, x1\n"                                               \
> +        "br x30\n"                                                   \
> +        "2: \n"                                                      \

For future reference, "bti j" (aka hint #36) goes here,
for the aarch64 branch target identification extension.


r~

