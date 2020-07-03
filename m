Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBF4207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3VV2i59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBF4207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOio-0000e3-9Y
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrOef-0000vZ-3t; Fri, 03 Jul 2020 12:35:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrOed-00009x-8t; Fri, 03 Jul 2020 12:35:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so33366187wrw.5;
 Fri, 03 Jul 2020 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J9fEYD4ab0vzqkQT1cWscq34B3z+iFCmm3a29FrbHVU=;
 b=r3VV2i598oUWCnEvGs2rfvD3+26DNM4PzKiY+zyAolMgbMgQwZ5LdfP5eXnLz7rVmj
 gwwaak4kLeDxsUGMHlPRQ3uZvWHaX6uSjtlzjLdcTrcpDLYegO1QRD29GEhtpZ+EeUHP
 7Z5lMs5/50amTkByuO60O48DuVNe8Zt/n7qSCyypHMIzqm+wrSOGcsmkzIjXHGW8UF18
 YAiZnf7n+5ICfLExI380eYK5hJ/etbPRd0bVwxuptAA/A9xtMMxpgtRvWdjJOt8RpMux
 cIKUuc9QlZiXROita2ZfO0tptotdeovKbF+u8PsL3ye10rTMAz8PVzclh6P0OzFrvMB5
 d8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J9fEYD4ab0vzqkQT1cWscq34B3z+iFCmm3a29FrbHVU=;
 b=bariaGZp47lXDEKLL1gTDuOeXSc+sQED/E9rb09THxK/sB8hR8x7YsrC+gXxCxx0Ok
 QzBriY4Dcori+dYwx2cqU3eZ9ZEw0oey3OYrkcgKUco8jWjvIut4wngLEYDN9zHLLd+d
 6k8/5KVSOMvQCAAwlRY3GmialiwwR366U0/eKfvN/njovSTTdOkqOlEsE69MW3KIAxs5
 Z1Ywwfo3nyIgCSaovgB4FU+AVWEg7MjsaznFRlD3EQGgfFa+NdirbTJm6nidiATG3DGo
 JdiNL8qi7WxFH/hAYCt76yB1quWWqF4bYk7SAJ3IshkOVxFe9ZaW2cerPOcy/iNU29tN
 eoHw==
X-Gm-Message-State: AOAM5333HxhNmqSYxczvsHrNTB6yOK+mulyPHIRmMzW2evocPip6/6DC
 SEXMhKvAoK1cSNHkKc79MqViwZGiayU=
X-Google-Smtp-Source: ABdhPJxRYEXx+5ZBWW1xzThzHttU3WKvlIdTFbAE0S5bt5fsHdRtJjfMqyMr16cBN9kyiG7eqYSIJg==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr3964539wru.344.1593794109399; 
 Fri, 03 Jul 2020 09:35:09 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u84sm13716676wmg.7.2020.07.03.09.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 09:35:08 -0700 (PDT)
Subject: Re: [PATCH v3 12/12] docs/system: Add Nuvoton machine documentation
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org,
 clg@kaod.org, joel@jms.id.au
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-13-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56028150-9efd-dc34-5244-2c6fa1f6b8e2@amsat.org>
Date: Fri, 3 Jul 2020 18:35:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626235519.591734-13-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, PDS_OTHER_BAD_TLD=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
[...]
> +Boot options
> +------------
> +
> +The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
> +a kernel using the ``-kernel`` option. OpenBMC images for `quanta-gsj` and
> +possibly others can be downloaded from the OpenPOWER jenkins :
> +
> +   https://openpower.xyz/

I can only see the build log, not the u-boot/kernel binaries.
Can you point me to an example please?

> +
> +Booting a full firmware image requires a Boot ROM specified via the ``-bios``
> +option to QEMU. The firmware image should be attached as an MTD drive. Example :
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -machine quanta-gsj -nographic \
> +      -bios npcm7xx_bootrom.bin \
> +      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 1bd477a293..38a9daa9b9 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -84,6 +84,7 @@ undocumented; you can get a complete list by running
>     arm/aspeed
>     arm/musicpal
>     arm/nseries
> +   arm/nuvoton
>     arm/orangepi
>     arm/palm
>     arm/xscale
> 


