Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADAAC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB2820651
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTn9247D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB2820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqQZ-0008Rs-BK
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:41:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqF2-0000SR-J7
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGqF1-0000Is-9j
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:29:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGqF0-0000Gz-Rr
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:29:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so12473351plp.10
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=POI4uWF27IB+mFNDPEicsUOWBGQH/vsnEtwTtLrnzOg=;
	b=hTn9247DUmKtWdGFiXaRkDYEEk2CnOLkdr8UMULwKA1ai49D3a+wQTn/X6tBTOgBTQ
	itceoKbODaeDNdL+tpWNzNDzu6KBNBusIxecYhYu8uYOoHM7O2mzrHEh7KTB5Z8hCAze
	thFfYWgSNOpPpa9T16LBuwLVaPLlK8vs/6tWEAjRuRWMJuPfuesphUd0EezY6hUvqSYT
	VdU4u+L23BnxLi5IWFWVhWPKx6GPtJ/Q1akB+AIJaMTBimv84lJ38WSsKdwq87Y62uOS
	39FBZ5rTBtkGzGL55/lQuB46T/g3RqS+y7mHFhKPxXHF3W1QZhgIE5qKuC6PKG8BHizH
	3aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=POI4uWF27IB+mFNDPEicsUOWBGQH/vsnEtwTtLrnzOg=;
	b=XCtX98za9ac4HDafwaDJzle4vk5qBQYaCyQoMUUoA6xFs1dZiql4i+1c7dUK8nIxXU
	UpXv/JQu6Zmf2g0/9nq9xhgFjT/geoYwFJs2vMG9O/Bfg2wJfph1UqlusABT8oh30NC3
	hD6h2vgb72SGgSed4RUsnVQYm2XOoOp0WVrZ8TpDGZTxKMlM7srl7gZIBo2Qm5nMJZDV
	jmF0KvvsFjWPFC+u+J/XXhzjGUYpciDIJZK07hp4w98Utm6y70d4vTVbKsU6MjEPTEDp
	z66mQMs//94pE/+DhiPtXH7A9MhsIWK9MMqEuJGPk2zcHAnz0n5HkmcjokpyFLS2aBuv
	XebA==
X-Gm-Message-State: APjAAAUmewMIigyoJZUOPBoebdip2J/hBeqWSTrC+tr7QNJjmOfVh2VC
	ZhEjow+xyAnTGNLDrRadLxzNfg==
X-Google-Smtp-Source: APXvYqy0GU3uurGSXDXOoR/smXHmtYNzQshoN5yXcso94uiQzE3Q78b58XfQTXsYwFP9Q+Lh8hKtAg==
X-Received: by 2002:a17:902:2a6a:: with SMTP id
	i97mr35966295plb.273.1555529345149; 
	Wed, 17 Apr 2019 12:29:05 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	s85sm82067713pfa.23.2019.04.17.12.29.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Apr 2019 12:29:04 -0700 (PDT)
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1555515206-9352-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d533932a-1bc4-6199-9e68-6c1d128d1724@linaro.org>
Date: Wed, 17 Apr 2019 09:29:00 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555515206-9352-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v7 1/6] target/mips: Optimize
 ILVOD.<B|H|W|D> MSA instructions
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
Message-ID: <20190417192900.dJBl5xPjQ0BScG83DZM6fxNWoNbGJnXppSFuJk48Jyg@z>

On 4/17/19 5:33 AM, Mateja Marjanovic wrote:
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> 
> Optimize set of MSA instructions ILVOD.<B|H|W|D>, using
> directly tcg registers and performing logic on them instead
> of using helpers.
> 
> In the following table, the first column is the performance
> before this patch. The second represents the performance
> after converting from helpers to tcg, but without using
> tcg_gen_deposit function. The third one is with the deposit
> function and with using a uint64_t constant bit mask, and
> the fourth is with the deposit function and with a mask
> which is a tcg constant. The fourth is implemented in this
> patch.
> 
> Performance measurement is done by executing the
> instructions 10 million times on a computer
> with Intel Core i7-3770 CPU @ 3.40GHz×8.
> 
> ==================================================================
> || instruction ||     1     ||     2    ||     3    ||     4    ||
> ==================================================================
> ||   ilvod.b   || 117.50 ms || 24.13 ms || 24.45 ms || 23.24 ms ||
> ||   ilvod.h   ||  93.16 ms || 24.21 ms || 24.28 ms || 23.20 ms ||
> ||   ilvod.w   || 119.90 ms || 24.15 ms || 23.19 ms || 22.95 ms ||
> ||   ilvod.d   ||  43.01 ms || 21.17 ms || 23.07 ms || 22.59 ms ||
> ==================================================================
> 1 - before
> 2 - no-deposit-no-mask-as-tcg-constant
> 3 - with-deposit-no-mask-as-tcg-constant
> 4 - with-deposit-with-mask-as-tcg-constant (final)
> 
> The deposit function is used only in ILVOD.W.
> 
> No-deposit version of the ILVOD.W implementation:
> 
> static inline void gen_ilvod_w(CPUMIPSState *env, uint32_t wd,
>                                uint32_t ws, uint32_t wt)
> {
>     TCGv_i64 t1 = tcg_temp_new_i64();
>     TCGv_i64 t2 = tcg_temp_new_i64();
>     TCGv_i64 mask = tcg_const_i64(0xffffffff00000000ULL);
> 
>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>     tcg_gen_shri_i64(t1, t1, 32);
>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> 
>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>     tcg_gen_shri_i64(t1, t1, 32);
>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> 
>     tcg_temp_free_i64(mask);
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
>  target/mips/msa_helper.c |  7 ----
>  target/mips/translate.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 90 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

