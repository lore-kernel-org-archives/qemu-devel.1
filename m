Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32986C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF838206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYNDB6xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF838206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeoj-000811-38
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVenc-0006ye-1a
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:22:36 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVenX-0004Nw-ET
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:22:35 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a32so143507pje.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WeZ1aCjfwHCKDvWu06jXxZszAC2JaQ1CtXTjM1KYrAU=;
 b=FYNDB6xc3TKPrXLk2AAmzZH6Ga7kULLiSQ1m3O5Rq3hmyMx9c+4uXJ86ENMZ8qOJEf
 8rkk3AXmztKXxaB2mW/4FOrtWwTxkWDg+qk/1orSlKEbSRZLvB58imVmzal3FB6nT7+y
 qggsqxAV/T248OXaOxTgU2Wymw+m9xG1QIOFEC0Qs6tCef6VkWTw1qr0r72n7x1dTJKd
 KmDOjh4M8pGAL1BY1mGDN4EnqS0Epaxr5iSTaccei3Py30SotTpdq+we3FXk1HT18NqA
 I7YDFOcfyh0fQiWfkH5h2nKhgkDhuzEWoxRfylaXVpMzrvESfd4/16ebWop51pC6nk6z
 aFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WeZ1aCjfwHCKDvWu06jXxZszAC2JaQ1CtXTjM1KYrAU=;
 b=Fe/V0uU/zZzyIYIQzoySqJWYT/KSI0WJJGepKF2dF/J8kBNvyIdrhAj0ZVqzLT6WNA
 ambk3koBpG5LGMsqng1dGIbLrVKjTuBSv2d9GvyBS0+rH2vJWKge/LGgPybiCkFoBXkg
 ABPyRsG65T0jB5GGOFtT0hXm/UwKBonKd7FBY+Tc1NpeLIa135fuq7bWEdFCPKCSY6sE
 ePklwnHk0RQda5s74k3gZihN/fIqNEQQ1zRFomZwU5vQw8Op5shgULisrlbW6WOr5+2z
 kMUVVf7uqMkXUUfAJvhBJEt4agiF0uTSl+STFmB3sX9a8ZUcnTaMAd/z4R+SkU0OciRX
 u4JA==
X-Gm-Message-State: AGi0PuYBeGx0n3xfpC9B8mUO5pBGrpVaKhV07nr8q9Ezo1qiifThLsM4
 CeogBMq0vniMAnVDe0tHY4toJw==
X-Google-Smtp-Source: APiQypLSbMfxUCaj63NATnz/UvVUISOwautoO5Nd9jyqQ4jFoGt6ZJYsU5clzdW/8OolReUVH2mWPg==
X-Received: by 2002:a17:902:7444:: with SMTP id
 e4mr282402plt.130.1588612950244; 
 Mon, 04 May 2020 10:22:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c1sm9223776pfc.94.2020.05.04.10.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:22:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] hw/timer/sh_timer: Remove unused 'qemu/timer.h'
 include
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504081653.14841-1-f4bug@amsat.org>
 <20200504081653.14841-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17e36520-b9d8-caa1-5695-ad361d58b5ba@linaro.org>
Date: Mon, 4 May 2020 10:22:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504081653.14841-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:16 AM, Philippe Mathieu-Daudé wrote:
> Remove unused "qemu/timer.h" include.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/timer/sh_timer.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


