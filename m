Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3110C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4707218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpQmfOyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4707218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ34E-00025D-0p
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:35:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ33J-0001iD-AX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ33I-000143-6O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:34:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ33G-0000tp-3q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:34:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id o5so3817707pls.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=VX94Em9/JxFBkaq9XXZQsOYSdZa/PqJ0ofPP+jlzHtI=;
	b=RpQmfOyR2qpbUEpwd48Ga3cwTP0L2E3HzDpVQgfLIi3ocCZJpScG6wdoslFnDQM65O
	LMO5NSVqRIw7pfy3IQVebJ1AtXVBwuogMRea3OYBh7netYHkVCtJO2Bfx/qaSWj4ACBg
	AXqM7O77/WUAAPaQbUziMNPjJ9+zdjpjVK+DazD7G9wlUTuuMo5X1B+kLKGJa8nTm1hQ
	HjKS1ND5TGJNhzdOz4kBk9c69MwkDzWuD33kiEn7+ajbMF7mLy4vcGsSFTNXvo3E29+p
	CD1xJYxTO+b4k2nR9QhBSNVq7uD/9RZ0s2z9hNhRoeXY9ug9bmaEhTc5t3zW3jtV80T+
	YNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VX94Em9/JxFBkaq9XXZQsOYSdZa/PqJ0ofPP+jlzHtI=;
	b=EdjQvyaHy8q42MfFknpvEsGGe/mIF6T/HzawgWZ4k9PapNqKC92SdYNHUH2+VMk32m
	lFb+bOgrpsHwj7c6irVWEqayuZy4UMe8+Cfqkr/R1RT43jtukvcldWqk/8oHNH6EcRCR
	2IGINmbrqXGkztTkSVMc1+nJn7TSv6eEbpnEkXRD7TG9iPUhBl4Qm5dZBuhKJmjJG+WV
	n2aIvK7laNDkmM+TFTG6WY1YVadvBvFydCCn4N4cLsHBrVwzsh1fgOFII9UuUfGIKe9L
	VQmO6JJUvVWnEeTbmMNPiInJcc2fMvJwQDNnzL6Fat4qXkKtAw2jjO21Kf3TpUy+Zz5q
	1NFw==
X-Gm-Message-State: APjAAAV4J3f3/d84y5nMcD7D5gHEzKDDMoRlMcCk99eWKESTP64v5LuM
	ovE+JD4tCFg+c0+X3Sjuo0GmDSLkec8=
X-Google-Smtp-Source: APXvYqw3d65lDHdnz84MWRyalsEwnF++Y6AbFwdG+5jlcdpz25/Y+1jFcrKqXX/gCs5vOLfRWVa6OA==
X-Received: by 2002:a17:902:9693:: with SMTP id
	n19mr20079521plp.92.1556055233041; 
	Tue, 23 Apr 2019 14:33:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	o89sm28442078pfi.178.2019.04.23.14.33.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 14:33:52 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5729634a-fc95-a6bb-cb97-3daa3daeba37@linaro.org>
Date: Tue, 23 Apr 2019 14:33:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 08/26] target/arm: Handle SFPA and FPCA
 bits in reads and writes of CONTROL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423213350.aS4OUmp2BHcpNxh3gtAnl-zr3Jy_4WK4fOXPXcDXrNo@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The M-profile CONTROL register has two bits -- SFPA and FPCA --
> which relate to floating-point support, and should be RES0 otherwise.
> Handle them correctly in the MSR/MRS register access code.
> Neither is banked between security states, so they are stored
> in v7m.control[M_REG_S] regardless of current security state.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 57 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


