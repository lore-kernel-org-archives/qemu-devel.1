Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F58C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48F02339D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQ7YzWNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48F02339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmVWC-0001TD-WF
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 00:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmVUw-0000bU-E4
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 00:52:58 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmVUv-00018U-1c
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 00:52:58 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so2769013pgh.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 21:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=2+5sC+jR9prNwT4gof3OKyfZTNvdJYm7c8yu4K/Wbto=;
 b=jQ7YzWNfav2cMFBEEbJq8ZLSmabVHQ5ODerZ0Hccx0It9DzoPz4WaJSbS5O75TJpim
 OER0rJNrB9gy8kE+78Gmpw2boptcMMxz4Szwh82KsiZalEAU6KTv1DRNKgX2eEJh64Bl
 +vy7DFUVFlP1R7Z9NXQkpQ0VFXDcGy1MpUtiPvNR/H00foEh8U1fsvtbvCpzGS+I4AAe
 3x4Zuzi5yj7Cu1t6tcDbRlIZzyfhKGtIokn/+viySqoyity28U1hAZ4W1ZsvOen4/KB5
 aqUB2mqkragZPeX3UBO/hucfQ3uT3ww2DLudvhZ8Ayd5XSd95M2JA6j+oTc8utjopohK
 u0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2+5sC+jR9prNwT4gof3OKyfZTNvdJYm7c8yu4K/Wbto=;
 b=BRoJShOOvFW3GDujpp1ivZRnaK+hj4pi/1aJq4mCfiZaeW+NRbtoC9QwLMWipR3zgN
 cj6/wZkv7qZq31Q+Kmba3+0+Kam6yAIQU0PQd10vMZ1uxMPTdsLlvUowilMFrxnc4psL
 1s+Xqzg3mvyFfkYZqTkFIV+Py8q5jauPJr2vTGaMkJB12jroj98h++QBU9xpcdHYLzMz
 MCx7/RYx1UHdTFjLi9JCmHQ23qVWTxWr76E43Ax0F7QM0NO6orH/zBOXoI8g58yrTB2+
 aX5Xv/KZT5mEqimSGGIbibHq0kZannsJw5AdKwLDlJgL/AMn1ZJwb0BFRVG1JOJJTICW
 g7rQ==
X-Gm-Message-State: AOAM531owhjPrQe1YvRqLjea5pFY74kTmFm6vlHStyvDY673h2rCqRsu
 O5OaEuK4awLXTa0y3w/DGZ7RUe6TEpw=
X-Google-Smtp-Source: ABdhPJzz5CW6QusL4ncTAdaX3uY5U+v8XZ6HGfSW6W14/r03lSbzkCXdAmy6c4ztFX5Kj0SfmlGnGQ==
X-Received: by 2002:a62:78d0:: with SMTP id t199mr10333739pfc.77.1592628774834; 
 Fri, 19 Jun 2020 21:52:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a17sm7288029pfi.203.2020.06.19.21.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 21:52:54 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Remove dead code relating to SABA and UABA
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200619171547.29780-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f9d22b9-da79-9d93-106f-d951b5ddea80@linaro.org>
Date: Fri, 19 Jun 2020 21:52:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619171547.29780-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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

On 6/19/20 10:15 AM, Peter Maydell wrote:
> In commit cfdb2c0c95ae9205b0 ("target/arm: Vectorize SABA/UABA") we
> replaced the old handling of SABA/UABA with a vectorized implementation
> which returns early rather than falling into the loop-ever-elements
> code. We forgot to delete the part of the old looping code that
> did the accumulate step, and Coverity correctly warns (CID 1428955)
> that this code is now dead. Delete it.
> 
> Fixes: cfdb2c0c95ae9205b0
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-a64.c | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

