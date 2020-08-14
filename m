Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EFDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DB620774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3SGt27y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DB620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6d5f-00014J-B7
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d2X-0004nT-Gp
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:58:49 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d2V-0004hH-KF
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:58:49 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ha11so4663324pjb.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2+7vjmmDLcLRpLinGwtu+OK3I1ZrJBg18a9aUp5XYoo=;
 b=e3SGt27ymXgIAz/Yimue85GdB5A9sEDagfcXPYFssr6efhLSHy3m/cpXY2dKkeoJKN
 zo+PW8atWBjASEHuXCFmtWNcDU4sWPPNtIkz322fhMwivLAr8XawtoFkiAUp9klAJMsi
 ejRYrT7oLFUD5ItMw8e3Kf/V8rnAyOZ2Q4iQHrZGI3/NSt8nbqqnSEtfezjdkyvRsn8F
 oM62YPRJHw50Rc589A0AXHgTLskl2ewEw4Q50f6EHc5ZGBSNukqREDpayJhldzxishw4
 /4xavrHSi5kPTn/mGzTu9Vl/SK6vL/qTeYnJh99T6l/gFL68kLexvYtWe8o7V/ngW5rM
 8xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2+7vjmmDLcLRpLinGwtu+OK3I1ZrJBg18a9aUp5XYoo=;
 b=MBrpyyzfcldSuadozUdyjhdnJ1lSlHKQgRTuFiwtRm8NaFUS/C+Ik29oZocd2G5krs
 8uxZk7rtL41cOaqzW8fRvnnklQ9yCrQj4olGicFc6neef03fLOmEnuoncYgoCCvAbYzN
 XFmSWkX0IxjNh9ULXPS5Kx5ZeSAION4MzDkW0P2hWVcjnoR8D4fYzULkj8b+BpeScHgn
 vEKquC1B61o7kjqVnsldRt7GQv3kvBmHGYIqy07pdMsboS0l9ulEFxZgrPjmlh8+Ai0Y
 fDi6IXbDHs2d+nxMDdbAEH+t/vn/aTaPNwlZFYM8qKC/pOK3eNDPPAHB3JvAmWWjoUbT
 fXJA==
X-Gm-Message-State: AOAM532vM89WmMDvbcas2cK/mb2I00VyjOXKUoCgmMw3OH+gokCL3PIg
 ++PJiSBY2pk8BavEp7a6vEUxHg==
X-Google-Smtp-Source: ABdhPJy8vDJFmTUOyvWh+QTZvjJ8Aj8fGiFlGNstlD1v2DWt7rrrl3JUVsIUZY5gWFluPEzAWf5fxw==
X-Received: by 2002:a17:90a:6903:: with SMTP id
 r3mr2969831pjj.65.1597424326248; 
 Fri, 14 Aug 2020 09:58:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cc23sm8440084pjb.48.2020.08.14.09.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:58:45 -0700 (PDT)
Subject: Re: [PATCH 3/7] hw/ide/core: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9db78d8e-0fc6-4ec7-a1f9-73c6d8d02639@linaro.org>
Date: Fri, 14 Aug 2020 09:58:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 1:28 AM, Philippe Mathieu-Daudé wrote:
> Use self-explicit definitions instead of magic '512' value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/core.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


