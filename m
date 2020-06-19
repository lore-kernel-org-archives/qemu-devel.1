Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380CFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FD82231B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bck6rl1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FD82231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQZ2-000269-9e
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQYH-0001ZP-Ko
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:36:05 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQYF-00019M-6p
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:36:05 -0400
Received: by mail-pg1-x544.google.com with SMTP id r18so5152052pgk.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=HF07ZQokGBlI0ovFsZMMTYdl2T9Vi+TfbY4gVr7sP8E=;
 b=Bck6rl1aDJPUkImw54prockbm89IKWgi76gMTNMBfUKBv2stVBQ195yr25SPdhcA7h
 TAocdgRoJZN2kmICfK085JJ2Gx90uOuDHVzF56bI9Rx3pYS+AgaaYy1RznQDSE+BqAQL
 o90PNrQrSJplTxQ/+HNMOgjW2b++Cf6mquu2djqMReraOhgyouUGZXws7Er/QfyE9DsK
 Al3WvIxIiUzeQOvgI7DKEUsLNbjoGK6SACH3SAB2C/JHGamsSJggjklYYSdzsi109kd0
 mPGIbpVeQoCP3QOIqwZk+h/cGQalJWaoa9AZfDFEzhr+4jIC9aqypHDqlFm1R3M0x570
 rK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HF07ZQokGBlI0ovFsZMMTYdl2T9Vi+TfbY4gVr7sP8E=;
 b=KFk6LfILYNHlo5r7/kwdSqXL03jOU0LAn4GXuJSJl9cBmfnXJSis+PJbbyCPqaDXGR
 GfD1zaU5YbPqOdegTvRRquMNTjqGaSVSIlLzw8zsDqlg987qHa8QrysHlCu5nEnJLqeJ
 BGRmC0fYHoz/VaPBUjEVSvjQ2bV2MAKPpxaGq1ZlRQQdtITRJSAZ4mSMZkkJKzhsZSOT
 cg65Nf2sNxxJ8nmFNSmRJRwrZcZiYRT5/y6hJxBQ3DNdZORrbvKWGTDM/JHJWa0JFp9r
 5dUFzsuYtEQze7nC4l/qQgno0eJfGZVUbdbmp4UnUWfLMdu/D/iX6NQ1ml7/WwDa0UoY
 Psug==
X-Gm-Message-State: AOAM531GwUv4SqxoG9kHoAIxC+n1FZmMLy0UK8fELi8KVyOaUJr8jRMD
 KPSOuPQebbdqKIndETqg3MmEle0r/ms=
X-Google-Smtp-Source: ABdhPJxRGmpD7VpBRSHfjYQI3hTznxln+UjEC5oZo2mEbfKHMZM7NA5SJ0/8VM8Xl4Q4kgwSc6Ko7w==
X-Received: by 2002:a62:27c6:: with SMTP id
 n189mr10424478pfn.277.1592609761581; 
 Fri, 19 Jun 2020 16:36:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c9sm6926808pfp.100.2020.06.19.16.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:36:00 -0700 (PDT)
Subject: Re: [PATCH 12/21] target/arm: Convert Neon 2-reg-misc VREV32 and
 VREV16 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13b3e56f-4aa2-b17e-184b-a84e345e1a3b@linaro.org>
Date: Fri, 19 Jun 2020 16:35:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the VREV32 and VREV16 insns in the Neon 2-reg-misc group
> to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.h          |  1 +
>  target/arm/neon-dp.decode       |  2 ++
>  target/arm/translate-neon.inc.c | 55 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 12 ++-----
>  4 files changed, 60 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


