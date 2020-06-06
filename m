Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371BEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 17:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0400420760
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 17:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dC38inu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0400420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhctU-0001Z0-6Z
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 13:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhcsM-0000kI-Ix
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 13:44:58 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhcsL-0001m7-BF
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 13:44:58 -0400
Received: by mail-pj1-x1043.google.com with SMTP id s88so4194880pjb.5
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VI9oT2ndwF7VvgZj9Umnd1iY2byWKqjgY7WtOrfd8SM=;
 b=dC38inu6DapJjYyPEYYMhvIRlba+XNVwBYB7O4orysqz7SyqXY+3i97y52yJAGUD5N
 imqT+O2lGa7Yug/NEyypkQuOqfazk7dQ7yfmRI9+CfFqxITdJUWbJtzkE7kbNJWmvRD2
 neYkAEVmo+sou/rw2w/p/xCOCgUf0d0oN7b5ePa/jXPPtJ8sw8eh3J/kE6pDwKus+Ful
 oY3PiyMfm7QR5a/JB1NayBQecj1/J31Huo1WHmR7+6IvEpgjcufy/bS/vD2TvpE5DqfK
 vTiduw6N9xvVnTpm/+K8JkNd18I9PehpyyC4q9IMi0C/7YxnlXPq5+PtT1dldlsqlsUV
 7eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VI9oT2ndwF7VvgZj9Umnd1iY2byWKqjgY7WtOrfd8SM=;
 b=rHaPxqiRUiE85/3iP6GCec2AJduuP8fy7QoDuUisNku6Citbna4EsqcaFI52MDkYmx
 cLsvIKYWTNvfegqOFa6W37PBdR/GJUgJCFQSNXwi1Xnm5O7C81icZmq8dYqHTzMyik1s
 3IelDEO8ziDRdzUPZtH7MbvpzdeBjQdXCIaPkjVWCTbBrxM1+hZk+cXUl6eUR50oxcVI
 D9WQFJQmXAq6AEytmDv4W49URB98AP1Ji37Dt23dwDCtzjfp0TCE6Nug8YTbj4hDMJEv
 wtPMq16ox3qNgQ4/fKgqj2XqWpnsdKm6ynbLc8A32owpNiTT26x0bqE5m5WOUI1KBqRP
 L1sw==
X-Gm-Message-State: AOAM5305AUHo5AACRpomx8L6o/6gs9mDC/DIqZ6enUZ9OeRow2W/ZfJw
 WOHDc0fQhLTg4hmWgjPSnUDXhg==
X-Google-Smtp-Source: ABdhPJyKroqHqXa4OrfFLCy7G8jYmn3XdAf3MK+XgYdYyOqHBFyKcXETnCQsgw/BZFZQkzeFYMHZGg==
X-Received: by 2002:a17:90a:6f04:: with SMTP id
 d4mr8324880pjk.134.1591465495624; 
 Sat, 06 Jun 2020 10:44:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id r1sm2377268pgb.37.2020.06.06.10.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2020 10:44:54 -0700 (PDT)
Subject: Re: [PATCH] hw/misc/auxbus: Use qemu_log_mask(UNIMP) instead of debug
 printf
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200606070216.30952-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94fe679f-b96c-92cb-e839-d9e68e03346c@linaro.org>
Date: Sat, 6 Jun 2020 10:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200606070216.30952-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: qemu-trivial@nongnu.org, Fred Konrad <konrad@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/20 12:02 AM, Philippe Mathieu-Daudé wrote:
> Replace a deprecated DPRINTF() call by qemu_log_mask(LOG_UNIMP).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/misc/auxbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

