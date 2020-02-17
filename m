Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B2EC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313CC207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6jpJeBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313CC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3la2-00060G-E5
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lZQ-0005Sp-Ge
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lZP-0007Uw-IO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:56:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lZP-0007UA-C3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:56:39 -0500
Received: by mail-pf1-x442.google.com with SMTP id q8so9364389pfh.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sQ2ZgNtBw9V43GtXo/sfTz7OE2ZgJFYbShsu0RSvMoU=;
 b=S6jpJeBM67IyRAXTM0Fg46AbLRjulpXvRdxj7MUPFAqmeNM0GvccQ5Lkm/zKoop0f9
 b2mkV5RpyEoqtMqVsdxc0QsN/fkbDWyvPScrAjf/OHh+fMJKpxsrlmFt2Engn8B5ovzj
 67POrqic1qB6eZb0tLn9IwUyxJkVOcboVveiLOCSMFWPhrdDzQ++OCAs51cyAI/sTxuY
 +e/aS0UEfduRHmZr9v9LhAX1T+caOnt7shoP+DvJymRn4cq/WZ5uebDSJzRm8SVXbFXB
 GZiMSvCb0QfLXxA6x0hi0dVMDcquYuYNdSXeFYvgL7h+64VbpFozgatEVc8EyWznK8gk
 PrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sQ2ZgNtBw9V43GtXo/sfTz7OE2ZgJFYbShsu0RSvMoU=;
 b=IKqGsdCPxgm0q9CtZ9dBYUUacT9YRzKvT+apMAXsJHXZ8BCcPO67zWw6e+6g4GkEY1
 99KTONsAhsxUnsKL9TTgUsbJFEGZiXvBg/JmdEG+h0npLfxi+OcJrjp5l+YstovvBvds
 mlrTCk7IL93i2k+0WHhIGTu7HvcOwPT0n1PiLyzJYICCkB8EO2/rUY4iUSvuzDPqbv5R
 gg8GsWi3kzYMb7h4Fuphzay841+/Ehm+O5b6QJwfWkt8lCzEotaDtiVXNohnaW1HCMZg
 1FfoRsgUDRKP6bTSUb5r+CGA6n/nZlChAToLscFbeNzB2JumSyouSAj0ZYARO/k8Jbwk
 8PRw==
X-Gm-Message-State: APjAAAXbT+MNZAMx4hxpPiSxq4GfybmuD3KuihEUbwfDgtGtvAyYSyMf
 14/NuZKeKQfcH4iybHz31GgNzw==
X-Google-Smtp-Source: APXvYqyP9qMqkxpGRCf12+dn7qv+wlHeRFFpDdQqgarjXnN/NKVxhOwHwvDBtX0K7JLyo4ls3AV5qw==
X-Received: by 2002:a63:f94b:: with SMTP id q11mr20039261pgk.161.1581965798204; 
 Mon, 17 Feb 2020 10:56:38 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z10sm2919pgj.73.2020.02.17.10.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:56:37 -0800 (PST)
Subject: Re: [PATCH v5 15/79] arm/imx25_pdk: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-16-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77939c6c-3781-a016-d023-a9aa0f580846@linaro.org>
Date: Mon, 17 Feb 2020 10:56:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-16-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 jcd@tribudubois.net, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
>      /* We need to initialize our memory */
>      if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
> -        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
> +        error_report("RAM size " RAM_ADDR_FMT " above max supported, "
>                      "reduced to %x", machine->ram_size,
>                      FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE);
> -        machine->ram_size = FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE;
> +        exit(EXIT_FAILURE);

The wording here doesn't make sense anymore.
I think it would be better to mirror that used elsewhere:

+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

