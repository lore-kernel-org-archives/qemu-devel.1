Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501A820737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWuk1Mtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501A820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkqd-00014t-JV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 22:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAkpv-0000DX-De
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:06:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAkpt-0005uM-MO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:06:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id y6so154954plk.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 19:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HF8dLwqsnKvQs3BxsargpvOGSOtQRtGOQ3qSBPzH408=;
 b=dWuk1MtdUkPTBdDgFltp387JoLwVQyc8VWOAvlmrtrlpvIASHu6W5hj3Cc8RUYPyS8
 mCzuPRifoEym6P4ZfiNnRM35pEfGYuZnNG6YFiba0h4GRiiHZF1LDXPUG6JB4O6nd5TP
 ltMN9F3zSjAvEhaOwCv2r52SAiswK4IRd5j+HXDZLE4vXSccihR2XqnAO6Eoh+HIlV31
 rmtLxpDFpqwZqyglS7vtPhSSkJ59w3ZYAHZR/HpkR5n4mk//f88QSYz5Poq03C0eVdnc
 +Al64ZH+aTqs0m+1D/Dx2hmeQE8EiLfCTlnVaI7Npe7oAewo1XI1q0yNhArKw/M5Kyhv
 IRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HF8dLwqsnKvQs3BxsargpvOGSOtQRtGOQ3qSBPzH408=;
 b=Chf2B5ZCvQrrd+cx+9xHSkDbkIpRAC9k/EodK7HYH/B7Ro6i7lggpf55mQqqRzH2DG
 zszBma6uf0hJRcToU7Z8DrwuygaH3FyqNqtiyk2tgaB4H6lAZfDIN0tUVPTPLbfKqyGE
 GZSDPxfBqkuT6DSSyEM82e2jen8uLCjeXd5rKCSrB4kJGT7zG9Kpk0+Ly1A/amWUUv4K
 OdHXsJ9E0rOVP/1n4mDTwtPDrvyoyAmqEHu9qcm+nLVVcx5URCj0pbbrnO5U5JO6vRiS
 MRIAc+kH9QACV9A30gEEqiT2N4cBcNxhzutDrwAp+Ly2cQg/Lo1RgUCqXslI8z6URPbH
 ROew==
X-Gm-Message-State: AOAM532+zXw0W26hkJijkkroMbVZk9e0FRc+s83W3UhnXHzt38V+4WJj
 ulBF2yrAs2nle46eS0/Yb7ZbOA==
X-Google-Smtp-Source: ABdhPJzDi5KHIbMNrdGYYsIBd6sv3gX4qtkPgsNJyXFS4vCwUoey8qPQIofRhGwRmzBIRWUhQtyXfA==
X-Received: by 2002:a17:90b:3641:: with SMTP id
 nh1mr3882667pjb.157.1598407608066; 
 Tue, 25 Aug 2020 19:06:48 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id a20sm590636pfi.11.2020.08.25.19.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 19:06:47 -0700 (PDT)
Subject: Re: [RFC PATCH v3 03/34] Hexagon (include/elf.h) ELF machine
 definition
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-4-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66858372-44e6-d0b6-49d7-82777d81236e@linaro.org>
Date: Tue, 25 Aug 2020 19:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-4-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Define EM_HEXAGON 164
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/elf.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


