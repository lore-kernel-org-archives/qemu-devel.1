Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56950C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DA92073E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6zk68e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DA92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvsp-0002S7-8D
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvs4-0001Vm-F7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvs2-0000wq-KW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:57:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvs2-0000mO-Co
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:57:54 -0400
Received: by mail-pg1-x541.google.com with SMTP id h8so10331383pgs.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/ZD6IBSncn3hFN7wdM3J8776A5oAwPcS5286HEhKUro=;
 b=L6zk68e1i+2AgxptxWZqB+tahbSclBRmjTHT9k7BmgQbeRJtpXFgoVql/JY4saECMo
 +Tz3UYILj7ci6nVxw4AOYExOQ1HCuTC7IjuYYJ/pDFbfJ/8Gn93bYiDUUhubSs93yY2A
 CDboSlBf8/Vn5p8VSTphl8VpaNoTChZbMrD+fgDv6jflEpFmqLhRVXgNtm3bnI+fZ9OH
 +g54ozdmT9CoMZ43w1f8W3Rw30Ve3JFzSyTCeAxHoYpv1FE4hbFhC50twXHKV7IgkqhX
 2GBGr/18eVmWaLwOTf6FuwTPcKI7LY2yhFOG963t11jEdL/4AhdC62Dvq9FpAdEVuVX2
 7F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ZD6IBSncn3hFN7wdM3J8776A5oAwPcS5286HEhKUro=;
 b=IWH+MvC7W1iy9MrMuyBKLQmm9NCZXh6JsPu0X/9r+V4vCPDSGiMDyBI8ox63iEBSqN
 wPbjvc41NYHhvHseieq7ZS/OvuWzKL3l/E+EVdQdwJaSlo3zqAEo7pSySGQTWO9XlG/L
 dXR+a8TRtpH6SCuUmYDQFEqakE0dxKLGoheYDBpxjML3PFMNNknCjwaV56bDAXpQNRCN
 k9yf3fXOuvHtbtVXbUz0ROorppwC4sGenuNkC9C5CnsPrVjO8NnU4Grz93b/FJBk0DWY
 jI++pfDwUUEj+EMTOU6Jg0pXkXtyGPqffwhrBTh7PhsDhIG+I2so0UC0nFJt/PtEaVN6
 2QBw==
X-Gm-Message-State: ANhLgQ1V0YgwM7Nc/QD2pfp7gJ6Y4/GxwT8d7iuXKo/6RhvtKs3Hv07w
 6kmqX9zQvhkUnt99q0weMxDu8A==
X-Google-Smtp-Source: ADFU+vtAxoh3oD0q0HO9joInGqS1LhMAVfwaEPgsfQZbtnWC293MC0TDFomQja9Ca3QFZvEm1fy0/g==
X-Received: by 2002:a62:e505:: with SMTP id n5mr1351882pff.189.1584388673109; 
 Mon, 16 Mar 2020 12:57:53 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 mq6sm575473pjb.38.2020.03.16.12.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:57:52 -0700 (PDT)
Subject: Re: [PATCH v3 14/19] target/arm: Restrict ARMv7 M-profile cpus to TCG
 accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-15-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2b3493eb-2e15-a5a1-5034-785345420a89@linaro.org>
Date: Mon, 16 Mar 2020 12:57:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-15-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
> +static void arm_v7m_cpu_register_types(void)
> +{
> +    const ARMCPUInfo *info = arm_v7m_cpus;
> +
> +    while (info->name) {
> +        arm_cpu_register(info);
> +        info++;
> +    }
> +}

Likewise wrt ARRAY_SIZE, otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

