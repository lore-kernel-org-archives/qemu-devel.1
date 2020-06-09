Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D44FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0108A20691
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0108A20691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii5V-0003Hn-OL
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jihdn-0003K6-L1; Tue, 09 Jun 2020 13:02:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jihdl-0007O6-IR; Tue, 09 Jun 2020 13:02:23 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McpaE-1j8or81WXC-00a0wE; Tue, 09 Jun 2020 19:02:12 +0200
Subject: Re: [PATCH] hw/unicore32/puv3: Use qemu_log_mask(ERROR) instead of
 debug printf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200524164503.11944-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <827c7ed6-6c1a-306b-a6e8-3e24c36fadc3@vivier.eu>
Date: Tue, 9 Jun 2020 19:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524164503.11944-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y3RSFJUWu65rM5DlPFpv8MohQAXk8B+Ajpr6wRviHNrgTNYvc9f
 eyJR2WI07Te8eb+EftZAlTfsEXfa+dXT/zBclA30nrKmfS8RjvEXvWbWo6OuiMhL54NHSYJ
 ymQcYYgooCMvjZl7f1uJ8TQojQDNH9u8p7J8OEtKX7Equ51ugZWF9daGi2Lti0tpkwg6u8K
 fjyiNi8GDL1BLLpYbwKwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TWy+DFppmoM=:lYxcyeqIzUHrG3VC8JntGi
 wUUFSHKce6fnxlnRu9DvKtL9nn6g125SWHv2JkEkjUKiUIvBVFKfc+mnNaGRcbHam0axBQxCr
 z9O6gPDrs1U52xr7aGbsXLq4hFHKYZ3cyf0I4XL2EKIlvVZ4KxbDnAt629/ReW4bvpoOJEE5+
 L5QeHygG1jTLKaSrdYN5DROXXPHqOfuHHBh1+vg2fVyz0dZFfKFADiEpe5RrRIFXoXhqxYBEp
 ELDhndQn7+ZJs8SCu/UtXhci9e2k0HwbLPbfiJzD+B3bPIYUFYRlUIRrgzY6ztUoOXR2DF3Lw
 5y+TuspkmB3yD7PBiG2pqV5PfpWSPQV/lupB6CTnk9ypEvu6/8hh3ecjeF1XdRu5eyihUKdnk
 Eys2zodssoUClB2q1APNCEK2hhKVdk5E5i+RpTsZEJ0cpPgxfqFYoxQaPEBM0+XBYpx8DKSN9
 lNtUW3NYbOsA6VqMePmIpZYj6eRh0oO2NFpZbNW7ACmz2585SyZumsSPLZC2Q60BzqYH4LG1q
 JxsTOOctC+KR9FIagmLf9DnwG8r/fH41V7fCEFqKjJo7I0bxOdvMEXZfXR6cOxhrUAzdbI7/L
 lx1ubsFaRQFTaPJoQt01ksZHopO9H2bAwdcj544FZufcJSrOP19pu5dwHAq9ImR2eI5LETS+/
 47QsLph5rtdOtLqxtq+ovVnynV3RAuy6T3DliRybeCOukXO65Ss72q7yBgPjIDSAMjXDXunBM
 YhFLH1v7uDZJOWRrB8YLxd5j48a1yeBztp6dUKMReNJsLA1xV2aNLmYAg9+9yanJCVDwA9Gbg
 R36y7K23NqmnB7Xxe7DMO5r0Vq3PXVx6OKiYI5KLS7d9ACQF2OA7PvGduNu2wRVIJ/O+Oym
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 12:55:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/05/2020 à 18:45, Philippe Mathieu-Daudé a écrit :
> Replace some debug printf() calls by qemu_log_mask(LOG_GUEST_ERROR).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/dma/puv3_dma.c   |  9 +++++++--
>  hw/gpio/puv3_gpio.c | 15 +++++++++++----
>  hw/intc/puv3_intc.c |  9 +++++++--
>  hw/misc/puv3_pm.c   |  9 +++++++--
>  hw/timer/puv3_ost.c |  9 +++++++--
>  hw/unicore32/puv3.c |  2 --
>  6 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
> index 5488d388a9..7fa979180f 100644
> --- a/hw/dma/puv3_dma.c
> +++ b/hw/dma/puv3_dma.c
> @@ -15,6 +15,7 @@
>  #undef DEBUG_PUV3
>  #include "hw/unicore32/puv3.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  
>  #define PUV3_DMA_CH_NR          (6)
>  #define PUV3_DMA_CH_MASK        (0xff)
> @@ -43,7 +44,9 @@ static uint64_t puv3_dma_read(void *opaque, hwaddr offset,
>          ret = s->reg_CFG[PUV3_DMA_CH(offset)];
>          break;
>      default:
> -        DPRINTF("Bad offset 0x%x\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>      DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
>  
> @@ -62,7 +65,9 @@ static void puv3_dma_write(void *opaque, hwaddr offset,
>          s->reg_CFG[PUV3_DMA_CH(offset)] = value;
>          break;
>      default:
> -        DPRINTF("Bad offset 0x%x\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>      DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
>  }
> diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
> index d19e342514..7362b6715f 100644
> --- a/hw/gpio/puv3_gpio.c
> +++ b/hw/gpio/puv3_gpio.c
> @@ -15,6 +15,7 @@
>  #undef DEBUG_PUV3
>  #include "hw/unicore32/puv3.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  
>  #define TYPE_PUV3_GPIO "puv3_gpio"
>  #define PUV3_GPIO(obj) OBJECT_CHECK(PUV3GPIOState, (obj), TYPE_PUV3_GPIO)
> @@ -47,7 +48,9 @@ static uint64_t puv3_gpio_read(void *opaque, hwaddr offset,
>          ret = s->reg_GPIR;
>          break;
>      default:
> -        DPRINTF("Bad offset 0x%x\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>      DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
>  
> @@ -68,14 +71,16 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
>          if (s->reg_GPDR & value) {
>              s->reg_GPLR |= value;
>          } else {
> -            DPRINTF("Write gpio input port error!");
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write gpio input port\n",
> +                          __func__);
>          }
>          break;
>      case 0x0c:
>          if (s->reg_GPDR & value) {
>              s->reg_GPLR &= ~value;
>          } else {
> -            DPRINTF("Write gpio input port error!");
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write gpio input port\n",
> +                          __func__);
>          }
>          break;
>      case 0x10: /* GRER */
> @@ -86,7 +91,9 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
>          s->reg_GPIR = value;
>          break;
>      default:
> -        DPRINTF("Bad offset 0x%x\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>  }
>  
> diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
> index e018955ce8..090d4839d1 100644
> --- a/hw/intc/puv3_intc.c
> +++ b/hw/intc/puv3_intc.c
> @@ -16,6 +16,7 @@
>  #undef DEBUG_PUV3
>  #include "hw/unicore32/puv3.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  
>  #define TYPE_PUV3_INTC "puv3_intc"
>  #define PUV3_INTC(obj) OBJECT_CHECK(PUV3INTCState, (obj), TYPE_PUV3_INTC)
> @@ -68,7 +69,9 @@ static uint64_t puv3_intc_read(void *opaque, hwaddr offset,
>          ret = s->reg_ICPR; /* the same value with ICPR */
>          break;
>      default:
> -        DPRINTF("Bad offset %x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>      DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
>      return ret;
> @@ -88,7 +91,9 @@ static void puv3_intc_write(void *opaque, hwaddr offset,
>          s->reg_ICMR = value;
>          break;
>      default:
> -        DPRINTF("Bad offset 0x%x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>          return;
>      }
>      puv3_intc_update(s);
> diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
> index c213500d9c..8989d363cd 100644
> --- a/hw/misc/puv3_pm.c
> +++ b/hw/misc/puv3_pm.c
> @@ -15,6 +15,7 @@
>  #undef DEBUG_PUV3
>  #include "hw/unicore32/puv3.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  
>  #define TYPE_PUV3_PM "puv3_pm"
>  #define PUV3_PM(obj) OBJECT_CHECK(PUV3PMState, (obj), TYPE_PUV3_PM)
> @@ -73,7 +74,9 @@ static uint64_t puv3_pm_read(void *opaque, hwaddr offset,
>          ret = 0x7;
>          break;
>      default:
> -        DPRINTF("Bad offset 0x%x\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>      DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
>  
> @@ -105,7 +108,9 @@ static void puv3_pm_write(void *opaque, hwaddr offset,
>      case 0x38:
>          break;
>      default:
> -        DPRINTF("Bad offset 0x%x\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>      DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
>  }
> diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
> index 697519593b..f76b0bb1ca 100644
> --- a/hw/timer/puv3_ost.c
> +++ b/hw/timer/puv3_ost.c
> @@ -14,6 +14,7 @@
>  #include "hw/irq.h"
>  #include "hw/ptimer.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  
>  #undef DEBUG_PUV3
>  #include "hw/unicore32/puv3.h"
> @@ -52,7 +53,9 @@ static uint64_t puv3_ost_read(void *opaque, hwaddr offset,
>          ret = s->reg_OIER;
>          break;
>      default:
> -        DPRINTF("Bad offset %x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>      DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
>      return ret;
> @@ -88,7 +91,9 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
>          s->reg_OIER = value;
>          break;
>      default:
> -        DPRINTF("Bad offset %x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, offset);
>      }
>  }
>  
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 7f9c0238fe..eacacb4249 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -16,8 +16,6 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "sysemu/qtest.h"
> -
> -#undef DEBUG_PUV3
>  #include "hw/unicore32/puv3.h"
>  #include "hw/input/i8042.h"
>  #include "hw/irq.h"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


