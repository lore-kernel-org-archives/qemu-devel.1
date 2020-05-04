Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B66C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C1820721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5z/4XsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C1820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVekS-0002bb-Hc
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVehZ-0007dX-F9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:16:22 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVehX-0002eo-7z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:16:21 -0400
Received: by mail-pl1-x642.google.com with SMTP id x10so1355647plr.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZAgT/N6VdVa2gcUEHlc67rQXtKYTDUFcbF1qLY4/QxY=;
 b=I5z/4XsF7Xcb6+MFqLEvp9BfhJ2xKkrPkV8mUvHLei/aSMS2Y0ip5cfr4p8Mj7zRc9
 zhhW3BEf21Kq9bA9WPGS+gowESI6cIOatbnOWjet2yVpUcY3bAcGnzab8e+iJMDL1iOv
 FlMlG61aktw8Lg+ngkpTNLOjqa35aS0ukTQoZoV2VJGdZHgl9FLKore0wRRndyPWxO6N
 0ae5mPRMNAqI+B7Z+m0gQEhugM1hcEQOfmxLloWdw6uRd7ZCbz0zjakOw6ddWvcWlNbq
 E3+mSGeWCytH4TrXAkdAI95HN3dV7+mQin+3w2loRExdSSYCDaxizLOxOsomv5gyPW52
 RewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZAgT/N6VdVa2gcUEHlc67rQXtKYTDUFcbF1qLY4/QxY=;
 b=cQ+iS9yo2e1zPYFuqdi3x+N6/C2H6nyf2Uq7WALYd269S1PcHcwv1fpT7Xl+BV3rIC
 F4YKn9jBh1SK8Uv/Ntk6uRYcOxXf/gEG0nK6j46NYvf8UpA8wz6vNxzED97kWSrfoXCO
 A/bXoupZ3OBNdxejuXFQRJnIF87q5RIEwDeN8gOnF6Xy+vSLiZh6xDSd2w2r/Zx9YYgC
 2/sRgXTNzHrNXIQdQQKYOLAkUU2xgg7tCjAsdvlOqXG4PrQXfTYL4+Nxh0y1keVUoEwo
 Lf0DnTvUkoiuC+a/IF4nL8ZC/bW189uvx7wu9cJF/WH7G4CoikiXpFTMxKlDXaFCUOgB
 K+YQ==
X-Gm-Message-State: AGi0PuZIpuTvGwZDR0PtrDnc8Nxhi6lHaKCC18ioQdPdwTAgB3Dx8q70
 g+CJaiI/BYZp6UjAzdiqZduxkw==
X-Google-Smtp-Source: APiQypJg3m2dY58QHJp2xl7Iu3TTOgHMqG8n+Pd3vfXVTp7nBXCkai1epY1+gzu1loKjaywzi/lI4Q==
X-Received: by 2002:a17:902:b48f:: with SMTP id
 y15mr232447plr.114.1588612577533; 
 Mon, 04 May 2020 10:16:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i190sm9277842pfe.114.2020.05.04.10.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:16:16 -0700 (PDT)
Subject: Re: [PATCH 4/4] hw/timer/nrf51_timer: Add trace event of counter
 value update
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504072822.18799-1-f4bug@amsat.org>
 <20200504072822.18799-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d24fa27c-f311-080b-bf9d-7150b23cfa41@linaro.org>
Date: Mon, 4 May 2020 10:16:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504072822.18799-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 12:28 AM, Philippe Mathieu-Daudé wrote:
> Add trace event to display timer's counter value updates.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/timer/nrf51_timer.c | 1 +
>  hw/timer/trace-events  | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


