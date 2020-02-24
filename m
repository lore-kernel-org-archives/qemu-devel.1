Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0AAC38BE1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD65D20836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wzts5uCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD65D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6If2-0002IS-TW
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Ie4-0001gB-BC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Ie3-0000Nb-8E
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:39:56 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Ie2-0000MU-Vs
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:39:55 -0500
Received: by mail-pj1-x1044.google.com with SMTP id f2so176987pjq.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=zubGseT9wH0F1ENLP7Fhgu5xm4hXEL++f8sLSVYuPcM=;
 b=Wzts5uCdxXl37sV/RTAwXeHqkGXaUR7gyYIXGjI1r4MWf3DrZZMMSjFFWNxJ89sK8Y
 pY4Xyy+EcvLup+bm/TlSPCt5oa1ATgE8fWU+PSd23WruIi99WYLYvYe9UMKnzMk4YGlk
 Sa5G8I0QqNkjjXllS0owNpE633paRfgfFDCM/cdQTRghDnOUOQFmnnmJfX7i0Gqn/mQq
 TF1l5fjw6v3EAxF5zVWiNfKPOCKolnWv+n4y1ChJnW/wGRiYfntacfPirZyVS+3DvEzu
 32iePuEKnbQE0f5mGJ8g1L80ul4eFNrzV8G2iHCaYNDg6PPg+wCQmHXoiqylUOvjj6sY
 ZL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zubGseT9wH0F1ENLP7Fhgu5xm4hXEL++f8sLSVYuPcM=;
 b=A7Y2BbedsO8Li5BUapMqART9ohQweVpdxbwB1wCbyXRdS3cXYmH7ONBubgNLjJs68y
 Tbeko4TzwzXzOcl/N5wBRHb8gkwyiJyMkVbj1uf6doFIrSzsQifT+SmQrRzBMP7CZbNj
 DwF3OdMKkaKPKSdW+x8HAIFXpLYjYh2iRnZZKJFSnJlTfqpSBewljAhfOKiQh0YKaY3o
 Uf8YUDHFlgLhsn6WPQa0ZMg7kanfYFoUaivjLT+Wy9d1Pir8C/k1/AvDTmOyxz2sqYn6
 7fKrPalZGum0eL+McbThU34WkcpRarvKICj6a28nzy5ZKpSWZkR3DrbC3FaRB6z4jRKp
 aBZg==
X-Gm-Message-State: APjAAAW++WRXMVQ1Q1ExjqRx4Js5HCtgppAQHu95qFXrWW9hIhL8Mfyg
 j1E6BTjahS/kqcJwuoGMEwW0Ay9DFIs=
X-Google-Smtp-Source: APXvYqz7X2ibh4Nh5yu9RhANkeZZpbL9f/zQNwIZ3HZOUkaDDrgRzRQvBbw+d1S3ceuM9/bSK3Dlkg==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr533337pju.60.1582569593620; 
 Mon, 24 Feb 2020 10:39:53 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 hg11sm179602pjb.14.2020.02.24.10.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:39:52 -0800 (PST)
Subject: Re: [PATCH 3/3] target/arm: Implement v8.4-RCPC
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200224172846.13053-1-peter.maydell@linaro.org>
 <20200224172846.13053-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <60d47c82-1c7b-9e75-f4fd-fbf752092a82@linaro.org>
Date: Mon, 24 Feb 2020 10:39:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224172846.13053-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
> The v8.4-RCPC extension implements some new instructions:
>  * LDAPUR, LDAPURB, LDAPURH, LDAPRSB, LDAPRSH, LDAPRSW
>  * STLUR, STLURB, STLURH
> 
> These are all in a new subgroup of encodings that sits below the
> top-level "Loads and Stores" group in the Arm ARM.
> 
> The STLUR* instructions have standard store-release semantics; the
> LDAPUR* have Load-AcquirePC semantics, but (as with LDAPR*) we choose
> to implement them as the slightly stronger Load-Acquire.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h           |  5 +++
>  linux-user/elfload.c       |  1 +
>  target/arm/cpu64.c         |  2 +-
>  target/arm/translate-a64.c | 90 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 97 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

