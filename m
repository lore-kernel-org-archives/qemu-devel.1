Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC4C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7797D2070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cr2FzRNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7797D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2GV-0001d2-K1
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Fp-0000z6-GG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Fo-0000ZE-Gs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:43:33 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Fo-0000Xm-By
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:43:32 -0500
Received: by mail-pj1-x1044.google.com with SMTP id j11so463637pjs.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n4KRq0iVYMZ1ZUExiPG20dlEc9tkNUHT9Cu9seAfTfs=;
 b=Cr2FzRNjA/Blb6c0Sinrdtr0wyaZ3cHF+c9aQ5Vq3UM4YXMeDAvUblcxvJcxjf8LeN
 QMSMvfe9rUW9636zMcwqXnS0cmiGxKOwfHBMYFJqNcaLVZx05XnzQN60U1LNio6WsLhx
 CBaSvNM00ttJplnWrqcQtDnesYdy2lpApsUuyNbRSAruLLFlCMTe4rMnTL62PirJ5V/c
 wZYuom9RW1gLGBNDiPqKqXnnfAYiPv7/EIyFJsJcyCbCfXVZc2ZHU6OZstyr5338UPAz
 y+lT//Viu8ODJ7SbEDqM+zfR/ipN2Gc/A+Bt7LJtTRQa3d4Mco+s81T25kZ7WELpcet0
 Ne3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n4KRq0iVYMZ1ZUExiPG20dlEc9tkNUHT9Cu9seAfTfs=;
 b=HPg2KijoFO21VZaakTppbY3CjPXva97SY5Mzn1VygLo6KQ1vp8p6idMvSctA6QNWaW
 QIAm64pMWHWzdJaHWd0hnweFJVEMwc0qe5ldlS+PGf2WvwOWgI3xKW2zhpxWdqraQHGv
 5qv8ANM21ohTj0fEl71L+jcfo9dmOM4WVK4nt/08tx9NlubCsVN+mmmSzbIj7WWj+RWp
 PEsPe2Ml5PCvDuuLmSYEpNt/8+JYa2vvPfvyG70c/vi+xmqel+d0kZhbMJbI/pxgThBo
 A6/sFXY7hRBlwSrIc+DG7BY7xN+FphlFS/J1zHuLC0UBCAkde5caiO3Il4IVlNdD0SNl
 9+0A==
X-Gm-Message-State: APjAAAVnEbMdCkH79C0HihafMXtSXpOKcsuO/lwJ12Q/8F6dxBhABPza
 5rdxWBPb/wLP2PGIs3n8LFYW6Q==
X-Google-Smtp-Source: APXvYqxkW5J1QX7FPiii7GhLBDVZw2J4tqeaIAx+/JCNb13jbWfUXjbnA+P60neWfeP2ywY5E7AoLQ==
X-Received: by 2002:a17:90a:20aa:: with SMTP id
 f39mr2134589pjg.35.1578455010013; 
 Tue, 07 Jan 2020 19:43:30 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id 203sm1101880pfy.185.2020.01.07.19.43.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 19:43:29 -0800 (PST)
Subject: Re: [PATCH v2] arm/translate-a64: fix uninitialized variable warning
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200108023915.52288-1-pannengyuan@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f024c3a8-6685-e37a-c53f-44c6116d3268@linaro.org>
Date: Wed, 8 Jan 2020 13:43:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108023915.52288-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 qemu-arm@nongnu.org, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 12:39 PM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fixes:
> target/arm/translate-a64.c: In function 'disas_crypto_three_reg_sha512':
> target/arm/translate-a64.c:13625:9: error: 'genfn' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> qemu/target/arm/translate-a64.c:13609:8: error: 'feature' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     if (!feature) {
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - add a default label to fix uninitialized warnings(suggested by Richard Henderson)
> ---
>  target/arm/translate-a64.c | 2 ++
>  1 file changed, 2 insertions(+)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Given that you are using -O2, this should probably also be reported as a GCC bug.


r~

