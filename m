Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7825C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D02205CB
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9X+mlsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D02205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8AW-0001MR-M1
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kE876-00045p-TT; Fri, 04 Sep 2020 05:34:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kE874-00061c-ES; Fri, 04 Sep 2020 05:34:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id v4so5423620wmj.5;
 Fri, 04 Sep 2020 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TLJjWJUfKWCJsqTgPpdjawEm573aXoozoIxsLLKe/oI=;
 b=f9X+mlspjCPuaTqlkB5sI+Fc+XCXArPNX01NvJb1+z0NtGU22xGGAesl9OduxrQJ3I
 0iDlDquPiWvMccjv6IJonytPBnt90I7cgbhUZRSZENkJSK5qU/Eqtu+7Vj/hVreBe8OG
 KtT2tpgiQosJL8bP02j3LLHapCEZ1ySVOcJqroJzp0CP8OkEWuvwJ9QyXCkh5qf4LcD6
 qX9bBfVliREdKm2jP8TcqlKVFC81GvWIEm81TklTBef2zP4u1t+j2U19jpQYTEF3zjXx
 rXL9iefTh25WgIxvYUylpO1qFApZzNEzJuXKmJGpHzvpvW3K34EhZiqzX+qSUHJJZNVb
 pfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TLJjWJUfKWCJsqTgPpdjawEm573aXoozoIxsLLKe/oI=;
 b=Wt/VuxZLWJx+TOK3FtGhOtEvMSKEox3dzJrK3iDtLXeMCJfmdZ8UOrhIwZeSK/xYgm
 oKHGBr5nW7xBUPnaPfUX7DBKjw98CQiTbYvUPgPUA4aubVI0W9FfOA7colYxm007ru4y
 vxReM3EWMfn7/iZzFSnyCllrHpHqPrYEXNC7pfy5LqvNk7+JZc1YNxMep9qeXyWZN9Fd
 Bxfjs7pfwbhcfpavwE1EVSNs98xhD3v02OKC6ug9FJ1Vn99weefKObMGJ3yhXqER2ImX
 Ho8HFZFMDWcXmtnS4HnRh85Z+ahPmoNCaZMSz3+znIjbmlad7KTlG5lMcKefBuZmeQxe
 G8Bg==
X-Gm-Message-State: AOAM533a0DLgV825q7sxltBFk7nmsxyPgtQrV+FhJ5WoRrAVaiah7PhF
 1V9DppXh/CRPMAZmC/SZd/0=
X-Google-Smtp-Source: ABdhPJyJPfDAOgZZPCNMlftkMHivtS1pAggJt6SpmpUIzd0UEOgoz2RLpPtyi7EDhcpaQsQOM4bCcA==
X-Received: by 2002:a1c:302:: with SMTP id 2mr6543473wmd.134.1599212068673;
 Fri, 04 Sep 2020 02:34:28 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c145sm9290446wmd.7.2020.09.04.02.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 02:34:27 -0700 (PDT)
Subject: Re: [PATCH v8 12/14] hw/arm/npcm7xx: add board setup stub for CPU and
 UART clocks
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200825001711.1340443-13-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65832bc3-6f22-bc11-d559-02b0810d73ee@amsat.org>
Date: Fri, 4 Sep 2020 11:34:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825001711.1340443-13-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:17 AM, Havard Skinnemoen via wrote:
> When booting directly into a kernel, bypassing the boot loader, the CPU and
> UART clocks are not set up correctly. This makes the system appear very
> slow, and causes the initrd boot test to fail when optimization is off.
> 
> The UART clock must run at 24 MHz. The default 25 MHz reference clock
> cannot achieve this, so switch to PLL2/2 @ 480 MHz, which works
> perfectly with the default /20 divider.
> 
> The CPU clock should run at 800 MHz, so switch it to PLL1/2. PLL1 runs
> at 800 MHz by default, so we need to double the feedback divider as well
> to make it run at 1600 MHz (so PLL1/2 runs at 800 MHz).
> 
> We don't bother checking for PLL lock because we know our emulated PLLs
> lock instantly.
> 
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  include/hw/arm/npcm7xx.h |  1 +
>  hw/arm/npcm7xx.c         | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> index 78d0d78c52..13106af215 100644
> --- a/include/hw/arm/npcm7xx.h
> +++ b/include/hw/arm/npcm7xx.h
> @@ -37,6 +37,7 @@
>  #define NPCM7XX_SMP_LOADER_START        (0xffff0000)  /* Boot ROM */
>  #define NPCM7XX_SMP_BOOTREG_ADDR        (0xf080013c)  /* GCR.SCRPAD */
>  #define NPCM7XX_GIC_CPU_IF_ADDR         (0xf03fe100)  /* GIC within A9 */
> +#define NPCM7XX_BOARD_SETUP_ADDR        (0xffff1000)  /* Boot ROM */
>  
>  typedef struct NPCM7xxMachine {
>      MachineState        parent;
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index 7884b2b03d..037f3a26f2 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -55,6 +55,13 @@
>  #define NPCM7XX_ROM_BA          (0xffff0000)
>  #define NPCM7XX_ROM_SZ          (64 * KiB)
>  
> +/* Clock configuration values to be fixed up when bypassing bootloader */
> +
> +/* Run PLL1 at 1600 MHz */
> +#define NPCM7XX_PLLCON1_FIXUP_VAL   (0x00402101)
> +/* Run the CPU from PLL1 and UART from PLL2 */
> +#define NPCM7XX_CLKSEL_FIXUP_VAL    (0x004aaba9)
> +
>  /*
>   * Interrupt lines going into the GIC. This does not include internal Cortex-A9
>   * interrupts.
> @@ -132,6 +139,29 @@ static const struct {
>      },
>  };
>  
> +static void npcm7xx_write_board_setup(ARMCPU *cpu,
> +                                      const struct arm_boot_info *info)
> +{
> +    uint32_t board_setup[] = {
> +        0xe59f0010,     /* ldr r0, clk_base_addr */
> +        0xe59f1010,     /* ldr r1, pllcon1_value */
> +        0xe5801010,     /* str r1, [r0, #16] */
> +        0xe59f100c,     /* ldr r1, clksel_value */
> +        0xe5801004,     /* str r1, [r0, #4] */
> +        0xe12fff1e,     /* bx lr */
> +        NPCM7XX_CLK_BA,
> +        NPCM7XX_PLLCON1_FIXUP_VAL,
> +        NPCM7XX_CLKSEL_FIXUP_VAL,
> +    };
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(board_setup); i++) {
> +        board_setup[i] = tswap32(board_setup[i]);
> +    }
> +    rom_add_blob_fixed("board-setup", board_setup, sizeof(board_setup),
> +                       info->board_setup_addr);
> +}
> +
>  static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
>                                           const struct arm_boot_info *info)
>  {
> @@ -170,6 +200,8 @@ static struct arm_boot_info npcm7xx_binfo = {
>      .gic_cpu_if_addr        = NPCM7XX_GIC_CPU_IF_ADDR,
>      .write_secondary_boot   = npcm7xx_write_secondary_boot,
>      .board_id               = -1,
> +    .board_setup_addr       = NPCM7XX_BOARD_SETUP_ADDR,
> +    .write_board_setup      = npcm7xx_write_board_setup,
>  };
>  
>  void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
> 

Very very clean :) :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

