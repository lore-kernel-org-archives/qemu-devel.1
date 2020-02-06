Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B2C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B28320838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B28320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdqA-000085-HR
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izdpR-00083r-1D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izdpN-0007xh-1u
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:52:08 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izdpM-0007dR-NN; Thu, 06 Feb 2020 04:52:04 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MBE3k-1ipAmU1YRa-00CiFf; Thu, 06 Feb 2020 10:52:00 +0100
Subject: Re: [PATCH v3 2/2] hw/timer/m48t59: Convert debug printf()s to trace
 events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20200117165809.31067-1-philmd@redhat.com>
 <20200117165809.31067-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <266f5004-8245-9a37-34a0-d3bebadf6ef7@vivier.eu>
Date: Thu, 6 Feb 2020 10:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117165809.31067-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JIpKapatKnxrDxKA0o/8c1XZ9p8SqRTzo5aacvKk+Pu7LyaRmfx
 nqPYuE/B/OCwDGD1fi+WXIKhZI5woSnjwIkbIPRnh3OHrHXMmq0oFfBp5tCefsfpBPrjXEt
 kgtl+HLe2ny7xw2rpJdUBaDYQpj02O8e8UQUiKQHbPSgqibrEaxmPzbmEW3wgG+6ounUFyq
 oxKXZnEInqHMNl3rzBkyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DeeSZEVBDyk=:KWuv5EFtOh2xs8CJP3E0s0
 DEPcsArrCosAx/8CvZOxCZGkgg1zMv/zdmACzHJaXx+l8gvBl9xEFpqgKothMzXXLmMP0oNSJ
 dm0Rf9/Lvfp5M6ITT8TqOzr9zOOmCo0nJaZaV+aiJKVkQvqMWpiHn33soKsHqh2c+lmS3mAvI
 2N+Vcniu5ULhpx6R4ccBRNs9KM4Idt04KubTfiBDF1zQwEO5Ir47mWCDXKSfIazDNgE01oWei
 LluvFKvd9kRDtO3zpSwgWXbzb2J/NMq7r1kpsqTG973hIBliTnap++ESwobc0mr6Uixudx326
 DEYHrJnlmbezlVec9wjTaw9/4P2OBJtrjIKYvtMX9/u7iix4jdS1qdDD2WGl7pUzzOClqnkUV
 oiUNatwIhF6demk4W68CBMR8rZmErSAtrdjj+H0oDdQNpOAj6mR31SjGax2jtNkmtfFvBiLi1
 vNCksol0RpsXRAgAuEZNp/Rs/D0O/+BJNDImIWqELZgm3yC+tgWQCFo4NSh/GRL4egmBgAn8T
 /smzSCepYYrHhzhmoEvwbBMg8uv5D0oVL+J/RT6f9i26YmL3Bol93hTYRWArICAqzqQQzQEEs
 M4zWUw21hq/VVpZUKQ0vJ2cvEGxgM/DRrhO5jVC2Vp9y1YJZTOKMQIrBRv4wWdIm3cp3LBtGK
 OX6rHZobfEn9ak+EyX2I9PNrnTdue5i9rmJZpMOLmHUsmDnn42lBSMRAXsuG1fUinPv2ZCQUu
 hh+Bw2u+wEkSdE+b4uSNVaUAKc13N4qUor3tMQnaT91XVM/P/BrFOHSxb9CJ1CnkEc/YD2YOn
 QNIkzr5Fto77POnRPI9vZX4JxpO2QW6ikH5a9NKY6fzAJUMQ1MxOsm3+YNpw8i44AT7F9Fl
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/01/2020 à 17:58, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/rtc/m48t59-internal.h |  5 -----
>  hw/rtc/m48t59.c          | 11 +++++------
>  hw/rtc/trace-events      |  6 ++++++
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/rtc/m48t59-internal.h b/hw/rtc/m48t59-internal.h
> index 4d4f2a6fed..cd648241e9 100644
> --- a/hw/rtc/m48t59-internal.h
> +++ b/hw/rtc/m48t59-internal.h
> @@ -26,11 +26,6 @@
>  #ifndef HW_M48T59_INTERNAL_H
>  #define HW_M48T59_INTERNAL_H
>  
> -#define M48T59_DEBUG 0
> -
> -#define NVRAM_PRINTF(fmt, ...) do { \
> -    if (M48T59_DEBUG) { printf(fmt , ## __VA_ARGS__); } } while (0)
> -
>  /*
>   * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 has
>   * alarm and a watchdog timer and related control registers. In the
> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> index fc592b9fb1..ecc92ca476 100644
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -35,6 +35,7 @@
>  #include "exec/address-spaces.h"
>  #include "qemu/bcd.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>  
>  #include "m48t59-internal.h"
>  #include "migration/vmstate.h"
> @@ -192,8 +193,7 @@ void m48t59_write(M48t59State *NVRAM, uint32_t addr, uint32_t val)
>      struct tm tm;
>      int tmp;
>  
> -    if (addr > 0x1FF8 && addr < 0x2000)
> -	NVRAM_PRINTF("%s: 0x%08x => 0x%08x\n", __func__, addr, val);
> +    trace_m48txx_nvram_mem_write(addr, val);
>  
>      /* check for NVRAM access */
>      if ((NVRAM->model == 2 && addr < 0x7f8) ||
> @@ -450,8 +450,7 @@ uint32_t m48t59_read(M48t59State *NVRAM, uint32_t addr)
>  	}
>          break;
>      }
> -    if (addr > 0x1FF9 && addr < 0x2000)
> -       NVRAM_PRINTF("%s: 0x%08x <= 0x%08x\n", __func__, addr, retval);
> +    trace_m48txx_nvram_mem_read(addr, retval);
>  
>      return retval;
>  }
> @@ -462,7 +461,7 @@ static void NVRAM_writeb(void *opaque, hwaddr addr, uint64_t val,
>  {
>      M48t59State *NVRAM = opaque;
>  
> -    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" => 0x%"PRIx64"\n", __func__, addr, val);
> +    trace_m48txx_nvram_io_write(addr, val);
>      switch (addr) {
>      case 0:
>          NVRAM->addr &= ~0x00FF;
> @@ -494,7 +493,7 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr, unsigned size)
>          retval = -1;
>          break;
>      }
> -    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" <= 0x%08x\n", __func__, addr, retval);
> +    trace_m48txx_nvram_io_read(addr, retval);
>  
>      return retval;
>  }
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index d6749f4616..52c1566198 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -17,3 +17,9 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
>  # aspeed-rtc.c
>  aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
>  aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> +
> +# m48t59.c
> +m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04" PRIx64 " value:0x%02" PRIx64
> +m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx64 " value:0x%02" PRIx64
> +m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%04x value:0x%02x"
> +m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x value:0x%02x"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

