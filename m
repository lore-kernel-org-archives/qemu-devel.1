Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD04C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B722051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0S5VS9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B722051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDcVk-0003Ke-Ca
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 19:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcRb-0002WM-QI
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcRa-0007d7-Qt
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:13:19 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDcRa-0007Z6-Jc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:13:18 -0400
Received: by mail-pj1-x1043.google.com with SMTP id l36so7202133pjb.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=36GghPKVCi/R2ygkrbs03strV9PNRG9KAxoWu+TbGBw=;
 b=f0S5VS9h13xOaGKVZHXY4oS7hRyvu/P1MJOOODGi/iit9rlawcW73CoILCdKdH/y2I
 iWJl5Hz7YDAfABvMx68BRvYlRvtf6I57KCc5qe69a21wT4G1+W7qygVJsB9XRFDGerQ5
 QkHF3VWajjbfqousJErDCYy0fV2/IEJYN7ifOgoyduVuOu4jYhd45qK+69kW2+TTKypR
 KV4IKcQxrsjx+dV6L5PofXhFdqXizlTLw99hAjZp5EzdJR4Y0M+bGUxMtTQ6k6dRNrEn
 9kAxbhSnozziL9bSI/sXEkozLjBvfJxBhjqBdUCPvsMRf4qirfcXW401tRc3bFSWXk8U
 RKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=36GghPKVCi/R2ygkrbs03strV9PNRG9KAxoWu+TbGBw=;
 b=fFHH8s/Cz6otuRtvfM5gES6aDc0bBg7sF2KaBGfcMZas9gEF5yHdBA/MrqbBPVTnf9
 iK3L5BAH2JpiUGfBdhGXFXMWV8YYplnc56BfLN1snYZ1f2uToEBbvPvDwZHb89IrbLhl
 feNg4WRmnd5aGWTLWrzYm4kCuAGMt/an3Ua2YAWB9zAgXvAsJCp3Gcrf4vbjrAhTniud
 MK555k5jJpisTL6WDCY5eKsBtHdFDGdahnXRLHJsO0EYJt2Oeksec03AqlmAWFf2nuVv
 pI5JP5MIl0VtijDb1ncm516FauUG8vFvMxt9X8WB7bE0AYMFiOS2pRaQyZWP2rGc4y6G
 2Puw==
X-Gm-Message-State: ANhLgQ0bP3R78n/CHbFFFR9rpJq2wnCvXbe7ck4T/Y3GswoIunE8Od2F
 KaNztSdWDaL5+YdB9NuSV1ZX7A==
X-Google-Smtp-Source: ADFU+vsiEhRbEZVnH77ALBAUwDAML/mTmKy17TAawUASthJI1l3OBy/WvBGJ8RlwQCcVT1zFsTKrUw==
X-Received: by 2002:a17:90a:fb8e:: with SMTP id
 cp14mr14950718pjb.8.1584313997316; 
 Sun, 15 Mar 2020 16:13:17 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w11sm64108184pfn.4.2020.03.15.16.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 16:13:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] scripts: add a script to generate syscall_nr.h
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200314113922.233353-1-laurent@vivier.eu>
 <20200314113922.233353-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fdc0622c-fdf7-a39c-cf76-14dd2dd3ccfd@linaro.org>
Date: Sun, 15 Mar 2020 16:13:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200314113922.233353-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 4:39 AM, Laurent Vivier wrote:
> +qemu_arch()
> +{
> +    case "$1" in
> +    arm64)
> +        echo "aarch64"
> +        ;;
> +    *)
> +        upper "$1"
> +        ;;
> +    esac
> +}

I think you can drop the upper here.  That distinction is confusing.  Anyway,
it's only use applies upper again.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

