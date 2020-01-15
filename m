Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11FEC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780622465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIQabkcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780622465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrRX-0002Nz-LY
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irrQm-0001ID-8z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irrQl-00074D-Cb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:46:32 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:46300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irrQl-00073h-7X
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:46:31 -0500
Received: by mail-pf1-x430.google.com with SMTP id n9so9185856pff.13
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qf8LJpxXCPca50BvU5HXYv2o9w7EnnZUiPaTuA7YnC8=;
 b=MIQabkcxFFWNtGeMJA/r6yy4Uf+cXQacFxXYe7kWEVWU/4apwBQhVFMPvu/3zYGBgM
 g3f9M9bDyKZH1qOBuHnkj5Uba8YyI1H3sZCtbiMsUw593VDdPbfq3swKFN2kS8/kZ3gN
 lwqQqnrAGgY2ej1ptokARTD3KWnsvIZt/cXmbA38h/LiGemqWvZpGnD6PfmU5Hb+an2C
 uDt6k04Ig0L1HVtTRt6uxrU4QtLzBRncsPsqv5t5nZkqRC2EhrIpeli64vkwcepV2pA2
 28x/7NrFK5my0tMKEbdBKVjIDpXMBi2GrI04TeH3XFJc8kaXgNk0hRo7yroplzmZznnr
 i04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qf8LJpxXCPca50BvU5HXYv2o9w7EnnZUiPaTuA7YnC8=;
 b=qfakWDaHqfGYycxl+IQr1+Ugq+nY85jvSsYY7Ab7qplqrXNZMdljcGBqJvBuhBB+Gj
 X5THAeTTpV7zMZFFuQ5rNjmPjnIn4IEbqghwH9uHChebmRCkN3C3m/FdxZXrA+3iI6yX
 Zs9GQ5weTMTcKxfHGjcueHlg4guSdatz3XIzLpCRgt3wdQ9hdNk4E5qxxiWnka6KoAKR
 6+S+GEYMhhn/R4xmzThWkqEFuxLxCMBghVq3hUt74agfhgfxJan2c2vaZsuWDS8IfEE3
 26UYh4zezvpwo36Zl2d8HhnMNsjhh3F9Hp5EgmejTSXyGPZ3in3KZsq4nCG3htgZzwqW
 UTFQ==
X-Gm-Message-State: APjAAAXp+lvKHfowvNv3wwmx6LW5JU9zAoXvxwlsHBQVqChZ5GVlKvmN
 fC8cq9Jkrp8jOaUfHs3P4zFOQA==
X-Google-Smtp-Source: APXvYqx6YydqDUPcyRoA/WMKO09xvqfX6y3pJhq3N078knsBE9zCBUnCPJcYHXSEwI9Fw3Q/y859Rg==
X-Received: by 2002:a65:66c8:: with SMTP id c8mr37350285pgw.161.1579128390001; 
 Wed, 15 Jan 2020 14:46:30 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id o7sm24349273pfg.138.2020.01.15.14.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:46:29 -0800 (PST)
Subject: Re: [PATCH v5 19/22] tests/tcg/aarch64: add SVE iotcl test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eef4b299-26fc-6e46-186d-c63d1fe47991@linaro.org>
Date: Wed, 15 Jan 2020 12:46:26 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> +int main(int argc, char **argv)
> +{
> +    unsigned int sve_feature = (get_cpu_reg(ID_AA64PFR0_EL1) >> 32) & 0xf;
> +    /* Exit early if we don't support SVE at all */
> +    if (sve_feature == 0x1) {
> +        /* we also need to probe for the ioctl support */
> +        if (getauxval(AT_HWCAP) & HWCAP_SVE) {

You should only probe hwcap.


r!

