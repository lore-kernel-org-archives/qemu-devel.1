Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029D3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F047123110
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8stUgv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F047123110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3g6c-0004PR-0Q
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3g61-0003tg-MN; Thu, 06 Aug 2020 09:38:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3g60-0002t0-2D; Thu, 06 Aug 2020 09:38:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id y3so44044830wrl.4;
 Thu, 06 Aug 2020 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OjcdhDLucSRT8FFIZv176pPKfHlgD06Q4at/uUFwg18=;
 b=R8stUgv6aD/HW5lP2fgPJMR4Pdb5o6g5P/BeSR4cCF1GcClUdqR+u3AUN7MTkzp4rf
 64SjaeNYNVEinfZCWE6D7fGK4+QrOjmc7+keyz0+IZ51gwOqflqvlRI1kwYhWmcb0mDL
 jCr7Iem/pfUPlSIaNk78u7wBDL3FTaQNjJ6Gq8F+Qo1doQqH2zHl3q0NLVuIcyj0dlNs
 0UfDln8+Ojd8+ZWWmXJd4YgEW2h8gL8ZBfA6yXB0FEQXBzNguz6pG9ojHs55EupUXvro
 OMFR3cXIDJbV/Ljrm4pl1MuDLai8qjHaXt7JfANnvapQoONNuquIJwR1ZcQLbFW3K1n2
 WhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OjcdhDLucSRT8FFIZv176pPKfHlgD06Q4at/uUFwg18=;
 b=c6uC2ji970tOKLO+/cJrJz/qrlIxEQjUWtYJMkPd3YN1NytB8+q8NCr4YR/VjmROJy
 35+8FDaFXaglCpkcoXkMCgnCwutw96o7/qP337F6QMh6gLLgZ6U6EOR3KMRtNI6XLQDS
 3N4eIp7ICbAHKhdlpbT95NoVXO1P232qWASNXg2BdjQnuu6RX+Wh8VrKovBranVdt+/L
 WvQi7m9Ugpu7QVs2fsx2oVzf8abeu9JiYNV3eq/MQLIAa4HoFEaZ0y2O86V2HXxygHoH
 9dxF25aFQR2ioPiPmGaBk1pQGwgyHvxnkIf2wNuT5G6rcoMQiwFWUC4XtvBPx8UuiCFe
 nw8w==
X-Gm-Message-State: AOAM530XJA+y3EKd7+P3gr+vJ45PnA9Zh2T5UJYeHhRg4sfSdNzKb8Ud
 ERomoyakqPbCocgdl+Up8HrhSwEy
X-Google-Smtp-Source: ABdhPJxQFVDAxOK2L5UcMVG3/RWN+q7JtafbotGzZ3ui+581Z04m3XrGDVhuiP5lm831Ug4KSYQqDA==
X-Received: by 2002:adf:a45d:: with SMTP id e29mr7578761wra.107.1596721089900; 
 Thu, 06 Aug 2020 06:38:09 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c15sm6311768wme.23.2020.08.06.06.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 06:38:08 -0700 (PDT)
Subject: Re: [PATCH for-5.2 16/19] aspeed/sdmc: Perform memory training
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-17-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56f83c0b-b5eb-241e-c848-56f038633398@amsat.org>
Date: Thu, 6 Aug 2020 15:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200806132106.747414-17-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:21 PM, Cédric Le Goater wrote:
> From: Joel Stanley <joel@jms.id.au>
> 
> This allows qemu to run the "normal" power on reset boot path through
> u-boot, where the DDR is trained.
> 
> An enhancement would be to have the SCU bit stick across qemu reboots,
> but be unset on initial boot.
> 
> Proper modelling would be to discard all writes to the phy setting regs
> at offset 0x100 - 0x400 and to model the phy status regs at offset
> 0x400.
> 
> The status regs model would only need to account for offets 0x00,
> 0x50, 0x68 and 0x7c.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> [ clg: checkpatch fixes ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  include/hw/misc/aspeed_sdmc.h | 13 ++++++++++++-
>  hw/misc/aspeed_scu.c          |  2 +-
>  hw/misc/aspeed_sdmc.c         | 19 +++++++++++++++++--
>  3 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
> index cea1e67fe365..c6226957dd3d 100644
> --- a/include/hw/misc/aspeed_sdmc.h
> +++ b/include/hw/misc/aspeed_sdmc.h
> @@ -17,7 +17,18 @@
>  #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
>  #define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
>  
> -#define ASPEED_SDMC_NR_REGS (0x174 >> 2)
> +/*
> + * SDMC has 174 documented registers. In addition the u-boot device tree
> + * describes the following regions:
> + *  - PHY status regs at offset 0x400, length 0x200
> + *  - PHY setting regs at offset 0x100, length 0x300
> + *
> + * There are two sets of MRS (Mode Registers) configuration in ast2600 memory
> + * system: one is in the SDRAM MC (memory controller) which is used in run
> + * time, and the other is in the DDR-PHY IP which is used during DDR-PHY
> + * training.
> + */
> +#define ASPEED_SDMC_NR_REGS (0x500 >> 2)
>  
>  typedef struct AspeedSDMCState {
>      /*< private >*/
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 764222404bef..dc6dd87c22f4 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -656,7 +656,7 @@ static const uint32_t ast2600_a1_resets[ASPEED_AST2600_SCU_NR_REGS] = {
>      [AST2600_SYS_RST_CTRL2]     = 0xFFFFFFFC,
>      [AST2600_CLK_STOP_CTRL]     = 0xFFFF7F8A,
>      [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
> -    [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM init */
> +    [AST2600_SDRAM_HANDSHAKE]   = 0x00000000,
>      [AST2600_HPLL_PARAM]        = 0x1000405F,
>      [AST2600_CHIP_ID0]          = 0x1234ABCD,
>      [AST2600_CHIP_ID1]          = 0x88884444,
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 855848b7d23a..ff2809a09965 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -113,7 +113,7 @@ static uint64_t aspeed_sdmc_read(void *opaque, hwaddr addr, unsigned size)
>      if (addr >= ARRAY_SIZE(s->regs)) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> -                      __func__, addr);
> +                      __func__, addr * 4);
>          return 0;
>      }
>  
> @@ -206,6 +206,19 @@ static void aspeed_sdmc_reset(DeviceState *dev)
>  
>      /* Set ram size bit and defaults values */
>      s->regs[R_CONF] = asc->compute_conf(s, 0);
> +
> +    /*
> +     * PHY status:
> +     *  - set phy status ok (set bit 1)
> +     *  - initial PVT calibration ok (clear bit 3)
> +     *  - runtime calibration ok (clear bit 5)
> +     */
> +    s->regs[0x100] = BIT(1);

This is usually implemented with a one-shot timer, see
sd_ocr_powerup() in hw/sd/sd.c (migration is handled).

> +
> +    /* PHY eye window: set all as passing */
> +    s->regs[0x100 | (0x68 / 4)] = 0xff;
> +    s->regs[0x100 | (0x7c / 4)] = 0xff;
> +    s->regs[0x100 | (0x50 / 4)] = 0xfffffff;
>  }
>  
>  static void aspeed_sdmc_get_ram_size(Object *obj, Visitor *v, const char *name,
> @@ -443,7 +456,9 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>      }
>  
>      if (reg != R_PROT && s->regs[R_PROT] == PROT_SOFTLOCKED) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: SDMC is locked! (write to MCR%02x blocked)\n",
> +                      __func__, reg * 4);
>          return;
>      }
>  
> 


