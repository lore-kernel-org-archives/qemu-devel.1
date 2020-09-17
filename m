Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1E6C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD33206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdlB0wdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD33206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvFR-0008IW-4j
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kIvCX-0005GD-U2; Thu, 17 Sep 2020 10:47:59 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kIvCW-0007Rp-1T; Thu, 17 Sep 2020 10:47:57 -0400
Received: by mail-lj1-x241.google.com with SMTP id v23so2306811ljd.1;
 Thu, 17 Sep 2020 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=htEnsEN8WmAO6m9/MU3LazOV+3ttHlSQqPbp2ygyP4Y=;
 b=QdlB0wdz0do66pplqkv8SIJuolawHuMCRydep8m+/e4G65rlpN0e46/0NEvoDB5U4d
 0HcgPnQpzUG9X+C1KPhY3V/wfQYSYo6ghcAFaONFrpj2rYVuJtx7ZblkLjd2zZBJ+bDZ
 9kpu3vmv0wSlEZIY2mpGALeth7mnMag4WgqijGbOYdyoUp5dMohXDT04fHMGQxEgZyrw
 qXRGjqhwoCzAhnK6OmA5NkJZf55d2k8yahojd1zt2JBjrRqIjchKjP7oQ2QNDXRc1+9d
 Hn+KEYpkbSuftNgKCap6cng3il0+DSs495kDOBi7PeTWa9uIdF2UJzldAGFmfdYznNF/
 SR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=htEnsEN8WmAO6m9/MU3LazOV+3ttHlSQqPbp2ygyP4Y=;
 b=lURZu2gsC6gavk753PQZg7E+Up1mM80j39jPYi3TIERZWIIIoiwoDN8V5w+9zuhvad
 55DR4QbXyFaaFE9C7OoGbquweuvKef2+AhUg560VKhSuSdsAH26fy8QJWKHM2h12sO3V
 GGviO8jC8oEGX4g+4vZCkf9HHwC41df1Ofuq8fMyZjBNpqjyonpWpJMv6or5fFdjT1iR
 mzLD3Bcj5y2oWNwayD6UeBJABfQI5aIiOQkUFgr8TifKDDBoSeupI3nbnRh1zvmtYi3x
 hf8CgYmA+LAgv1iOTOWjdKJdNH1B28qrrmtBKFdx4Q5Dalz8DupiArhc8j6ZPgy5KSS5
 IGCw==
X-Gm-Message-State: AOAM5315tLcoedYYh/mc3KhnqJZDJQSQau7axFiLiC9YtGPk+7QoWEGf
 976HwpxEkS1tGcXrAkGlQd0=
X-Google-Smtp-Source: ABdhPJwhARKwAJNL8lcou6jJ/JxHByzYudO5bObgKWTR5PoDV/m8cPak9n1qydoF9Si5S1hSzgPVzg==
X-Received: by 2002:a2e:9919:: with SMTP id v25mr11021126lji.167.1600354073148; 
 Thu, 17 Sep 2020 07:47:53 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 h27sm5625055lfj.87.2020.09.17.07.47.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Sep 2020 07:47:52 -0700 (PDT)
Date: Thu, 17 Sep 2020 16:47:50 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 9/9] aspeed/smc: Add support for RDSFDP command
Message-ID: <20200917144749.2yez6f46jkedxbnx@fralle-msi>
References: <20200902093107.608000-1-clg@kaod.org>
 <20200902093107.608000-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902093107.608000-10-clg@kaod.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cedric,

On [2020 Sep 02] Wed 11:31:07, Cédric Le Goater wrote:
> Modify the snooping routine to handle RDSFDP, 1 dummy and 3 bytes
> address space.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  include/hw/ssi/aspeed_smc.h |  1 +
>  hw/ssi/aspeed_smc.c         | 21 ++++++++++++++-------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 6fbbb238f158..5f477eb9cf97 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -115,6 +115,7 @@ typedef struct AspeedSMCState {
>  
>      AspeedSMCFlash *flashes;
>  
> +    uint8_t snoop_addr_width;
>      uint8_t snoop_index;
>      uint8_t snoop_dummies;
>  } AspeedSMCState;
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 795784e5f364..594f34668e7a 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -778,10 +778,15 @@ typedef enum {
>      PP = 0x2,           PP_4 = 0x12,
>      DPP = 0xa2,
>      QPP = 0x32,         QPP_4 = 0x34,
> +    RDSFDP = 0x5a,
>  } FlashCMD;
>  
> -static int aspeed_smc_num_dummies(uint8_t command)
> +static int aspeed_smc_num_dummies(AspeedSMCFlash *fl, uint8_t command)

Should the function be renamed to reflect that it also calculates the address
width now? (An alternative could be to create a new function for the address
width calculation)

The patch looks good to me else!

Best regards,
Francisco Iglesias

>  {
> +    AspeedSMCState *s = fl->controller;
> +
> +    s->snoop_addr_width = aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
> +
>      switch (command) { /* check for dummies */
>      case READ: /* no dummy bytes/cycles */
>      case PP:
> @@ -798,6 +803,9 @@ static int aspeed_smc_num_dummies(uint8_t command)
>      case DOR_4:
>      case QOR_4:
>          return 1;
> +    case RDSFDP:
> +        s->snoop_addr_width = 3;
> +        return 1;
>      case DIOR:
>      case DIOR_4:
>          return 2;
> @@ -813,8 +821,6 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
>                                  unsigned size)
>  {
>      AspeedSMCState *s = fl->controller;
> -    uint8_t addr_width = aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
> -
>      trace_aspeed_smc_do_snoop(fl->id, s->snoop_index, s->snoop_dummies,
>                                (uint8_t) data & 0xff);
>  
> @@ -823,7 +829,7 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
>  
>      } else if (s->snoop_index == SNOOP_START) {
>          uint8_t cmd = data & 0xff;
> -        int ndummies = aspeed_smc_num_dummies(cmd);
> +        int ndummies = aspeed_smc_num_dummies(fl, cmd);
>  
>          /*
>           * No dummy cycles are expected with the current command. Turn
> @@ -836,7 +842,7 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
>  
>          s->snoop_dummies = ndummies * 8;
>  
> -    } else if (s->snoop_index >= addr_width + 1) {
> +    } else if (s->snoop_index >= s->snoop_addr_width + 1) {
>  
>          /* The SPI transfer has reached the dummy cycles sequence */
>          for (; s->snoop_dummies; s->snoop_dummies--) {
> @@ -1407,10 +1413,11 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>  
>  static const VMStateDescription vmstate_aspeed_smc = {
>      .name = "aspeed.smc",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
> +        VMSTATE_UINT8(snoop_addr_width, AspeedSMCState),
>          VMSTATE_UINT8(snoop_index, AspeedSMCState),
>          VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
>          VMSTATE_END_OF_LIST()
> -- 
> 2.25.4
> 

