Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708292075A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsPP114Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708292075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLCn-0003yV-Hq
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPLAp-0002ig-KF; Mon, 05 Oct 2020 03:44:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPLAl-0002L2-Mj; Mon, 05 Oct 2020 03:44:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id n18so522609wrs.5;
 Mon, 05 Oct 2020 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Mwg9iuCCINmBbgih34xe9eRnF4q0DELhsessjY5I1zY=;
 b=LsPP114Q4BZHyHnkZ8v5CFAd5kF8hsNyWzyjiWf/C6FeKRArXnGA+7aymFyzmhHeJ4
 tX9UNCF6UD6xH736ukKzhnnkb1evGvAyx1/6A03GNxoe69QRgYNhxgp+WHUFNIhIB3/J
 1LbvDsWRM4j+LUCWvsaweGccvMLDUxZsQ6m0fMulV3iykoKL5vzh172AR+6MW4Bcdqy8
 m7snAjnrn386RAQsi1j8iTk9Pdd5Us/pa22i7DM0e7yelVxNFwO+JKl+AWH5KWKcXpvn
 nGsBQZTh8shtnzw22pgbaqZgk6GputljFyC3dBSY2CyUL908Meaj05C+2q0rXN7ZKy1z
 4Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mwg9iuCCINmBbgih34xe9eRnF4q0DELhsessjY5I1zY=;
 b=jdTy+Y/P6WVklauIvdjQvwsIiMjiMC9qVpBFRm7N3WOvwbXfsWkAzR/l9CDbIItaWV
 M3YNZy81Qf4JwBbdRBLWSfvQ3tBVOviGucBkhmssdSLEvS4smo8gZV0Z1zm1pripqOSr
 AIihMWwus8y3AEVgXMGZOakWyNdifJsg9fLqayTA9/94qaBbiWqCn66yHeAJUeL57u6B
 DoKVbpXYHmSIOu+ek+ZSDFHPppXUYLo4KgrRBIMT4wOmMNgbmSNxzQJqGz7yUC4DhLi8
 4Ca+8BAfSNrVwG8CX6kWDfBUkVyxetv4Ca7MJIfum/dvIQhPCpqWMFckpBUpPXX2O2Se
 Ci8w==
X-Gm-Message-State: AOAM530+afJ7GmY1Gn6uBteo7zxccocFzQQzE/4QI4venitBYU/Ne14I
 R780InbqfK9SQkURvunLI3Z7tm3ZtkdKUw==
X-Google-Smtp-Source: ABdhPJzKOx06duxrDPSH5VpZd0hZ5MTtB8ejyD87C/4EE4MY1AbENirmSNXpNIslQH4kdm61prxmfw==
X-Received: by 2002:adf:aa99:: with SMTP id h25mr15189148wrc.101.1601883877117; 
 Mon, 05 Oct 2020 00:44:37 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a15sm13051325wrn.3.2020.10.05.00.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 00:44:36 -0700 (PDT)
Subject: Re: [PATCH] ssi: Display chip select polarity in monitor 'info qtree'
To: qemu-devel@nongnu.org
References: <20200927091946.65491-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <290a4128-dd09-7f05-1f2d-0a0f607de28b@amsat.org>
Date: Mon, 5 Oct 2020 09:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200927091946.65491-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Can you take this patch via your qemu-arm tree please?
(most of SPI boards are ARM based)

On 9/27/20 11:19 AM, Philippe Mathieu-Daudé wrote:
> It is sometime useful to verify a device chip select polarity
> on a SPI bus. Since we have this information available, display
> it in the 'info qtree' monitor output:
> 
>   $ qemu-system-arm -M lm3s6965evb -monitor stdio -S
>   (qemu) info qtree
>   [...]
>   dev: pl022, id ""
>     gpio-out "sysbus-irq" 1
>     mmio 0000000040008000/0000000000001000
>     bus: ssi
>       type SSI
>       dev: ssd0323, id ""
>         gpio-in "" 1
>         gpio-in "ssi-gpio-cs" 1
>         chip select polarity: high           <---
>       dev: ssi-sd, id ""
>         gpio-in "ssi-gpio-cs" 1
>         chip select polarity: low            <---
>         bus: sd-bus
>           type sd-bus
>           dev: sd-card, id ""
>             spec_version = 2 (0x2)
>             drive = "sd0"
>             spi = true
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ssi/ssi.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index 4278d0e4440..4c9f8d66d23 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -17,6 +17,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
> +#include "monitor/monitor.h"
>  #include "qom/object.h"
>  
>  struct SSIBus {
> @@ -26,10 +27,31 @@ struct SSIBus {
>  #define TYPE_SSI_BUS "SSI"
>  OBJECT_DECLARE_SIMPLE_TYPE(SSIBus, SSI_BUS)
>  
> +static void ssi_print_dev(Monitor *mon, DeviceState *dev, int indent)
> +{
> +    static const char *const polarity_s[] = {
> +        [SSI_CS_NONE] = "unknown",
> +        [SSI_CS_LOW]  = "low",
> +        [SSI_CS_HIGH] = "high"
> +    };
> +    SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(dev);
> +
> +    monitor_printf(mon, "%*schip select polarity: %s\n",
> +                   indent, "", polarity_s[ssc->cs_polarity]);
> +}
> +
> +static void ssi_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *k = BUS_CLASS(klass);
> +
> +    k->print_dev = ssi_print_dev;
> +}
> +
>  static const TypeInfo ssi_bus_info = {
>      .name = TYPE_SSI_BUS,
>      .parent = TYPE_BUS,
>      .instance_size = sizeof(SSIBus),
> +    .class_init = ssi_bus_class_init,
>  };
>  
>  static void ssi_cs_default(void *opaque, int n, int level)
> 

