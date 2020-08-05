Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FBEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 03:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7382070A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 03:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mb4dVSm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7382070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39o1-0007yF-T0
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 23:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39lu-0007Ob-BP
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 23:07:18 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39ls-0005oj-56
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 23:07:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id t10so19131339plz.10
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 20:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Tjuk8mPH4Hs+Fhn/Jhu40zdX+l7fPLPuyWDtsbdLNW0=;
 b=Mb4dVSm/gvoy/JLzrmgeW2XfjfC2NK5u4/PNYYjyd8tYwm5u4pZuW1O7f+HM9VSvMp
 AwMw2fpvazsb7S8QzQzqhLiIBCKjC3DRbcOCKIspMBpdzLXFLRWxrHvnwncex9OYu1UP
 iPESuNTNBRGfrGysDAYSTa4/ES+1TaA+0/Cd98W2amOKwTT8ZN8uMSP7fV9+SXnW6CdT
 OVX/VJasT8uzc8SkR/lPrXjIQvG6zti264S9oaJHf+Jer0bqE094CvhQ8EjuLq6lcbXQ
 HCD8fXkYyXwqr4Vulf+54dy8Ion5YXqHZdlIrpwIy55fsBAMyNihyu7KcU27/7YFc6Sz
 JjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tjuk8mPH4Hs+Fhn/Jhu40zdX+l7fPLPuyWDtsbdLNW0=;
 b=hd2BM1pKAipeVdJ8kmc9yqPv00kQelGRVN2pDyx/oXCIgNBb7Nabzp6twcC6T6HRfr
 8lzPekUy/4cuJ2/1j7t+kO5ew7rCVqCePGr1WncRODxGaVmlhVs2/oh4N2NXSoQ9zsad
 yp1RSbb2twITqFVE7w5V+XZXi06MuPQQbhgGR1VAtuE5pqmnAG9dmsKHJpZ3jtUpyonQ
 skVT/z/55pGt1xzZ1ir4aW3Zbbk29rsjJPtmfR83NH1qQmYwvh7RufnoTVOky3FFHQq9
 dlV5AarIHi5fYYlUL8rz3c9h1hoBckTbz9BKQ9rik9wgK2nbetkyGD59N3yLoU49vy6p
 cxcA==
X-Gm-Message-State: AOAM532Hiu30kKALMIl8EAZeIJDFFubLBSQGhJ0hcbGpMPLIyqYeOPUW
 2Owfu+GNw+WQwnIeZLbC8zLnyxJGPYs=
X-Google-Smtp-Source: ABdhPJy2b5ovAJB9J/BuWNhIxu8gl3FWAeAmQ7jAnf0VdOAnlRq094WIh1MRDjqcatbj7k2MZhn7wA==
X-Received: by 2002:a17:902:547:: with SMTP id
 65mr1142328plf.191.1596596834538; 
 Tue, 04 Aug 2020 20:07:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b185sm803174pfg.71.2020.08.04.20.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 20:07:13 -0700 (PDT)
Subject: Re: [PATCH 7/7] target/arm: Remove ARCH macro
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803111849.13368-1-peter.maydell@linaro.org>
 <20200803111849.13368-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6a1d0c5-30ad-f6c5-8919-a76b9591b4fe@linaro.org>
Date: Tue, 4 Aug 2020 20:07:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803111849.13368-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

On 8/3/20 4:18 AM, Peter Maydell wrote:
> The ARCH() macro was used a lot in the legacy decoder, but
> there are now just two uses of it left. Since a macro which
> expands out to a goto is liable to be confusing when reading
> code, replace the last two uses with a simple open-coded
> qeuivalent.
  ^^^
typo

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

