Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79050C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4589920781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hj5vqABs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4589920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5umm-0002Qs-E9
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ulI-0000r0-Te
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:42:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:43622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ulG-000402-J5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:42:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id t10so1424572plz.10
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3EbHHfdO2Kojsq2nCAoTefRRXvkT4TJdjU8l8Tz3ZzU=;
 b=Hj5vqABslG2N57YVmUiLBs/EnQJ3wRCal/9tdTmkJYFBr0/OBxTrs/JzcCqaM+wT6r
 JARHb3NsWWQbCjMRRBZvQi3FdztGavqG+toVBWULGY6wfIrfCCaRZFFuhVdx8tMtPkNs
 GBYenDMlAC35gnAWTRjwv21Ef4ubpCW2ybrfe/Ss0j+Hzfkj9tgJVJadqGtrDxpDK0W+
 JIJNX2cxtALhg5zKY5bfu0E8PonEMKqbumq7eVEo7TjpKBEC/XQPvQ0Y1IAi1ZHwozWd
 QbK1dA6Qs4rBrjo+SAcSCihUx0zu0zntrzTrnwP5cYZ8O6sUF70yieGf7ET6p+YLmXDj
 fQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3EbHHfdO2Kojsq2nCAoTefRRXvkT4TJdjU8l8Tz3ZzU=;
 b=OdI3LaicAzxbYam0dpQ9XVaIeHtbCuT1L17yx1FL4HGLe403lcGwPFGkTKpOaiJxQJ
 lHsXFrYI2D/v8NfVLvHpJ0ubRfOhbEcK8d6i9Z83JuLvjTDTXk2zrfH898d+PXa1xprR
 6zuaqJ4iII4bMOhZHAMEVzkuMZxltxaBJvNu53z2ShCzAk+Qava78VLyLrCVwvKOEZBz
 9SDopsk+jea+SNHw6VIqv6jE9yDq3OoCv1OzPrPmruYpkQsgdg/EUakk40RqWF++fD0i
 86nz24HuVB+pQnTAMqQtXaU7AltME1Vs0IGOmUpgXhhcqaYOKCAmg/gizFPXblekcKIQ
 jM2A==
X-Gm-Message-State: AOAM531c/E93uhdAhiOTAuTLtb/VgPPtzutQfBFdgYdeaUCx4PgXRgGB
 tCe4YcVoRs8+bvooDk5SsNPbCw==
X-Google-Smtp-Source: ABdhPJwtoDGB5QiHESS7d67eGqoTCumeL2j7dvOvNcMbRj8N8AsHzqIk0JPJs+gJHmavYijHyUouXg==
X-Received: by 2002:a17:902:9a09:: with SMTP id
 v9mr443210plp.331.1597254121111; 
 Wed, 12 Aug 2020 10:42:01 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 63sm3015942pfu.196.2020.08.12.10.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:42:00 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 1/4] hw/char/serial: Replace commented DPRINTF()
 by trace event
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806130340.17316-1-f4bug@amsat.org>
 <20200806130340.17316-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <768423f6-a9b9-0e5d-6cf9-71189bfc0d8f@linaro.org>
Date: Wed, 12 Aug 2020 10:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806130340.17316-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 6:03 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/char/serial.c     | 4 +---
>  hw/char/trace-events | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

