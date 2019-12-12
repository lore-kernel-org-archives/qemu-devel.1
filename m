Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE25B21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hj7iUN4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifGGU-0005zF-Vu
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifGFo-0005QH-VB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifGFn-00075w-Rp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:39:08 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifGFn-00072x-Kh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:39:07 -0500
Received: by mail-pg1-x543.google.com with SMTP id k197so466654pga.10
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g/0+fqEyhiq6ASPNGWf9vLDy/5EwwqqcMrlBqNUmLtA=;
 b=hj7iUN4pV5zPWdMOx7V+DGFqsG3pzGRPsKwD9zT/3rR33ZIhY+4PmqyCn9+wR/5oTx
 rVEHAndDA02TXobJAK7U7KJJhF5DbkKfec1/K6Nog32OwuySc32DqE2KbxQ8vPxszraU
 Zi+GU8AMTcqeOpyl3DtmokvMa91gyQFm/npPdF+0kXUkZlJhlpNRmsx05r2sAR5RmCrk
 gSws7jO8cBDiX6hRVfxjhI1WkOPnZQlyr2CpmOZxxE14Iffb8WD/387lvCwBWhvO9+Oj
 gR6NUQCsIxeMcyF+zovSPi3I1eFQ7sY8ZTwI06FcLA3wrFdiXemI3lE+L1KtLiWm+JEV
 j09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g/0+fqEyhiq6ASPNGWf9vLDy/5EwwqqcMrlBqNUmLtA=;
 b=Z6b28Q37okdEt1zR2uA4HNsP/QcwQ+GBpgRiVt7T+bQyDJHwnkBqUAh4FKtI7ghbKQ
 YRJR+PysewuwRudL/NXbAywO3Fzv/wPJAGh/gJBfsVl0Dq1jyv3Uh9zKr1Y3A9gFLw9x
 3Lnt3vBsMOq6x8f4VOXFOriLD8whprCkkvrr/34VCAA3f7mJnjR+3hfE+ee5Yz2qZscy
 X4FGOCxUcl37nzBuhAcc2GCPE/eSW1P5NxVOnM9Bpu5FQDLf9j1SxVzkzp3YMyxNx3La
 h2saxq/VSzzvIJ0NipnQ/KMZVfnL1/TvDrOOwZeh8EWSsxDYTIt9TkrT2MwpxTZIvVNX
 SEAQ==
X-Gm-Message-State: APjAAAW6UCe+7r9d6V9oeWotQp1ZgIJ4ZQtCqYHxFr2wOiuAwSh8QHAb
 G6UucWt/D6WFcjnT2x332JoFdg==
X-Google-Smtp-Source: APXvYqxctGMEzDt5OfVoHGCB7EeKoOH0GVB9MCYIdsN9fvykQrd7dbaQKvXLG1N3KnZFtLyjbM4ZdQ==
X-Received: by 2002:a63:f70b:: with SMTP id x11mr8358270pgh.80.1576125546335; 
 Wed, 11 Dec 2019 20:39:06 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b129sm4820086pfb.147.2019.12.11.20.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 20:39:05 -0800 (PST)
Subject: Re: [PATCH v2 01/18] memory: do not look at current_machine->accel
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-2-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e2544e6-f74a-956b-9692-b9ff1c964f0f@linaro.org>
Date: Wed, 11 Dec 2019 20:39:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 7:01 AM, Paolo Bonzini wrote:
> "info mtree -f" prints the wrong accelerator name if used with for example
> "-machine accel=kvm:tcg".  The right thing to do is to fetch the name
> from the AccelClass, which will also work nicely once
> current_machine->accel stops existing.
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  memory.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

