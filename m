Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A068C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8683D20809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FI5MJbBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8683D20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK8Um-0008Cq-8p
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 19:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8Tv-0007ks-Mw
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:10:55 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8To-0005Pe-Et
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:10:51 -0400
Received: by mail-pg1-x542.google.com with SMTP id g29so7268534pgl.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=mBbIriOKfWb6KBm1bCtu2UG9ugzVsEFTnnciII7Q9T4=;
 b=FI5MJbBAq9v4ot/1Ln6ym4hfPxdBldGOhcDCrC8BRWoqqro+GE8BTJo6uDgfTeamlg
 r2XgiPrVcb9PSGTcmqoN4Pj0ksFaukKw9O1mEcBOccs1zyKrFdK+pyV8aCDtPnqlAkHQ
 WY0vQBzdebcn3K9P1A2fco8w6PhN08bz/PxEOOIQPUeuIY7pJYwyJGpjRB0pigx/bsk4
 BxSq4TSqOV3xd4sIqJ7HZUMqYkYcpyrB3eZt36AT0EUTqALkNpd2QL7s0WV1CkfFdq6F
 SmRPUlCS3BBtpv90RBbX27FcZiIjKg5oFC6BTIYBAAjqpgMagKQrq4OGOUelE5wzSUE5
 6vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mBbIriOKfWb6KBm1bCtu2UG9ugzVsEFTnnciII7Q9T4=;
 b=kbkz5hQxw/GcuXJTdFuQfMvd1zVmnnJQPlMdmgXXvKkBBLi7AU0gB6dab/bMmpaXeh
 0T6bu92Z47294HyBCP0VK7di7hJUo5YNgSFggsvOpRFZF0ZSVGQ/zPn+ERA4GprOyNpK
 e+eCWtUg+C+mXBYWAtMdoXfBXP8/ecIw93M2HQiQwq9qdNKrkizk4XaDRtKq/q2WAM4O
 Z3LIVu8rzmpgGy1Jhfk6X/1VRabhrG+91XkiWWYjY1ZOD4bwhnfV1Ypxvqr/u/bnLlJw
 Eibe+AktzvWSOml2DJt268MQOxOR131IZIx3M6gX2OYUZXME908zDpsWIaCIw7C0MuVL
 Snkg==
X-Gm-Message-State: AOAM530Tdr0to591QcVrP1A+WCcdfhU6Re7HNTkOlgwLhmthAamN9FW5
 Gd7jpWQWTlCA/zX0NjDlaDUfKznTA3hHFQ==
X-Google-Smtp-Source: ABdhPJy9iK1Xf6O+0PueS0c0Ngz6Ed+5aPJAeTmrqZRJaWaO6Ty8+XjZ4NIfEqMM7wFm9AJwp9l6fw==
X-Received: by 2002:aa7:8ad8:0:b029:150:7d36:cddf with SMTP id
 b24-20020aa78ad80000b02901507d36cddfmr3708500pfd.55.1600643446105; 
 Sun, 20 Sep 2020 16:10:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id bb6sm8546312pjb.15.2020.09.20.16.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 16:10:45 -0700 (PDT)
Subject: Re: [PATCH 2/4] configure: cleanup CFLAGS and LDFLAGS for submodules
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920093016.1150346-1-pbonzini@redhat.com>
 <20200920093016.1150346-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c31f7fc-c4e5-7f81-e4db-8b5562073e20@linaro.org>
Date: Sun, 20 Sep 2020 16:10:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920093016.1150346-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 2:30 AM, Paolo Bonzini wrote:
> The -g and -O2 flags that configure adds to CFLAGS are only used by submodules,
> so do not put anymore the confusing CFLAGS variable in config-host.mak and
> replace it with more explicit SUBMODULE_CFLAGS variable.
> 
> There was also no equivalent SUBMODULE_LDFLAGS variable, add it.  This would
> theoretically help with LTO if we want -g and -O2 options on the command line.
> I say "theoretically" because submodules should not be linking anything; but
> since we were passing an "LD" variable we might as well get its flags right.
> 
> CFLAGS are now synthesized in the configuration summary as a quick way to present
> --enable-debug and --enable-debug-info.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

