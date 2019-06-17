Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4488BC31E49
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D67B2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5ppl8tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D67B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hchbZ-0007oS-KD
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 22:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34102)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hchaA-0006tu-2Z
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hchNZ-0001BP-72
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:28:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hchNX-0001AI-Lv
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:28:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id v11so4877800pgl.5
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 19:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1LPfcdrD/k4H78JoS4S2qB87Exh5rKrRhAgJ6vHwYrA=;
 b=o5ppl8tf/lah2Vgg8DU9L80yaBXBlg95iFyumumouS2heGl7WfSWNXNKAMA0jsaxCd
 T0lyzjgwA8ZcWdg7UsYPdeh6WNqIqVdXp15BwydMjciOwNDTH2TUYe83Vrc2ou/FVDc5
 Vu5FHC8nsu+3ShycFWUy1cpmaaKH7LWDPC0dnEg3csuiIk+JgGrKDCbnRk6H6h10yXH2
 56YvAMohefnx/mxhUn31+7gn6KGADmna/va00MDKMKrG8d/pU2JnOm4q5EMyrUC3F522
 zV/2lOWv9tsdlqwwXq8+PzpJc4U1ulehzS7mIx5Mezz/C2lcyF7iO9fw0QLcj+YKekX3
 0h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1LPfcdrD/k4H78JoS4S2qB87Exh5rKrRhAgJ6vHwYrA=;
 b=p5CgslSKO4pWKgcnNdXIG7XSmR3q2EqYuhOwm1Uicaylia16gkJXisv2rXiE2MNGv+
 +OcfwMbUYmOAULGHbolg52vZ6PzxiCOKFquyG5iU/J2/qIL71s8T404dcIqozJRanLaU
 wIBPzr02wpdaDJ4A9zhduaFU+OQbKPl6AEBEHQbfbcUXmvK39A9fY8PxEKd9zxMri3kT
 S/pA4kBCNegtkOmbvij5ylIDxKB+UUydMRjduvUZZZBtUmt+2WMkXz/uBs9O4NuszKF9
 i6gnfq0sCpZsdD/UTG8VDdZmU6g1GBUutshWHs1BdIf3EXrr6ZHbWytHBiZ5C3doSIIS
 5A3g==
X-Gm-Message-State: APjAAAWOZNFI4ttlAOK3mDGjf4t3FCvp+rhxyE6fpgYehY9ZwgpezzKg
 GUiQWpSZHy2aaZbBTs+3evRwbg==
X-Google-Smtp-Source: APXvYqzViMX5IFZl8nGyPr+76gb7JrPJHnb2nYyGvZRxvIOGFi0eCFNXGZgRoVRNthNhj/xpKEv+Ug==
X-Received: by 2002:a63:2ace:: with SMTP id
 q197mr46363889pgq.102.1560738494011; 
 Sun, 16 Jun 2019 19:28:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 j14sm9889915pfe.10.2019.06.16.19.28.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 19:28:13 -0700 (PDT)
To: vandersonmr <vandersonmr2@gmail.com>, qemu-devel@nongnu.org
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
 <20190614135332.12777-2-vandersonmr2@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3e8fb7a9-12cc-aea7-6c95-de6ba8f8209b@linaro.org>
Date: Sun, 16 Jun 2019 19:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614135332.12777-2-vandersonmr2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [Qemu-Devel][PATCH 1/3] Adding an optional tb
 execution counter.
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 6:53 AM, vandersonmr wrote:
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TranslationBlock* tb = (TranslationBlock*) ptr;
> +    atomic_inc(&tb->exec_freq);
> +}
...
> +DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
...
>      uint32_t flags; /* flags defining in which context the code was generated */
>      uint16_t size;      /* size of target code for this block (1 <=
>                             size <= TARGET_PAGE_SIZE) */
> +    uint64_t exec_freq;

It's not a frequency, but a count.

>      uint16_t icount;
>      uint32_t cflags;    /* compile flags */

Consider where you've placed the data with respect to the packing of other
members of the structure.

>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
>      TCGv_i32 count, imm;
>  
> +    if (enable_freq_count) {
> +        TCGv_ptr tb_ptr = tcg_temp_new_ptr();
> +        tcg_gen_trunc_i64_ptr(tb_ptr, tcg_const_i64((int64_t) tb));
> +        gen_helper_inc_exec_freq(tb_ptr);
> +    }
> +
>      tcg_ctx->exitreq_label = gen_new_label();
>      if (tb_cflags(tb) & CF_USE_ICOUNT) {
>          count = tcg_temp_local_new_i32();

By placing the increment before the exit for interrupt check instead of after,
you're kinda counting the wrong thing, because the TB hasn't executed.


> diff --git a/linux-user/main.c b/linux-user/main.c
> index a59ae9439d..1bf7155670 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -58,6 +58,7 @@ static const char *seed_optarg;
>  unsigned long mmap_min_addr;
>  unsigned long guest_base;
>  int have_guest_base;
> +bool enable_freq_count = false;

This is being declared in multiple places and initialized in multiple places.
This needs to go elsewhere.


r~

