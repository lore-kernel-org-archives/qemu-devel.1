Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22371C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE00A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBoYJfmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE00A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvp9-0006Qj-50
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvoS-0005k3-31
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvoR-0002yA-5M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:54:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvoQ-0002sY-UV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:54:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id 7so10338213pgr.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J0uobKBgK4rHZ0hjWoBdZkci++dbIcJWriw2kCPQsXs=;
 b=VBoYJfmuvaGBrugdO/DrCXhiDIyTOTxyjk3+L+oRn/eFQXQK+YHtv4UMbvsiMAbZP2
 23y3Sgp5psLOea82yutv9iU8nulEA6PIOHKyZzWf3FYu1Eq9QTNxkrAQNXA/FusCZsBQ
 pHXuv/DnAeYNEjXoLBMtdhZIIkGq/8+0WKUUxFohhFFTycwg0kDBx7N6YJtoNa591ueC
 oHTG+OSIf/8BwaspwHEnXCwd/VNNyICWMyqEKj8CWBbVQGrC+E/A1JIBT2ZEuRN2WlDj
 548E5I0aeW/O+F0Goih6831O4k5Z12z5vrnW0pVVwihckLJPa6Z6W7huUE7ak0g3VmJz
 VCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J0uobKBgK4rHZ0hjWoBdZkci++dbIcJWriw2kCPQsXs=;
 b=ESJX2kmqP/ToKtEymlnAHfkw6BuyBHPzm1tlP69fusxiN+USYM2yrd3gK5ldGaVq5S
 DEdrwDCIKlYdiuwl5fW7aXfYnqHpHQvaJM37FFqX+xdbg7RtYNWF5IowYp/+/vLXKMkx
 +tU5MNx4M7ugj0FZcbD/nMnmJRmN21Mrr0r9OcOGxSFygVsVzU18mFoOnWDD4hH4LloR
 /Sxs7/zHZIV5838vCBBfmW3TWJ9MXGDX3pT/VHr0CqHWJcTXmo4oYkwqwDl2gozf2lS7
 Pd578MrsRqeYjlKBvnCRto2zLAhr+FA/45LUkuPMY6jyvgUZ3yNEtpGfbJds9PcxxNeq
 C30w==
X-Gm-Message-State: ANhLgQ0F34m09hdvtAUmcKgOMdL6hz6ho2oYxD0V3BH3IYOQbI7orELK
 ZHRckWlDGCAQHR5Ywi4B6zVo0Q==
X-Google-Smtp-Source: ADFU+vszr2eVMxAjcMPZzWWCPhhjw6Y5KImoake42lZ76b/FAthTjOmvFTNUgtos8pANIhHmIZiLgw==
X-Received: by 2002:a63:3547:: with SMTP id c68mr1425842pga.380.1584388450100; 
 Mon, 16 Mar 2020 12:54:10 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p9sm538444pjo.28.2020.03.16.12.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:54:09 -0700 (PDT)
Subject: Re: [PATCH v3 12/19] target/arm: Restrict ARMv6 cpus to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-13-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e3728368-4c23-ac70-949e-d02ea698887a@linaro.org>
Date: Mon, 16 Mar 2020 12:54:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> +static void arm_v6_cpu_register_types(void)
> +{
> +    const ARMCPUInfo *info = arm_v6_cpus;
> +
> +    while (info->name) {
> +        arm_cpu_register(info);
> +        info++;
> +    }
> +}

Likewise wrt ARRAY_SIZE, otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


