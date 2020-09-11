Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5ADC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B331222207
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnHjl7S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B331222207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGrg3-0000yb-M3
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 18:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGrfG-00008C-U0
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:37:07 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGrfE-0008AY-Bd
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:37:05 -0400
Received: by mail-pf1-x441.google.com with SMTP id b124so8346840pfg.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ssd1nqFLH4rM+Rj0wUSn3hf5Knthje/+o2KirR/A3VM=;
 b=TnHjl7S6zriP8jCdI1VFBwmeTPLaK7fuO/AF1FXxNqpKtdp6ZZH5BJkVUsuN4E7BWx
 oFABRCyO4lotkrzJIFGU4NRZKOKsp8FGqOzJo8kDRUYMpcL/nw6PEsTedTHzyGwnUVmH
 nD+ZQRCtlad2K6nczs6WHchjXWuTnypCIjZCMzBKeS4Ajf+QKIBnmwLzpX6UHdqE9lhv
 sQzhmD1Ack6XKmlPmuLd1E0x0Ez9BF+mmydX8mOltpcQnomYmFmitGvleUB2EFKrCay0
 QGyHmB/cRlWSl9Frec1sEy9485IZureC8emRqznZXlhgPpPGc2gQXOyDz3/VpzoOzC6J
 yDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ssd1nqFLH4rM+Rj0wUSn3hf5Knthje/+o2KirR/A3VM=;
 b=m5QwwdjkOVplSf1wThhY7rCfTsYlprKGvT7AZWIwIEY4z4eY4dtseQXzIEzbMG/c7Y
 qazMzfj+O8Ftc6RrKyqAK6oMIltzSbveKmRcPg9Os1MWAo/M/uVDFY/EkDnCFsQlD2IT
 YsAawNjPMNj2iHU4YFwAkHq9wJO8h3sa9BSaCnPsmN7N8JlHeI+uJ6iW+hxOBreYBMvs
 Vnb4jjAdact5GmlOYczSePs1Axs50201KNq0i0ll9mb4kpKml1hh5hZgnoOKYIqns2xp
 CBa5Q2l05zBdiIG6WEuULxxKh7yoJWCXi0oGtMnqFu7o1qXGWTY6XErH6maoziRdf0c4
 esZQ==
X-Gm-Message-State: AOAM531/zkaIbl6HS8NkDnXQ2Ns2eNFB5KEJI7UVn54gl+tyo2HkPU92
 5GcpqBKQCmnxR3Leg4wAcsGRFQ==
X-Google-Smtp-Source: ABdhPJyz3CTNmOQslU2Az6PM8n5Pk+KS2G4yzkqSrAy6nIS0lJ2r65UNR2mDvEtP60wa425XTELGpg==
X-Received: by 2002:aa7:8bd8:: with SMTP id s24mr4150600pfd.80.1599863822692; 
 Fri, 11 Sep 2020 15:37:02 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 72sm3181961pfx.79.2020.09.11.15.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 15:37:02 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] hw/misc/led: Add a LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0af3da18-e71a-4659-fa6a-568ad493e4b0@linaro.org>
Date: Fri, 11 Sep 2020 15:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910205429.727766-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
> +static const char *led_color_name[] = {

const char * const

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

