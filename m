Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D5CC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA6B21473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOYSDqaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA6B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbX8b-0005PI-Ft
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbX6X-000479-J6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbX6S-0002qb-NL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:17:53 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbX6Q-0002og-2f
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:17:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id 81so24675pfy.13
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4yMHvf0hUfaJfI1pMhQ/w/OXG5dCWud1i8+8m0GQous=;
 b=vOYSDqaXOoNbhWH5jiXnI1fGr1eWxHlnzd/kQMwSOGp7ZciF16TdwhgEaq5sd4yqFk
 flcVLJG14bsBJIhHmkaO9iRKS5rAjgEuGgQcTsKlEPPQl0oJkOWZRW3pBa2XxBYF8nRC
 cPTvX7CipvG81MELz5BNzohas7htMRc9hfuC3D2ekOvpxrPlj2h9AENur/x+/O+UiZjl
 UOHtL+hnUCOv5+SuKNuOedG9arAZa/2s0Z9yxozoWq+xKhoUmiuOW8ql31utM/F2+QdS
 NUPQXzq3E5z/PXOrmoE1LnsqpidABTBLB4Y7aeAvU3LENjLo2pD6afZTf7BBZQiTr+/J
 6ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4yMHvf0hUfaJfI1pMhQ/w/OXG5dCWud1i8+8m0GQous=;
 b=Db6cL6rFeWijqtIrt6yvE8rIHUn/EiETX3H9y8kbBqDrOufvGGaNETSHMAWRrY+Uu/
 /cZrw3md98QrnzQ7dyze3Mh3cRLhMiKq5SGrs0pbcS4cEjH2TVzLY+r23r8UcU1gkjy5
 tSf8Sf/D8SEZGnb4eGftg2SNYKbrXA7P/GVGrZfDO1DU7V6pLAaaQlk6vjIDe1v7Eeta
 C1VClw3tRluFvO7PHvuxt2IhnpKfn1cDQ03S6wvfD0NM5tq+T6OH1RIuIQ9K4t6sEzcP
 gBuO4uvFszFSzoRvdIg2zSTGoC6ra5mcTCKMHtcGEwWtjSGDLRFWHtEk/ysDukDkJE/B
 SnwQ==
X-Gm-Message-State: APjAAAWyUUVT862Ev4Jln608XEbu/ffYo3FN9JdPTlWa1NLBPIll/E/m
 gxwa2a1RUF7YWTFvWRiuhgmliQ==
X-Google-Smtp-Source: APXvYqx6aXssKFY4zeVrsKQHw94Ud35twxKVMT5u3RctBhBg/AKusGs+7xx5dGM26ePlFsG0UzQ4FA==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr32304315pgv.217.1560460662295; 
 Thu, 13 Jun 2019 14:17:42 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id j2sm680508pgq.13.2019.06.13.14.17.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:17:41 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613143741.15128-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <724331ba-44ee-c37c-e22b-452b6f25ee7b@linaro.org>
Date: Thu, 13 Jun 2019 14:17:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613143741.15128-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [RISU PATCH] arm.risu: Avoid VTRN with Vd == Vm
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/19 7:37 AM, Peter Maydell wrote:
> The AArch32 VTRN instruction is specified to give an UNKNOWN
> result if Vd and Vm are the same register; avoid generating
> this in risu output, as we already do for VUZP and VZIP.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Alex: this pattern error is why we don't pass your
> testcases/aarch32-all/insn_VTRN__INC.risu.bin when compared
> with a real Cortex-A7. You probably want to update that.
> 
>  arm.risu | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

