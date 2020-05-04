Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F246E206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2VLUdgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F246E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVfzE-0004ML-0j
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 14:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVfyT-0003nU-1H
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:37:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVfyR-0001jq-NC
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:37:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id 207so174935pgc.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LBe0LByfI8ODUWHGnqMJ+kv/EENUQD7l4y3Ff87mtOY=;
 b=o2VLUdgdRU3jcUhS4YAg9ZVj3HfDwCVN6K2pmcpbMe4R4rXaI1rb9rI+aMxlsKqetB
 6ispbs1sm/pkVAUbBiLwoH1EatCwPoEZDzC6QuOTNe24pAFY4o/arTCOtDGRstaf2DIf
 6aHp86FMMIIJgxAJEltyfZYrbDiZfuCRzazWAniSm3IK5krWBsJioMikYqeLc9E98vlc
 mP9FpsAKoB6XUDqGALEe+OWVK1QYwHJMpn1iSOkLxkKQKo0o4qHOc+0mGDR2xpBFx5U1
 PY5w36AYyZ5IKqtEtIJtcb6UCQX9Mfxa38z+1JWa+VmheaeSY4ys/N0lAZOn3vnL9FmP
 j7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LBe0LByfI8ODUWHGnqMJ+kv/EENUQD7l4y3Ff87mtOY=;
 b=ZcvstFPHL1b/J58gnOxP8UZwHs1cEPWo5VADqxmwR+ywRzua5JJY2KB13q6LliZArL
 jlgjVspsf2sjP3XRO7HKV0VreCBS4Fo2tvxf/ODsZO10Sn1l8EndnHQnbFvOmsHt7Kn2
 czMP9Y1rvmkg7r1UzebwDY8y3NfQCVR5SUAZrQDxpSdw3zc7rToriCCKdGxzsecQaZel
 LFyy/qEUJ9AgphQNiKcwjD720WtjhjCDsB15Em0G5ctCJkR3R0EuWtKOWm1DQOYS0uCF
 TinXbtdGN6nNHCWGSh1jNghmFr/rs32Hx6kszmgib2no8zWSW72C06JEL+ChCNlTCtUh
 JGuQ==
X-Gm-Message-State: AGi0PuYEGfKc4CNs6biTWRfU2mdOmZ2egOIYN9e7Snp7JRdIGML7NAD9
 P4VEWsV511XSPswMORo6cUJhKw==
X-Google-Smtp-Source: APiQypLbr5FD3QQNUzyqmShvcsCxrF4kOZIPzVCLBHzvVa/Y+r3gb9nY3twq+7k9AGrktEF5gjMi8Q==
X-Received: by 2002:a63:ef04:: with SMTP id u4mr312580pgh.280.1588617469673;
 Mon, 04 May 2020 11:37:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 1sm9259922pff.151.2020.05.04.11.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 11:37:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/display/edid: Add missing 'qdev-properties.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504082003.16298-1-f4bug@amsat.org>
 <20200504082003.16298-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59e5a700-e2fe-b053-3bbd-71c36134c116@linaro.org>
Date: Mon, 4 May 2020 11:37:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504082003.16298-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:20 AM, Philippe Mathieu-Daudé wrote:
> To use the DEFINE_EDID_PROPERTIES() macro we need the
> definitions from "hw/qdev-properties.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/display/edid.h | 1 +
>  1 file changed, 1 insertion(+)

Does this not currently build?  I'm not sure what you're fixing.


r~

