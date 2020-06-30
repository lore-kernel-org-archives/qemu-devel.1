Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A12204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP0T/bM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A12204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCUi-0002XR-BQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCLs-0007jI-8Y; Tue, 30 Jun 2020 05:14:52 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCLq-0004Zr-Mn; Tue, 30 Jun 2020 05:14:51 -0400
Received: by mail-ej1-x642.google.com with SMTP id lx13so1096178ejb.4;
 Tue, 30 Jun 2020 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9HsxS9NEhWP0zB6QcuRaQWpE6vWLicWd6QnR/7/w+mc=;
 b=sP0T/bM+UiaSzpgzdiWGFIqgD3NVBMy8LtZ0tFgfNLkW/Ms0nDq8ToIqdZ600JCw56
 a3k9R1ulhd2SnEjVBIkDmdq5aa5yJSUw3lk2IpvHCGHNnJr1FEgNWAy8CE6Kw0aOJ9CD
 KPDF6Be1H9jZ6ctGEme8uwGoKyYu8V0NKnEWO39sKINYxgFes5iGdwehS6FBudTw8zFo
 F3eLy/WR+RwZZsgiaOJph8twTX/MlnA8AfJzvozOfrINWxAKbr9FkKSNSslT06Jqp+q+
 MBFW6x0PdL1694H/CHMkpVnEGY07YNTeTqSsrnzUBtcMQ6cuP3vCBZvDS5zSjJDEGvDZ
 qMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9HsxS9NEhWP0zB6QcuRaQWpE6vWLicWd6QnR/7/w+mc=;
 b=rYo8MdHkBsw8pdGM45BCejk2gMfaZlvss+PeyqDf57YqVCNlC6SYxn5TIb8/CE0lp2
 rof1bb7OK09YwQDaqMDj/bt2vwUHLa0u+xkH2HPOAYzujLbPduBHlOIo73hHIA+gXPSj
 N7dA6PJNB1kVcm1DwvgrenzUq2y1Z6lM7tBIeIIIDJZ+4eNBdzUf5TP15aaW7mZQELAH
 gquMeHp4ARL+AgYwLvLJ93poOzAbtzNyTBNljwl5zj7yiroR+L7OQPJdPLs18pAi6NsX
 DX/z0yKogsDXVFal6OEPCWap/cvQjnCtYbzNaZw87YCR4pGd1JvchptS7RQ6ZTei9B6Q
 0Xqg==
X-Gm-Message-State: AOAM532OIJlIPTsoa0eZ+Tz+wkdNwq+c5lSB7H9vzHVk4e92YbiNsTK4
 91oGjfSZhud+WvnfIG+BOu58xfn2fww=
X-Google-Smtp-Source: ABdhPJxm01j/d0AwevTU63y51ZKANCl6gohav6rVNEmpk45k6pD6moAB7FKpg+hbQy6Qvqq/pXBf1w==
X-Received: by 2002:a17:906:b353:: with SMTP id
 cd19mr9829732ejb.395.1593508488688; 
 Tue, 30 Jun 2020 02:14:48 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l12sm2400047edj.6.2020.06.30.02.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 02:14:48 -0700 (PDT)
Subject: Re: [PATCH v3 22/26] arm/stm32f205 arm/stm32f405: Fix realize error
 API violation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-23-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1c6d230c-cddb-9859-0a53-723db7c52e0f@amsat.org>
Date: Tue, 30 Jun 2020 11:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630090351.1247703-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 11:03 AM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
> 
> stm32f205_soc_realize() and stm32f405_soc_realize() are wrong that
> way: they pass &err to object_property_set_int() without checking it,
> and then to qdev_realize().  Harmless, because the former can't
> actually fail here.
> 
> Fix by passing &error_abort instead.
> 
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/arm/stm32f205_soc.c | 2 +-
>  hw/arm/stm32f405_soc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> index 19487544f0..56aef686c9 100644
> --- a/hw/arm/stm32f205_soc.c
> +++ b/hw/arm/stm32f205_soc.c
> @@ -154,7 +154,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
>  
>      /* ADC 1 to 3 */
>      object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
> -                            "num-lines", &err);
> +                            "num-lines", &error_abort);
>      qdev_realize(DEVICE(s->adc_irqs), NULL, &err);

qdev_realize() coult take &error_abort too then.

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      if (err != NULL) {
>          error_propagate(errp, err);
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index c12d9f999d..cf9228d8e7 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -172,7 +172,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>      object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
> -                            "num-lines", &err);
> +                            "num-lines", &error_abort);
>      qdev_realize(DEVICE(&s->adc_irqs), NULL, &err);
>      if (err != NULL) {
>          error_propagate(errp, err);
> 


