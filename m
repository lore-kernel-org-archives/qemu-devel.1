Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09626C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCEC2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCEC2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMTKj-0002nQ-Ro
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 04:14:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTIQ-0001Xg-I1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTIL-0008Ou-EY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:11:52 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:34564
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hMTIL-0008O4-4h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:11:49 -0400
Received: from host109-149-60-255.range109-149.btcentralplus.com
	([109.149.60.255] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hMTFc-0005jE-PW; Fri, 03 May 2019 09:09:02 +0100
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
References: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
	<1556194715-24427-3-git-send-email-frederic.konrad@adacore.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
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
Message-ID: <d0aeae41-d3f4-964b-077a-1a1c005ec9e3@ilande.co.uk>
Date: Fri, 3 May 2019 09:09:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556194715-24427-3-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.149.60.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH v2 2/3] leon3: introduce the plug and play
 mecanism
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, philmd@redhat.com, atar4qemu@gmail.com,
	chouteau@adacore.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503080933.lplm9ZGLFojTDQJsf86IZsVyVKwI3p00N_bJBK9uNYg@z>

On 25/04/2019 13:18, KONRAD Frederic wrote:

> This adds the AHB and APB plug and play devices.
> They are scanned during the linux boot to discover the various peripheral.
> 
> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  hw/misc/Makefile.objs               |   2 +
>  hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++++++++++++
>  hw/sparc/leon3.c                    |  34 ++++-
>  include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
>  include/hw/sparc/grlib.h            |  35 +++--
>  5 files changed, 382 insertions(+), 18 deletions(-)
>  create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
>  create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h
> 
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index c71e07a..77b9df9 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -77,3 +77,5 @@ obj-$(CONFIG_AUX) += auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
>  obj-$(CONFIG_MSF2) += msf2-sysreg.o
>  obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
> +
> +obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
> diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
> new file mode 100644
> index 0000000..90d5f6e
> --- /dev/null
> +++ b/hw/misc/grlib_ahb_apb_pnp.c
> @@ -0,0 +1,269 @@
> +/*
> + * GRLIB AHB APB PNP
> + *
> + *  Copyright (C) 2019 AdaCore
> + *
> + *  Developed by :
> + *  Frederic Konrad   <frederic.konrad@adacore.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/grlib_ahb_apb_pnp.h"
> +
> +#define GRLIB_PNP_VENDOR_SHIFT (24)
> +#define GRLIB_PNP_VENDOR_SIZE   (8)
> +#define GRLIB_PNP_DEV_SHIFT    (12)
> +#define GRLIB_PNP_DEV_SIZE     (12)
> +#define GRLIB_PNP_VER_SHIFT     (5)
> +#define GRLIB_PNP_VER_SIZE      (5)
> +#define GRLIB_PNP_IRQ_SHIFT     (0)
> +#define GRLIB_PNP_IRQ_SIZE      (5)
> +#define GRLIB_PNP_ADDR_SHIFT   (20)
> +#define GRLIB_PNP_ADDR_SIZE    (12)
> +#define GRLIB_PNP_MASK_SHIFT    (4)
> +#define GRLIB_PNP_MASK_SIZE    (12)
> +
> +#define GRLIB_AHB_DEV_ADDR_SHIFT   (20)
> +#define GRLIB_AHB_DEV_ADDR_SIZE    (12)
> +#define GRLIB_AHB_ENTRY_SIZE       (0x20)
> +#define GRLIB_AHB_MAX_DEV          (64)
> +#define GRLIB_AHB_SLAVE_OFFSET     (0x800)
> +
> +#define GRLIB_APB_DEV_ADDR_SHIFT   (8)
> +#define GRLIB_APB_DEV_ADDR_SIZE    (12)
> +#define GRLIB_APB_ENTRY_SIZE       (0x08)
> +#define GRLIB_APB_MAX_DEV          (512)
> +
> +#define GRLIB_PNP_MAX_REGS         (0x1000)
> +
> +typedef struct AHBPnp {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +
> +    uint32_t regs[GRLIB_PNP_MAX_REGS >> 2];
> +    uint8_t master_count;
> +    uint8_t slave_count;
> +} AHBPnp;
> +
> +void grlib_ahb_pnp_add_entry(AHBPnp *dev, uint32_t address, uint32_t mask,
> +                             uint8_t vendor, uint16_t device, int slave,
> +                             int type)
> +{
> +    unsigned int reg_start;
> +
> +    /*
> +     * AHB entries look like this:
> +     *
> +     * 31 -------- 23 -------- 11 ----- 9 -------- 4 --- 0
> +     *  | VENDOR ID | DEVICE ID | IRQ ? | VERSION  | IRQ |
> +     *  --------------------------------------------------
> +     *  |                      USER                      |
> +     *  --------------------------------------------------
> +     *  |                      USER                      |
> +     *  --------------------------------------------------
> +     *  |                      USER                      |
> +     *  --------------------------------------------------
> +     *  |                      USER                      |
> +     *  --------------------------------------------------
> +     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
> +     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
> +     *  --------------------------------------------------
> +     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
> +     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
> +     *  --------------------------------------------------
> +     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
> +     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
> +     *  --------------------------------------------------
> +     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
> +     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
> +     *  --------------------------------------------------
> +     */
> +
> +    if (slave) {
> +        assert(dev->slave_count < GRLIB_AHB_MAX_DEV);
> +        reg_start = (GRLIB_AHB_SLAVE_OFFSET
> +                  + (dev->slave_count * GRLIB_AHB_ENTRY_SIZE)) >> 2;
> +        dev->slave_count++;
> +    } else {
> +        assert(dev->master_count < GRLIB_AHB_MAX_DEV);
> +        reg_start = (dev->master_count * GRLIB_AHB_ENTRY_SIZE) >> 2;
> +        dev->master_count++;
> +    }
> +
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_VENDOR_SHIFT,
> +                                     GRLIB_PNP_VENDOR_SIZE,
> +                                     vendor);
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_DEV_SHIFT,
> +                                     GRLIB_PNP_DEV_SIZE,
> +                                     device);
> +    reg_start += 4;
> +    /* AHB Memory Space */
> +    dev->regs[reg_start] = type;
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_ADDR_SHIFT,
> +                                     GRLIB_PNP_ADDR_SIZE,
> +                                     extract32(address,
> +                                               GRLIB_AHB_DEV_ADDR_SHIFT,
> +                                               GRLIB_AHB_DEV_ADDR_SIZE));
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_MASK_SHIFT,
> +                                     GRLIB_PNP_MASK_SIZE,
> +                                     mask);
> +}
> +
> +static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AHBPnp *ahb_pnp = GRLIB_AHB_PNP(opaque);
> +
> +    return ahb_pnp->regs[offset >> 2];
> +}
> +
> +static const MemoryRegionOps grlib_ahb_pnp_ops = {
> +    .read       = grlib_ahb_pnp_read,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};

Should be DEVICE_BIG_ENDIAN?

> +static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
> +{
> +    AHBPnp *ahb_pnp = GRLIB_AHB_PNP(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&ahb_pnp->iomem, OBJECT(dev), &grlib_ahb_pnp_ops,
> +                          ahb_pnp, TYPE_GRLIB_AHB_PNP, GRLIB_PNP_MAX_REGS);
> +    sysbus_init_mmio(sbd, &ahb_pnp->iomem);
> +}
> +
> +static void grlib_ahb_pnp_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = grlib_ahb_pnp_realize;

Since this requires wiring up in code (i.e. can't be instantiated in the monitor via
device_add) you'll need to mark the device as not user creatable e.g.

    /* Reason: Must be wired up in code (see leon3_generic_hw_init() function) */
    dc->user_creatable = false;

> +}
> +
> +static const TypeInfo grlib_ahb_pnp_info = {
> +    .name          = TYPE_GRLIB_AHB_PNP,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AHBPnp),
> +    .class_init    = grlib_ahb_pnp_class_init,
> +};
> +
> +/* APBPnp */
> +
> +typedef struct APBPnp {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +
> +    uint32_t regs[GRLIB_PNP_MAX_REGS >> 2];
> +    uint32_t entry_count;
> +} APBPnp;
> +
> +void grlib_apb_pnp_add_entry(APBPnp *dev, uint32_t address, uint32_t mask,
> +                             uint8_t vendor, uint16_t device, uint8_t version,
> +                             uint8_t irq, int type)
> +{
> +    unsigned int reg_start;
> +
> +    /*
> +     * APB entries look like this:
> +     *
> +     * 31 -------- 23 -------- 11 ----- 9 ------- 4 --- 0
> +     *  | VENDOR ID | DEVICE ID | IRQ ? | VERSION | IRQ |
> +     *
> +     * 31 ---------- 20 --- 15 ----------------- 3 ---- 0
> +     *  | ADDR[20..8] | 0000 |        MASK       | TYPE |
> +     */
> +
> +    assert(dev->entry_count < GRLIB_APB_MAX_DEV);
> +    reg_start = (dev->entry_count * GRLIB_APB_ENTRY_SIZE) >> 2;
> +    dev->entry_count++;
> +
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_VENDOR_SHIFT,
> +                                     GRLIB_PNP_VENDOR_SIZE,
> +                                     vendor);
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_DEV_SHIFT,
> +                                     GRLIB_PNP_DEV_SIZE,
> +                                     device);
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_VER_SHIFT,
> +                                     GRLIB_PNP_VER_SIZE,
> +                                     version);
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_IRQ_SHIFT,
> +                                     GRLIB_PNP_IRQ_SIZE,
> +                                     irq);
> +    reg_start += 1;
> +    dev->regs[reg_start] = type;
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_ADDR_SHIFT,
> +                                     GRLIB_PNP_ADDR_SIZE,
> +                                     extract32(address,
> +                                               GRLIB_APB_DEV_ADDR_SHIFT,
> +                                               GRLIB_APB_DEV_ADDR_SIZE));
> +    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
> +                                     GRLIB_PNP_MASK_SHIFT,
> +                                     GRLIB_PNP_MASK_SIZE,
> +                                     mask);
> +}
> +
> +static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    APBPnp *apb_pnp = GRLIB_APB_PNP(opaque);
> +
> +    return apb_pnp->regs[offset >> 2];
> +}
> +
> +static const MemoryRegionOps grlib_apb_pnp_ops = {
> +    .read       = grlib_apb_pnp_read,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};

and also here DEVICE_BIG_ENDIAN?

> +static void grlib_apb_pnp_realize(DeviceState *dev, Error **errp)
> +{
> +    APBPnp *apb_pnp = GRLIB_APB_PNP(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&apb_pnp->iomem, OBJECT(dev), &grlib_apb_pnp_ops,
> +                          apb_pnp, TYPE_GRLIB_APB_PNP, GRLIB_PNP_MAX_REGS);
> +    sysbus_init_mmio(sbd, &apb_pnp->iomem);
> +}
> +
> +static void grlib_apb_pnp_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = grlib_apb_pnp_realize;

Same again here: this device should be marked as not user creatable.

> +}
> +
> +static const TypeInfo grlib_apb_pnp_info = {
> +    .name          = TYPE_GRLIB_APB_PNP,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(APBPnp),
> +    .class_init    = grlib_apb_pnp_class_init,
> +};
> +
> +static void grlib_ahb_apb_pnp_register_types(void)
> +{
> +    type_register_static(&grlib_ahb_pnp_info);
> +    type_register_static(&grlib_apb_pnp_info);
> +}
> +
> +type_init(grlib_ahb_apb_pnp_register_types)
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index f25432c..03ff163 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -46,6 +46,13 @@
>  #define PROM_FILENAME        "u-boot.bin"
>  #define LEON3_PROM_OFFSET    (0x00000000)
>  #define LEON3_RAM_OFFSET     (0x40000000)
> +#define LEON3_APBUART_OFFSET (0x80000100)
> +#define LEON3_APBUART_IRQ    (0x3)
> +#define LEON3_IRQMP_OFFSET   (0x80000200)
> +#define LEON3_GPTIMER_OFFSET (0x80000300)
> +#define LEON3_GPTIMER_IRQ    (0x6)
> +#define LEON3_APB_PNP_OFFSET (0x800FF000)
> +#define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
>  
>  #define MAX_PILS 16
>  
> @@ -176,6 +183,8 @@ static void leon3_generic_hw_init(MachineState *machine)
>      int         bios_size;
>      int         prom_size;
>      ResetData  *reset_info;
> +    AHBPnp *ahb_pnp;
> +    APBPnp *apb_pnp;
>  
>      /* Init CPU */
>      cpu = SPARC_CPU(cpu_create(machine->cpu_type));
> @@ -189,9 +198,23 @@ static void leon3_generic_hw_init(MachineState *machine)
>      reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
>      qemu_register_reset(main_cpu_reset, reset_info);
>  
> +    ahb_pnp = GRLIB_AHB_PNP(object_new(TYPE_GRLIB_AHB_PNP));
> +    object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
> +    grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
> +                            GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
> +                            GRLIB_CPU_AREA);
> +
> +    apb_pnp = GRLIB_APB_PNP(object_new(TYPE_GRLIB_APB_PNP));
> +    object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
> +    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
> +                            GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
> +                            GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
> +
>      /* Allocate IRQ manager */
> -    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS,
> -                       &leon3_set_pil_in);
> +    grlib_irqmp_create(LEON3_IRQMP_OFFSET, env, &cpu_irqs, MAX_PILS,
> +                       &leon3_set_pil_in, apb_pnp);

Whilst we're here, is there any way we can get rid of these old-style create
functions? The general philosophy today is that rather than have multiple per-board
init functions, expose the required properties via qdev and then wire up the device
directly within the board itself.

A quick glance at the code suggests you can just move the contents of the relevant
functions from the header file directly inline with a few minor tweaks.

>      env->qemu_irq_ack = leon3_irq_manager;
>  
> @@ -270,11 +293,14 @@ static void leon3_generic_hw_init(MachineState *machine)
>      }
>  
>      /* Allocate timers */
> -    grlib_gptimer_create(0x80000300, 2, CPU_CLK, cpu_irqs, 6);
> +    grlib_gptimer_create(LEON3_GPTIMER_OFFSET, 2, CPU_CLK, cpu_irqs,
> +                         LEON3_GPTIMER_IRQ,
> +                         apb_pnp);

And here.

>      /* Allocate uart */
>      if (serial_hd(0)) {
> -        grlib_apbuart_create(0x80000100, serial_hd(0), cpu_irqs[3]);
> +        grlib_apbuart_create(LEON3_APBUART_OFFSET, serial_hd(0), cpu_irqs,
> +                             LEON3_APBUART_IRQ, apb_pnp);

And here too.

>      }
>  }
>  
> diff --git a/include/hw/misc/grlib_ahb_apb_pnp.h b/include/hw/misc/grlib_ahb_apb_pnp.h
> new file mode 100644
> index 0000000..a0f6dcf
> --- /dev/null
> +++ b/include/hw/misc/grlib_ahb_apb_pnp.h
> @@ -0,0 +1,60 @@
> +/*
> + * GRLIB AHB APB PNP
> + *
> + *  Copyright (C) 2019 AdaCore
> + *
> + *  Developed by :
> + *  Frederic Konrad   <frederic.konrad@adacore.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#ifndef GRLIB_AHB_APB_PNP_H
> +#define GRLIB_AHB_APB_PNP_H
> +
> +#define TYPE_GRLIB_AHB_PNP "grlib,ahbpnp"
> +#define GRLIB_AHB_PNP(obj) \
> +    OBJECT_CHECK(AHBPnp, (obj), TYPE_GRLIB_AHB_PNP)
> +typedef struct AHBPnp AHBPnp;
> +
> +#define TYPE_GRLIB_APB_PNP "grlib,apbpnp"
> +#define GRLIB_APB_PNP(obj) \
> +    OBJECT_CHECK(APBPnp, (obj), TYPE_GRLIB_APB_PNP)
> +typedef struct APBPnp APBPnp;
> +
> +void grlib_ahb_pnp_add_entry(AHBPnp *dev, uint32_t address, uint32_t mask,
> +                             uint8_t vendor, uint16_t device, int slave,
> +                             int type);
> +void grlib_apb_pnp_add_entry(APBPnp *dev, uint32_t address, uint32_t mask,
> +                             uint8_t vendor, uint16_t device, uint8_t version,
> +                             uint8_t irq, int type);
> +
> +/* VENDORS */
> +#define GRLIB_VENDOR_GAISLER (0x01)
> +/* DEVICES */
> +#define GRLIB_LEON3_DEV      (0x03)
> +#define GRLIB_APBMST_DEV     (0x06)
> +#define GRLIB_APBUART_DEV    (0x0C)
> +#define GRLIB_IRQMP_DEV      (0x0D)
> +#define GRLIB_GPTIMER_DEV    (0x11)
> +/* TYPE */
> +#define GRLIB_CPU_AREA       (0x00)
> +#define GRLIB_APBIO_AREA     (0x01)
> +#define GRLIB_AHBMEM_AREA    (0x02)
> +
> +#define GRLIB_AHB_MASTER     (0x00)
> +#define GRLIB_AHB_SLAVE      (0x01)
> +
> +#endif /* GRLIB_AHB_APB_PNP_H */
> diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
> index 61a345c..28320ab 100644
> --- a/include/hw/sparc/grlib.h
> +++ b/include/hw/sparc/grlib.h
> @@ -27,6 +27,7 @@
>  
>  #include "hw/qdev.h"
>  #include "hw/sysbus.h"
> +#include "hw/misc/grlib_ahb_apb_pnp.h"
>  
>  /* Emulation of GrLib device is base on the GRLIB IP Core User's Manual:
>   * http://www.gaisler.com/products/grlib/grip.pdf
> @@ -41,11 +42,9 @@ void grlib_irqmp_set_irq(void *opaque, int irq, int level);
>  void grlib_irqmp_ack(DeviceState *dev, int intno);
>  
>  static inline
> -DeviceState *grlib_irqmp_create(hwaddr   base,
> -                                CPUSPARCState            *env,
> -                                qemu_irq           **cpu_irqs,
> -                                uint32_t             nr_irqs,
> -                                set_pil_in_fn        set_pil_in)
> +DeviceState *grlib_irqmp_create(hwaddr base, CPUSPARCState *env,
> +                                qemu_irq **cpu_irqs, uint32_t nr_irqs,
> +                                set_pil_in_fn set_pil_in, APBPnp *apb_pnp)
>  {
>      DeviceState *dev;
>  
> @@ -65,17 +64,18 @@ DeviceState *grlib_irqmp_create(hwaddr   base,
>                                     dev,
>                                     nr_irqs);
>  
> +    /* Register this device in the APB PNP device */
> +    grlib_apb_pnp_add_entry(apb_pnp, base, 0xFFF, GRLIB_VENDOR_GAISLER,
> +                            GRLIB_IRQMP_DEV, 2, 0, GRLIB_APBIO_AREA);
>      return dev;
>  }
>  
>  /* GPTimer */
>  
>  static inline
> -DeviceState *grlib_gptimer_create(hwaddr  base,
> -                                  uint32_t            nr_timers,
> -                                  uint32_t            freq,
> -                                  qemu_irq           *cpu_irqs,
> -                                  int                 base_irq)
> +DeviceState *grlib_gptimer_create(hwaddr base, uint32_t nr_timers,
> +                                  uint32_t freq, qemu_irq *cpu_irqs,
> +                                  int base_irq, APBPnp *apb_pnp)
>  {
>      DeviceState *dev;
>      int i;
> @@ -93,15 +93,18 @@ DeviceState *grlib_gptimer_create(hwaddr  base,
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, cpu_irqs[base_irq + i]);
>      }
>  
> +    /* Register this device in the APB PNP device */
> +    grlib_apb_pnp_add_entry(apb_pnp, base, 0xFFF, GRLIB_VENDOR_GAISLER,
> +                            GRLIB_GPTIMER_DEV, 0, base_irq, GRLIB_APBIO_AREA);
>      return dev;
>  }
>  
>  /* APB UART */
>  
>  static inline
> -DeviceState *grlib_apbuart_create(hwaddr  base,
> -                                  Chardev    *serial,
> -                                  qemu_irq            irq)
> +DeviceState *grlib_apbuart_create(hwaddr base, Chardev *serial,
> +                                  qemu_irq *cpu_irqs, int base_irq,
> +                                  APBPnp *apb_pnp)
>  {
>      DeviceState *dev;
>  
> @@ -112,7 +115,11 @@ DeviceState *grlib_apbuart_create(hwaddr  base,
>  
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>  
> -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[base_irq]);
> +
> +    /* Register this device in the APB PNP device */
> +    grlib_apb_pnp_add_entry(apb_pnp, base, 0xFFF, GRLIB_VENDOR_GAISLER,
> +                            GRLIB_APBUART_DEV, 1, base_irq, GRLIB_APBIO_AREA);
>  
>      return dev;
>  }
> 

Other than that, checkpatch gave a warning to check MAINTAINERS and it looks like
you're missing an entry for the new hw/misc/grlib_ahb_apb_pnp.h header file.

Finally there's a small typo in the commit message: mecanism -> mechanism.


ATB,

Mark.

