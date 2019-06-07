Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD25C468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF415208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M34QohYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF415208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHCk-0003m2-1I
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGCR-0002Y8-It
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGCO-0001fH-II
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:50:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZGCB-0001Fq-7v
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:50:20 -0400
Received: by mail-ot1-x344.google.com with SMTP id 107so2072863otj.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4IGbLR/xOUnc0zxyrAdrCGsxVZ0sCSsFrqqw4DMRkJE=;
 b=M34QohYJK2Ue7WSjt/fT2wlTHFPZMsaGKcXLr2ITNlTNG8iy5dCanRvTbkqvhqA/wR
 Un2S3E8urmgCIUR0WvH4qC6n09waipqnLn5deZ9e7FWRNeKvxKWNyVkevTooco7f8UdU
 cClt6eyouGcHYLYO8oYsKfl6j//dXbVbAM4GpF5nIKci+eZENK5QIUxVEUp+3bii+IOX
 1ekm7/w+SmhKpQP4QjpyNVOcfxXTG4X1ZSxncGneq66JBc049+TIE8X9eMAgrjdWWumz
 IAngyNFvz6ydpB5aBrCqKE20kSOAqJhsQ8dWRzK6hGfDaFt6V9KfkzxDfsNCi4dA57YT
 LGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4IGbLR/xOUnc0zxyrAdrCGsxVZ0sCSsFrqqw4DMRkJE=;
 b=BXCiZDkBSI1zxiXbozxu6KJxMT/Ka9qKYcs15ylrAYK0yuIFxnVezWPXGsNiAv1yLD
 MIl4dBca2qitTeoIZkF5TZ4RWXs7aD9rxJgArGu3kRQ90LwiSLRzERfidIzcGKtQVQFg
 PCtnOAiqhjIx1vwHnKcPLXRq+oV8a8plJNa6CaAm4sZjFjEyvAe38+qcDm8ulDx5sXBS
 /j+V+DB4PuBnRtKZov+EQaKjl6ZVp1pbb8LFPqLFUqkQ48ttMwQN33/DDVjDnKpMw4Ef
 seQBFAMp9VgJZJOREtJYGr0Dj2Wq9JMV/VBfXLVr3JImPSec3oN/xxf9xaf7FXKDEVBZ
 6sjw==
X-Gm-Message-State: APjAAAWQ6B57mlNdZMxF23G/0AHaC29NbyT58TS4REnS32u5j+m1ilo4
 x4Yi7NCY7wJo3dUJtPXtlc2X+NTtiUZITw==
X-Google-Smtp-Source: APXvYqzlo0jubHUS0vvtz5CL/tlCy0/8vLPRUgC3zQcvyDNqFGczolu0o8B9mSYMNyZjAAjGLKpyog==
X-Received: by 2002:a9d:4d0c:: with SMTP id n12mr18754741otf.305.1559919016976; 
 Fri, 07 Jun 2019 07:50:16 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id n11sm813433ota.80.2019.06.07.07.50.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:50:16 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6540d63c-a6ee-5a35-f682-bd9287a96a8f@linaro.org>
Date: Fri, 7 Jun 2019 09:50:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 04/42] target/arm: Fix Cortex-R5F MVFR
 values
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> The Cortex-R5F initfn was not correctly setting up the MVFR
> ID register values. Fill these in, since some subsequent patches
> will use ID register checks rather than CPU feature bit checks.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


