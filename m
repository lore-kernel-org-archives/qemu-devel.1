Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7D420748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJYVyao3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7D420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iboFh-0001tF-Ka
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iboF4-0001QW-G7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iboF3-0003I3-D7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:08:06 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:34059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iboF3-0003HY-66
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:08:05 -0500
Received: by mail-pl1-x635.google.com with SMTP id h13so120738plr.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N4iwl6gO27U0OW+8kRHtJsgDrHGzcB40YvGn9zm5cj8=;
 b=ZJYVyao3d2/IFEUV2y092K+jQvxIBdGEYQqmgDq9LDI2L/zGr5n8xcHAyMWkkaYjaP
 Uzkv2qhmTqcGJw238JRGnLT6R3ZWORi5RGqzsTn8M1tNnCV5tVPCzg88W/nxFRtfcmU6
 YhM79gLe7RaT/LaJ9bvX4j8r/wMTSF4emub1cPmr2darKltN52m3+/0nhQvT+O0XDTPr
 CBXlAHiAJKJjCKQF0PytvsUgT0cAQBS4CCO5CSaZ4r2o1I/1vzLhGWKPKqSlakC93xo/
 x4qKlrdTAKuxYq1reiX20UW8VpyXJYB+wRjkWNm7y6Yf4MqciXyNNAzm0AVtF9CkU53P
 a04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N4iwl6gO27U0OW+8kRHtJsgDrHGzcB40YvGn9zm5cj8=;
 b=fgG/boyamzr8i2DvKtBf961D5k2Z+YRzyGXRwVYvAmZPOUJKYI5BYJlQ4o4qQ36hEr
 TFokoo6L+PUk8JPeXbfTY322fuWanF/a6LwQgOjo/N0g0+o7OHwrKduWdhXkZvc/kM5R
 G1PmdYckA7oDnVBLKDcSpI4CNHUoP6Chz727Qucjk/0JtjOxfIzMnDK6cpChv5wCEG0C
 /3X3EaXB9h6E+8tZJwpKU/H6c8tMQ2pg+q7aL9gTyxSELumtsvZyUVLSBeVi4AdidL43
 vTfpvwClGfPVRdrRBt0yvKK5unfvy4Vq9m9aXoY0IxzHctBarW+zVif8Im+nuL9SiEjk
 OFnA==
X-Gm-Message-State: APjAAAUjNYFWGr0n3dqTNNNU2FLBGTCHQybTyKu2mngqrou3VUUbPJ0d
 fUq9FxU0hLXuZ3Tn9vqnFHzHKQ==
X-Google-Smtp-Source: APXvYqwflwYRyJ+Z9qOLHBXUR9Jt31rtAB3K03oseTE7CEaieUOC46bo8mSdmXQxgCe8UAIWzvHaIA==
X-Received: by 2002:a17:902:b70b:: with SMTP id
 d11mr27549776pls.48.1575302883800; 
 Mon, 02 Dec 2019 08:08:03 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o124sm36352821pfb.56.2019.12.02.08.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 08:08:03 -0800 (PST)
Subject: Re: [PATCHv3] exynos4210_gic: Suppress gcc9 format-truncation warnings
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20191202060806.77968-1-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b490fbe-2b09-2a2c-16a8-6739ce6a847d@linaro.org>
Date: Mon, 2 Dec 2019 08:08:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202060806.77968-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
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
Cc: i.mitsyanko@gmail.com, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 6:08 AM, David Gibson wrote:
>  
> -    for (i = 0; i < s->num_cpu; i++) {
> +    /*
> +     * This clues in gcc that our on-stack buffers do, in fact have
> +     * enough room for the cpu numbers.  gcc 9.2.1 on 32-bit x86
> +     * doesn't figure this out, otherwise and gives spurious warnings.
> +     */
> +    assert(n <= EXYNOS4210_NCPUS);
> +    for (i = 0; i < n; i++) {
> +
>          /* Map CPU interface per SMP Core */

Watch out for the extra line added at the start of the block.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


