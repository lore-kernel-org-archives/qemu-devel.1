Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED3BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DB82074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GstEVyK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DB82074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAevx-0005zW-0w
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeeg-0000fP-U0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:30:50 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeef-0007MG-43
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:30:50 -0400
Received: by mail-pf1-x443.google.com with SMTP id m71so8136621pfd.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=w7+EdLOxHGbkMm10CGWFvzLy4NVAUtmc3MD806ii9MA=;
 b=GstEVyK2mj3OWhC+5gYBtNBeGTnxA/T6VXJDnFBYnkqMshFrMP4JbNTVcEF/hmg+zW
 fbU8lZjdr7gSAYsMES0YV6vy8/kEboj/D9QrOiB00hINdPJfxzGmjPvjrOwUFNr50eDL
 GacfhUyAFW3+bSyVEBalmw+Pr0osp3hl9UVKW+nkpFlVBeiKq9TFU2P7l1LsykSYukrL
 mGm//r05bzJOH2iS/1eGyWkgger1H1Lt37OA5AzZSSb7+MX5ciUp3NwoFh3dmRi3ASP8
 /h0CE6UnMocjpdgDTtmpUdscf2Bi9maJiYeUCQEouTAANBiRK5N7IDY3vsLyjLKeqN7r
 Ea9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w7+EdLOxHGbkMm10CGWFvzLy4NVAUtmc3MD806ii9MA=;
 b=aRlIVer2B3uTKH/51ck3Y458hcE4lZd1rHfjaeh8V/1wpd7HZoZUIMVNCCOqt3Lhhg
 lMFvKVKFKhIh5cSsHZW+p7tqKo/rGxjgE3yIaOqQPH/p51oYHLJ2QAG3n40k8I+mZHUj
 TQMYEejMzB4rZSmr2d6wEB3CBmZRHNOnzbai5sKna/2oLoB1C8vaROaQSvyFgYa6u+Cy
 6RCeNHusfuCNDmesBe8+UGIE4Ri3WPWDI+5cXLLqh/lG+WrIje/jesbYz5eMonc/pNKD
 v+5QCxCXpaiY8kCAWQF6Sjg9MJm9FcnBJnuV987wqvF6x5WLDSQgN9jfVxkQQkKSP0t7
 78VA==
X-Gm-Message-State: AOAM531ISuWbsjEPXAlWNQPFucjKmmxHMEX7orOIJTazCo1p7xsjvi5J
 i5YU/0ZTJbDYie6dzWztxop6SJ3ciOi0+A==
X-Google-Smtp-Source: ABdhPJxkHY1n9kW0eOqHE4n/gvf2JpuXDkxGxSIvNuAVClOKnsT1KlTsA+MnqGo1eyNknAEa7J8mRw==
X-Received: by 2002:a05:6a00:90:: with SMTP id
 c16mr9311495pfj.200.1598383847264; 
 Tue, 25 Aug 2020 12:30:47 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id d128sm27038pfa.24.2020.08.25.12.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 12:30:46 -0700 (PDT)
Subject: Re: [PATCH 22/22] target/arm: Enable FP16 in '-cpu max'
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c922abe6-ddd8-5110-31a0-560f96c312dc@linaro.org>
Date: Tue, 25 Aug 2020 12:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Set the MVFR1 ID register FPHP and SIMDHP fields to indicate
> that our "-cpu max" has v8.2-FP16.
> 
> TODO: this patch needs to go at the end of the series.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c   |  3 ++-
>  target/arm/cpu64.c | 10 ++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

