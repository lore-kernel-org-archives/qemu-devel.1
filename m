Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E34C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2BC20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2BC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbS3E-0007HT-Rx
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbQml-000877-WB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbQmk-0007gc-06
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:33:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbQmj-0007cz-OC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:33:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so21007261wre.12
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l0K5KEQjVJUDYQD89OQeAZZUAdVtmWYufBhAs8yf588=;
 b=mIHR737nnUFbGwstS26G0EAQDp1f5UC8fCOtestnmgZpvlTzvRUOjjvyGwF6VvZY05
 xZPgswEt0FPnvLv8c0id2Nbv/pLCqmQ+bzlO/XyUwBDCcKtgWgGfqK/7IT6wlPM+qkRK
 /j2K3eNF5mQb4a22KUcWbv6o+h5u9VMCVf2sHJ1EY6haDlpXiJL10jYz/Jl5jd6vzhwn
 IHN/GGP+YVfei99mXiEL4yssDKxcyHvbkNV/7PT88YgHXfmI6t32y0EU/Z+kkvhWKnVN
 YAAKxKag0HWth8dkNsdElr0pURQkXoIYbWE1dDuf9hMejMF3Nz7SrFijhFT4rLPB4YWw
 jV5g==
X-Gm-Message-State: APjAAAUJhkvPrTqY+TfzDMcc3cRi4iAzmQ3aLwbLWZB8DP9FvdQMccJ2
 Vo0CONc93d88d3z+wHlEgWpT/w==
X-Google-Smtp-Source: APXvYqzmIOHbuKoob97Q8rJx6Mld35xeZlX1WMfmuuj+938USiilyKy+uRinhXIU7Xh3jvb9O5rrkA==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr60432910wrn.165.1560436380083; 
 Thu, 13 Jun 2019 07:33:00 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id d17sm4358853wrx.9.2019.06.13.07.32.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 07:32:59 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-14-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <777b7a86-ce5e-d218-5848-c8f4b37a0bf4@redhat.com>
Date: Thu, 13 Jun 2019 16:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525151241.5017-14-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 13/19] aspeed/smc: add a 'sdram_base'
 propertie
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/19 5:12 PM, Cédric Le Goater wrote:
> The DRAM address of a DMA transaction depends on the DRAM base address
> of the SoC. Inform the SMC controller model of this value.

I'd reorder this one previous patch #16 "aspeed/smc: add support for
DMAs" where you start to use sdram_base.

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  include/hw/ssi/aspeed_smc.h | 3 +++
>  hw/arm/aspeed_soc.c         | 6 ++++++
>  hw/ssi/aspeed_smc.c         | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 3b1e7fce6c86..591279ba1f43 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -97,6 +97,9 @@ typedef struct AspeedSMCState {
>      uint8_t r_timings;
>      uint8_t conf_enable_w0;
>  
> +    /* for DMA support */
> +    uint64_t sdram_base;
> +
>      AspeedSMCFlash *flashes;
>  
>      uint8_t snoop_index;
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 8cfe9e9515ed..65fbac896c85 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -326,6 +326,12 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>                         aspeed_soc_get_irq(s, ASPEED_I2C));
>  
>      /* FMC, The number of CS is set at the board level */
> +    object_property_set_int(OBJECT(&s->fmc), sc->info->memmap[ASPEED_SDRAM],
> +                            "sdram-base", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index f1e66870d71f..4ff12f7b27fc 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -912,6 +912,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
>  
>  static Property aspeed_smc_properties[] = {
>      DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
> +    DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> 

