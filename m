Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7ACC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0386A2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0386A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooAY-0002k1-AS
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joo9x-0002Eh-Qs; Fri, 26 Jun 2020 09:12:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:35024
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joo9u-0007DX-4k; Fri, 26 Jun 2020 09:12:49 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1joo9n-0000e1-T5; Fri, 26 Jun 2020 14:12:47 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <ecaaee4ba802b7a53de03e401c4d68e94de554f5.1592315226.git.balaton@eik.bme.hu>
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
Message-ID: <3012998c-8345-f654-1de1-dd623ef375e8@ilande.co.uk>
Date: Fri, 26 Jun 2020 14:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ecaaee4ba802b7a53de03e401c4d68e94de554f5.1592315226.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 09/11] macio: Add dummy screamer register area
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
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/2020 14:47, BALATON Zoltan wrote:

> The only thing this returns is an idle status so the firmware
> continues, otherwise just ignores and logs access for debugging. This
> is a stop gap until proper implementation of this device lands.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/misc/macio/macio.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 8ba7af073c..c7e8556ca6 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  #include "hw/ppc/mac.h"
>  #include "hw/misc/macio/cuda.h"
>  #include "hw/pci/pci.h"
> @@ -94,6 +95,33 @@ static void macio_bar_setup(MacIOState *s)
>      macio_escc_legacy_setup(s);
>  }
>  
> +#define AWAC_CODEC_STATUS_REG 0x20
> +
> +#define AWAC_MAKER_CRYSTAL 1
> +#define AWAC_REV_SCREAMER 3
> +#define AWAC_VALID_DATA 0x40
> +
> +static uint64_t screamer_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                  "macio: screamer read %" HWADDR_PRIx "  %d\n", addr, size);
> +    return (addr == AWAC_CODEC_STATUS_REG ? AWAC_VALID_DATA << 8 |
> +            AWAC_MAKER_CRYSTAL << 16 | AWAC_REV_SCREAMER << 20 : 0);
> +}
> +
> +static void screamer_write(void *opaque, hwaddr addr,
> +                           uint64_t val, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                  "macio: screamer write %" HWADDR_PRIx "  %d = %"PRIx64"\n",
> +                  addr, size, val);
> +}
> +
> +const MemoryRegionOps screamer_ops = {
> +    .read = screamer_read,
> +    .write = screamer_write,
> +};

static const.

>  static void macio_common_realize(PCIDevice *d, Error **errp)
>  {
>      MacIOState *s = MACIO(d);
> @@ -149,6 +177,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
>      DeviceState *pic_dev = DEVICE(os->pic);
>      Error *err = NULL;
>      SysBusDevice *sysbus_dev;
> +    MemoryRegion *screamer = g_new(MemoryRegion, 1);
>  
>      macio_common_realize(d, &err);
>      if (err) {
> @@ -208,6 +237,11 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> +
> +    /* Dummy screamer sound device */
> +    memory_region_init_io(screamer, OBJECT(d), &screamer_ops, NULL,
> +                          "screamer", 0x2000);
> +    memory_region_add_subregion(&s->bar, 0x14000, screamer);
>  }
>  
>  static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, int index)

Again I'm wary of adding empty devices here as the main issue around the screamer
code (and why it has not been submitted upstream) is that it can cause random hangs
for MacOS on startup. Does it regress any MacOS 9 through 10.5 boot tests?

FWIW I've rebased the latest version of my screamer branch at
https://github.com/mcayland/qemu/commits/screamer to git master if you want to see if
any noise comes out.


ATB,

Mark.

