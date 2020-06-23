Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D5AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9D22072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBclIOdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9D22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngnp-00089z-J8
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jngn9-0007bj-LD; Tue, 23 Jun 2020 07:08:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jngn7-0000nx-GM; Tue, 23 Jun 2020 07:08:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so20073668wrr.10;
 Tue, 23 Jun 2020 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eFNg4l8BDcidOcqkqEkPfeilv/c4Xk+sftvu9BcvccI=;
 b=kBclIOdpxNKOWd/EFm8EVNmK7rCGTjP8QRt1JWlWiUg6ZCwzpvlA1ylXFfUB5LKDtQ
 xKGER9BCOLFGDIoW9cdzBtIHF/c7nfbUhhUyRzhj3CqdYZqb3URVJYE5IvJV2sHfuJBx
 /ihMJwUr31CGiTc4/FTWnyJwKoHEYGvQKLAndzfS82ufZYUlXdf0o+RxuGvdioJL7wdx
 anZBWX+Ntc1zn0/xqqx1KK8FCWz/PJlPkTvPwVYZT25/kr4lLNQsGHjNhfVmbOcI2A+K
 CCkMxKJnM3ZiHxZndxjrFr9q9xvm4VZvBYpCSSXdczpzLHFMPrUH4w9B+EhAERnEkrHe
 1kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eFNg4l8BDcidOcqkqEkPfeilv/c4Xk+sftvu9BcvccI=;
 b=GHgnH9NTcgbq5D75Dz4buqr8plNosYz39YnaOzeMQy8bYC3fNXZDavUidztIpXW9Rz
 1jVzH7ZKfmUDw2/VEa1w8htWAKoiQ9rhhMh1ByDF+BfvtTE/cJJqKLUB0uLvrXruQ7PD
 vraPA/dYAB9UrBVwI+dhkiQttuXUHYqs1JUg8fl+hNBA3l+LT/MdwsX8FMi6FJ9ih2gd
 shMb8nvcu75JVRPv4oHvsJDYazuqJJbpziFfhuDBxewfokHiksC8hazXNJKas25fM6i3
 v61hFGGbSK8JcImUPXm8tGEhShFEhZwTItBn2z40eu+4TtW7nGmbhVUKfHeYh811Ojtk
 AqbQ==
X-Gm-Message-State: AOAM532vI/DdwthfTG8KqXE0+t0JXvba5JlP35AYvdVuVpxpN2VUODU5
 qsj6A/iMUu9pEz/HEQ9sJp4=
X-Google-Smtp-Source: ABdhPJyjTD9fGgQAS1awL5rOLy0PKu19iYRdmAh9cNhg0fTK5kgc5snvE1tn0w33GaOxGKv1fbQfbw==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr23365697wrv.381.1592910515300; 
 Tue, 23 Jun 2020 04:08:35 -0700 (PDT)
Received: from [192.168.1.41] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 63sm23803379wra.86.2020.06.23.04.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 04:08:34 -0700 (PDT)
Subject: Re: [PATCH v6 7/9] hw/arm/aspeed: Describe each PCA9552 device
To: qemu-devel@nongnu.org
References: <20200623072723.6324-1-f4bug@amsat.org>
 <20200623072723.6324-8-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd0407f1-e6d5-596a-2a16-7056801ad761@amsat.org>
Date: Tue, 23 Jun 2020 13:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623072723.6324-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 9:27 AM, Philippe Mathieu-Daudé wrote:
> We have 2 distinct PCA9552 devices. Set their description
> to distinguish them when looking at the trace events.
> 
> Description name taken from:
> https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Collecting Markus review on v5:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg07078.html

> ---
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/arm/aspeed.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ccf127b328..307dba5065 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -508,12 +508,15 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc = &bmc->soc;
>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
> +    DeviceState *dev;
>  
>      /* Bus 3: TODO bmp280@77 */
>      /* Bus 3: TODO max31785@52 */
>      /* Bus 3: TODO dps310@76 */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9552,
> -                     0x60);
> +    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    qdev_prop_set_string(dev, "description", "pca1");
> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
> +                          &error_fatal);
>  
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
> @@ -528,8 +531,10 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>  
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
>                            eeprom_buf);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA9552,
> -                     0x60);
> +    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    qdev_prop_set_string(dev, "description", "pca0");
> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11),
> +                          &error_fatal);
>      /* Bus 11: TODO ucd90160@64 */
>  }
>  
> 

