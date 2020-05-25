Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E8DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 09:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F46F20787
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 09:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F46F20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd9ER-0007NW-E8
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 05:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jd9Dk-0006YA-Ii; Mon, 25 May 2020 05:16:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:50316
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jd9Dj-0003dT-R8; Mon, 25 May 2020 05:16:32 -0400
Received: from host109-156-104-24.range109-156.btcentralplus.com
 ([109.156.104.24] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jd9DZ-0000Og-HC; Mon, 25 May 2020 10:16:30 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200524165126.13920-1-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <1a402dac-ee39-f454-4488-c48d0e46da1f@ilande.co.uk>
Date: Mon, 25 May 2020 10:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524165126.13920-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.156.104.24
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/nvram/mac_nvram: Convert debug printf()s to trace
 events
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/2020 17:51, Philippe Mathieu-Daudé wrote:

> Convert NVR_DPRINTF() to trace events and remove ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/nvram/mac_nvram.c  | 17 +++--------------
>  hw/nvram/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
> index ff5db03e6b..beec1c4e4d 100644
> --- a/hw/nvram/mac_nvram.c
> +++ b/hw/nvram/mac_nvram.c
> @@ -30,18 +30,9 @@
>  #include "migration/vmstate.h"
>  #include "qemu/cutils.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>  #include <zlib.h>
>  
> -/* debug NVR */
> -//#define DEBUG_NVR
> -
> -#ifdef DEBUG_NVR
> -#define NVR_DPRINTF(fmt, ...)                                   \
> -    do { printf("NVR: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define NVR_DPRINTF(fmt, ...)
> -#endif
> -
>  #define DEF_SYSTEM_SIZE 0xc10
>  
>  /* macio style NVRAM device */
> @@ -51,9 +42,8 @@ static void macio_nvram_writeb(void *opaque, hwaddr addr,
>      MacIONVRAMState *s = opaque;
>  
>      addr = (addr >> s->it_shift) & (s->size - 1);
> +    trace_macio_nvram_write(addr, value);
>      s->data[addr] = value;
> -    NVR_DPRINTF("writeb addr %04" HWADDR_PRIx " val %" PRIx64 "\n",
> -                addr, value);
>  }
>  
>  static uint64_t macio_nvram_readb(void *opaque, hwaddr addr,
> @@ -64,8 +54,7 @@ static uint64_t macio_nvram_readb(void *opaque, hwaddr addr,
>  
>      addr = (addr >> s->it_shift) & (s->size - 1);
>      value = s->data[addr];
> -    NVR_DPRINTF("readb addr %04" HWADDR_PRIx " val %" PRIx32 "\n",
> -                addr, value);
> +    trace_macio_nvram_read(addr, value);
>  
>      return value;
>  }
> diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
> index 0dea9260ce..e023193295 100644
> --- a/hw/nvram/trace-events
> +++ b/hw/nvram/trace-events
> @@ -13,3 +13,7 @@ fw_cfg_add_string(uint16_t key_value, const char *key_name, const char *value) "
>  fw_cfg_add_i16(uint16_t key_value, const char *key_name, uint16_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx16
>  fw_cfg_add_i32(uint16_t key_value, const char *key_name, uint32_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx32
>  fw_cfg_add_i64(uint16_t key_value, const char *key_name, uint64_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx64
> +
> +# mac_nvram.c
> +macio_nvram_read(uint32_t addr, uint8_t val) "read addr=0x%04"PRIx32" val=0x%02x"
> +macio_nvram_write(uint32_t addr, uint8_t val) "write addr=0x%04"PRIx32" val=0x%02x"

Looks good to me.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

