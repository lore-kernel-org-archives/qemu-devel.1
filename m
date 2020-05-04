Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B618C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C262620721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk+l2J9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C262620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVemZ-0005nh-V1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVel7-00041r-EJ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:20:02 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVel6-0003bu-GZ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:20:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id y25so5844059pfn.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zZVm1hsjJOS2dQ7dW9OoeOwkjogB/hb3t0l+Bm65tww=;
 b=Fk+l2J9Mh1hmrDmclYjn054qX72sK8aMp/F7IAEOcQtXIjRCiqQl0Hh3O/Wkn7xuuv
 ys3+QsA3+gMGp1JjRZELYsevpWycniQQQRg/WB1yoZ0CavoiFFBkxTtv99OYWNBkxM32
 Lqrn+DRMr7lzL6OXOU2wW+/MXdsaB4EFWzwgphpjMyM9/k50Y7gcfEEvgcyosA6GpIDR
 NP0dEHx0+5cuI4SLHURjQFlNPkcxYNz1jAv0ePmcH3if1fn6duX500lH9yRGswtNnvdh
 sQAmcBicho5fLrrJeSDFuGhdQswZGKTLLdXLSl77yuQ8cmQTcqVYCdsCl4DXYA2krtlg
 Bpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zZVm1hsjJOS2dQ7dW9OoeOwkjogB/hb3t0l+Bm65tww=;
 b=kGwd34Esh5Rgo9JE4aUIOgWMEc/aToaTApoXxu7iel3Bkx/+broEfuzWnXTTBISayq
 Al88QXjmYyU0pLXEDTBCKpD12dOZxpOAMDGrtr6jeWE7vkG+w0vUVtMdWno44cT5PT71
 y/V6FOvuWFCefV35Ya56lFuXz30drokSA0RzeV7hIxms4kEAVYJ0I0LekOEX+nsn2hLD
 w5qbLt/nT7tt/ryiAIjwBaksI43+JC+r4ohLRs9fYD/ivJ2e6u9xiexSO0UYTgd8Ifen
 94X/oBdNhdFym0X/KxiZWXbWJjZ/pzikPyKR5Lw6n/R6mUeR++gKj8Ic224h1JcZ9p8D
 FdYg==
X-Gm-Message-State: AGi0Puawv9zMJfwNscxejgHAT/QCGLqvYp5xN/Ftoio35aS4r5b24W0L
 ZJgNnh5JasNcD4LOqZCDfJFp5g==
X-Google-Smtp-Source: APiQypJtK6ZbyvcZHHYS2rPDtF+Za+aUjBzuVzWqoMBgQl8H5jWo9waeYtCBpHG8A8zjpaqt81uF9Q==
X-Received: by 2002:a62:2cd7:: with SMTP id
 s206mr17912726pfs.183.1588612798895; 
 Mon, 04 May 2020 10:19:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a23sm9286109pfo.145.2020.05.04.10.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:19:58 -0700 (PDT)
Subject: Re: [PATCH 1/3] hw/sh4: Use MemoryRegion typedef
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504081653.14841-1-f4bug@amsat.org>
 <20200504081653.14841-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1fda6a7c-3b29-3a71-5143-a61b879477c5@linaro.org>
Date: Mon, 4 May 2020 10:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504081653.14841-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:16 AM, Philippe Mathieu-Daudé wrote:
> Use the MemoryRegion type defined in "qemu/typedefs.h",
> to keep the repository style consistent.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/sh4/sh.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


