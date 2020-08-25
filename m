Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C621C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EE820715
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9kxAt8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EE820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdKV-0007WH-Bx
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdJG-0006pV-SP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:04:38 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdJE-0004Mj-Di
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:04:38 -0400
Received: by mail-pj1-x1042.google.com with SMTP id j13so1630238pjd.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=yU5E4M+tA8tTOIPkvrFpnPiIdUTYXojJGIEhZtlETKU=;
 b=x9kxAt8FuMMvI/qQ6XQaHD8KCWH3F0UVg5l0ZhMkWTbVr0TwkeGwYqjrTyGZSsDNzc
 /1PEeos5TGmWMjyuQFPsfAvqBy4ig3cJDuTvFCeXwt/DML6aOV0kaX+fIsbm44A6H2wM
 0TZq55Xp3ReENNlEpI3NVl/VXzI3cMYY9ElqbGroYGW9zx6+zl/zb4Bnci3FWUnD67Fv
 +8e5L0VsLrtjqb69teD6vVK/K3PPR67frWkTRDJtTZtEbm/fldOt4R16ZBxzeuLPvLPZ
 TFT9Cgl7xKV13aINE67uXuQlZMp9vLgvOCuXwm1GewOKJ8ekhhBi+d7TuRE0W+qcifQj
 7aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yU5E4M+tA8tTOIPkvrFpnPiIdUTYXojJGIEhZtlETKU=;
 b=BgDfOXvHjF+sRhIS7f6q2fTARfUiSwFQgnnpF4LpzZueub/z1IbvMubn3TIje2TJ/D
 bMUfSZ1TiK8NDbWTJ9ODPr9AxRMW1VWJDFjuF1ovXyucYqBHPbNlZ/PvBFOSz7GUJ/OM
 mOIq52dctyWmKEL3uf5HjFbo/xInz9BeK4IjAx8KHY5AYetWzbh/XxTC9q82rdmdjTNd
 EkYCvD9EOVcqm/xoAjjDKFobz4+AB4Wj4KkDfMO5VZq+SQNmrmFOWPVgYcVRXGa/i/Es
 U6dwYa0CWFnInNmWDQ62MNb5evvGEjKB6aqn82KU7Dd6+MIDrxarZr8ytyS2zxTeY7gR
 1IUw==
X-Gm-Message-State: AOAM532EOtiNfMJGIekVrh+VddH3jwnOjZEOLV/KHbQ5bfUCZ6f/EDIl
 vQQz2h0P7tP73TI0AlpfpMfErypwaZLFlg==
X-Google-Smtp-Source: ABdhPJwnVgeTc09++gr485SKiLK+N2Bk2pHLwWIE0IGtB5n8FbTy4/nBsHA314MXhrBgXaj/vPZD6g==
X-Received: by 2002:a17:90a:eb15:: with SMTP id
 j21mr2639683pjz.83.1598378674509; 
 Tue, 25 Aug 2020 11:04:34 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id q18sm15811112pfn.106.2020.08.25.11.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:04:33 -0700 (PDT)
Subject: Re: [PATCH 01/22] target/arm: Remove local definitions of float
 constants
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4773cee0-4b3a-e308-1b4e-8d9ff5a09707@linaro.org>
Date: Tue, 25 Aug 2020 11:04:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
> In several places the target/arm code defines local float constants
> for 2, 3 and 1.5, which are also provided by include/fpu/softfloat.h.
> Remove the unnecessary local duplicate versions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper-a64.c    | 11 -----------
>  target/arm/translate-sve.c |  4 ----
>  target/arm/vfp_helper.c    |  4 ----
>  3 files changed, 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

