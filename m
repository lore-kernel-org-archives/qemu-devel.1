Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161B9C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43F020773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43F020773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOui-0004bP-0J
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kDOu3-0004BH-7d; Wed, 02 Sep 2020 05:18:03 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kDOtz-0002o7-Dn; Wed, 02 Sep 2020 05:18:02 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MjSDU-1ksl2w1Vc2-00kx9m; Wed, 02 Sep 2020 11:17:28 +0200
Subject: Re: [PATCH 2/2] hw/gpio/max7310: Replace disabled printf() by
 qemu_log_mask(UNIMP)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901104234.92159-1-f4bug@amsat.org>
 <20200901104234.92159-3-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <163c6c1b-bb3a-0ed0-2316-8d024bc84183@vivier.eu>
Date: Wed, 2 Sep 2020 11:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901104234.92159-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bqx5yJcBtwM9/wQcztqYOzToBGEJTLVIXvw1UUSkleQtjbHbkqZ
 kyL8N61xDuRkxXvQ0TXU+IWtiP0Z4Qu/GOyp1BMUwZMQ0vtWV9TYH1OMHdoVLTlJFiT+pJZ
 xFShNj2W10zTXVXNsLJ6An2TgfLNZa2FUxCtJrjHOgdUtVHP7gZZEMZc2TQyjYDFoFq4RJt
 r54x3ASaV++iaGfEJfJiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ECWtHgJgqEg=:QB9CIwA/w0lauRfvB7Rem8
 /7B/ujTVScOHfzzenvXsZ+GNmA9JoFLr4+9enF+yfnbHO+NSZsml5VITKUBdgiDltgmmGjp2Q
 7COcV3nsGv6XYmcP8Vbj3cFmBTomkkkfye0G4Qji9g1H0eJZCoqqyEtHleMI1LZbdz0kliC3x
 hvqn+8I5EFG53l2KXodD5PI6JEdegG5MpGzri7pGWgY9k52GFyvZdQMEVn3WeYoYvCfulXajh
 SBefgI0O+L7rtE+3C/dGXLrDyLxxn7KRvWDwCqMakdZNtyUuvLLXnqHmGQn/naDvcpVDj9B4d
 m2+QOhqCmnmlIo7JtcECTL5KJqoxqTvwx1Cl8DobcINgL9s6Xnv7buT1u1C8rFvfg/MRd1hka
 VigexJFfNFjpUZYNnmq+WKz5cic1jHPV99f69e59Jzz3PkveG4sw1DGGcAVU29LpUiLEx3ttc
 L4KEuhNEtRBcl7jNT4UuuvcZuY/CHi3uZRcX1C1fJmaKB1rZk1yAkimCkjChNxvkyH8N65GPd
 WloHJ2qocJLsYjxRT3o/ZTYclQNUcW+1ibDDgFVQRpufizKh0K0raeCa2ptFHVqia7M/1Qvyo
 zwvw+9urj/KtmcOAfQ7LrhPKsY6/TaVPXjdskmujke5z3shLdiKlf46l5PrQ2dUQg98mTCjfc
 F2jXnR0mseOC1pFpgS98EQ8zm/q4eGfddWlDQ+Sn2YIyDOK5GTuq/h6w+LzMqI7JKGtr56bSX
 TdiTQUYp9JEPtk285oUtAnQfAv4UQfBfQpGY9zwrwknEww4NA7YW9Het1a9Jrtx6COO6cf5dF
 dJ8UMNaJN1ws0SyuxfpuyMlBFxFdgM4ot+FFDfcOg+rEfpmEreBoFqNi1fl9ry9+vJC6S/C
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 05:17:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 01/09/2020 à 12:42, Philippe Mathieu-Daudé a écrit :
> Replace disabled printf() by qemu_log_mask(UNIMP).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/gpio/max7310.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
> index 7f5de189acf..c58a1996418 100644
> --- a/hw/gpio/max7310.c
> +++ b/hw/gpio/max7310.c
> @@ -11,6 +11,7 @@
>  #include "hw/i2c/i2c.h"
>  #include "hw/irq.h"
>  #include "migration/vmstate.h"
> +#include "qemu/log.h"
>  #include "qemu/module.h"
>  
>  #define TYPE_MAX7310 "max7310"
> @@ -69,9 +70,8 @@ static uint8_t max7310_rx(I2CSlave *i2c)
>          return 0xff;
>  
>      default:
> -#ifdef VERBOSE
> -        printf("%s: unknown register %02x\n", __func__, s->command);
> -#endif
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
> +                      __func__, s->command);
>          break;
>      }
>      return 0xff;
> @@ -123,9 +123,8 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)
>      case 0x00:	/* Input port - ignore writes */
>          break;
>      default:
> -#ifdef VERBOSE
> -        printf("%s: unknown register %02x\n", __func__, s->command);
> -#endif
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
> +                      __func__, s->command);
>          return 1;
>      }
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

