Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A59C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E8820838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiKjM8Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E8820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6IX4-0007UJ-UE
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6IVn-0006Op-TN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6IVm-0008PB-VY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:31:23 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6IVm-0008Nh-Po
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:31:22 -0500
Received: by mail-pg1-x542.google.com with SMTP id j4so5583245pgi.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=GSCcYlKRE/PP6lBbkvmuft18cUfg2SNmB9vLMQhcdo0=;
 b=KiKjM8Yc4YBChmVTWGw1RmmxPAgU0kUVPk+icdnTu/kCHPuBk8q9xmBMi+09YxTOHv
 ZhQugOl7x5wYuoxwU0yT4Js+EV+m7e36w3xmvJsIyWy/dv8Tb9r4t4QEOlcu3fZrNmIQ
 4xo9q2U8HTfXIUzaxC/Ztq0Non6udLpb48DZIzC8J4c6FYRAx6uSZQ5r+l/Kene5wEdJ
 jEhfV/1BFiqUF4gu4NcTFiD8CAI9RpQda2neTXooPIzbBQ7VVrYlDWHSpROIfO34HFNF
 uh8Cs3eCjTuc4bjuc0URtQnT/psg0OTYQRFlgVnMD13og3K89tJ1eF0QVJD/BFPlMh+X
 tf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GSCcYlKRE/PP6lBbkvmuft18cUfg2SNmB9vLMQhcdo0=;
 b=omXh9RnixK8Q2UE9tDbHqnKXvcYlz0oeH75KInwIBeOTGuYwCrjdQGGWt+ZtN7S9ZM
 nsJQ9Sp/3uz4/7YCcDbtqYiAUBeNwlVbzYw1o3+Hu6u9skSk2osBRa62eSWAxPt1ij4q
 VnjR3faufaAjsHLbe+jmP6Gz2P4AtWUXc7KZsvRNVp6hK7eIVWWFiqy+Z5Go2D57nyUu
 TGXW/IOilfYuzRCypS6cpxWrtguRP3nU9TDwOSWDx5tydcGlUPbp8fll820PBsQkqvf3
 /6QPcaj4HP9NmJ7s2ZTyIOGge27YydC7DPLiTvISa8kcBYdy3QE08XAlXgzAKqlBs5dl
 zPhw==
X-Gm-Message-State: APjAAAUFBxxe8jlY5RYnB63ZS//PPeRm7X/KSklxm2HBFp3tQavwcbvW
 SP2OEfwYKOZ+/+2qGqaTkWXli701dx0=
X-Google-Smtp-Source: APXvYqxSQQrGi357zC47LXguBvm1Gh0tf6KVZQOsQnrLn6lsq95Wb0/wMt98RMHChHXZsuUxBlvZ6g==
X-Received: by 2002:a63:5826:: with SMTP id m38mr55797916pgb.191.1582569081200; 
 Mon, 24 Feb 2020 10:31:21 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x197sm13893526pfc.1.2020.02.24.10.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:31:20 -0800 (PST)
Subject: Re: [PATCH 2/3] target/arm: Implement v8.3-RCPC
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200224172846.13053-1-peter.maydell@linaro.org>
 <20200224172846.13053-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f04c5aa6-0a6d-72d0-5033-4676777322b9@linaro.org>
Date: Mon, 24 Feb 2020 10:31:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224172846.13053-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

On 2/24/20 9:28 AM, Peter Maydell wrote:
> The v8.3-RCPC extension implements three new load instructions
> which provide slightly weaker consistency guarantees than the
> existing load-acquire operations. For QEMU we choose to simply
> implement them with a full LDAQ barrier.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h           |  5 +++++
>  linux-user/elfload.c       |  1 +
>  target/arm/cpu64.c         |  1 +
>  target/arm/translate-a64.c | 24 ++++++++++++++++++++++++
>  4 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

