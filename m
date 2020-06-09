Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3862C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC13206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJzhe5i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC13206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiTm-000307-RY
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiiF4-00087r-IQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:40:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiiF2-0005Rq-TU
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:40:54 -0400
Received: by mail-pf1-x441.google.com with SMTP id b201so10401286pfb.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=jBasq2HlXfK5voP01gxs0wtnR36LLYRt0XI1AqC9FVc=;
 b=EJzhe5i+zNgaON/3jcBQK00amcSerEcnunR0dlI7yf3Ou6SrJQUTsbnS5QQzTPvs6T
 iq5io3DM169jnUKB/G/TGZAgcFjMAoAYhH0J47hIMKxbUQ6Zeqh7bH/1sAOD+OJ6KyMB
 YyC2GhpnV0NtdsTbxwIdfmdiG+fLLvCGKDcwrTkQTWDgWWfMsHMaWj1fTRg+w/sVHrMM
 suWFC7SWaAPhFkv4Xln5tiWsML/8ArQmPVaYlrsbmzXvRtfaYbtMshyFSqywg7NGF5Ch
 JNRGy5EjpYltr6JXK4W/uhdTw1n1IE45jOajKtNnMtWvg5ba22hWYyHbg3mgvJ5tUNFV
 ZeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jBasq2HlXfK5voP01gxs0wtnR36LLYRt0XI1AqC9FVc=;
 b=BrA2wMAkB6Chx2HRD4QBbyxBngEa24NO+0Qe3eaT0h1Yrefw5g+D+5kf6s5eaT/8iv
 U/D+ZlrdhIXckaeXIrNhZ/DLCXf/a6RvXFT2s9halCmyAntxAjJ4wRAXy7HqdYvK8TVM
 rFex1l9mz5nsDCFZqH7hqo35bXP/XwglWAIAP2hPVwRhxk8pO1GN6A0NEBDQcUOhHhaP
 VhMQ8TYD1KFUOQBhdhKxaesPqICeqne2UM6Qoq1iE5vfo0WNmITggZ7hScZ/e+otsvl0
 Xu6CIY5H1KkbBw5CpVoEOOA28UIQiXukci8c4uYjEQ0kxsGbM9Zsvyq0ep+rKCcfDfaj
 xN0A==
X-Gm-Message-State: AOAM533Oz+ByXd02J5HBZlA1J1rryCg9pyjIhfMH7M8vWBJRtP6zS/8k
 jrtdO3AYAWOg6KNpuSLO/2jz3aSL0nE=
X-Google-Smtp-Source: ABdhPJw406KxQBYpSTWaJx0fUC+QfxuTEmIcri0RykJYbgl5TRxnKT1VtqKs5EyrojICrsjz6NCf5A==
X-Received: by 2002:a63:40a:: with SMTP id 10mr26045995pge.310.1591724451050; 
 Tue, 09 Jun 2020 10:40:51 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d189sm10563666pfc.51.2020.06.09.10.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 10:40:50 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/arm: Convert Neon 3-reg-diff narrowing ops to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200609160209.29960-1-peter.maydell@linaro.org>
 <20200609160209.29960-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f7e4d90-e5e0-5b76-e801-4bc556036652@linaro.org>
Date: Tue, 9 Jun 2020 10:40:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609160209.29960-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 9:02 AM, Peter Maydell wrote:
> +#define DO_NARROW_3D(INSN, OP, NARROWTYPE, EXTOP)                       \
> +    static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
> +    {                                                                   \
> +        NeonGenTwo64OpFn *addfn[] = {                                   \
> +            gen_helper_neon_##OP##l_u16,                                \
> +            gen_helper_neon_##OP##l_u32,                                \
> +            tcg_gen_##OP##_i64,                                         \
> +            NULL,                                                       \
> +        };                                                              \
> +        NeonGenNarrowFn *narrowfn[] = {                                 \
> +            gen_helper_neon_##NARROWTYPE##_high_u8,                     \
> +            gen_helper_neon_##NARROWTYPE##_high_u16,                    \
> +            EXTOP,                                                      \
> +            NULL,                                                       \
> +        };                                                              \
> +        return do_narrow_3d(s, a, addfn[a->size], narrowfn[a->size]);   \
> +    }

Missing const again.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

