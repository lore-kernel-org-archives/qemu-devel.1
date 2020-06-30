Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44360C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D34206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPjmTkFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D34206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCM4-0007OA-OQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCJ1-0001Tt-Ne; Tue, 30 Jun 2020 05:11:56 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:46890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqCIz-0004CX-Q2; Tue, 30 Jun 2020 05:11:55 -0400
Received: by mail-ej1-x644.google.com with SMTP id p20so19705681ejd.13;
 Tue, 30 Jun 2020 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D9mdRQwdC5EeawapV6J9Zhfd1oXOQ1bzYAweYGrslB0=;
 b=mPjmTkFGyKcqjBGHNQL/ybRic2qOU7jfupN2hoPT6OiXntJtBmGobch5q6ddaofksM
 0S8ov06nGUcdaVb49fwF2BaKpQU6hjwMI6ARFyfE5ajPIRK7AHG+GgZOydThtAQJlWgK
 nOKxVft8dYCzDbA1ttNazCXSZ/jlSkcWBsTSFYu+wHFol+b/hS05A+FnFiD2lejG9UN3
 49BLFBhozBbhxpdfe/wI94YLsgWi8r+8SeaXLDKfN3WBhfWlJmIBYpLhbINR3xVfgbep
 kEooP91hGH37d9PptFdxsd3Yt7E+VEhD1Yflk+1IOMCPADLL+Q4UOhOdGCkxdqqzqH4L
 zZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D9mdRQwdC5EeawapV6J9Zhfd1oXOQ1bzYAweYGrslB0=;
 b=s8aVdO+0SVGTczEOaqDqDh1m/r1+89XEouaTwOlWyHQX9zBFCk/NxmbsJHvz8oIHOo
 iM7frlM9z+bmhvn6NYcRsoelM4gUnKJgyRTIWtJaKICXChBzhtpIc1uWqer6wVatYn1o
 EPhOgw8AURagnaWZ9MLTC0NegcySGucDpLHwLEYsY5WvGgehWdFMo2kL4JvJ0u4+/kLY
 seomwCpL6TbvGf4jC0t43zhrwt1XZGwNSCYwVZzKmVhMTSsknjkEMNs0VYUX6rJKPqvz
 iJQupfYAhlOooRfV2awngVV7bflRiJcIpNYEnnq8gmyDR2bMCKeIc+4094+vuw5oGAav
 L8tw==
X-Gm-Message-State: AOAM533MkiQsx/zYP8xyOQQqLvjTdiDVjCAVjKrwIu8I71MZP0Kk2O2q
 T8tOzKW+y2WKZFcVb3LOk/cyrpouy+M=
X-Google-Smtp-Source: ABdhPJx4IUyki2vnUYKTEG1SxAtDntt9j4qZwsf0KDgrt64egUoVkWbBipSoM3e6LhEIbgIpsbyWFQ==
X-Received: by 2002:a17:906:1499:: with SMTP id
 x25mr17153476ejc.406.1593508311814; 
 Tue, 30 Jun 2020 02:11:51 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v5sm1562164eje.88.2020.06.30.02.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 02:11:51 -0700 (PDT)
Subject: Re: [PATCH v3 24/26] hw/arm/armsse: Fix armsse_realize() error API
 violation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-25-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <943dbf9e-71fd-c53d-46d6-c19e7e4a000b@amsat.org>
Date: Tue, 30 Jun 2020 11:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630090351.1247703-25-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
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
> armsse_realize() is wrong that way: it passes &err to
> object_property_set_int() multiple times without checking it, and then
> to sysbus_realize().  Harmless, because the former can't actually fail
> here.
> 
> Fix by passing &error_abort instead.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/armsse.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index c73cc6badf..e2cf43ee0b 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -991,13 +991,13 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, 0x40020000);
>      /* System control registers */
>      object_property_set_int(OBJECT(&s->sysctl), info->sys_version,
> -                            "SYS_VERSION", &err);
> +                            "SYS_VERSION", &error_abort);
>      object_property_set_int(OBJECT(&s->sysctl), info->cpuwait_rst,
> -                            "CPUWAIT_RST", &err);
> +                            "CPUWAIT_RST", &error_abort);
>      object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
> -                            "INITSVTOR0_RST", &err);
> +                            "INITSVTOR0_RST", &error_abort);
>      object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
> -                            "INITSVTOR1_RST", &err);
> +                            "INITSVTOR1_RST", &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err);
>      if (err) {
>          error_propagate(errp, err);
> 


