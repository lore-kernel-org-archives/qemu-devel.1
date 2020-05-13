Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3654C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CB92064E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/DmlcF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CB92064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuCx-0000SZ-Rw
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuBv-0007u1-Vw
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:25:08 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuBu-00007t-0z
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:25:07 -0400
Received: by mail-pj1-x1044.google.com with SMTP id z15so1984898pjb.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jALpiG9Xg0nLBFUsBAx+25LmHsLE8s16daADM3OrSvI=;
 b=g/DmlcF1AtYt5nb513Vcip4bgcmY1ALoJRus6D1ZKh6/y+UEcMrxNb5HB9u2DkLD7q
 Gep6UTyosO2RgjqgoMm9YvYBrKyZybKw6UsbKmPp0Y54P3aZfHqyA9lP1aPJu0ygxL5S
 9vKX2nEKzUJixNr8oKByT9cRaD+Xm/XxgM1DExBtT28fnV0oc/nmEXLgLWe+G6Da+uEI
 LFsIzg9zVqWXnmSOsi0dnf3eaWxRVQCoPJrsR7Q8jW6S1EdxL09Emd5UOqPZZwP/06Ee
 OUAhLiJqMSVtsRJBeYEsuyr2NJXQWU/86zvzURspxKwNTB/lsJwaKqedsOomm0xHvSxW
 yafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jALpiG9Xg0nLBFUsBAx+25LmHsLE8s16daADM3OrSvI=;
 b=NSBUTPl8DNb3AgPqT3WfoH/XmQ2XZZWagd1cKg6yVbHPm5J/cNiCwtF0eR2EfIokMe
 Pl0BIdNVU5t5Qg4MoIVS0Af6kEIcaJIO6UUGeJu3Itq7kKcW+QMUJywwUtgFKFuLmtby
 UONG8kQKDc5IH6Sda+ZW5SkLVQ5Dq0KcvOzh7Vs8J+5/up7GqoLLxPbu8h5U5D9xBKD0
 k078alLOXtT/Cnv6lk3qnIxajJTCBj/QL+I8oa8oCtAcbEQRa8Rq3VELkBzvQ/fmjiHM
 8jC8EaqsuJSDzEMjBbGUwof4q+DHBrSLSes2JUSEfHIbhpImH+RUAUYrfBb0FlxoNJA2
 0usg==
X-Gm-Message-State: AOAM531DoBlEdb0Eq3KKdWjoqIPRUWiIeboCqvukMeEuvzfma5rXenM8
 l09eshVqOwVbrH8+69P5nymTLw==
X-Google-Smtp-Source: ABdhPJzzyE6UccOQbVB9n2yGsUmcTVsMlxKLulju2ya7pchKz1+bFvNOSUVBW/ossKlMcvcLfSMLNg==
X-Received: by 2002:a17:902:7c16:: with SMTP id
 x22mr14549pll.244.1589387103663; 
 Wed, 13 May 2020 09:25:03 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u3sm40216pfb.105.2020.05.13.09.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 09:25:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] NetBSD/arm build fix
To: Nick Hudson <skrll@netbsd.org>, qemu-devel@nongnu.org
References: <20200512064823.13025-1-skrll@netbsd.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6b6cedd-7e6b-642e-e441-63f68f005582@linaro.org>
Date: Wed, 13 May 2020 09:25:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512064823.13025-1-skrll@netbsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 11:48 PM, Nick Hudson wrote:
>  
> +#if defined(__NetBSD__)
> +    /* siginfo_t::si_trap is the FSR value, in which bit 11 is WnR
> +     * (assuming a v6 or later processor; on v5 we will always report
> +     * this as a read).
> +     */
> +    is_write = extract32(si->si_trap, 11, 1);
> +#else
>      /* error_code is the FSR value, in which bit 11 is WnR (assuming a v6 or
>       * later processor; on v5 we will always report this as a read).
>       */
>      is_write = extract32(uc->uc_mcontext.error_code, 11, 1);
> +#endif

While this works, I think it might be a bit clearer as


    uint32_t fsr;

#ifdef __NetBSD__
    fsr = si->si_trap;
#else
    fsr = uc->uc_mcontext.error_code;
#endif
    /*
     * In the FSR, bit 11 is WnR, assuming a v6 or
     * later processor.  On v5 we will always report
     * this as a read, which will fail later.
     */
    is_write = extract32(fsr, 11, 1);


r~

