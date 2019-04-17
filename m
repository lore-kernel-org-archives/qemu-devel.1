Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42837C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF116206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzsY5o7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF116206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqSH-0001Ie-4H
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:42:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqKE-0004ik-AW
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqKD-0004MY-79
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:34:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGqKC-0004KQ-RO
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:34:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id y3so12445977pgk.12
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=VbNjd1hJY4K23JcowT1RLEz/O21Xxn/9LYJsw3YJ46I=;
	b=lzsY5o7e2mGqBgM+pgH6paTBL048Lh41kd849azZgXfugg+kfg6YL6LOP6OQjrjXa8
	gpCDvrHXeGXHnowbBlIJuaGVaMqnBH1kyUlEAn0gGoVtRr77fLdlBSkRtDvRY8RQ3cCr
	8REs+UCBR7zksxvO48u4LmXlrek67u58rC63cEe915ojSlJjUNUOx9P35zDcrZtnoKk3
	D/Z4mS7Wh3oOPw7ie/Fmb84Ho6DuTzvX3Jm8Fh1fvQdTIAwF/apSRrUpIjmIF2OatknH
	JpcV1CA0cuoLu/O1jN0ieChRO+uh+2g15T+Fhdkwi08CWDUWLFO7wHnlkphv9O3FvSQF
	G14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VbNjd1hJY4K23JcowT1RLEz/O21Xxn/9LYJsw3YJ46I=;
	b=beECPmJVMXizjyQucvbLr3ohPWvCJWZ6St0kfwoVyHGh/YCHIVyUTnPNUDoTPStv7m
	2JityXXAStKDLAjmryt5oI4a9i4aS+LKO3+tMuH1mWBO9ZloJk2SebCXhxvsIXhsZ6cY
	seb9CIX4roW7LoyqQ+e4pkqk3vkjfeuG9Bow7H4c3BfFwTMaHyXrlIrc6KYFjVzOOBLM
	5zpFUchTMP13QVaPLTl1Yj2huCKAUbdOzR7F663c/MUrQr2OnJyv3OxEB+qZ6ty/k0Au
	6Fx2O1hVsjiAiJmf8iktVqbbe6x8BfITh87U2Sqv3SENzpdSfsMTun/uspvKo5HSZrZt
	26Aw==
X-Gm-Message-State: APjAAAUvo+qGthSoQxOT/R6pH+YnsCnXAEl7VdN3dRkIGxuDER4VhmK7
	h+s2Kh/kvpb0Vi3CzT5ObgIsGQ==
X-Google-Smtp-Source: APXvYqwmmM+WdsM2sxOGrv31aMARpN/ZjwnE4QMbb3hXGYzXXn1zDLFamhuj7HhLxGqMlNijgQCBIw==
X-Received: by 2002:a63:1247:: with SMTP id 7mr83683621pgs.352.1555529667275; 
	Wed, 17 Apr 2019 12:34:27 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155])
	by smtp.gmail.com with ESMTPSA id h3sm4205352pgl.3.2019.04.17.12.34.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Apr 2019 12:34:26 -0700 (PDT)
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1555515206-9352-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cf8101ba-e5b1-ad42-9615-ee6cae402cee@linaro.org>
Date: Wed, 17 Apr 2019 09:34:22 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555515206-9352-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v7 2/6] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417193422.YV9ZKZjiz3MKC5dcZk8wNysnaUVPahZhYJzYJyrzsgM@z>

On 4/17/19 5:33 AM, Mateja Marjanovic wrote:
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> 
> Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
> directly tcg registers and performing logic on them
> instead of using helpers.
> 
> In the following table, the first column is the performance
> before this patch. The second represents the performance
> after converting from helpers to tcg, but without using
> tcg_gen_deposit function. The third one is with using the
> tcg_gen_deposit function and with using a uint64_t constant
> bit mask, and the fourth is with using the tcg_gen_deposit
> function and with a mask which is a tcg constant. The fourth
> is implemented in this patch.
> 
> Performance measurement is done by executing the
> instructions 10 million times on a computer
> with Intel Core i7-3770 CPU @ 3.40GHz×8.
> 
> ==================================================================
> || instruction ||     1     ||     2    ||     3    ||     4    ||
> ==================================================================
> ||   ilvev.b   || 126.92 ms || 24.52 ms || 25.19 ms || 23.89 ms ||
> ||   ilvev.h   ||  93.67 ms || 23.92 ms || 24.76 ms || 24.31 ms ||
> ||   ilvev.w   || 117.86 ms || 23.83 ms || 21.84 ms || 21.99 ms ||
> ||   ilvev.d   ||  45.49 ms || 19.74 ms || 20.21 ms || 20.07 ms ||
> ==================================================================
> 1 - before
> 2 - no-deposit-no-mask-as-tcg-constant
> 3 - with-deposit-no-mask-as-tcg-constant
> 4 - with-deposit-with-mask-as-tcg-constant (final)
> 
> The deposit function is used only in ILVEV.W.
> 
> No-deposit version of the ILVEV.W implementation:
> 
> static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>                                uint32_t ws, uint32_t wt)
> {
>     TCGv_i64 t1 = tcg_temp_new_i64();
>     TCGv_i64 t2 = tcg_temp_new_i64();
>     uint64_t mask = 0x00000000ffffffffULL;
> 
>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
>     tcg_gen_shli_i64(t2, t2, 32);
>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> 
>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>     tcg_gen_shli_i64(t2, t2, 32);
>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> 
>     tcg_temp_free_i64(t1);
>     tcg_temp_free_i64(t2);
> }
> 
> Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/helper.h     |  1 -
>  target/mips/msa_helper.c |  9 -----
>  target/mips/translate.c  | 87 +++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 86 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

