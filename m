Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16A8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7AF20760
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehxEtIlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7AF20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLMe-0007WY-Sp
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLLw-0006pF-Pa
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:52:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLLv-0002oo-AS
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:52:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id s26so7614414pfm.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dup6cGDRjnMJ1zxD6x6v7WGZ32JA0lrSdl91CJyE0KY=;
 b=ehxEtIlcCCLxl7TevgbK10ofLL5/ObUEXZgFS5N0v3r8DGh+xIc1sbA2vgFW/oPQQo
 fMTkmItIAhw6dcb6mGCXW8sCKeJQoEiCV2x7afnhWC8HDlLl6fmHn1Y+l+VtEwu8xqCF
 TnuNJS7q11Dr6ct8mwkulE9bXjoZlDlET8A0qjgd/7jYRwNjpgTUIatBdrIgMXx/6uaz
 +i8iIp8b5Ak5Kmh019n1Pffv7Ngi4B536bBNKvuSxGoqWGIa7izGlNGyNB2VbPsVV9KR
 qPHxIiq7k06yvHHIyi+UnKorNq1nqf1VXL+hSxy5X4K9lXebYEtMvG9KTAOS/UYRAUm4
 tYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dup6cGDRjnMJ1zxD6x6v7WGZ32JA0lrSdl91CJyE0KY=;
 b=jFsiJUoxE3NuDUg4fnoOPDHtTlTZZQyObHD3GjrnwaMk9hZQ1wEOvubXfrtKlD3I66
 CzT3mx3asCDp+66ipAwPOejl0bQcq4+I+D4o8LuWlw0Rvj97UHVIJ5fUcVqOP3C8Kt5J
 HSG8aye2xO+z7a+ygEcUqG2H4BuyDeu2nctH8OLFkvb3sc/vigJFu6vb7AU/mEZaTGk4
 uF+gcDNatGl4n645WUkVMkonDozlu1xjX+tzJsjT9m7J/6ne9D5S5JRnuqFXVoNaLED2
 VwrGg6FXeTxLkjyFW6nfj0wxtgkLULh6LtTGEqaBw19dFe9GSBdnserz18sLSR/7CMoK
 tKvw==
X-Gm-Message-State: AOAM533S1BCTDhSF1tA3impVcKo3lsRQM0hbR4Axv671+sVitOve34+p
 Cg/VgxFQxPDW+kNuGeO5n6KwKjTfT3I=
X-Google-Smtp-Source: ABdhPJyWjbq11fBwsO1YVSJftH8LIbAzbwInZl7D2IjhY+Y8AEYkAmiFhULtlBbCGZESzW9Afix/vA==
X-Received: by 2002:a63:7313:: with SMTP id o19mr3570265pgc.307.1594734729836; 
 Tue, 14 Jul 2020 06:52:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id e20sm17698596pfl.212.2020.07.14.06.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:52:09 -0700 (PDT)
Subject: Re: [PATCH] hw: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600444-23272-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <275c6780-78a3-3bc0-3be1-6dc2f1305088@linaro.org>
Date: Tue, 14 Jul 2020 06:52:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600444-23272-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:34 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  hw/block/pflash_cfi01.c     |  1 -
>  hw/display/cirrus_vga.c     |  1 -
>  hw/display/qxl-logger.c     |  2 --
>  hw/gpio/max7310.c           |  3 ---
>  hw/i386/intel_iommu.c       |  1 -
>  hw/input/pxa2xx_keypad.c    | 10 ----------
>  hw/intc/armv7m_nvic.c       |  1 -
>  hw/net/lan9118.c            |  2 --
>  hw/usb/ccid-card-emulated.c |  1 -
>  9 files changed, 22 deletions(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

