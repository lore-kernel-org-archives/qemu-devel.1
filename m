Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E607C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA75E21473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA75E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRLR-0001Rj-AW
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbQlC-00074X-QE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbQl9-0006XJ-JE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:31:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbQl9-0006W9-54
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:31:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so21034924wrm.8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uPCG31NtCjQrMhfMzWaej0+MxaSfA9nDhfT/lK6L+dI=;
 b=Jok8BRqiWv2X4coer/x2uhHDffZzCkeofxOx3rh26G9kwVurCBNdn6Rqpq7FRttkjT
 rhW4YqBMccB/ryUF3YPLz8mJCcOHc7dEY2ZnbxLxVc83lgI0RHSLQSbfPTu/Nj0j5tFR
 WBWHOFlSXEbSUGI3LjmB8kBJgsFXM0B1TuwGTRL+OG1E4tRDFFTEFSVXT5jNx4ZPFR3A
 p/5zxSqw7Z9eB4hTWaIzLYkqBw053cpfTWyA2d8wwD57F5HwivxJMidi9Bh44rddcw3j
 d4AjLEE63D915eEy792yXCxzLZqK7uBQZ7NdPWEbpZNFDiUePtSs/OLl57bA9TPINR0i
 EN1A==
X-Gm-Message-State: APjAAAV2SBqjQLz9FlkTo/DYC5sNEbWEfpt4tWCZfwJylGh0hzciKzXp
 7BUQmI7r0HZ2QKJY069igmFYfA==
X-Google-Smtp-Source: APXvYqxLBpwl/foxG7kqoic92DU825MdQN6BTtxZbFqLQRSin80/J2NLSAOcot+ka13dkzRhDQOs/A==
X-Received: by 2002:adf:e311:: with SMTP id b17mr60379164wrj.11.1560436281778; 
 Thu, 13 Jun 2019 07:31:21 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x16sm61458wmj.4.2019.06.13.07.31.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 07:31:20 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-19-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f3b3948f-8d24-fb8c-0b65-8fe08019a077@redhat.com>
Date: Thu, 13 Jun 2019 16:31:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525151241.5017-19-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 18/19] aspeed/smc: inject errors in DMA
 checksum
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

Hi Cédric,

On 5/25/19 5:12 PM, Cédric Le Goater wrote:
> Emulate read errors in the DMA Checksum Register for high frequencies
> and optimistic settings of the Read Timing Compensation Register. This
> will help in tuning the SPI timing calibration algorithm.
> 
> The values below are those to expect from the first flash device of
> the FMC controller of a palmetto-bmc machine.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/ssi/aspeed_smc.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 406c30c60b3f..4c162912cf62 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -866,6 +866,30 @@ static void aspeed_smc_dma_calibration(AspeedSMCState *s)
>      s->regs[s->r_ctrl0 + cs] |= CE_CTRL_CLOCK_FREQ(hclk_div);
>  }
>  

Can you add a comment (like the patch description) here?

> +static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
> +{
> +    uint8_t delay =
> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELAY_MASK;
> +    uint8_t hclk_mask =
> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_MASK;
> +
> +    /*
> +     * Typical values of a palmetto-bmc machine.
> +     */
> +    switch (aspeed_smc_hclk_divisor(hclk_mask)) {
> +    case 4 ... 16:
> +        return false;
> +    case 3: /* at least one HCLK cycle delay */
> +        return (delay & 0x7) < 1;
> +    case 2: /* at least two HCLK cycle delay */
> +        return (delay & 0x7) < 2;
> +    case 1: /* (> 100MHz) is above the max freq of the controller */
> +        return true;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  /*
>   * Accumulate the result of the reads to provide a checksum that will
>   * be used to validate the read timing settings.
> @@ -903,6 +927,11 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>          s->regs[R_DMA_FLASH_ADDR] += 4;
>          s->regs[R_DMA_LEN] -= 4;
>      }
> +
> +    if (aspeed_smc_inject_read_failure(s)) {

So this model real world where noise eventually triggers errors. Don't
we want this to be enable by the user (or a QMP command)?

> +        s->regs[R_DMA_CHECKSUM] = 0xbadc0de;
> +    }
> +
>  }
>  
>  static void aspeed_smc_dma_rw(AspeedSMCState *s)
> 

