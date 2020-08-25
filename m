Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0800B2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6aICL82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0800B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAddl-0002Ny-Ao
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdcI-00016F-8l
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:24:18 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdcE-00078D-My
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:24:17 -0400
Received: by mail-pj1-x1043.google.com with SMTP id i13so1687786pjv.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=gAAR1NvGCldnuyaks9jqC7Et0Al1/tcqkfH+nw3aOWg=;
 b=f6aICL828XmWrEN8d9k43PVIyse1DWF2PMBFh0h0SRd9Mzmc8ZSS4Xcfkb3AmLZgc9
 xHXAHPlrH/NojYs6xumoqE3QZdkNqB1jV5Y5P0zf07z1kXJtgB1WkGbl9s0hQOitYdBa
 cygP1HQbf4I85ywiPMgvvWOoh9zFzCcaK8SOeGHsEWebnI6Kee9PccJDbWy19t9atGEc
 wFdVQZdqsfWFgDuIj4sNutgL9xSEUZ4tiSLrU0NP/U0ve370QXTUXqmlevmpaQE3Lsws
 wMYxaTrgg8NdF61v6T+t6Avwrs8ewUhxWGJAwrqZKB08lCOdB1poa6GxPGRHkmc8DO/q
 GNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gAAR1NvGCldnuyaks9jqC7Et0Al1/tcqkfH+nw3aOWg=;
 b=EluGxpDrgCHnf8SGzsx2EgsZ/qp561nVfPkPZ3xvHdBvF3YZm6xZWANiaNCSndvXE/
 fsMSdiN2bP6sCmlfD58uKrX4w/T8bLl+j82kwQYE0OGe/6z6gOxdU9po7yQRpIkwt0eE
 oE6pDbs4L39EDX8LNG8b5ZMEuCEexU1H3uUJTTnoInSA3QClSgiBSoZe2gXaM0vhJS9U
 HkXzEpa3QmY8HMlufUEgMKmfVWR3KdsUymg0jJsEjA+kLndeeVDZMR0IHLqBUmDy7cvu
 s3IZu3jTaaOsNGpKvnNcw5Fp+O/AyKX8RVM0zsJHflwdcI43i6j2z2tkCV+ZHqAhXnXO
 FPGA==
X-Gm-Message-State: AOAM531+6ygK7tQTSu0yCuyGmw8hKtjynfc4tONKyXEH8AxHjjuD2Yj6
 iiUOeUmtcs0au3xmOOP1OR1jo3zXsOKHqg==
X-Google-Smtp-Source: ABdhPJy7B7J//Z/ek+U/n3EANp4lXy1W49SpUDh3GXXPAEZcnvhP7pEn7BnzLc/CYYLncEF+uYrEOw==
X-Received: by 2002:a17:90a:8589:: with SMTP id
 m9mr2677225pjn.109.1598379853152; 
 Tue, 25 Aug 2020 11:24:13 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id cv3sm3519110pjb.45.2020.08.25.11.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:24:12 -0700 (PDT)
Subject: Re: [PATCH 08/22] target/arm: Implement VFP fp16 for VABS, VNEG, VSQRT
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20953e1f-df8a-3265-5fa4-329384351e4a@linaro.org>
Date: Tue, 25 Aug 2020 11:24:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Implement VFP fp16 for VABS, VNEG and VSQRT. This is all
> the fp16 insns that use the DO_VFP_2OP macro, because there
> is no fp16 version of VMOV_reg.
> 
> Notes:
>  * the gen_helper_vfp_negh already exists as we needed to create
>    it for the fp16 multiply-add insns
>  * as usual we need to use the f16 version of the fp_status;
>    this is only relevant for VSQRT
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h            |  2 ++
>  target/arm/vfp.decode          |  3 +++
>  target/arm/vfp_helper.c        | 10 +++++++++
>  target/arm/translate-vfp.c.inc | 40 ++++++++++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+)

Same comments re the helper types.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

