Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E748B2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTmkS1Hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E748B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAezv-00050o-5B
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeXt-00042T-QV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:49 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeXs-0006PN-BT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:49 -0400
Received: by mail-pf1-x441.google.com with SMTP id k1so1269811pfu.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=gwUMg//wgrjXwTQ9kMa/PPluoqP399CBrBsdMzkVKAE=;
 b=JTmkS1Hx9tNj1TOyhiG8OQK/izPhFW9XeKztqLWhP6r8lsoWf+XkVVKNEgK9CP4750
 SYwQdp94GhW12AFh5rPvKk+98B3aQsLVdXmvdtMckE/dLesSdLOIMqr8SXk4tXOjxF/v
 hInaMda2gJBdMldA1j8S8rPpktv8KiBY7zw0Nb6JFUuEwoMbtBw6FQLWTd9in2tAbQYA
 bWETLy8c6g3C4S6F8p4pdFiIoZXvaEleHqFnPXw25WC+cvUzvhaBRHnFfVrmaLYTbFk0
 /OY2g2SQJj5wHNgwNh89dkMZT1hoqj2qxL5y+XgXi1y0rsHCdlfuzP+qOK6jExsFxco/
 b3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gwUMg//wgrjXwTQ9kMa/PPluoqP399CBrBsdMzkVKAE=;
 b=HTu5LyUkXDgNOVeZIwkCsSFL7T7PvBAKmQ+zEwh9dUJS55nd8dVOqp54oax3MF19VD
 JcdnNXLwlf/vtZKp3jwClO1HHUVZDgnrosZDNI/rIizh571HOdpzJWOjWNn2gWXIRT1a
 jrjmdJl92ANGDrvIcTtAcaq5XiaHLrd5YZna5TIB+xdJejGDOgVTYq2lkdUaWS3SxXTC
 hpx+bxh/9WrlPMhSPdt/j7tuJLLKL/xdQBxlhif83u6xx7dcUnA5udtpSbuzGN6AaQ9g
 XExLt/i68vqSBwkIiJ2XvMhb4PuMh7BHtojfMdVCPygTskKZz8A54nUdBZNKtwcTVa0e
 /Y3A==
X-Gm-Message-State: AOAM530SMGa+aqqBGdC0ECKhwpK6h6EeN0vrijUa7LAm0Inpgf/JPYO3
 JXedWxSF6TJJfmsOE2oo0khfJ71S/HdXKA==
X-Google-Smtp-Source: ABdhPJxczoEL6hQWLQZlKB6Z1sK3iKFk/q3FqUzpQAhbv3Rz0MSs6D8zspcYvR2tLm2J5Ml3nC5Bow==
X-Received: by 2002:a63:1262:: with SMTP id 34mr7963859pgs.37.1598383426160;
 Tue, 25 Aug 2020 12:23:46 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id p11sm3343pfn.109.2020.08.25.12.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 12:23:45 -0700 (PDT)
Subject: Re: [PATCH 19/22] target/arm: Implement new VFP fp16 insn VINS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <863f1d23-1002-ca2b-60fe-2f6e4721ff33@linaro.org>
Date: Tue, 25 Aug 2020 12:23:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> The fp16 extension includes a new instruction VINS, which copies the
> lower 16 bits of a 32-bit source VFP register into the upper 16 bits
> of the destination.  Implement it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp-uncond.decode   |  3 +++
>  target/arm/translate-vfp.c.inc | 28 ++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

