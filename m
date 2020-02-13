Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8047FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57759222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilxu9p45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57759222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JIJ-0005Hf-JQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2J6X-0006qJ-Hc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2J6T-00069O-8F
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:20:47 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2J6T-000616-0x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:20:45 -0500
Received: by mail-pg1-x543.google.com with SMTP id j4so3551919pgi.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mrycwskl5pvPO64L7Ue9xswCdopqbG7ifptehKNfIOg=;
 b=ilxu9p45EZ+17nmkXQUzlwbcmOJbELfU7c3J9+8punSbapIaeN5ExOiYTcFGKCknwS
 ZR6uSr2l091QQBNDSHdkjyaZ5lZHCAImsTD9qlJX6NZEpz+suyq56KnEywnkDBMbxslR
 I18ft2L3DRBX6ejFx0jfamuuDpcrRbc+l0t9wV+4ULvuUfJsCk4sny7dz+eoaAQWhJTu
 02pDxlestMNKo2P6Dktj0WJ1/kJUJLZsIpv2ir09o+tmQru1jKsq8shN5136ksT3S0ne
 px0gHPYN/jUaeH+oo9IUq8Xtk3WgJRzIU02rckrDhHpFSV6nAGnFMqbIE2bb2gV/jglV
 vEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mrycwskl5pvPO64L7Ue9xswCdopqbG7ifptehKNfIOg=;
 b=OawBuTO/GAZ11FCtFVpnyVSiGbLPOQrPmsw9dHnmnm+0musM8yyLAc6cskTAAFUqPa
 mOSXD7GrpbZFYXAE+WWQi4i8RzaDXKtrYRyKpLotiEjqiIDyIlUn4JoNG/Dnp40zqwPw
 P6JxV6Wh+OOYKTeu0csdOwI2dHdLSUevpCmMOw1+qrYp9CiT7W/e/oTgD4XwnXBYP0iU
 iAGAAFxIijg1I8oMknzKdt+flAGehTVIaThinZfyBOVPh20ysuEgZPHCOvaC7YbbefAs
 01JZN2vJpmFtIkb+se1ii8wuubuplJt6rIAUUUpyk1EOE5PuYdK3EOwSokcuj5X0iGrv
 dZdw==
X-Gm-Message-State: APjAAAU9+ZgPbhk4QBIB88F7zfHM6CtjZnblOAJESq01Sa6RnJiDKb9C
 8upUVhkoUPz98ZH69Nd5cDfEgQ==
X-Google-Smtp-Source: APXvYqy+Xyy6rL54cp8a8loTRl5wNI7qQJj4S7vyO332WcWph42Fdbw6o2rRl9dmxnM6pNGf0ZHHPw==
X-Received: by 2002:a63:2309:: with SMTP id j9mr19339081pgj.54.1581618038815; 
 Thu, 13 Feb 2020 10:20:38 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 v9sm3526676pja.26.2020.02.13.10.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 10:20:38 -0800 (PST)
Subject: Re: [PATCH 2/2] util: add util function buffer_zero_avx512()
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
 <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee2ef44a-737b-e989-7f20-18a69e19d430@linaro.org>
Date: Thu, 13 Feb 2020 10:20:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: robert.hu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 11:52 PM, Robert Hoo wrote:
> And initialize buffer_is_zero() with it, when Intel AVX512F is
> available on host.
> 
> This function utilizes Intel AVX512 fundamental instructions which
> perform over previous AVX2 instructions.

Is it not still true that any AVX512 insn will cause the entire cpu package,
not just the current core, to drop frequency by 20%?

As far as I know one should only use the 512-bit instructions when you can
overcome that frequency drop, which seems unlikely in this case.  That said...


> +    if (unlikely(len < 64)) { /*buff less than 512 bits, unlikely*/
> +        return buffer_zero_int(buf, len);
> +    }

First, len < 64 has been eliminated already in select_accel_fn.
Second, len < 256 is not handled properly by the code below...


> +    /* Begin with an unaligned head of 64 bytes.  */
> +    t = _mm512_loadu_si512(buf);
> +    p = (__m512i *)(((uintptr_t)buf + 5 * 64) & -64);
> +    e = (__m512i *)(((uintptr_t)buf + len) & -64);
> +
> +    /* Loop over 64-byte aligned blocks of 256.  */
> +    while (p < e) {
> +        __builtin_prefetch(p);
> +        if (unlikely(_mm512_test_epi64_mask(t, t))) {
> +            return false;
> +        }
> +        t = p[-4] | p[-3] | p[-2] | p[-1];
> +        p += 4;
> +    }
> +
> +    t |= _mm512_loadu_si512(buf + len - 4 * 64);
> +    t |= _mm512_loadu_si512(buf + len - 3 * 64);
> +    t |= _mm512_loadu_si512(buf + len - 2 * 64);
> +    t |= _mm512_loadu_si512(buf + len - 1 * 64);

... because this final sequence loads 256 bytes.

Rather than make a second test vs 256 in buffer_zero_avx512, I wonder if it
would be better to have select_accel_fn do the job.  Have a global variable
buffer_accel_size alongside buffer_accel so there's only one branch
(mis)predict to worry about.

FWIW, something that the compiler should do, but doesn't currently, is use
vpternlogq to perform a 3-input OR.  Something like

    /* 0xfe -> orABC */
    t = _mm512_ternarylogic_epi64(t, p[-4], p[-3], 0xfe);
    t = _mm512_ternarylogic_epi64(t, p[-2], p[-1], 0xfe);


r~

