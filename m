Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E752AC0044D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27612076D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQVxIbCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27612076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDIDv-0002mD-U0
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 21:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDID2-0002Lc-HB
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDID1-0006LU-AU
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:36:56 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDID1-0006H5-37
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:36:55 -0400
Received: by mail-pj1-x1042.google.com with SMTP id m15so5687330pje.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MkPh+klBPXxqZj98aRVuJbutaODh1jtYz1eovAeUds8=;
 b=mQVxIbCLIm5GR4FENAbW1w0EKfFeWJGOciTEPfdo+D2hFgNIckQIhrt/S/gBJzaDOb
 rN2qpJBCZg+xKO1kB912jDUahkD3czWw5xD7cBlxEXaMxhZKczeBkJLFBsTgcsCq9waG
 a4QeLwkMMpcWoebTFBpNxD8vI9Pr9AaayPCUi/HYwKCk5L0hIleScQz/Z0ah/8vCsbI/
 I9PuPmI4Ood9/bmSCfTbfS8RLTUZbgurFYhIDjuG16gKNBXDN7KXIKhW23twjY+HfQCB
 wNSvkXEBJKrguLvatPjCmu36+df5e7qzSoP/+WiYux8seAnhTRBI7J81gjO8S8j0VBUA
 bBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MkPh+klBPXxqZj98aRVuJbutaODh1jtYz1eovAeUds8=;
 b=VRxP6FBahENxtRyP8k4Zb3pFmfX/YXSTIoXUKJNKBHwhwphGWnalcNXN9SuY/arxQt
 jG1p1os+cHRq4WKu3Rz7NFAmxz5aYgPvjcTwjuZD7xz7m4nEd9xzV36GeumwuXBzcdL4
 gzlrUhv5Hl//jdpR7RYoRO74QBxhou4O9wmgGQWn7ChHNH0ykCOKNaN6PllYvfERsThR
 dH4gAg3UG91gELZXeaMVWKSvyS1Zd/Y/qrkwMlrE1QbqnZM6E+4tI2T2/aic9mekG2Ou
 B+7/QZth3Gu4MllzzRDsk92e6K2JNy2gQAHV5AKMIdRXNNbW+qtrfRO6659vofma2c8h
 6FfA==
X-Gm-Message-State: ANhLgQ0yiux26nlSz/rvFR3jt8qfTfivRCVrdoxHCyVJuzfGhTNoYcTb
 TuZqHTHlz/ZG/7HN9/iusPYHKQ==
X-Google-Smtp-Source: ADFU+vuzgW1+1LHRTEe3CcbvmTeTa8lr1GozmfsCfpmNS3wcO2FWIZahChLoJp37jfA+apOUNzIr6Q==
X-Received: by 2002:a17:90b:4c91:: with SMTP id
 my17mr3328953pjb.140.1584236213697; 
 Sat, 14 Mar 2020 18:36:53 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 15sm4593122pfu.186.2020.03.14.18.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 18:36:53 -0700 (PDT)
Subject: Re: [PATCH v5 50/60] target/riscv: vmfirst find-first-set mask bit
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-51-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e514fa28-dee0-2c25-8ee2-9aa8b5d2ea77@linaro.org>
Date: Sat, 14 Mar 2020 18:36:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-51-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +/* vmfirst find-first-set mask bit*/
> +target_ulong HELPER(vmfirst_m)(void *v0, void *vs2, CPURISCVState *env,
> +        uint32_t desc)
> +{
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    int i;
> +
> +    for (i = 0; i < vl; i++) {
> +        if (vm || vext_elem_mask(v0, mlen, i)) {
> +            if (vext_elem_mask(vs2, mlen, i)) {
> +               return i;
> +            }
> +        }
> +    }
> +    return -1LL;
> +}

This is ok as-is, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But you can do better.  With the mask, as discussed, the inner loop looks like

    j = mask;
    j &= ((uint64_t *)vs2)[i];
    j &= ((uint64_t *)v0)[i];
    if (j) {
        k = ctz64(j) + i * 64;
        return k >> log2_mlen;
    }


r~

