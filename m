Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A52C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F372465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efJ1U+v6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F372465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqdo-0001k6-00
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 16:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irqco-0000uL-5v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irqcl-0005Lg-Vq
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:54:52 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irqcl-0005Kw-P0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:54:51 -0500
Received: by mail-pg1-x544.google.com with SMTP id s64so8817528pgb.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 13:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P5AF25iR5YcTp/Ch3FrHCMFiy/2zmVsTfVD+N8NKyxw=;
 b=efJ1U+v6k5WSNDwJuRS8F1Ah+rRYCHK8L9KYLZ/jVb3S65KcyyfRm6wlQXGWumHm2O
 pm6R5iB5ex49USTAno1WnF2v4uDFsG9oHSAXz9i+RAH+OytVs4qC8snO//eGJQxnhb7l
 iXRgMUbwsnrBt6vok70PXrU0XTgRkozvdv7NP+1Ku97hVbIvIDVGiYn4Zu2PE39YyT54
 aFzCPDeu5/bSXAgs1qNp0KLjokbvzrq6qDjxXDvxKyszSskffo3ZQBS8zogflSlypKBw
 fYrOAPjZHK5y4qakCPifPvewu7VxXmEapzWuuZSJkp91z5vqfuJTSQmzyK+awA1dUM00
 iS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P5AF25iR5YcTp/Ch3FrHCMFiy/2zmVsTfVD+N8NKyxw=;
 b=BKAdLo7p/ER8TeBEzCNsz1bf31n8w87bz4QkuuB4bsFtizlHj2dj4vcQ5L6U243d9h
 LQbbCLeFxCthe9QFhFXxTP/WMJL5aOIPsvGez+ARG8b9aMh4Rhx+KVMQbY+U3Aux5Bdr
 KU5HNaxaehq8XVXzzgICsqkqwB+hmUzKMTUf7hmL3xF8y//vH1hW2U/5vn5QtLx+GmCE
 cx62HWdtHkL7xnpw4NacZ6uiCxMzrWXjzaX8u2+sfXPSjF3THccttx6A/aLiEeBeZrDg
 DRwQ2gVoF34BY5wPuElmwMB5tzCUf/uL4FIoj9B1tkq5FYuNXAW7aJNWl5idgj9lcIjM
 nF/Q==
X-Gm-Message-State: APjAAAVYkvD5vTERFyjszoO/HyhIhfHaDXCZQ3naNqG+yTv47sZwFkqR
 n8nQ6TRDfpY1k6lSIiClgzZ44g==
X-Google-Smtp-Source: APXvYqytjMbIwcWrs48B+yJXmSZTcrorMRV2Fw6bBRBBs2c6W+hrlFmmo2PAddG6BuXdLIOKVAr53Q==
X-Received: by 2002:a63:e4f:: with SMTP id 15mr33961313pgo.398.1579125290554; 
 Wed, 15 Jan 2020 13:54:50 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id m101sm761461pje.13.2020.01.15.13.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 13:54:49 -0800 (PST)
Subject: Re: [PATCH] m68k: Fix regression causing Single-Step via GDB/RSP to
 not single step
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200115110359.1885149-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <577e6e33-bb6f-5925-a106-304b678f3d49@linaro.org>
Date: Wed, 15 Jan 2020 11:54:45 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115110359.1885149-1-laurent@vivier.eu>
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
Cc: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 1:03 AM, Laurent Vivier wrote:
> +        if (dc->base.singlestep_enabled) {
> +            tcg_gen_movi_i32(QREG_PC, dc->pc);
> +            gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));

This leaks the temporary, and so not quite ideal.  It would be of more concern
if the rest of the m68k port was audited, so that you could turn on leak detection.

I would suggest routing all calls to gen_helper_raise_exception through a
function (gen_raise_exception, usually), which takes an int argument, and does
all of the TCGv_i32 management internally.

But otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

