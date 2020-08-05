Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 21:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D442063A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 21:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9ixiADJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D442063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3QiJ-0006cj-65
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 17:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3QhG-00065c-6o
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 17:11:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3QhD-0000nb-Kn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 17:11:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so26227428pls.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=nykug7OBkKT8FIPOakEQS12YWRPjq4aLZnOHHuZdFfQ=;
 b=U9ixiADJq31jCbxqvdt3AbYtFNOl2CHgeb5P64QjEBAHSivQYTjBW7jEvTavPkcKG/
 s3s88C8xCxPc/oWoERiZK+KTOklPYrOSH2ppGQWFSv6ZcJEYWIs1ICE2KZhqmL2avbl9
 SVjTXCD5BwlNTxpU+gu6sB2bbAiEiGPpKIEHMaKiOMxLZsv3jvZdPIeA9yeBxKnjfVYP
 M4Pksaqo64H+DdX3Vs481cxRbScOZTlxv9Rn2ICuza/TTUqNYZGp0XCY3pNDgm3pexbN
 zB6onC81juJAJ986KomZ5JGtqIPLEz/sy/a/FEGP4zNB31jbjUHL2xHeZtS9dq1fg2jT
 4NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nykug7OBkKT8FIPOakEQS12YWRPjq4aLZnOHHuZdFfQ=;
 b=c8R4XCdazr3yRcuAUwZv/Rv1tb2ofBQ06i+tXAEeOvNp/dyy/jl4xArwkx4tImoalq
 0BU/ZpdBgg1NBTlTSAf82HjpaLGqMzoWQp3cAOGilOD5/aERr6aWkW7Fw1N8/paGa/Ks
 djIKPpWhW+fu6cV/ZcoLlScBbcQD+bA1D8YuGY6x5P7HqiHoehJZcVP6BiWfdaWyk3yG
 uxBbOGOoX2/bBUfXtOT6x4kd3vmH/8h+iYogEkYXgcc/uQBsTvMWtP9/QMgFdNfm/DEN
 Y329UZA+6eyQLT2R/BmNWBXA5+/LsJSAbqgU/JWfBhQmNF0yaUDEn59JKc21SwHV0nwe
 6t8g==
X-Gm-Message-State: AOAM53258H/J+y6g6qtAwEMXmMmriS5V+T3UuifR99WkVBxvTOzY/rfz
 3DIDeoU/az46vwWLpiHuiL2szE7e4EE=
X-Google-Smtp-Source: ABdhPJxhexH7NUgTtfjyTbvFAT7cjGiYDrdH5kX9C3UGu9TUKfmCtjD+H+cxRiKV97uoutGNIaXw+w==
X-Received: by 2002:a17:902:9883:: with SMTP id
 s3mr4621699plp.271.1596661893664; 
 Wed, 05 Aug 2020 14:11:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id np4sm4355712pjb.4.2020.08.05.14.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 14:11:32 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Delete unused ARM_FEATURE_CRC
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200805210848.6688-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cc82d899-fe0a-87f1-8061-d1265d919873@linaro.org>
Date: Wed, 5 Aug 2020 14:11:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805210848.6688-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/5/20 2:08 PM, Peter Maydell wrote:
> In commit 962fcbf2efe57231a9f5df we converted the uses of the
> ARM_FEATURE_CRC bit to use the aa32_crc32 isar_feature test
> instead. However we forgot to remove the now-unused definition
> of the feature name in the enum. Delete it now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

