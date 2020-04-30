Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D65C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 21:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB15F2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 21:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvPDBEfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUGKr-0007f9-PS
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 17:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUGHH-0005SY-VQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUGHF-0002sl-Ut
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:59:27 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUGHF-0002oK-8B
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:59:25 -0400
Received: by mail-pf1-x442.google.com with SMTP id f7so479623pfa.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=syP61VexkoQAAxyuK65YJsKWhf8NpTioloMhS9Km3MM=;
 b=VvPDBEfJ+M2OEkq+qxXVu1rnwQ5qaCrbJmrxg04G0NYod2Ox0fU4PDS9/ooFbeFmL/
 pIsx6oBIMB9BHh9+0mAmf/Qry172ajF+HNP95DDiLoBfUJfsAkZsTfVZQ2hHpTf1DRdp
 JOfF2/QwTUmXgOSqVjv3y3mX83b/vxDnP+JuG7LE5IRsxiGyOQfS9YAZuy4CCVFjqrf2
 sFO8YIM0lUpkT3l7D7qOMyE9IR+yM8a2XyMyvPivoXNNm+b96w/SKgNFPGxwI3DI9VvD
 2uCpCM1rFDsblDsSFmVe4AZ7e3niGIjC0CApVfVXjy8z7wGkgIG9SnL1/hssAH9mywFE
 0wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=syP61VexkoQAAxyuK65YJsKWhf8NpTioloMhS9Km3MM=;
 b=XYA6FJ3BF/TqYS+YXHQB2f2AqXsyUPdKrPyoFwGgYD4xhf/JJfu5s1uRSsfbnHio1M
 qn8thujLl5c9S0W5PgthUCQucZ8tqgwrYcxtdkN5qlg7BrzH2d46ZRZ+2XhHYRb34YtO
 pPR+DDu5mOWlbJKVegAg0tGnc+Uu5UkrP8373DK5q5NmGTd0RrFrcbURE+vy4smaHGqA
 wY4SmhR9EKreUJ5ru06gI6zmMbMAWy82gKkEZhNTtHt4EDnrFV5qAhATeRbpAN7oETIU
 dIg37hdbS+xanMoIIf0j3qWtyBlGVNCZMjJx0DHHK0QpD7MoutwLiNZgXwfGoSu6/pjd
 NJ9g==
X-Gm-Message-State: AGi0Pualo/9UwiOo5iZ+lGsqfS9mcp0YCXS2OKi2V358xhxoaOYoM5if
 zbAtFcbUUbToJ9ykIMuCqYrdOWU7rNI=
X-Google-Smtp-Source: APiQypK0hy8jIWJhyje5sVwnzH9TMnlGsVZNFhRlRRXUC1Ce8pmQPxTbzgy7a+l6s6S7ov59LjEAgg==
X-Received: by 2002:aa7:990f:: with SMTP id z15mr713752pff.132.1588280362607; 
 Thu, 30 Apr 2020 13:59:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a16sm578009pff.41.2020.04.30.13.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 13:59:21 -0700 (PDT)
Subject: Re: [PATCH 24/36] target/arm: Convert Neon VHADD 3-reg-same insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-25-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72c8792f-2ab6-dd8b-94e9-79cf533fc584@linaro.org>
Date: Thu, 30 Apr 2020 13:59:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> +    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
> +        tmp = neon_load_reg(a->vn, pass);
> +        tmp2 = neon_load_reg(a->vm, pass);
> +        fn(tmp, tmp, tmp2);
> +        tcg_temp_free_i32(tmp2);
> +        neon_store_reg(a->vd, pass, tmp);
> +    }
> +    return true;
> +}
> +
> +#define DO_3SAME_32(INSN, func)                                         \
> +    static bool trans_##INSN##_S_3s(DisasContext *s, arg_3same *a)      \
> +    {                                                                   \
> +        static NeonGenTwoOpFn * const fns[] = {                         \
> +            gen_helper_neon_##func##_s8,                                \
> +            gen_helper_neon_##func##_s16,                               \
> +            gen_helper_neon_##func##_s32,                               \
> +        };                                                              \
> +        if (a->size > 2) {                                              \
> +            return false;                                               \
> +        }                                                               \
> +        return do_3same_32(s, a, fns[a->size]);                         \
> +    }                                                                   \

Right, I just talked about the .fni4 hook vs the DO_3SAME_64 patch.


r~

