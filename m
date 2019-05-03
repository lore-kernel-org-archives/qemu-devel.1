Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A45C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 03:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E092075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 03:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCJwqBxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E092075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMPA5-0002C6-38
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 23:47:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMP96-0001ru-Uj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMP96-0003iv-1b
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMP95-0003iO-Q5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:45:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id b3so2026500plr.7
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 20:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=40b+lUXPoMvbyVf8fe/A5lxWr1bCVOZIGD4ywstMp8M=;
	b=DCJwqBxI7CYb1SHkhRc3Icv8S0mAu+Z1ka7wXhc0w/GS94lazUAHgg5sPXpfwGTJxe
	1SqSfwn9p1A83ksJYasRwTW+SVm79okyGZthEB1kAA1g6UPnzzunNfmpVWTFFQdbSuCd
	5i2Jb8koCU9R4NqFE5TZj2YJ8gwHQuX1WMyxTg6u7vETJF44ePTEAuo47FFyQ5qUWx3o
	M6DTQZU9dhCgGYRCFjqaXGWGy3t/QH6eYTPiQO38yeP4BK9Fww2QdQpEfDw9TJ1HjaRd
	HHy/535O5ldZv2ePKoi9crWHtGHASyij7Z+BBVZ2e0VafyNRVYF+mg5qU/I196U8FkUu
	oUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=40b+lUXPoMvbyVf8fe/A5lxWr1bCVOZIGD4ywstMp8M=;
	b=e8A9RJviWYXcjwJHT5wPdfbg5yiblHsm1dHNyOonEMUKyd8CymkvjfI07rHJhJnCMb
	njlDQ+V+Y7gr6hkTxcIRqMh6FT6bzbaNDkD8zSJilMCgvXX+5Zx5FVMfDG6xhh95NvgH
	teen1nE0ZWJDFDHhX9of8u9R6/liSgsiXbnNPVvPlrk2KkvW4wqUhLiOrkkBh/fbXZrZ
	O3rqjFcr1xN9NqSeKyh/kFpDusY/n2r2IR1SgHovLgyXMOKsBYNdkpJcu/EpGY3rigwx
	d05MG02A+/jTAnB7S97kQjSzPqAun891WbHPLyRIxNqfmUltvli04QQJHEfu7GOyooTc
	/Iog==
X-Gm-Message-State: APjAAAWX0d4kYjyoJRzSePaQSYffJWL0D4oiBlFAdd2sfSA6mBjVVBwl
	h/ceTgCMFqIuyFV5eO1yUwbf/w==
X-Google-Smtp-Source: APXvYqxLrzU8jVPR4wu2fWew15nNUsn+KCQZnmtNQrPvLnpLIRjuS39lLZKrzINoM6xgEsx1Mn8y2A==
X-Received: by 2002:a17:902:7d8f:: with SMTP id
	a15mr7509062plm.3.1556855158619; 
	Thu, 02 May 2019 20:45:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	y17sm808737pfb.161.2019.05.02.20.45.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 20:45:57 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <69b8508d-9586-ab11-3318-83d21ddd4d25@linaro.org>
Date: Thu, 2 May 2019 20:45:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-3-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v3 02/40] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503034555.tQmgg2LNBqlW89Smj5ILEd6TqQ3Ks_sD-SM3XV7Ksi0@z>

On 5/2/19 7:09 AM, David Hildenbrand wrote:
> 128-bit handling courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 +
>  target/s390x/translate_vx.inc.c | 94 +++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static void gen_acc(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, uint8_t es)
> +{
> +    const uint8_t msb_bit_nr = NUM_VEC_ELEMENT_BITS(es) - 1;
> +    TCGv_i64 msb_mask = tcg_const_i64(dup_const(es, 1ull << msb_bit_nr));
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +    TCGv_i64 t3 = tcg_temp_new_i64();
> +
> +    /* Calculate the carry into the MSB, ignoring the old MSBs */
> +    tcg_gen_andc_i64(t1, a, msb_mask);
> +    tcg_gen_andc_i64(t2, b, msb_mask);
> +    tcg_gen_add_i64(t1, t1, t2);
> +    /* Calculate the MSB without any carry into it */
> +    tcg_gen_xor_i64(t3, a, b);
> +    /* Calculate the carry out of the MSB in the MSB bit position */
> +    tcg_gen_and_i64(d, a, b);
> +    tcg_gen_and_i64(t1, t1, t3);
> +    tcg_gen_or_i64(d, d, t1);
> +    /* Isolate and shift the carry into position */
> +    tcg_gen_and_i64(d, d, msb_mask);
> +    tcg_gen_shri_i64(d, d, msb_bit_nr);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +    tcg_temp_free_i64(t3);
> +}
...> +static void gen_acc32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    gen_acc(d, a, b, ES_32);
> +}
> +
> +static void gen_acc_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 t = tcg_temp_new_i64();
> +
> +    tcg_gen_add_i64(t, a, b);
> +    tcg_gen_setcond_i64(TCG_COND_LTU, d, t, b);
> +    tcg_temp_free_i64(t);
> +}

As an aside, I think the 32-bit version should use 32-bit ops, as per
gen_acc_i64.  That would be 4 * 2 operations instead of 2 * 9 over the 128-bit
vector.


r~

