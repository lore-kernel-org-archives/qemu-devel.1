Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B1C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC312078A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJxouwcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC312078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOflx-0006dC-5s
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 07:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jOflI-00067W-E6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jOflF-0006DY-Di
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:59:20 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jOflF-0006CV-79; Wed, 15 Apr 2020 06:59:17 -0400
Received: by mail-io1-xd42.google.com with SMTP id o127so16693788iof.0;
 Wed, 15 Apr 2020 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Exzk85Ml7MsvrnSZT7z+XnLY0c+xkBwWqGu7kDMCfz4=;
 b=IJxouwcVxoZVWMTNR1Xj0EOh+VCRsFIe2+BKqv3zVPrkAuXgNnBHs1WbEQlxNfQOP3
 Y1K928GrfI/kLH56NC0HUgZUgkYAC8g4p5RufEICf5C0z8TZVwTPn/kC7wq3nxNZ+9Zs
 5iG6Ebbgab2kC3qMKVhLUSyjrBd/C8Tu0M1+K4nlTKyYmb50X+xr3w85XFeaiRgVzrgc
 5OfLAlYcIgRqRjjnlwZuxFPHeaWt8vuqAW56djUTP8ehRaVoW5Q24jBqfMsUaIp3BW5O
 SbSZXezNw756iReO17iEA29ErqiG3q74WOTEKFFPHF6fTKRb6adshg/hFMkEcRt5LFsn
 XgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Exzk85Ml7MsvrnSZT7z+XnLY0c+xkBwWqGu7kDMCfz4=;
 b=Lv+gioruSL1pWE5c0baq2kthSiH78BrUkIWmb95NuBctTituSPFs/ibHSXvuCy+YA8
 55sLnEZYTmSu2khAE9P2SCn+c+qIDnBvOIQigdh6xNNWXTRXAy0iMxNkIy4DlfxrsMAF
 DpQseMbf9venuVODXQBMwMmPDdSMTcif8A988wOSZ4d5pOcWw0LRAbe+g+TdBu2FvNUd
 I6WNO4I6mC/zE6ZCYKYk4h0EI0YxRH/3SYvwIzFAEpPowix8uILf86tOOV8G97XkRmTD
 GcMtxvC0rceaL53UcQ/C8Liz5KuWMTK4WpYb+hNGXd+ZaYxcno1P+M/mI0cWASCcD6Np
 yYeA==
X-Gm-Message-State: AGi0PubGYEi/5vaS39a0i0WwP26HaRQvOeoL0Ob8H5h7bhGjtRUiMVBR
 QAuCcmfFtq4oSNJmW3bieIjUd8yKHM0O9+ckCb8=
X-Google-Smtp-Source: APiQypKQ06osrK7ntUnoXPurW11eSVKwDvZAUQM3Ox4nXNqQU6cSuuG3UjR5EUtxoii9bmvSmV2N+sqqXGqslqrkEiM=
X-Received: by 2002:a02:9642:: with SMTP id c60mr24874023jai.87.1586948355719; 
 Wed, 15 Apr 2020 03:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <1586876551-3695-1-git-send-email-sundeep.lkml@gmail.com>
 <1586876551-3695-2-git-send-email-sundeep.lkml@gmail.com>
 <f3ab27fe-e270-39a2-10eb-0c16be5ad3cd@amsat.org>
In-Reply-To: <f3ab27fe-e270-39a2-10eb-0c16be5ad3cd@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Wed, 15 Apr 2020 16:29:04 +0530
Message-ID: <CALHRZuqfyQB5n_RVcVmJvU5Y66C6a_wivyJmAEKVVMVq=Ua2vA@mail.gmail.com>
Subject: Re: [Qemu devel PATCH v5 1/3] hw/net: Add Smartfusion2 emac block
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Wed, Apr 15, 2020 at 11:43 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 4/14/20 5:02 PM, sundeep.lkml@gmail.com wrote:
> > From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >
> > Modelled Ethernet MAC of Smartfusion2 SoC.
> > Micrel KSZ8051 PHY is present on Emcraft's
> > SOM kit hence same PHY is emulated.
> >
> > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  MAINTAINERS                |   2 +
> >  hw/net/Makefile.objs       |   1 +
> >  hw/net/msf2-emac.c         | 566 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/net/msf2-emac.h |  53 +++++
> >  4 files changed, 622 insertions(+)
> >  create mode 100644 hw/net/msf2-emac.c
> >  create mode 100644 include/hw/net/msf2-emac.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 642c8e0..9d0ff20 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -919,6 +919,8 @@ F: include/hw/arm/msf2-soc.h
> >  F: include/hw/misc/msf2-sysreg.h
> >  F: include/hw/timer/mss-timer.h
> >  F: include/hw/ssi/mss-spi.h
> > +F: hw/net/msf2-emac.c
> > +F: include/hw/net/msf2-emac.h
> >
> >  Emcraft M2S-FG484
> >  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> > index af4d194..f2b7398 100644
> > --- a/hw/net/Makefile.objs
> > +++ b/hw/net/Makefile.objs
> > @@ -55,3 +55,4 @@ common-obj-$(CONFIG_ROCKER) +=3D rocker/rocker.o rock=
er/rocker_fp.o \
> >  obj-$(call lnot,$(CONFIG_ROCKER)) +=3D rocker/qmp-norocker.o
> >
> >  common-obj-$(CONFIG_CAN_BUS) +=3D can/
> > +common-obj-$(CONFIG_MSF2) +=3D msf2-emac.o
> > diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
> > new file mode 100644
> > index 0000000..cae40fd
> > --- /dev/null
> > +++ b/hw/net/msf2-emac.c
> > @@ -0,0 +1,566 @@
> > +/*
> > + * QEMU model of the Smartfusion2 Ethernet MAC.
> > + *
> > + * Copyright (c) 2020 Subbaraya Sundeep <sundeep.lkml@gmail.com>.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + *
> > + * Refer to section Ethernet MAC in the document:
> > + * UG0331: SmartFusion2 Microcontroller Subsystem User Guide
> > + * Datasheet URL:
> > + * https://www.microsemi.com/document-portal/cat_view/56661-internal-d=
ocuments/
> > + * 56758-soc?lang=3Den&limit=3D20&limitstart=3D220
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "qemu/log.h"
> > +#include "qapi/error.h"
> > +#include "exec/address-spaces.h"
> > +#include "hw/registerfields.h"
> > +#include "hw/net/msf2-emac.h"
> > +#include "hw/net/mii.h"
> > +#include "hw/irq.h"
> > +#include "hw/qdev-properties.h"
> > +#include "migration/vmstate.h"
> > +
> > +REG32(CFG1, 0x0)
> > +    FIELD(CFG1, RESET, 31, 1)
> > +    FIELD(CFG1, RX_EN, 2, 1)
> > +    FIELD(CFG1, TX_EN, 0, 1)
> > +    FIELD(CFG1, LB_EN, 8, 1)
> > +REG32(CFG2, 0x4)
> > +REG32(IFG, 0x8)
> > +REG32(HALF_DUPLEX, 0xc)
> > +REG32(MAX_FRAME_LENGTH, 0x10)
> > +REG32(MII_CMD, 0x24)
> > +    FIELD(MII_CMD, READ, 0, 1)
> > +REG32(MII_ADDR, 0x28)
> > +    FIELD(MII_ADDR, REGADDR, 0, 5)
> > +    FIELD(MII_ADDR, PHYADDR, 8, 5)
> > +REG32(MII_CTL, 0x2c)
> > +REG32(MII_STS, 0x30)
> > +REG32(STA1, 0x40)
> > +REG32(STA2, 0x44)
> > +REG32(FIFO_CFG0, 0x48)
> > +REG32(DMA_TX_CTL, 0x180)
> > +    FIELD(DMA_TX_CTL, EN, 0, 1)
> > +REG32(DMA_TX_DESC, 0x184)
> > +REG32(DMA_TX_STATUS, 0x188)
> > +    FIELD(DMA_TX_STATUS, PKTCNT, 16, 8)
> > +    FIELD(DMA_TX_STATUS, UNDERRUN, 1, 1)
> > +    FIELD(DMA_TX_STATUS, PKT_SENT, 0, 1)
> > +REG32(DMA_RX_CTL, 0x18c)
> > +    FIELD(DMA_RX_CTL, EN, 0, 1)
> > +REG32(DMA_RX_DESC, 0x190)
> > +REG32(DMA_RX_STATUS, 0x194)
> > +    FIELD(DMA_RX_STATUS, PKTCNT, 16, 8)
> > +    FIELD(DMA_RX_STATUS, OVERFLOW, 2, 1)
> > +    FIELD(DMA_RX_STATUS, PKT_RCVD, 0, 1)
> > +REG32(DMA_IRQ_MASK, 0x198)
> > +REG32(DMA_IRQ, 0x19c)
> > +
> > +#define EMPTY_MASK              (1 << 31)
> > +#define PKT_SIZE                0x7FF
> > +#define PHYADDR                 0x1
> > +#define MAX_PKT_SIZE            2048
> > +
> > +typedef struct {
> > +    uint32_t pktaddr;
> > +    uint32_t pktsize;
> > +    uint32_t next;
> > +} EmacDesc;
> > +
> > +static uint32_t emac_get_isr(MSF2EmacState *s)
> > +{
> > +    uint32_t ier =3D s->regs[R_DMA_IRQ_MASK];
> > +    uint32_t tx =3D s->regs[R_DMA_TX_STATUS] & 0xF;
> > +    uint32_t rx =3D s->regs[R_DMA_RX_STATUS] & 0xF;
> > +    uint32_t isr =3D (rx << 4) | tx;
> > +
> > +    s->regs[R_DMA_IRQ] =3D ier & isr;
> > +    return s->regs[R_DMA_IRQ];
> > +}
> > +
> > +static void emac_update_irq(MSF2EmacState *s)
> > +{
> > +    bool intr =3D emac_get_isr(s);
> > +
> > +    qemu_set_irq(s->irq, intr);
> > +}
> > +
> > +static void emac_load_desc(MSF2EmacState *s, EmacDesc *d, hwaddr desc)
> > +{
> > +    address_space_read(&s->dma_as, desc, MEMTXATTRS_UNSPECIFIED, d, si=
zeof *d);
> > +    /* Convert from LE into host endianness. */
> > +    d->pktaddr =3D le32_to_cpu(d->pktaddr);
> > +    d->pktsize =3D le32_to_cpu(d->pktsize);
> > +    d->next =3D le32_to_cpu(d->next);
> > +}
> > +
> > +static void emac_store_desc(MSF2EmacState *s, EmacDesc *d, hwaddr desc=
)
> > +{
> > +    /* Convert from host endianness into LE. */
> > +    d->pktaddr =3D cpu_to_le32(d->pktaddr);
> > +    d->pktsize =3D cpu_to_le32(d->pktsize);
> > +    d->next =3D cpu_to_le32(d->next);
> > +
> > +    address_space_write(&s->dma_as, desc, MEMTXATTRS_UNSPECIFIED, d, s=
izeof *d);
> > +}
> > +
> > +static void msf2_dma_tx(MSF2EmacState *s)
> > +{
> > +    NetClientState *nc =3D qemu_get_queue(s->nic);
> > +    hwaddr desc =3D s->regs[R_DMA_TX_DESC];
> > +    uint8_t buf[MAX_PKT_SIZE];
> > +    EmacDesc d;
> > +    int size;
> > +    uint8_t pktcnt;
> > +    uint32_t status;
> > +
> > +    if (!(s->regs[R_CFG1] & R_CFG1_TX_EN_MASK)) {
> > +        return;
> > +    }
> > +
> > +    while (1) {
> > +        emac_load_desc(s, &d, desc);
> > +        if (d.pktsize & EMPTY_MASK) {
> > +            break;
> > +        }
> > +        size =3D d.pktsize & PKT_SIZE;
> > +        address_space_read(&s->dma_as, d.pktaddr, MEMTXATTRS_UNSPECIFI=
ED,
> > +                           buf, size);
> > +        /*
> > +         * This is very basic way to send packets. Ideally there shoul=
d be
> > +         * a FIFO and packets should be sent out from FIFO only when
> > +         * R_CFG1 bit 0 is set.
> > +         */
> > +        if (s->regs[R_CFG1] & R_CFG1_LB_EN_MASK) {
> > +            nc->info->receive(nc, buf, size);
> > +        } else {
> > +            qemu_send_packet(nc, buf, size);
> > +        }
> > +        d.pktsize |=3D EMPTY_MASK;
> > +        emac_store_desc(s, &d, desc);
> > +        /* update sent packets count */
> > +        status =3D s->regs[R_DMA_TX_STATUS];
> > +        pktcnt =3D FIELD_EX32(status, DMA_TX_STATUS, PKTCNT);
> > +        pktcnt++;
> > +        s->regs[R_DMA_TX_STATUS] =3D FIELD_DP32(status, DMA_TX_STATUS,
> > +                                              PKTCNT, pktcnt);
> > +        s->regs[R_DMA_TX_STATUS] |=3D R_DMA_TX_STATUS_PKT_SENT_MASK;
> > +        desc =3D d.next;
> > +    }
> > +    s->regs[R_DMA_TX_STATUS] |=3D R_DMA_TX_STATUS_UNDERRUN_MASK;
> > +    s->regs[R_DMA_TX_CTL] &=3D ~R_DMA_TX_CTL_EN_MASK;
> > +}
> > +
> > +static void msf2_phy_update_link(MSF2EmacState *s)
> > +{
> > +    /* Autonegotiation status mirrors link status. */
> > +    if (qemu_get_queue(s->nic)->link_down) {
> > +        s->phy_regs[MII_BMSR] &=3D ~(MII_BMSR_AN_COMP |
> > +                                   MII_BMSR_LINK_ST);
> > +    } else {
> > +        s->phy_regs[MII_BMSR] |=3D (MII_BMSR_AN_COMP |
> > +                                  MII_BMSR_LINK_ST);
> > +    }
> > +}
> > +
> > +static void msf2_phy_reset(MSF2EmacState *s)
> > +{
> > +    memset(&s->phy_regs[0], 0, sizeof(s->phy_regs));
> > +    s->phy_regs[MII_BMCR] =3D 0x1140;
> > +    s->phy_regs[MII_BMSR] =3D 0x7968;
> > +    s->phy_regs[MII_PHYID1] =3D 0x0022;
> > +    s->phy_regs[MII_PHYID2] =3D 0x1550;
> > +    s->phy_regs[MII_ANAR] =3D 0x01E1;
> > +    s->phy_regs[MII_ANLPAR] =3D 0xCDE1;
> > +
> > +    msf2_phy_update_link(s);
> > +}
> > +
> > +static void write_to_phy(MSF2EmacState *s)
> > +{
> > +    uint8_t reg_addr =3D s->regs[R_MII_ADDR] & R_MII_ADDR_REGADDR_MASK=
;
> > +    uint8_t phy_addr =3D (s->regs[R_MII_ADDR] >> R_MII_ADDR_PHYADDR_SH=
IFT) &
> > +                       R_MII_ADDR_REGADDR_MASK;
> > +    uint16_t data =3D s->regs[R_MII_CTL] & 0xFFFF;
> > +
> > +    if (phy_addr !=3D PHYADDR) {
> > +        return;
> > +    }
> > +
> > +    switch (reg_addr) {
> > +    case MII_BMCR:
> > +        if (data & MII_BMCR_RESET) {
> > +            /* Phy reset */
> > +            msf2_phy_reset(s);
> > +            data &=3D ~MII_BMCR_RESET;
> > +        }
> > +        if (data & MII_BMCR_AUTOEN) {
> > +            /* Complete autonegotiation immediately */
> > +            data &=3D ~MII_BMCR_AUTOEN;
> > +            s->phy_regs[MII_BMSR] |=3D MII_BMSR_AN_COMP;
> > +        }
> > +        break;
> > +    }
> > +
> > +    s->phy_regs[reg_addr] =3D data;
> > +}
> > +
> > +static uint16_t read_from_phy(MSF2EmacState *s)
> > +{
> > +    uint8_t reg_addr =3D s->regs[R_MII_ADDR] & R_MII_ADDR_REGADDR_MASK=
;
> > +    uint8_t phy_addr =3D (s->regs[R_MII_ADDR] >> R_MII_ADDR_PHYADDR_SH=
IFT) &
> > +                       R_MII_ADDR_REGADDR_MASK;
> > +
> > +    if (phy_addr =3D=3D PHYADDR) {
> > +        return s->phy_regs[reg_addr];
> > +    } else {
> > +        return 0xFFFF;
> > +    }
> > +}
> > +
> > +static void msf2_emac_do_reset(MSF2EmacState *s)
> > +{
> > +    memset(&s->regs[0], 0, sizeof(s->regs));
> > +    s->regs[R_CFG1] =3D 0x80000000;
> > +    s->regs[R_CFG2] =3D 0x00007000;
> > +    s->regs[R_IFG] =3D 0x40605060;
> > +    s->regs[R_HALF_DUPLEX] =3D 0x00A1F037;
> > +    s->regs[R_MAX_FRAME_LENGTH] =3D 0x00000600;
> > +
> > +    msf2_phy_reset(s);
> > +}
> > +
> > +static uint64_t emac_read(void *opaque, hwaddr addr, unsigned int size=
)
> > +{
> > +    MSF2EmacState *s =3D opaque;
> > +    uint32_t r =3D 0;
> > +
> > +    addr >>=3D 2;
> > +
> > +    switch (addr) {
> > +    case R_DMA_IRQ:
> > +        r =3D emac_get_isr(s);
> > +        break;
> > +    default:
> > +        if (addr >=3D ARRAY_SIZE(s->regs)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: Bad offset 0x%" HWADDR_PRIx "\n", __fun=
c__,
> > +                          addr * 4);
> > +            return r;
> > +        }
> > +        r =3D s->regs[addr];
> > +        break;
> > +    }
> > +    return r;
> > +}
> > +
> > +static void emac_write(void *opaque, hwaddr addr, uint64_t val64,
> > +        unsigned int size)
> > +{
> > +    MSF2EmacState *s =3D opaque;
> > +    uint32_t value =3D val64;
> > +    uint32_t enreqbits;
> > +    uint8_t pktcnt;
> > +
> > +    addr >>=3D 2;
> > +    switch (addr) {
> > +    case R_DMA_TX_CTL:
> > +        s->regs[addr] =3D value;
> > +        if (value & R_DMA_TX_CTL_EN_MASK) {
> > +            msf2_dma_tx(s);
> > +        }
> > +        break;
> > +    case R_DMA_RX_CTL:
> > +        s->regs[addr] =3D value;
> > +        if (value & R_DMA_RX_CTL_EN_MASK) {
> > +            s->rx_desc =3D s->regs[R_DMA_RX_DESC];
> > +            qemu_flush_queued_packets(qemu_get_queue(s->nic));
> > +        }
> > +        break;
> > +    case R_CFG1:
> > +        if (value & R_CFG1_RESET_MASK) {
> > +            msf2_emac_do_reset(s);
> > +        }
>
> Missing break?

Yes. thanks for catching.
>
> > +    case R_FIFO_CFG0:
> > +       /*
> > +        * For our implementation, turning on modules is instantaneous,
> > +        * so the states requested via the *ENREQ bits appear in the
> > +        * *ENRPLY bits immediately. Also the reset bits to reset PE-MC=
XMAC
> > +        * module are not emulated here since it deals with start of fr=
ames,
> > +        * inter-packet gap and control frames.
> > +        */
> > +        enreqbits =3D extract32(value, 8, 5);
> > +        s->regs[addr] =3D deposit32(value, 16, 5, enreqbits);
> > +        break;
> > +    case R_DMA_TX_DESC:
> > +        if (value & 0x3) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "Tx Descriptor address shou=
ld be"
> > +                          " 32 bit aligned\n");
> > +        }
> > +        /* Ignore [1:0] bits */
> > +        s->regs[addr] =3D value & ~3;
> > +        break;
> > +    case R_DMA_RX_DESC:
> > +        if (value & 0x3) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "Rx Descriptor address shou=
ld be"
> > +                          " 32 bit aligned\n");
> > +        }
> > +        /* Ignore [1:0] bits */
> > +        s->regs[addr] =3D value & ~3;
> > +        break;
> > +    case R_DMA_TX_STATUS:
> > +        if (value & R_DMA_TX_STATUS_UNDERRUN_MASK) {
> > +            s->regs[addr] &=3D ~R_DMA_TX_STATUS_UNDERRUN_MASK;
> > +        }
> > +        if (value & R_DMA_TX_STATUS_PKT_SENT_MASK) {
> > +            pktcnt =3D FIELD_EX32(s->regs[addr], DMA_TX_STATUS, PKTCNT=
);
> > +            pktcnt--;
> > +            s->regs[addr] =3D FIELD_DP32(s->regs[addr], DMA_TX_STATUS,
> > +                                       PKTCNT, pktcnt);
> > +            if (pktcnt =3D=3D 0) {
> > +                s->regs[addr] &=3D ~R_DMA_TX_STATUS_PKT_SENT_MASK;
> > +            }
> > +        }
> > +        break;
> > +    case R_DMA_RX_STATUS:
> > +        if (value & R_DMA_RX_STATUS_OVERFLOW_MASK) {
> > +            s->regs[addr] &=3D ~R_DMA_RX_STATUS_OVERFLOW_MASK;
> > +        }
> > +        if (value & R_DMA_RX_STATUS_PKT_RCVD_MASK) {
> > +            pktcnt =3D FIELD_EX32(s->regs[addr], DMA_RX_STATUS, PKTCNT=
);
> > +            pktcnt--;
> > +            s->regs[addr] =3D FIELD_DP32(s->regs[addr], DMA_RX_STATUS,
> > +                                       PKTCNT, pktcnt);
> > +            if (pktcnt =3D=3D 0) {
> > +                s->regs[addr] &=3D ~R_DMA_RX_STATUS_PKT_RCVD_MASK;
> > +            }
> > +        }
> > +        break;
> > +    case R_DMA_IRQ:
> > +        break;
> > +    case R_MII_CMD:
> > +        if (value & R_MII_CMD_READ_MASK) {
> > +            s->regs[R_MII_STS] =3D read_from_phy(s);
> > +        }
> > +        break;
> > +    case R_MII_CTL:
> > +        s->regs[addr] =3D value;
> > +        write_to_phy(s);
> > +        break;
> > +    case R_STA1:
> > +        s->regs[addr] =3D value;
> > +       /*
> > +        * R_STA1 [31:24] : octet 1 of mac address
> > +        * R_STA1 [23:16] : octet 2 of mac address
> > +        * R_STA1 [15:8] : octet 3 of mac address
> > +        * R_STA1 [7:0] : octet 4 of mac address
> > +        */
> > +        stl_le_p(s->mac_addr, value);
> > +        break;
> > +    case R_STA2:
> > +        s->regs[addr] =3D value;
> > +       /*
> > +        * R_STA2 [31:24] : octet 5 of mac address
> > +        * R_STA2 [23:16] : octet 6 of mac address
> > +        */
> > +        stw_le_p(s->mac_addr + 4, value >> 16);
> > +        break;
> > +    default:
> > +        if (addr >=3D ARRAY_SIZE(s->regs)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: Bad offset 0x%" HWADDR_PRIx "\n", __fun=
c__,
> > +                          addr * 4);
> > +            return;
> > +        }
> > +        s->regs[addr] =3D value;
> > +        break;
> > +    }
> > +    emac_update_irq(s);
> > +}
> > +
> > +static const MemoryRegionOps emac_ops =3D {
> > +    .read =3D emac_read,
> > +    .write =3D emac_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4
> > +    }
> > +};
> > +
> > +static bool emac_can_rx(NetClientState *nc)
> > +{
> > +    MSF2EmacState *s =3D qemu_get_nic_opaque(nc);
> > +
> > +    return (s->regs[R_CFG1] & R_CFG1_RX_EN_MASK) &&
> > +           (s->regs[R_DMA_RX_CTL] & R_DMA_RX_CTL_EN_MASK);
> > +}
> > +
> > +static bool match_addr(MSF2EmacState *s, const uint8_t *buf)
> > +{
> > +    /* The broadcast MAC address: FF:FF:FF:FF:FF:FF */
> > +    static const uint8_t broadcast_addr[] =3D { 0xFF, 0xFF, 0xFF, 0xFF=
,
> > +                                              0xFF, 0xFF };
> > +
> > +    if (!memcmp(buf, broadcast_addr, sizeof(broadcast_addr))) {
> > +        return true;
> > +    }
> > +
> > +    if (!memcmp(buf, s->mac_addr, sizeof(s->mac_addr))) {
> > +        return false;
> > +    }
> > +
> > +    return true;
>
> Yes, or:
>
>        return !!memcmp(buf, s->mac_addr, sizeof(s->mac_addr));
>
This logic is wrong and unicast filter always fail and returns true for all
packets. Need to use stl_be_p instead of stl_le_p.
buf[0]:0xc0, 0xb1 0x3c 0x83 0x83 0x83
mac[0]:0x83, 0x3c 0xb1 0xc0 0x83 0x83

I will fix this and send another version.

Thanks,
Sundeep

> > +}
> > +
> > +static ssize_t emac_rx(NetClientState *nc, const uint8_t *buf, size_t =
size)
> > +{
> > +    MSF2EmacState *s =3D qemu_get_nic_opaque(nc);
> > +    EmacDesc d;
> > +    uint8_t pktcnt;
> > +    uint32_t status;
> > +
> > +    if (size > (s->regs[R_MAX_FRAME_LENGTH] & 0xFFFF)) {
> > +        return size;
> > +    }
> > +    if (!match_addr(s, buf)) {
> > +        return size;
> > +    }
> > +
> > +    emac_load_desc(s, &d, s->rx_desc);
> > +
> > +    if (d.pktsize & EMPTY_MASK) {
> > +        address_space_write(&s->dma_as, d.pktaddr, MEMTXATTRS_UNSPECIF=
IED,
> > +                            buf, size & PKT_SIZE);
> > +        d.pktsize =3D size & PKT_SIZE;
> > +        emac_store_desc(s, &d, s->rx_desc);
> > +        /* update received packets count */
> > +        status =3D s->regs[R_DMA_RX_STATUS];
> > +        pktcnt =3D FIELD_EX32(status, DMA_RX_STATUS, PKTCNT);
> > +        pktcnt++;
> > +        s->regs[R_DMA_RX_STATUS] =3D FIELD_DP32(status, DMA_RX_STATUS,
> > +                                              PKTCNT, pktcnt);
> > +        s->regs[R_DMA_RX_STATUS] |=3D R_DMA_RX_STATUS_PKT_RCVD_MASK;
> > +        s->rx_desc =3D d.next;
> > +    } else {
> > +        s->regs[R_DMA_RX_CTL] &=3D ~R_DMA_RX_CTL_EN_MASK;
> > +        s->regs[R_DMA_RX_STATUS] |=3D R_DMA_RX_STATUS_OVERFLOW_MASK;
> > +    }
> > +    emac_update_irq(s);
> > +    return size;
> > +}
> > +
> > +static void msf2_emac_reset(DeviceState *dev)
> > +{
> > +    MSF2EmacState *s =3D MSS_EMAC(dev);
> > +
> > +    msf2_emac_do_reset(s);
> > +}
> > +
> > +static void emac_set_link(NetClientState *nc)
> > +{
> > +    MSF2EmacState *s =3D qemu_get_nic_opaque(nc);
> > +
> > +    msf2_phy_update_link(s);
> > +}
> > +
> > +static NetClientInfo net_msf2_emac_info =3D {
> > +    .type =3D NET_CLIENT_DRIVER_NIC,
> > +    .size =3D sizeof(NICState),
> > +    .can_receive =3D emac_can_rx,
> > +    .receive =3D emac_rx,
> > +    .link_status_changed =3D emac_set_link,
> > +};
> > +
> > +static void msf2_emac_realize(DeviceState *dev, Error **errp)
> > +{
> > +    MSF2EmacState *s =3D MSS_EMAC(dev);
> > +
> > +    if (!s->dma_mr) {
> > +        error_setg(errp, "MSS_EMAC 'ahb-bus' link not set");
> > +        return;
> > +    }
> > +
> > +    address_space_init(&s->dma_as, s->dma_mr, "emac-ahb");
> > +
> > +    qemu_macaddr_default_if_unset(&s->conf.macaddr);
> > +    s->nic =3D qemu_new_nic(&net_msf2_emac_info, &s->conf,
> > +                          object_get_typename(OBJECT(dev)), dev->id, s=
);
> > +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a=
);
> > +}
> > +
> > +static void msf2_emac_init(Object *obj)
> > +{
> > +    MSF2EmacState *s =3D MSS_EMAC(obj);
> > +
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> > +
> > +    memory_region_init_io(&s->mmio, obj, &emac_ops, s,
> > +                          "msf2-emac", R_MAX * 4);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +}
> > +
> > +static Property msf2_emac_properties[] =3D {
> > +    DEFINE_PROP_LINK("ahb-bus", MSF2EmacState, dma_mr,
> > +                     TYPE_MEMORY_REGION, MemoryRegion *),
> > +    DEFINE_NIC_PROPERTIES(MSF2EmacState, conf),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static const VMStateDescription vmstate_msf2_emac =3D {
> > +    .name =3D TYPE_MSS_EMAC,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8_ARRAY(mac_addr, MSF2EmacState, ETH_ALEN),
> > +        VMSTATE_UINT32(rx_desc, MSF2EmacState),
> > +        VMSTATE_UINT16_ARRAY(phy_regs, MSF2EmacState, PHY_MAX_REGS),
> > +        VMSTATE_UINT32_ARRAY(regs, MSF2EmacState, R_MAX),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void msf2_emac_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D msf2_emac_realize;
> > +    dc->reset =3D msf2_emac_reset;
> > +    dc->vmsd =3D &vmstate_msf2_emac;
> > +    device_class_set_props(dc, msf2_emac_properties);
> > +}
> > +
> > +static const TypeInfo msf2_emac_info =3D {
> > +    .name          =3D TYPE_MSS_EMAC,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(MSF2EmacState),
> > +    .instance_init =3D msf2_emac_init,
> > +    .class_init    =3D msf2_emac_class_init,
> > +};
> > +
> > +static void msf2_emac_register_types(void)
> > +{
> > +    type_register_static(&msf2_emac_info);
> > +}
> > +
> > +type_init(msf2_emac_register_types)
> > diff --git a/include/hw/net/msf2-emac.h b/include/hw/net/msf2-emac.h
> > new file mode 100644
> > index 0000000..37966d3
> > --- /dev/null
> > +++ b/include/hw/net/msf2-emac.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * QEMU model of the Smartfusion2 Ethernet MAC.
> > + *
> > + * Copyright (c) 2020 Subbaraya Sundeep <sundeep.lkml@gmail.com>.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "hw/sysbus.h"
> > +#include "exec/memory.h"
> > +#include "net/net.h"
> > +#include "net/eth.h"
> > +
> > +#define TYPE_MSS_EMAC "msf2-emac"
> > +#define MSS_EMAC(obj) \
> > +    OBJECT_CHECK(MSF2EmacState, (obj), TYPE_MSS_EMAC)
> > +
> > +#define R_MAX         (0x1a0 / 4)
> > +#define PHY_MAX_REGS  32
> > +
> > +typedef struct MSF2EmacState {
> > +    SysBusDevice parent;
> > +
> > +    MemoryRegion mmio;
> > +    MemoryRegion *dma_mr;
> > +    AddressSpace dma_as;
> > +
> > +    qemu_irq irq;
> > +    NICState *nic;
> > +    NICConf conf;
> > +
> > +    uint8_t mac_addr[ETH_ALEN];
> > +    uint32_t rx_desc;
> > +    uint16_t phy_regs[PHY_MAX_REGS];
> > +
> > +    uint32_t regs[R_MAX];
> > +} MSF2EmacState;
> >

