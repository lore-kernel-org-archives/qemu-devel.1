Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6E9C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE22E20731
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IM0B5u3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE22E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBL1-0000w5-RP
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYBK3-0000HH-Lk
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:30:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYBK2-0006vi-KG
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:30:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id a4so4799706pgc.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=12LvgeCJuJQO3x2fy3fOhZzkeb9hiF3TwYLbtoQhgjE=;
 b=IM0B5u3hBpCzzpi8IxE9sXcWUgtDEjBiX8nG2PnrRXW9fnY7BhJ4VZX53DNIoh85PL
 8ZsqC7xxT1azwq5FYbXqgAEnyIb/4dWXfchjVLFIJmjr909BuKa4fHRFDO8Ir5AobA9B
 SDQkTu34UIn++jLG22dbNBNZgSA7QSsKOMh7oKLrwdRO7MZy+j8DiFxEqRStMOjFXi8Y
 Tj/tjmz1RQOlrWw6cf1EIjG6rLbfAqnG4FMVknJEcc43dapTc7kBrhqImYJWuj/21zPS
 lg+J3318kmpAvYWe/S9nn2JG80kFNJ1STvvAoWVCN1H1M1RYKddg+nPUuDuwyVAwiiXv
 2b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=12LvgeCJuJQO3x2fy3fOhZzkeb9hiF3TwYLbtoQhgjE=;
 b=JB5zcPPlkybcgq50WD2I/L9eu3F33K6lx6AYWKCVDyc7b8T6RzxSGnu8zKxDbLMT83
 yT/yvMVpgAlqTH7Jp/XngxQbdfzv6nm99n6fVp7BhB19c9N0L/LyQTvpFxvdbslRhRPP
 UqMc/agy2+IEbBTTMQmuQ0cqWDCVbVFUfV3eflWJmk0/bG8x+NpGYg6Z1HQVDVZZm1x7
 j1aAGOs37Ml+UVBbN92DauOvprXy+3BbrEG0P/T6xpm3Fp5bqrehSteYGiJx+QM0MoiO
 5D7ZNsCDdJnaedcEZyq8YOaf3Rd+PNxyFQ1LQ9IudYHn5bmp/Bl5ywycC3sUTqTsgaHH
 /jrA==
X-Gm-Message-State: AGi0PualtMzqIGfPgmPFlwbq7tRaxGKfU2Q+D3v93WYt100kibuG6UKW
 a3/70jGsuUSRk/aa7KN1CoheWg==
X-Google-Smtp-Source: APiQypIxSHvfBpeI5GgcgAdvgUY8hMhxX2Z9+ye+soBg+4jiP7ygMrKAW997OWDcXwNQxQmelp09Mg==
X-Received: by 2002:a63:4f65:: with SMTP id p37mr15762222pgl.60.1589214628988; 
 Mon, 11 May 2020 09:30:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w143sm9371201pfc.165.2020.05.11.09.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 09:30:28 -0700 (PDT)
Subject: Re: [RFC PATCH 0/8] RISCV risu porting
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69d804ea-5274-bee4-9368-69c888082143@linaro.org>
Date: Mon, 11 May 2020 09:30:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> It's some difficult when I try to support RV32, because it's very
> similiar to RV64, so I can't make two .risu files like arm.risu and
> aarch64.risu.

You could a command-line parameter, like --be or --sve for this.


r~

