Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3699AC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1887208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4XJ98ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1887208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuMQ-0003HX-T4
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 01:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuLi-0002JS-A0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuLh-0004Tf-1b
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:56:10 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuLg-0004TE-RS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:56:08 -0400
Received: by mail-pg1-x544.google.com with SMTP id b1so564831pgm.8
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 22:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=HCcDrzSMiBlJ7TZYfNo5yZNb6fKCNk4D/MH52yjChpw=;
 b=c4XJ98ipxhS9clr7TVzVV7B5sFPaU+6MKZ9+L7+GIfufP6h1Pj3fTRZCDckEgnGbia
 lpdzEGL9s84DgJqFLg1URPkIvc9rtECXaH9h5zbO+ZeIRtWQSVmrfRWEA4fQsx3AWYEw
 0wkbmh0r65asixHwJ8VvHmcPkMSNpmLuTR3tHGtTYCL5GKLZoBzMdjShn7N1HHQyYInI
 CGdza32kLMK8k19rbRWauSOmDm5Yvf9qHBsEfINqkHrNfUj+uMczpq26yGNNIdhaonZ/
 3lI71JFd4wEnM2cXKOhzrQIMxEWk/dh7hDaLHNy+XpuDIyJ51hG0KknHx9FR5BNy7VNm
 eyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HCcDrzSMiBlJ7TZYfNo5yZNb6fKCNk4D/MH52yjChpw=;
 b=QaC5aGzyUiuKs78e6ar3eI1PBzNqhbN6QpuVpU2fYXWi+6wc8mAccCMkA/NJ0NS224
 /kaF7QRjdnV7Sr5FZ0S7c1wMUDgIrDo08OgB3KQMD0FVv4vx3D741uZDK3j38N4aQf7r
 d0yOEnxYVI6aHTMkNjvvY09TQ9VPSgDOPUgkkMEiCqk/AZ/hH15ajw5+/lFtJpx/f9OI
 vhiYThWcKLxYJpF/qysfXoQxU3P9u0l9AQbqk8q9z9uTXiWEmo9DR8JNDd8Uxv4r8du+
 j1LaDZFD8GVpQShvvyEkI5QwqSa6FevMzZuu49TyJ8yXnVXxby9B6Trq8H2d3RQh3uwv
 Tf5A==
X-Gm-Message-State: ANhLgQ09WmB3HTUJSLzsJwMlamzKQazTFIQBSfxYxFgZ5MFiAeloFC2h
 mt9hj7CeSgH4wPsCqQB2AuP+IXmi4K4=
X-Google-Smtp-Source: ADFU+vvaXslhqiqs91Jj9yg7EznnwxvEIkH/NsBZSHtYlYPUU/2FihZwCydkzQmbAVybDZ3rocbTPQ==
X-Received: by 2002:aa7:9306:: with SMTP id 6mr1288297pfj.72.1583906164968;
 Tue, 10 Mar 2020 22:56:04 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q7sm34915699pfs.17.2020.03.10.22.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 22:56:04 -0700 (PDT)
Subject: Re: [PATCH 0/7] post-rst-conversion cleanups
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200306171749.10756-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <403e23a4-d237-d44b-269b-6c2b655e274b@linaro.org>
Date: Tue, 10 Mar 2020 22:56:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On 3/6/20 9:17 AM, Peter Maydell wrote:
> Peter Maydell (7):
>   Makefile: Remove redundant Texinfo related code
>   Update comments in .hx files that mention Texinfo
>   hxtool: Remove Texinfo generation support
>   docs/sphinx/hxtool.py: Remove STEXI/ETEXI support
>   Makefile: Make all Sphinx documentation depend on the extensions
>   docs/index.rst, docs/index.html.in: Reorder manuals
>   docs/qemu-option-trace.rst.inc: Remove redundant comment

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

