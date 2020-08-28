Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E6FC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2962074A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vt4LTlpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2962074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBl4t-0006Cs-Pl
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBl4D-0005aV-Rv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:33:46 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBl4A-00042c-Un
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:33:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id h2so221160plr.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=vdDOyDijRjE1ptteUMGDx2/i3MNjI+NxccBmLnqZQ/k=;
 b=vt4LTlpyM1HOzm9dmVE7q1uab0QUhY6f649qA5vrwhhVoTYZuq4UcI4otTp1RdZxvF
 5P3qGozqoTvtekoxnrqqKJWXox1//+faakvR2cc4qDLlZInRoVX933rh1aM9iJngYOGA
 hE7qyl030Q5/eE1tRg8qn++H6GGgshMtT/ZnGzoVZJesdB7p9FGv2kpdRk3Bs9wkJfAV
 q4ic7oQGKBN1cbJLaggPh9EUVMxFWeTf3j3qCwhe9h5L19Ywu8Gef9UW0AmhD5vK1rRp
 SbIFXsX7wUx1RUd5wpDXYKSk5re2lJBCRJnceF0L3Xuj+XxDl9lb4o6mWXcaMB6oIHVz
 ubaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vdDOyDijRjE1ptteUMGDx2/i3MNjI+NxccBmLnqZQ/k=;
 b=rkok4qjTUYDXuNUXscfIEBlAyhIgSVuXn4dZepd1LdknwSkwNXO9CzLKJ+Y2jDlQuR
 zhPTP04N1P8S6dycmuxs2MEZlp/BSBA/E7nHOZv8TPM/7ttt2K3kchzSdnfw1KuIdNcE
 2q5C11do+v3TI3TonCrhyBhkVv0fFgiwlFWTnOqUe+DvxhSw3cug9Vb9f4UdYHRNP68K
 07DGj52glOambQu40Yo3CRyH2kHajGQOu/bR33jN9qfUuoejgKMkesXM/gRdnMfSViL9
 griN4ym4REvDY9EmtIaGtTMVIlybMT6zwE360S9D7ISpxcQYnY5phlVy3wTDxqy/SX/L
 hC0w==
X-Gm-Message-State: AOAM532T8PvyP5WuIS1IZ+QegvYfQFBupm4gIlY9UoWt/7yLmpY23tvs
 tIsloEzLBD3/MhGX1DWc3JtqVS5x0srSXw==
X-Google-Smtp-Source: ABdhPJxZss4yppbmtgx/UuLH+ssFO3IuYRKpgSdXYQHA5fIzEgo2d+Wx607lPDWCj7+XElWM4YismA==
X-Received: by 2002:a17:90a:ca89:: with SMTP id
 y9mr664197pjt.108.1598646820735; 
 Fri, 28 Aug 2020 13:33:40 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l24sm301803pff.20.2020.08.28.13.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:33:39 -0700 (PDT)
Subject: Re: [PATCH v2 25/45] target/arm: Implement fp16 for Neon VABS, VNEG
 of floats
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-26-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81cb8181-f605-259f-1aa5-193a2af6dc94@linaro.org>
Date: Fri, 28 Aug 2020 13:33:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Rewrite Neon VABS/VNEG of floats to use gvec logical AND and XOR, so
> that we can implement the fp16 version of the insns.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.c.inc | 34 +++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

