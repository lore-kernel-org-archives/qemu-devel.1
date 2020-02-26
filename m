Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509FBC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 03:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8932067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 03:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="TOdfVf2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8932067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ngL-0000yC-3n
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 22:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1j6ndy-0000Il-SX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1j6ndx-0001m5-KG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:45:54 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:44144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1j6ndt-0001ch-VB; Tue, 25 Feb 2020 22:45:50 -0500
Received: by mail-qv1-xf43.google.com with SMTP id by15so614853qvb.11;
 Tue, 25 Feb 2020 19:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RdUwzPHr0EsP2DPfTpOPFqh3f4LQ7hBAEwsEVS+4tEs=;
 b=TOdfVf2DcFqYrq6ET+Breltgoa8ckCqfhz5qYZBQolSo400w2XSVZroXyq+aZU0Bho
 pTIN3fHGtFdXJSomEdttWn0me6BG6xSjjxrYP4IcJMttSWSS/AnQ/aFcnEWrRvZxAAaK
 rJ6UFbLydd+DVlQNUu9qrvNOwjNveKi1jM1X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RdUwzPHr0EsP2DPfTpOPFqh3f4LQ7hBAEwsEVS+4tEs=;
 b=Lpr02OOxmaTMvDHyvqX+YGpR5eOsMi9VgeyuihDLY5hKDSAsJiFaRT4pPZcG9CCXMA
 /+BeiLL2/LOf8P3dAWo34Kk3XfxNfV0YDfSqArOihE/I8ZGRVEH5Kw+dh+2PgxrIEmU4
 Aah6kX9y22pJ4h3zp3mutE+seEDUvBTHh8WNk6yZwamikxuh3FdiMZxjvB5bBY9+hcYG
 mPYs/x1d0LGs1ubmISEYVyZAN+mIH5Pwstu91bdQC3+Sgr6CpN7Mg6yD9yhYmassoeWC
 rO8zGq8L7y/Tmna9kCoBlqdB4KXxIPi93r5/4NNeFTTXbW4gkmlB34AmYm/WIxuoqkYq
 dhSw==
X-Gm-Message-State: APjAAAXNy5q3HDqunzd0XoAUbGDGqkB1rr/VVNSuRUbiGKDJtiI6MSw7
 HchmEJyR39ka3OAGoRwza7m/ix7tN4QP0f4N6Ns=
X-Google-Smtp-Source: APXvYqyK+Hv5N7bZ7O2+Jto0YXwUW+Rpft85PkGO+Tv1tlvbb1rWxjfVUHSH6vW0kRVckzDyqAFcRrtzDTGOAcQLQ6E=
X-Received: by 2002:a05:6214:17c5:: with SMTP id
 cu5mr2491460qvb.210.1582688748986; 
 Tue, 25 Feb 2020 19:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20200206112645.21275-1-clg@kaod.org>
 <20200206112645.21275-2-clg@kaod.org>
In-Reply-To: <20200206112645.21275-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 26 Feb 2020 03:45:37 +0000
Message-ID: <CACPK8XcDdfUVj9APG8N=E8Fm28F-ZsAqDXjx4YmCUR3HLWA4ig@mail.gmail.com>
Subject: Re: [PATCH 1/2] aspeed/smc: Add some tracing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Geissler <geissonator@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

n

On Thu, 6 Feb 2020 at 11:27, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
>  Makefile.objs       |  1 +
>  hw/ssi/aspeed_smc.c | 17 +++++++++++++++++
>  hw/ssi/trace-events |  9 +++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 hw/ssi/trace-events
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 26b9cff95436..9e4ba95794e9 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -168,6 +168,7 @@ trace-events-subdirs +=3D hw/scsi
>  trace-events-subdirs +=3D hw/sd
>  trace-events-subdirs +=3D hw/sparc
>  trace-events-subdirs +=3D hw/sparc64
> +trace-events-subdirs +=3D hw/ssi
>  trace-events-subdirs +=3D hw/timer
>  trace-events-subdirs +=3D hw/tpm
>  trace-events-subdirs +=3D hw/usb
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 23c8d2f06245..e5621bf728ca 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -31,6 +31,7 @@
>  #include "qapi/error.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/units.h"
> +#include "trace.h"
>
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> @@ -513,6 +514,8 @@ static void aspeed_smc_flash_set_segment(AspeedSMCSta=
te *s, int cs,
>
>      s->ctrl->reg_to_segment(s, new, &seg);
>
> +    trace_aspeed_smc_flash_set_segment(cs, new, seg.addr, seg.addr + seg=
.size);
> +
>      /* The start address of CS0 is read-only */
>      if (cs =3D=3D 0 && seg.addr !=3D s->ctrl->flash_window_base) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -753,6 +756,8 @@ static uint64_t aspeed_smc_flash_read(void *opaque, h=
waddr addr, unsigned size)
>                        __func__, aspeed_smc_flash_mode(fl));
>      }
>
> +    trace_aspeed_smc_flash_read(fl->id, addr, size, ret,
> +                                aspeed_smc_flash_mode(fl));
>      return ret;
>  }
>
> @@ -808,6 +813,9 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  =
uint64_t data,
>      AspeedSMCState *s =3D fl->controller;
>      uint8_t addr_width =3D aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
>
> +    trace_aspeed_smc_do_snoop(fl->id, s->snoop_index, s->snoop_dummies,
> +                              (uint8_t) data & 0xff);
> +
>      if (s->snoop_index =3D=3D SNOOP_OFF) {
>          return false; /* Do nothing */
>
> @@ -858,6 +866,9 @@ static void aspeed_smc_flash_write(void *opaque, hwad=
dr addr, uint64_t data,
>      AspeedSMCState *s =3D fl->controller;
>      int i;
>
> +    trace_aspeed_smc_flash_write(fl->id, addr, size, data,
> +                                 aspeed_smc_flash_mode(fl));
> +
>      if (!aspeed_smc_is_writable(fl)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: flash is not writable at 0x%=
"
>                        HWADDR_PRIx "\n", __func__, addr);
> @@ -972,6 +983,9 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr =
addr, unsigned int size)
>          (s->ctrl->has_dma && addr =3D=3D R_DMA_CHECKSUM) ||
>          (addr >=3D R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slav=
es) ||
>          (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves=
)) {
> +
> +        trace_aspeed_smc_read(addr, size, s->regs[addr]);
> +
>          return s->regs[addr];
>      } else {
>          qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx =
"\n",
> @@ -1091,6 +1105,7 @@ static void aspeed_smc_dma_checksum(AspeedSMCState =
*s)
>                            __func__, s->regs[R_DMA_FLASH_ADDR]);
>              return;
>          }
> +        trace_aspeed_smc_dma_checksum(s->regs[R_DMA_FLASH_ADDR], data);
>
>          /*
>           * When the DMA is on-going, the DMA registers are updated
> @@ -1225,6 +1240,8 @@ static void aspeed_smc_write(void *opaque, hwaddr a=
ddr, uint64_t data,
>
>      addr >>=3D 2;
>
> +    trace_aspeed_smc_write(addr, size, data);
> +
>      if (addr =3D=3D s->r_conf ||
>          (addr >=3D s->r_timings &&
>           addr < s->r_timings + s->ctrl->nregs_timings) ||
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> new file mode 100644
> index 000000000000..ffe531a500aa
> --- /dev/null
> +++ b/hw/ssi/trace-events
> @@ -0,0 +1,9 @@
> +# aspeed_smc.c
> +
> +aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint6=
4_t end) "CS%d segreg=3D0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
> +aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t da=
ta, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
> +aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d inde=
x:0x%x dummies:%d data:0x%x"
> +aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t d=
ata, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
> +aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRI=
x64 " size %u: 0x%" PRIx64
> +aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
> +aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PR=
Ix64 " size %u: 0x%" PRIx64
> --
> 2.21.1
>

