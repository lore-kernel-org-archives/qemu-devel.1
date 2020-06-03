Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253FEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B7120659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 06:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWt3nz/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B7120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgN26-0005jU-7g
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 02:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgN1X-0005D5-9q; Wed, 03 Jun 2020 02:37:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgN1W-000837-Ff; Wed, 03 Jun 2020 02:37:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id d128so732383wmc.1;
 Tue, 02 Jun 2020 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GahUl7iml0F/qGrBXr0n7uqNZtwDbY8JOObISZ7TsKg=;
 b=SWt3nz/gTQxFRzhrBUcu/wGGOPCASDx3r9AIzuPI3asZXlHzJglkDGPfZT/cAI0373
 ewNPJl45eKk6r2tu82vqeoulqGGJPY2tuUUXxd9wAnJJmx6P/CBX4phL67fhwwrZefFP
 oMdHQ6mth7nhy/MxjhHjUWX4Z84DQcmaq6IHxjyDQbhsRYJobYV1FhXpmKgAz9FSAwmt
 M5VXgQgkmxUMxsSg26NjLWt6YdnzT9yq/6f9vLo04AggqUUIlnarl/fAouEQJv4vWDl9
 fiRgrPw0DLlcy2Gikq9FWhMNwo/PN+DMwMMuWIW1kJ55Fr3s5qLUQCf9UUD7qlRPs2C6
 05EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GahUl7iml0F/qGrBXr0n7uqNZtwDbY8JOObISZ7TsKg=;
 b=KXWYMptVgn50rXWssm84EXxgIrC9jl1/3/SZ7IeLtAJYfAw147vXrAiGzbxtTXpBfM
 /qLw00AG3JTIhZ366Ce34RFP5Z/mQWIKfcb7awo7eZM3LZMB7jpKj/BGfrcdbpVRchXV
 IYyE/CuWmplJt3nq6YHbdTjGy25OPhT1jIMRr0KJtp8R8IRd5dd06GzyT8bkKocFlW8I
 u2JcNW0u1peF9LoyD5MoQmakHwYzab7pMUwygOB4lbIKeOIUXMKeWFb2CbLiwWuz/Mr/
 Nlg1vYEYlr69MYROtoMPkxbzW3Gfn0TPJylg7UKVof3Y/iHWQMWmrDy/xkVgQ+XSUxlP
 LhKg==
X-Gm-Message-State: AOAM531V/ECJ0KUcTePrRZgvfKMKZHXMiod0SWf1ccs2IB65rG/pJl5m
 vkiGoCjoN/bdi/MRMeIcndEEvB62
X-Google-Smtp-Source: ABdhPJyBrJpVey9iNxqvKI3ryfMIbJTxKeChn31QiFCN9sOXGHFPBSJV1WS2ZjLsRfoDcu/U1skiZw==
X-Received: by 2002:a1c:1b11:: with SMTP id b17mr7211333wmb.123.1591166232306; 
 Tue, 02 Jun 2020 23:37:12 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a1sm1515981wmd.28.2020.06.02.23.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 23:37:11 -0700 (PDT)
Subject: Re: [PATCH 1/2] sd: sdhci: Implement basic vendor specific register
 support
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200603052404.30788-1-linux@roeck-us.net>
 <20200603052404.30788-2-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bac1b68a-3cee-5e60-dd6e-a866b04d2226@amsat.org>
Date: Wed, 3 Jun 2020 08:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603052404.30788-2-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Guenter,

On 6/3/20 7:24 AM, Guenter Roeck wrote:
> The Linux kernel's IMX code now uses vendor specific commands.
> This results in endless warnings when booting the Linux kernel.
> 
> sdhci-esdhc-imx 2194000.usdhc: esdhc_wait_for_card_clock_gate_off:
> 	card clock still not gate off in 100us!.
> 
> Implement support for the vendor specific command implemented in IMX hardware
> to be able to avoid this warning.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/sd/sdhci-internal.h |  5 +++++
>  hw/sd/sdhci.c          | 18 +++++++++++++++++-
>  include/hw/sd/sdhci.h  |  5 +++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index e7c8a523b5..e8c753d6d1 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -75,6 +75,7 @@
>  #define SDHC_CMD_INHIBIT               0x00000001
>  #define SDHC_DATA_INHIBIT              0x00000002
>  #define SDHC_DAT_LINE_ACTIVE           0x00000004
> +#define SDHC_IMX_CLOCK_GATE_OFF        0x00000080
>  #define SDHC_DOING_WRITE               0x00000100
>  #define SDHC_DOING_READ                0x00000200
>  #define SDHC_SPACE_AVAILABLE           0x00000400
> @@ -289,7 +290,10 @@ extern const VMStateDescription sdhci_vmstate;
>  
>  
>  #define ESDHC_MIX_CTRL                  0x48
> +
>  #define ESDHC_VENDOR_SPEC               0xc0
> +#define ESDHC_IMX_FRC_SDCLK_ON          (1 << 8)

I searched for the datasheet but couldn't find any, so I suppose it is
only available under NDA. I can not review much (in particular I wanted
to check the register sizes), anyway the overall looks OK:

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Also:

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>  #define ESDHC_DLL_CTRL                  0x60
>  
>  #define ESDHC_TUNING_CTRL               0xcc
> @@ -326,6 +330,7 @@ extern const VMStateDescription sdhci_vmstate;
>  #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>      DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
>      DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
> +    DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
>      \
>      /* Capabilities registers provide information on supported
>       * features of this specific host controller implementation */ \
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 1b75d7bab9..eb2be6529e 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1569,11 +1569,13 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
>          }
>          break;
>  
> +    case ESDHC_VENDOR_SPEC:
> +        ret = s->vendor_spec;
> +        break;
>      case ESDHC_DLL_CTRL:
>      case ESDHC_TUNE_CTRL_STATUS:
>      case ESDHC_UNDOCUMENTED_REG27:
>      case ESDHC_TUNING_CTRL:
> -    case ESDHC_VENDOR_SPEC:
>      case ESDHC_MIX_CTRL:
>      case ESDHC_WTMK_LVL:
>          ret = 0;
> @@ -1596,7 +1598,21 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>      case ESDHC_UNDOCUMENTED_REG27:
>      case ESDHC_TUNING_CTRL:
>      case ESDHC_WTMK_LVL:
> +        break;
> +
>      case ESDHC_VENDOR_SPEC:
> +        s->vendor_spec = value;
> +        switch (s->vendor) {
> +        case SDHCI_VENDOR_IMX:
> +            if (value & ESDHC_IMX_FRC_SDCLK_ON) {
> +                s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
> +            } else {
> +                s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
> +            }
> +            break;
> +        default:
> +            break;
> +        }
>          break;
>  
>      case SDHC_HOSTCTL:
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index c6868c9699..5d9275f3d6 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -74,6 +74,7 @@ typedef struct SDHCIState {
>      uint16_t acmd12errsts; /* Auto CMD12 error status register */
>      uint16_t hostctl2;     /* Host Control 2 */
>      uint64_t admasysaddr;  /* ADMA System Address Register */
> +    uint16_t vendor_spec;  /* Vendor specific register */
>  
>      /* Read-only registers */
>      uint64_t capareg;      /* Capabilities Register */
> @@ -96,8 +97,12 @@ typedef struct SDHCIState {
>      uint32_t quirks;
>      uint8_t sd_spec_version;
>      uint8_t uhs_mode;
> +    uint8_t vendor;        /* For vendor specific functionality */
>  } SDHCIState;
>  
> +#define SDHCI_VENDOR_NONE       0
> +#define SDHCI_VENDOR_IMX        1
> +
>  /*
>   * Controller does not provide transfer-complete interrupt when not
>   * busy.
> 


