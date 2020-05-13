Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1A92065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLuo/srn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1A92065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxoq-0001j0-Iq
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxo2-0000aT-T5
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:16:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxo2-0002u5-13
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:16:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id r22so223967pga.12
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1SEnJQ4CL3sdUqYVFbM44AMy+9Dsjv3cUOHCJEA/e74=;
 b=WLuo/srnVwWzjf04tGKqxNduIGyhlTmOUf8+XTAff9dXGzPVS8H9k/ebcmjup5NP8s
 BCH2VfA5lXNUNELwW7miWXDHfxoUwxqwXNc4bg5V+S0AnbzdMZhp9+8zFXaxLoirmhf3
 2v6xCwHBbMgR+vXkH1oYXqM/KD3tivee5VB4Z2pJrAARiMkxerJ08CkeIhnyZ3NsvZyI
 EhpawpAlNDE4YTTDCf9CP8TNfAmpy/TIPkPhm9ncPfUn9CAuhCjNKY1b7XLzBlEou2oF
 wGdg19Tcr06YpMlFThrFwvzsQsbBp2Ns5ka8Rj9rC9X7i7xxT/MGYkrZTFAzX+SytwrK
 e3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1SEnJQ4CL3sdUqYVFbM44AMy+9Dsjv3cUOHCJEA/e74=;
 b=tDLtaBFPrvb4dO1ljTP6YfroL/bG7sSQ5SdhBP4UDdiHg2CEtXvInHFXGURdLlmh/s
 hPqTYGokmvJKRv8joR1LoZu17dWqh2s/giAEUs8roRKGfdZu1cGpbMNyAbsS2xhW8jHT
 2nTJUq1DHiJ90k7CObFAqnhXK/F9k1fevNKceKwM6LVqc5nnFfYTLgwkibFrKL3MnE9q
 7Zy+rWKf1FIixcFtH+7FFXcSacp5o4VkFjfD6DVoVwHqMfmfp4A68Iod+BalfdFTV41c
 Znj3jTmXuDqtwIyND/JBTLUnN3AYoGyoxrQ7vDtklKjSGM7nV7edpkdAVKTyRiDQOiJB
 ZS+A==
X-Gm-Message-State: AOAM531VtTcG92Fc6AyPh61NYtPLFI0YgL6vMUKhk8/syTP5ki4kjwbP
 Xx6Qsl+Ahcb5hm3xMIYMse0M8ss7hPI=
X-Google-Smtp-Source: ABdhPJwNVle/4kzvLAh0KOtgZPdNomTZQaccII5OSbVFDRnAgFOHCCgK4mWIYPpMKssNSsxtwNgZOQ==
X-Received: by 2002:a63:1a01:: with SMTP id a1mr890454pga.87.1589401000191;
 Wed, 13 May 2020 13:16:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x13sm343918pfq.154.2020.05.13.13.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 13:16:39 -0700 (PDT)
Subject: Re: [PATCH v2 15/17] target/arm: Move 'env' argument of recps_f32 and
 rsqrts_f32 helpers to usual place
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200512163904.10918-1-peter.maydell@linaro.org>
 <20200512163904.10918-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a77e791-70fe-531a-322f-09720317785d@linaro.org>
Date: Wed, 13 May 2020 13:16:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163904.10918-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 9:39 AM, Peter Maydell wrote:
> The usual location for the env argument in the argument list of a TCG helper
> is immediately after the return-value argument. recps_f32 and rsqrts_f32
> differ in that they put it at the end.
> 
> Move the env argument to its usual place; this will allow us to
> more easily use these helper functions with the gvec APIs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h     | 4 ++--
>  target/arm/translate.c  | 4 ++--
>  target/arm/vfp_helper.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

