Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39492C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0229C20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wl1Y4XNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0229C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuxt-0000Zx-4T
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuZV-000438-KR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuZU-0005dY-LM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:34:41 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuZU-0005Xu-FX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:34:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id r3so348302pls.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PC2ldSLzBIGyBSvA9ZmOPp4tVJwN/WY+kDxO7U/JLuE=;
 b=Wl1Y4XNAeLvQNwX566xDFe85W8KyJrcvDX6J10fv+m0wYL+JW25xh7K6r+h2Qheawu
 O+pklhhG9PHcOqNKXo43tPmDRS4KKZ5Hd0N2s7bIesUMj7hJFfP5Ozje7pEXsOOvqTLF
 a2abxh1+DJD3KRsWHBRvrflXIq9qu/WPmNzyZ8zYmibfZt3W8RGKqq1TQpiL3wKZORRW
 zguNcoJQVNDmIGUd5tOIokHhYnLI4J5dTfMcMDZYh/dkxv8PL6dwqJ534ftKChB+s56l
 RZIjvouWMnpo4sphNj870/f21602na7bmZk0IvdLodMI75jINl4jTo96mwW12pwyQFi2
 h03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PC2ldSLzBIGyBSvA9ZmOPp4tVJwN/WY+kDxO7U/JLuE=;
 b=LNu29u96KjYHhIXog+Wvvwg8Eb1SOhfOdoyOlYUzoLcLhCjqeuHGNMr315ZeYpQXQ+
 36Tjoo/ZlC0l6kTN6pe0ECQrgOvkWCNTkpruBtMVYroCzGW15nZeEih/83UxcFz+B3aw
 JaxYBkRs5x9uDku4Jl/kYqJuAzpghYtIGUFg0xJfmI5aR5hsumx8n3jevFQw9cD2gx3C
 tgKY1aFn8Uz14kwJ42Bdv3i1IUII8N2GNs2UEDL9ApwhCSTyUKwrR2alH/Q0nJxLCsp1
 QI3eguA4vfp/8xigM3BApsgBV6BuFKfJLcNiIx3ASdqV8Xb/9FCD0sKhWGpp/SZZCRK/
 DGWQ==
X-Gm-Message-State: ANhLgQ0Pu+G8O88FZarIOg8AIwi3605inHlyCciwNu59/1Ap9IKFrSlU
 Y0FlhxvTnt+Vy2gNhWrg0sYxkA==
X-Google-Smtp-Source: ADFU+vtnItt3QTgIwsLaiSBbZ5RZmIlwQ80uqEu2MbvD9kszgcX8iuAzeXxMIY/NHizm7WCVLwm7Rg==
X-Received: by 2002:a17:90a:cf96:: with SMTP id
 i22mr949791pju.66.1584383679409; 
 Mon, 16 Mar 2020 11:34:39 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h64sm543729pfg.191.2020.03.16.11.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:34:38 -0700 (PDT)
Subject: Re: [PATCH 09/11] target/mips: Always enable CONFIG_SEMIHOSTING
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-10-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <68624737-0447-3e19-4971-1d1bbe2fde8c@linaro.org>
Date: Mon, 16 Mar 2020 11:34:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:00 AM, Philippe Mathieu-Daudé wrote:
> On MIPS, the semihosting feature is always required on user-space.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  default-configs/mips-linux-user-common.mak | 4 ++++
>  default-configs/mips-linux-user.mak        | 2 ++
>  default-configs/mips64-linux-user.mak      | 2 ++
>  default-configs/mips64el-linux-user.mak    | 2 ++
>  default-configs/mipsel-linux-user.mak      | 2 ++
>  default-configs/mipsn32-linux-user.mak     | 2 ++
>  default-configs/mipsn32el-linux-user.mak   | 2 ++
>  7 files changed, 16 insertions(+)
>  create mode 100644 default-configs/mips-linux-user-common.mak

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

