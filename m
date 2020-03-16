Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B6EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E57920663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+26InJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E57920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv1g-0006MY-Dk
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDucR-0000XG-2f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDucQ-00014l-24
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:37:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDucP-0000ry-QI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:37:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id h8so10222219pgs.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rukeMZTO3ItYYWVVNrji9T+F8BdIejhicAp//mKPMIg=;
 b=N+26InJnd8RLBPMVqL2LJB6roBeYuXsJGWTZiAzoheZQMs8tTkyZyDTphbapyIAI7R
 0WfhSb6m1AiOr/eqjG6zx45wvzPqZubXPHpEpveds3Mip+omBg5aPhhUA+/NNMsqx85E
 RdoOJuqUQrfTSpEG+HUSwtNy4/Sp5k3a/L6whrK0yEhSoDcjJNstcuFX+ZHaKONBYi3h
 LmYLTz1Z0krctBPPd9o6Ns2/euIFck0hkpAB/8STkwioE9nlLDp6hrqyv9QNZ3P6iS1I
 gjafC6Gw2W083KX/cDNB7LwoWBZ2oHW+kzjmJeGxF66gj/AkYzKBtI5hTYbPKJCXIbzd
 /93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rukeMZTO3ItYYWVVNrji9T+F8BdIejhicAp//mKPMIg=;
 b=i+qibnwwZTMzdM3n2MBD4GQUgm2qe5C9Vf5vvJLzgM1Soz+zKTjnMEg4aIHp5jUmjx
 t3hTgc/OyME3Oy0alk+WoXn83sVoqCV+auJpUoO3IRyI1O3DJheYIALSsNIVzNjpbmZz
 CmHtXG4zbHjLzWKMTHkz9frDEhPNeKPQVCiRWxT4Eppnttxn/nCAGV5FlmK3iRXrnu+L
 nZZSpW98c54o1t9O/0CiOU6qFAhb1qG72vIqp41WD+eAThjGrpH9ZC4kJkRRSIHxivA9
 fAQdw3M5nP2dOZCn8bzupTHGrICJxcELOTg62iaiMrcn3SbRC+YRGfJJ4Lr9xqvwmWBG
 nCyQ==
X-Gm-Message-State: ANhLgQ0SMLgnF/d+euAxgThEcPrjcuFfWocT049wVE+BuUMZ867nnTKf
 baLtOWrU8oIZ5Yxwhn32AQW/BQ==
X-Google-Smtp-Source: ADFU+vvjfJrWrrkRfgZmScambylSFixowRoyMCZOkLBug/XeApOXgRumgC+XKX/dKLYd3CttcgHniQ==
X-Received: by 2002:aa7:8d82:: with SMTP id i2mr993474pfr.179.1584383860512;
 Mon, 16 Mar 2020 11:37:40 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c128sm605845pfa.11.2020.03.16.11.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:37:39 -0700 (PDT)
Subject: Re: [PATCH 11/11] hw/semihosting: Make the feature depend of TCG, and
 allow to disable it
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-12-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b1325f2-38ee-4ea5-ceaf-838f764f678b@linaro.org>
Date: Mon, 16 Mar 2020 11:37:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:00 AM, Philippe Mathieu-Daudé wrote:
> The semihosting feature is only meaningful when using TCG.
> 
> So far only the ARM/MIPS/LM32 provide the semihosting feature.
> 
> Do not enable it by default, and let the few targets requiring
> it to manually select it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/semihosting/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

