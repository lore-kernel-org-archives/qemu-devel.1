Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97962C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD5820885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqT4H7A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD5820885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyTT-00063G-KX
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqySn-0005Sg-OO
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:37:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqySl-0003cv-9Y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:37:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so26569972wme.5
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H4lAOi0jdudNldy9T7erB2iyrG8uPkvf10Sc4D+gr0I=;
 b=eqT4H7A8Ctclf58N1CSAB9Ov1y/LeL7m4NvG/m+hYzk8olvnBF1e/2NsIP6/XrCIz0
 IZlE2Q4/H2yP6J2TTxMbJr9RldfT0T3yarAhZpQBvoetfyzEjaaWkgSTHCRDfTSKS50b
 +2wOdaJ/EIVYPyk+cwLEd7WKTAu1X+3adVfuIeHmh1/yelJzKAapeOqTQzAFfMaDR4Uk
 cTaqlibvCKk406VA2f70fP5rLxzkwpydqUKwC/2svUWh9DOu4HOL33fXhObKQK/mEVM+
 qv65Ynu0LAXPbo9XQUxSf3477g81z73duaqc+Tm3V4MHlRlizJnKStrhika/QH1R1Pd7
 gOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H4lAOi0jdudNldy9T7erB2iyrG8uPkvf10Sc4D+gr0I=;
 b=rg7bXhk7yEP7ZvvV0tIjzDorPSJM+YURBOhHm3cXCqkVe+5cQj8D/wVUALgpOE5NfW
 RFj7ubz3uyIr3aMsuuu0wa4qQ78YdYTFA4PGjI0cL0YXsibrHjKWBrKIMUfh0a7+BhfZ
 FLaYiD0O7eJlQPIQKBQTkO2PAJeFzkZUBc3NltCE+r/6wp8hBzeriyyBloL5Urt2ZbmD
 OdZ5G8K8PA7qS92ReirzER3UWmoECiJebRW8VTl9YR7Hs7G6FznTT86Ht0tkX2QkxzGi
 it0l+VIYhjPmtySsvxAHTgSDqEDcF20itiCUsUhTFlCdQoEKJ1tMFzIcEpG4KkFCkFfY
 IRXg==
X-Gm-Message-State: AOAM530BIkpxja4e3vokee0MnUuoRQrltm9sAn5ph8w9SjqeD8bxmpAP
 ZOjKAfYLnVyJ40IjHl+XgRo=
X-Google-Smtp-Source: ABdhPJzkUo3lG8n3k1V4kOD8MDFB5CBlzQXNppNgINVoRlwUTYFhpX/OQSerDj2La7z+beJxfE9WIg==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr33144569wmk.9.1593693427112; 
 Thu, 02 Jul 2020 05:37:07 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x11sm9978551wmc.26.2020.07.02.05.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 05:37:06 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: update linux-user maintainer
To: riku.voipio@linaro.org, qemu-devel@nongnu.org
References: <20200702111636.25792-1-riku.voipio@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <10cbb5a0-fe6a-3163-2a9e-c0f81f7bfbb5@amsat.org>
Date: Thu, 2 Jul 2020 14:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702111636.25792-1-riku.voipio@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 1:16 PM, riku.voipio@linaro.org wrote:
> From: Riku Voipio <riku.voipio@linaro.org>
> 
> I haven't been active for a while. Pass the maintainer hat
> forward to Laurent, who has done a stellar job filling in.
> 
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>

Thanks a lot for your contributions Riku!!!

FWIW:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git MAINTAINERS MAINTAINERS
> index dec252f38b..29a23b6d3a 100644
> --- MAINTAINERS
> +++ MAINTAINERS
> @@ -2629,8 +2629,7 @@ F: bsd-user/
>  F: default-configs/*-bsd-user.mak
>  
>  Linux user
> -M: Riku Voipio <riku.voipio@iki.fi>
> -R: Laurent Vivier <laurent@vivier.eu>
> +M: Laurent Vivier <laurent@vivier.eu>
>  S: Maintained
>  F: linux-user/
>  F: default-configs/*-linux-user.mak
> 


