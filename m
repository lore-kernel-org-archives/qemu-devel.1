Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36585C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014A221655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEytGpef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014A221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPRf-0004rz-7G
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifPQw-0004PV-Qa
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifPQv-0002Xg-Fd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:27:14 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifPQv-0002Vt-6o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:27:13 -0500
Received: by mail-pf1-x444.google.com with SMTP id x184so847491pfb.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=nvxk4w/BhuCMNQHLTJjLJrN27ClmCoaoni3Fxdh9B8g=;
 b=IEytGpefHhV7GfQWn5lRMYgWtqGfwJHOp1DRypElmQa4qVURq/x1AJ9JAlCFwmYFau
 i8kKnBsg97tSznRYyxwhj+QWwEQmQgp+UxvG//6YfTqkk8e12QvFZ8fznv8T2Bjw1bnc
 8XiT8zYAEUaGG7YcGtkHo1kIoTsjcJ3FDBtOiiKcuSX/rMgSqusqnyrn6JevT9nwdFls
 yLZ3fXz1pGmt70sLjaqpdDnvsWRwCMonKqHtjSUqF6sFwdnzMD2aVSjpcireKHCHISjl
 XGbuKgg/O7dBUc+q7ZPcDHKsGOZldIRUi796EC4izbQBDoiONMu2SR/1GL1aPB2gqgx5
 PsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nvxk4w/BhuCMNQHLTJjLJrN27ClmCoaoni3Fxdh9B8g=;
 b=tbDq+itu+a4i1LoDY6lUq+dZaCzf47X8j+cMaulELMBIIyXHog0StoEmY4Z8QJFJvB
 XbeA9Hm2K2Qfm74a2FNAmMhBt5gq0XQZPFDlOaFJmDq8yUcWdFBHJDBa4Zh7PegA5Hr3
 23UxgpAuYiM9z/b/GS1nQEb0/3D7Lw9unCmJpdqaIm2a/rcVY7dwCvB+IJ8owi+pH8WA
 gdsIivQf5outb4MZhyAzla4xvqdoLXnFS5JoKNdeLignzWsMSGD+5grA3QYzsxSNgQrF
 1uLGX6WfeN9A0vUTlik0MlhYJ3Tz9zT/p+sXDccmPXLWnQoCyOly55HQV2syC2F0w/G4
 C2LQ==
X-Gm-Message-State: APjAAAU1fDDXtY8kc/YC8f1T/D6aWGaaS3F1tbUC0GAbtGeiGX0GTsJX
 ZwFzkSuBgOJdC9CAcIGwOa2BU0WkOpQ=
X-Google-Smtp-Source: APXvYqxiLc3KzrCoLgdeKaxFfYibSFVXLyNVaL6fQZy2g05t6YuCIIvcADMHFOYd3SuJTIaOhrLpLg==
X-Received: by 2002:a63:5657:: with SMTP id g23mr10508251pgm.452.1576160831152; 
 Thu, 12 Dec 2019 06:27:11 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r1sm7019892pgp.15.2019.12.12.06.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 06:27:10 -0800 (PST)
Subject: Re: [PATCH 23/28] target/m68k: Use cpu_*_mmuidx_ra instead of
 MMU_MODE{0, 1}_SUFFIX
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-24-richard.henderson@linaro.org>
 <6162d8ab-b608-15e4-8e33-8a656afb304a@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b1beeef1-cb13-3452-f8be-e07b860143b5@linaro.org>
Date: Thu, 12 Dec 2019 06:27:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6162d8ab-b608-15e4-8e33-8a656afb304a@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 1:44 AM, Laurent Vivier wrote:
>> +#define cpu_lduw_kernel(e, p)    cpu_lduw_mmuidx_ra(e, p, MMU_KERNEL_IDX, 0)
>> +#define cpu_ldl_kernel(e, p)     cpu_ldl_mmuidx_ra(e, p, MMU_KERNEL_IDX, 0)
>> +#define cpu_stw_kernel(e, p, v)  cpu_stw_mmuidx_ra(e, p, v, MMU_KERNEL_IDX, 0)
>> +#define cpu_stl_kernel(e, p, v)  cpu_stl_mmuidx_ra(e, p, v, MMU_KERNEL_IDX, 0)
> 
> Do you think it would be a reasonable cleanup to replace the _kernel
> functions by the _mmuidx_ra functions directly in the code in a future
> patch?

I can do this in v2, as David asked for the same thing for s390x.


r~


