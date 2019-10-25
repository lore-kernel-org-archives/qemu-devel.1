Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17377CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44AE21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44AE21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy7y-0005w5-LM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNxzv-0004wa-2D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNxzq-0008DT-Cn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNxzp-0008Cx-TK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:43:10 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FD288665A
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 11:43:08 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id d127so1880854qkc.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c/oBdygM8qmnhiHLSoVGFuRRL1q9zI9bvcQdV5oZnX8=;
 b=Hs7lb7/NiiSJenViQFs3hz5vo7oEzkfMwswfoB6oKgbU8G/HH2XUqMP8UzTp9rwRBe
 rKyNbY6s/P0Fcjff1gS8qNGDBMXmgjM6RLnIM+0Am2GO7ZX45HnuWal2jb+bNEDWBLuf
 NzRaJfoqCUOV25kGlasSpJG+n1DOhaj5uR+p7zawCczw73aB/AsGA2I1OHzgZyMJA8zr
 Obe5kCWO9sglDevLUWz+OxwBcDjDbXG+VomK5w5iPQJ770eU/EFGuHPQNxDwhkvMNO0L
 +XcrKK7keVwovUpg9iXpBvHXT3TARrMpVCTZb8fITKyN/hzxkwoiSbE5ibVkNriFk84s
 kTbw==
X-Gm-Message-State: APjAAAXVvWjY5X2WcTG9a6vdBzg1ZOfJ3mK2R6AaKH6hPSerz9CnBpIg
 SeRmtjShGw5f7h3jCh5cv8cEm1r53nzBgrpUIlYV5dlpKeK6p4rjlqulT32tqaplYibeb0yvA6F
 3t3KuDPsu0FDUAXg=
X-Received: by 2002:a0c:b91e:: with SMTP id u30mr2093190qvf.31.1572003786515; 
 Fri, 25 Oct 2019 04:43:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCAndRr9I6m2eNtFqGDAjpqUrb7gNXOVcz/iDF6I5Rq4sJLeWChS5L5UKunHk/wYydFRvE6A==
X-Received: by 2002:a0c:b91e:: with SMTP id u30mr2093140qvf.31.1572003785706; 
 Fri, 25 Oct 2019 04:43:05 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 k187sm945486qkb.20.2019.10.25.04.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:43:04 -0700 (PDT)
Date: Fri, 25 Oct 2019 07:43:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH v2] net: add tulip (dec21143) driver
Message-ID: <20191025074243-mutt-send-email-mst@kernel.org>
References: <20191022155413.4619-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022155413.4619-1-svens@stackframe.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 22, 2019 at 05:54:13PM +0200, Sven Schnelle wrote:
> This adds the basic functionality to emulate a Tulip NIC.


Jason, do you want to queue this?

Overall ok so

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Implemented are:
> 
> - RX and TX functionality
> - Perfect Frame Filtering
> - Big/Little Endian descriptor support
> - 93C46 EEPROM support
> - LXT970 PHY
> 
> Not implemented, mostly because i had no OS using these functions:
> 
> - Imperfect frame filtering
> - General Purpose Timer
> - Transmit automatic polling
> - Boot ROM support
> - SIA interface
> - Big/Little Endian data buffer conversion
> 
> Successfully tested with the following Operating Systems:
> 
> - MSDOS with Microsoft Network Client 3.0 and DEC ODI drivers
> - HPPA Linux
> - Windows XP
> - HP-UX
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
> 
>  Changes in v2:
>  - changed tulip_desc_{read,write} to take a struct descriptor *
>    and no longer use a single pci DMA write, instead write one
>    struct member at a time.
> 
>  - fix _tulip_receive function name
>  - fix reset function and provide tulip_qdev_reset() for dc->reset.
>  - no longer write registers in the default case in tulip_write()
>  - set .impl.min_access_size and .impl.max_access_size
> 
>  MAINTAINERS              |    6 +
>  hw/net/Kconfig           |    5 +
>  hw/net/Makefile.objs     |    1 +
>  hw/net/trace-events      |   14 +
>  hw/net/tulip.c           | 1029 ++++++++++++++++++++++++++++++++++++++
>  hw/net/tulip.h           |  268 ++++++++++
>  include/hw/pci/pci_ids.h |    1 +
>  7 files changed, 1324 insertions(+)
>  create mode 100644 hw/net/tulip.c
>  create mode 100644 hw/net/tulip.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 250ce8e7a1..a12031c389 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1638,6 +1638,12 @@ M: Stefan Weil <sw@weilnetz.de>
>  S: Maintained
>  F: hw/net/eepro100.c
>  
> +tulip
> +M: Sven Schnelle <svens@stackframe.org>
> +S: Maintained
> +F: hw/net/tulip.c
> +F: hw/net/tulip.h
> +
>  Generic Loader
>  M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 4ef86dc3a5..3856417d42 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -24,6 +24,11 @@ config PCNET_PCI
>  config PCNET_COMMON
>      bool
>  
> +config TULIP
> +    bool
> +    default y if PCI_DEVICES
> +    depends on PCI
> +
>  config E1000_PCI
>      bool
>      default y if PCI_DEVICES
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index 9904273b06..7907d2c199 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -13,6 +13,7 @@ common-obj-$(CONFIG_E1000E_PCI_EXPRESS) += e1000e.o e1000e_core.o e1000x_common.
>  common-obj-$(CONFIG_RTL8139_PCI) += rtl8139.o
>  common-obj-$(CONFIG_VMXNET3_PCI) += net_tx_pkt.o net_rx_pkt.o
>  common-obj-$(CONFIG_VMXNET3_PCI) += vmxnet3.o
> +common-obj-$(CONFIG_TULIP) += tulip.o
>  
>  common-obj-$(CONFIG_SMC91C111) += smc91c111.o
>  common-obj-$(CONFIG_LAN9118) += lan9118.o
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 58665655cc..e70f12bee1 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -367,3 +367,17 @@ virtio_net_announce_notify(void) ""
>  virtio_net_announce_timer(int round) "%d"
>  virtio_net_handle_announce(int round) "%d"
>  virtio_net_post_load_device(void)
> +
> +# tulip.c
> +tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t val) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
> +tulip_reg_read(uint64_t addr, const char *name, int size, uint64_t val) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
> +tulip_receive(const uint8_t *buf, size_t len) "buf %p size %zu"
> +tulip_descriptor(const char *prefix, uint32_t addr, uint32_t status, uint32_t control, uint32_t len1, uint32_t len2, uint32_t buf1, uint32_t buf2) "%s 0x%08x: status 0x%08x control 0x%03x len1 %4d len2 %4d buf1 0x%08x buf2 0x%08x"
> +tulip_rx_state(const char *state) "RX %s"
> +tulip_tx_state(const char *state) "TX %s"
> +tulip_irq(uint32_t mask, uint32_t en, const char *state) "mask 0x%08x ie 0x%08x %s"
> +tulip_mii_write(int phy, int reg, uint16_t data) "phy 0x%x reg 0x%x data 0x%04x"
> +tulip_mii_read(int phy, int reg, uint16_t data) "phy 0x%x, reg 0x%x data 0x%04x"
> +tulip_reset(void) ""
> +tulip_setup_frame(void) ""
> +tulip_setup_filter(int n, uint8_t a, uint8_t b, uint8_t c, uint8_t d, uint8_t e, uint8_t f) "%d: %02x:%02x:%02x:%02x:%02x:%02x"
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> new file mode 100644
> index 0000000000..c826d9935c
> --- /dev/null
> +++ b/hw/net/tulip.c
> @@ -0,0 +1,1029 @@
> +/*
> + * QEMU TULIP Emulation
> + *
> + * Copyright (c) 2019 Sven Schnelle <svens@stackframe.org>
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/irq.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/nvram/eeprom93xx.h"
> +#include "migration/vmstate.h"
> +#include "sysemu/sysemu.h"
> +#include "tulip.h"
> +#include "trace.h"
> +#include "net/eth.h"
> +
> +typedef struct TULIPState {
> +    PCIDevice dev;
> +    MemoryRegion io;
> +    MemoryRegion memory;
> +    NICConf c;
> +    qemu_irq irq;
> +    NICState *nic;
> +    eeprom_t *eeprom;
> +    uint32_t csr[16];
> +
> +    /* state for MII */
> +    uint32_t old_csr9;
> +    uint32_t mii_word;
> +    uint32_t mii_bitcnt;
> +
> +    hwaddr current_rx_desc;
> +    hwaddr current_tx_desc;
> +
> +    uint8_t rx_frame[2048];
> +    uint8_t tx_frame[2048];
> +    uint16_t tx_frame_len;
> +    uint16_t rx_frame_len;
> +    uint16_t rx_frame_size;
> +
> +    uint32_t rx_status;
> +    uint8_t filter[16][6];
> +} TULIPState;
> +
> +static const VMStateDescription vmstate_pci_tulip = {
> +    .name = "tulip",
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, TULIPState),
> +        VMSTATE_UINT32_ARRAY(csr, TULIPState, 16),
> +        VMSTATE_UINT32(old_csr9, TULIPState),
> +        VMSTATE_UINT32(mii_word, TULIPState),
> +        VMSTATE_UINT32(mii_bitcnt, TULIPState),
> +        VMSTATE_UINT64(current_rx_desc, TULIPState),
> +        VMSTATE_UINT64(current_tx_desc, TULIPState),
> +        VMSTATE_BUFFER(rx_frame, TULIPState),
> +        VMSTATE_BUFFER(tx_frame, TULIPState),
> +        VMSTATE_UINT16(rx_frame_len, TULIPState),
> +        VMSTATE_UINT16(tx_frame_len, TULIPState),
> +        VMSTATE_UINT16(rx_frame_size, TULIPState),
> +        VMSTATE_UINT32(rx_status, TULIPState),
> +        VMSTATE_UINT8_2DARRAY(filter, TULIPState, 16, 6),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void tulip_desc_read(TULIPState *s, hwaddr p,
> +        struct tulip_descriptor *desc)
> +{
> +    if (s->csr[0] & CSR0_DBO) {
> +        desc->status = ldl_be_pci_dma(&s->dev, p);
> +        desc->control = ldl_be_pci_dma(&s->dev, p + 4);
> +        desc->buf_addr1 = ldl_be_pci_dma(&s->dev, p + 8);
> +        desc->buf_addr2 = ldl_be_pci_dma(&s->dev, p + 12);
> +    } else {
> +        desc->status = ldl_le_pci_dma(&s->dev, p);
> +        desc->control = ldl_le_pci_dma(&s->dev, p + 4);
> +        desc->buf_addr1 = ldl_le_pci_dma(&s->dev, p + 8);
> +        desc->buf_addr2 = ldl_le_pci_dma(&s->dev, p + 12);
> +    }
> +}
> +
> +static void tulip_desc_write(TULIPState *s, hwaddr p,
> +        struct tulip_descriptor *desc)
> +{
> +    if (s->csr[0] & CSR0_DBO) {
> +        stl_be_pci_dma(&s->dev, p, desc->status);
> +        stl_be_pci_dma(&s->dev, p + 4, desc->control);
> +        stl_be_pci_dma(&s->dev, p + 8, desc->buf_addr1);
> +        stl_be_pci_dma(&s->dev, p + 12, desc->buf_addr2);
> +    } else {
> +        stl_le_pci_dma(&s->dev, p, desc->status);
> +        stl_le_pci_dma(&s->dev, p + 4, desc->control);
> +        stl_le_pci_dma(&s->dev, p + 8, desc->buf_addr1);
> +        stl_le_pci_dma(&s->dev, p + 12, desc->buf_addr2);
> +    }
> +}
> +
> +static void tulip_update_int(TULIPState *s)
> +{
> +    uint32_t ie = s->csr[5] & s->csr[7];
> +    bool assert = false;
> +
> +    s->csr[5] &= ~(CSR5_AIS | CSR5_NIS);
> +
> +    if (ie & (CSR5_TI | CSR5_TU | CSR5_RI | CSR5_GTE | CSR5_ERI)) {
> +        s->csr[5] |= CSR5_NIS;
> +    }
> +
> +    if (ie & (CSR5_LC | CSR5_GPI | CSR5_FBE | CSR5_LNF | CSR5_ETI | CSR5_RWT |
> +              CSR5_RPS | CSR5_RU | CSR5_UNF | CSR5_LNP_ANC | CSR5_TJT |
> +              CSR5_TPS)) {
> +        s->csr[5] |= CSR5_AIS;
> +    }
> +
> +    assert = s->csr[5] & s->csr[7] & (CSR5_AIS | CSR5_NIS);
> +    trace_tulip_irq(s->csr[5], s->csr[7], assert ? "assert" : "deassert");
> +    qemu_set_irq(s->irq, assert);
> +}
> +
> +static bool tulip_rx_stopped(TULIPState *s)
> +{
> +    return ((s->csr[5] >> CSR5_RS_SHIFT) & CSR5_RS_MASK) == CSR5_RS_STOPPED;
> +}
> +
> +static void tulip_dump_tx_descriptor(TULIPState *s,
> +        struct tulip_descriptor *desc)
> +{
> +    trace_tulip_descriptor("TX ", s->current_tx_desc,
> +                desc->status, desc->control >> 22,
> +                desc->control & 0x7ff, (desc->control >> 11) & 0x7ff,
> +                desc->buf_addr1, desc->buf_addr2);
> +}
> +
> +static void tulip_dump_rx_descriptor(TULIPState *s,
> +        struct tulip_descriptor *desc)
> +{
> +    trace_tulip_descriptor("RX ", s->current_rx_desc,
> +                desc->status, desc->control >> 22,
> +                desc->control & 0x7ff, (desc->control >> 11) & 0x7ff,
> +                desc->buf_addr1, desc->buf_addr2);
> +}
> +
> +static void tulip_next_rx_descriptor(TULIPState *s,
> +    struct tulip_descriptor *desc)
> +{
> +    if (desc->control & RDES1_RER) {
> +        s->current_rx_desc = s->csr[3];
> +    } else if (desc->control & RDES1_RCH) {
> +        s->current_rx_desc = desc->buf_addr2;
> +    } else {
> +        s->current_rx_desc += sizeof(struct tulip_descriptor) +
> +                (((s->csr[0] >> CSR0_DSL_SHIFT) & CSR0_DSL_MASK) << 2);
> +    }
> +    s->current_rx_desc &= ~3ULL;
> +}
> +
> +static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
> +{
> +    int len1 = (desc->control >> RDES1_BUF1_SIZE_SHIFT) & RDES1_BUF1_SIZE_MASK;
> +    int len2 = (desc->control >> RDES1_BUF2_SIZE_SHIFT) & RDES1_BUF2_SIZE_MASK;
> +    int len;
> +
> +    if (s->rx_frame_len && len1) {
> +        if (s->rx_frame_len > len1) {
> +            len = len1;
> +        } else {
> +            len = s->rx_frame_len;
> +        }
> +        pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
> +            (s->rx_frame_size - s->rx_frame_len), len);
> +        s->rx_frame_len -= len;
> +    }
> +
> +    if (s->rx_frame_len && len2) {
> +        if (s->rx_frame_len > len2) {
> +            len = len2;
> +        } else {
> +            len = s->rx_frame_len;
> +        }
> +        pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
> +            (s->rx_frame_size - s->rx_frame_len), len);
> +        s->rx_frame_len -= len;
> +    }
> +}
> +
> +static bool tulip_filter_address(TULIPState *s, const uint8_t *addr)
> +{
> +    static const char broadcast[] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> +    bool ret = false;
> +    int i;
> +
> +    for (i = 0; i < 16 && ret == false; i++) {
> +        if (!memcmp(&s->filter[i], addr, ETH_ALEN)) {
> +            ret = true;
> +        }
> +    }
> +
> +    if (!memcmp(addr, broadcast, ETH_ALEN)) {
> +        return true;
> +    }
> +
> +    if (s->csr[6] & (CSR6_PR | CSR6_RA)) {
> +        /* Promiscuous mode enabled */
> +        s->rx_status |= RDES0_FF;
> +        return true;
> +    }
> +
> +    if ((s->csr[6] & CSR6_PM) && (addr[0] & 1)) {
> +        /* Pass all Multicast enabled */
> +        s->rx_status |= RDES0_MF;
> +        return true;
> +    }
> +
> +    if (s->csr[6] & CSR6_IF) {
> +        ret ^= true;
> +    }
> +    return ret;
> +}
> +
> +static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t size)
> +{
> +    struct tulip_descriptor desc;
> +
> +    trace_tulip_receive(buf, size);
> +
> +    if (size < 14 || size > 2048 || s->rx_frame_len || tulip_rx_stopped(s)) {
> +        return 0;
> +    }
> +
> +    if (!tulip_filter_address(s, buf)) {
> +        return size;
> +    }
> +
> +    do {
> +        tulip_desc_read(s, s->current_rx_desc, &desc);
> +        tulip_dump_rx_descriptor(s, &desc);
> +
> +        if (!(desc.status & RDES0_OWN)) {
> +            s->csr[5] |= CSR5_RU;
> +            tulip_update_int(s);
> +            return s->rx_frame_size - s->rx_frame_len;
> +        }
> +        desc.status = 0;
> +
> +        if (!s->rx_frame_len) {
> +            s->rx_frame_size = size + 4;
> +            s->rx_status = RDES0_LS |
> +                 ((s->rx_frame_size & RDES0_FL_MASK) << RDES0_FL_SHIFT);
> +            desc.status |= RDES0_FS;
> +            memcpy(s->rx_frame, buf, size);
> +            s->rx_frame_len = s->rx_frame_size;
> +        }
> +
> +        tulip_copy_rx_bytes(s, &desc);
> +
> +        if (!s->rx_frame_len) {
> +            desc.status |= s->rx_status;
> +            s->csr[5] |= CSR5_RI;
> +            tulip_update_int(s);
> +        }
> +        tulip_dump_rx_descriptor(s, &desc);
> +        tulip_desc_write(s, s->current_rx_desc, &desc);
> +        tulip_next_rx_descriptor(s, &desc);
> +    } while (s->rx_frame_len);
> +    return size;
> +}
> +
> +static ssize_t tulip_receive_nc(NetClientState *nc,
> +                             const uint8_t *buf, size_t size)
> +{
> +    return tulip_receive(qemu_get_nic_opaque(nc), buf, size);
> +}
> +
> +
> +static NetClientInfo net_tulip_info = {
> +    .type = NET_CLIENT_DRIVER_NIC,
> +    .size = sizeof(NICState),
> +    .receive = tulip_receive_nc,
> +};
> +
> +static const char *tulip_reg_name(const hwaddr addr)
> +{
> +    switch (addr) {
> +    case CSR(0):
> +        return "CSR0";
> +
> +    case CSR(1):
> +        return "CSR1";
> +
> +    case CSR(2):
> +        return "CSR2";
> +
> +    case CSR(3):
> +        return "CSR3";
> +
> +    case CSR(4):
> +        return "CSR4";
> +
> +    case CSR(5):
> +        return "CSR5";
> +
> +    case CSR(6):
> +        return "CSR6";
> +
> +    case CSR(7):
> +        return "CSR7";
> +
> +    case CSR(8):
> +        return "CSR8";
> +
> +    case CSR(9):
> +        return "CSR9";
> +
> +    case CSR(10):
> +        return "CSR10";
> +
> +    case CSR(11):
> +        return "CSR11";
> +
> +    case CSR(12):
> +        return "CSR12";
> +
> +    case CSR(13):
> +        return "CSR13";
> +
> +    case CSR(14):
> +        return "CSR14";
> +
> +    case CSR(15):
> +        return "CSR15";
> +
> +    default:
> +        break;
> +    }
> +    return "";
> +}
> +
> +static const char *tulip_rx_state_name(int state)
> +{
> +    switch (state) {
> +    case CSR5_RS_STOPPED:
> +        return "STOPPED";
> +
> +    case CSR5_RS_RUNNING_FETCH:
> +        return "RUNNING/FETCH";
> +
> +    case CSR5_RS_RUNNING_CHECK_EOR:
> +        return "RUNNING/CHECK EOR";
> +
> +    case CSR5_RS_RUNNING_WAIT_RECEIVE:
> +        return "WAIT RECEIVE";
> +
> +    case CSR5_RS_SUSPENDED:
> +        return "SUSPENDED";
> +
> +    case CSR5_RS_RUNNING_CLOSE:
> +        return "RUNNING/CLOSE";
> +
> +    case CSR5_RS_RUNNING_FLUSH:
> +        return "RUNNING/FLUSH";
> +
> +    case CSR5_RS_RUNNING_QUEUE:
> +        return "RUNNING/QUEUE";
> +
> +    default:
> +        break;
> +    }
> +    return "";
> +}
> +
> +static const char *tulip_tx_state_name(int state)
> +{
> +    switch (state) {
> +    case CSR5_TS_STOPPED:
> +        return "STOPPED";
> +
> +    case CSR5_TS_RUNNING_FETCH:
> +        return "RUNNING/FETCH";
> +
> +    case CSR5_TS_RUNNING_WAIT_EOT:
> +        return "RUNNING/WAIT EOT";
> +
> +    case CSR5_TS_RUNNING_READ_BUF:
> +        return "RUNNING/READ BUF";
> +
> +    case CSR5_TS_RUNNING_SETUP:
> +        return "RUNNING/SETUP";
> +
> +    case CSR5_TS_SUSPENDED:
> +        return "SUSPENDED";
> +
> +    case CSR5_TS_RUNNING_CLOSE:
> +        return "RUNNING/CLOSE";
> +
> +    default:
> +        break;
> +    }
> +    return "";
> +}
> +
> +static void tulip_update_rs(TULIPState *s, int state)
> +{
> +        s->csr[5] &= ~(CSR5_RS_MASK << CSR5_RS_SHIFT);
> +        s->csr[5] |= (state & CSR5_RS_MASK) << CSR5_RS_SHIFT;
> +        trace_tulip_rx_state(tulip_rx_state_name(state));
> +}
> +
> +static uint16_t tulip_mdi_default[] = {
> +    /* MDI Registers 0 - 6, 7 */
> +    0x3100, 0xf02c, 0x7810, 0x0000, 0x0501, 0x4181, 0x0000, 0x0000,
> +    /* MDI Registers 8 - 15 */
> +    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +    /* MDI Registers 16 - 31 */
> +    0x0003, 0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +};
> +
> +/* Readonly mask for MDI (PHY) registers */
> +static const uint16_t tulip_mdi_mask[] = {
> +    0x0000, 0xffff, 0xffff, 0xffff, 0xc01f, 0xffff, 0xffff, 0x0000,
> +    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0fff, 0x0000, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff,
> +    0xffff, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +};
> +
> +static uint16_t tulip_mii_read(TULIPState *s, int phy, int reg)
> +{
> +    uint16_t ret = 0;
> +    if (phy == 1) {
> +        ret = tulip_mdi_default[reg];
> +    }
> +    trace_tulip_mii_read(phy, reg, ret);
> +    return ret;
> +}
> +
> +static void tulip_mii_write(TULIPState *s, int phy, int reg, uint16_t data)
> +{
> +    trace_tulip_mii_write(phy, reg, data);
> +
> +    if (phy != 1) {
> +        return;
> +    }
> +
> +    tulip_mdi_default[reg] &= ~tulip_mdi_mask[reg];
> +    tulip_mdi_default[reg] |= (data & tulip_mdi_mask[reg]);
> +}
> +
> +static void tulip_mii(TULIPState *s)
> +{
> +    uint32_t changed = s->old_csr9 ^ s->csr[9];
> +    uint16_t data;
> +    int op, phy, reg;
> +
> +    if (!(changed & CSR9_MDC)) {
> +        return;
> +    }
> +
> +    if (!(s->csr[9] & CSR9_MDC)) {
> +        return;
> +    }
> +
> +    s->mii_bitcnt++;
> +    s->mii_word <<= 1;
> +
> +    if (s->csr[9] & CSR9_MDO && (s->mii_bitcnt < 16 ||
> +        !(s->csr[9] & CSR9_MII))) {
> +        /* write op or address bits */
> +        s->mii_word |= 1;
> +    }
> +
> +    if (s->mii_bitcnt >= 16 && (s->csr[9] & CSR9_MII)) {
> +        if (s->mii_word & 0x8000) {
> +            s->csr[9] |= CSR9_MDI;
> +        } else {
> +            s->csr[9] &= ~CSR9_MDI;
> +        }
> +    }
> +
> +    if (s->mii_word == 0xffffffff) {
> +        s->mii_bitcnt = 0;
> +    } else if (s->mii_bitcnt == 16) {
> +        op = (s->mii_word >> 12) & 0x0f;
> +        phy = (s->mii_word >> 7) & 0x1f;
> +        reg = (s->mii_word >> 2) & 0x1f;
> +
> +        if (op == 6) {
> +            s->mii_word = tulip_mii_read(s, phy, reg);
> +        }
> +    } else if (s->mii_bitcnt == 32) {
> +            op = (s->mii_word >> 28) & 0x0f;
> +            phy = (s->mii_word >> 23) & 0x1f;
> +            reg = (s->mii_word >> 18) & 0x1f;
> +            data = s->mii_word & 0xffff;
> +
> +        if (op == 5) {
> +            tulip_mii_write(s, phy, reg, data);
> +        }
> +    }
> +}
> +
> +static uint32_t tulip_csr9_read(TULIPState *s)
> +{
> +    if (s->csr[9] & CSR9_SR) {
> +        if (eeprom93xx_read(s->eeprom)) {
> +            s->csr[9] |= CSR9_SR_DO;
> +        } else {
> +            s->csr[9] &= ~CSR9_SR_DO;
> +        }
> +    }
> +
> +    tulip_mii(s);
> +    return s->csr[9];
> +}
> +
> +static void tulip_update_ts(TULIPState *s, int state)
> +{
> +        s->csr[5] &= ~(CSR5_TS_MASK << CSR5_TS_SHIFT);
> +        s->csr[5] |= (state & CSR5_TS_MASK) << CSR5_TS_SHIFT;
> +        trace_tulip_tx_state(tulip_tx_state_name(state));
> +}
> +
> +static uint64_t tulip_read(void *opaque, hwaddr addr,
> +                              unsigned size)
> +{
> +    TULIPState *s = opaque;
> +    uint64_t data = 0;
> +
> +    switch (addr) {
> +    case CSR(9):
> +        data = tulip_csr9_read(s);
> +        break;
> +
> +    case CSR(12):
> +        /* Fake autocompletion complete until we have PHY emulation */
> +        data = 5 << CSR12_ANS_SHIFT;
> +        break;
> +
> +    default:
> +        if (addr & 7) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: read access add unknown address"
> +                " %lx\n", __func__, addr);
> +        } else {
> +            data = s->csr[addr >> 3];
> +        }
> +        break;
> +    }
> +    trace_tulip_reg_read(addr, tulip_reg_name(addr), size, data);
> +    return data;
> +}
> +
> +static void tulip_tx(TULIPState *s, struct tulip_descriptor *desc)
> +{
> +    if (s->tx_frame_len) {
> +        if ((s->csr[6] >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
> +            /* Internal or external Loopback */
> +            tulip_receive(s, s->tx_frame, s->tx_frame_len);
> +        } else {
> +            qemu_send_packet(qemu_get_queue(s->nic),
> +                s->tx_frame, s->tx_frame_len);
> +        }
> +    }
> +
> +    if (desc->control & TDES1_IC) {
> +        s->csr[5] |= CSR5_TI;
> +        tulip_update_int(s);
> +    }
> +}
> +
> +static void tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *desc)
> +{
> +    int len1 = (desc->control >> TDES1_BUF1_SIZE_SHIFT) & TDES1_BUF1_SIZE_MASK;
> +    int len2 = (desc->control >> TDES1_BUF2_SIZE_SHIFT) & TDES1_BUF2_SIZE_MASK;
> +
> +    if (len1) {
> +        pci_dma_read(&s->dev, desc->buf_addr1,
> +            s->tx_frame + s->tx_frame_len, len1);
> +        s->tx_frame_len += len1;
> +    }
> +
> +    if (len2) {
> +        pci_dma_read(&s->dev, desc->buf_addr2,
> +            s->tx_frame + s->tx_frame_len, len2);
> +        s->tx_frame_len += len2;
> +    }
> +    desc->status = (len1 + len2) ? 0 : 0x7fffffff;
> +}
> +
> +static void tulip_setup_filter_addr(TULIPState *s, uint8_t *buf, int n)
> +{
> +    int offset = n * 12;
> +
> +    s->filter[n][0] = buf[offset];
> +    s->filter[n][1] = buf[offset + 1];
> +
> +    s->filter[n][2] = buf[offset + 4];
> +    s->filter[n][3] = buf[offset + 5];
> +
> +    s->filter[n][4] = buf[offset + 8];
> +    s->filter[n][5] = buf[offset + 9];
> +
> +    trace_tulip_setup_filter(n, s->filter[n][5], s->filter[n][4],
> +            s->filter[n][3], s->filter[n][2], s->filter[n][1], s->filter[n][0]);
> +}
> +
> +static void tulip_setup_frame(TULIPState *s,
> +        struct tulip_descriptor *desc)
> +{
> +    uint8_t buf[4096];
> +    int len = (desc->control >> TDES1_BUF1_SIZE_SHIFT) & TDES1_BUF1_SIZE_MASK;
> +    int i;
> +
> +    trace_tulip_setup_frame();
> +
> +    if (len == 192) {
> +        pci_dma_read(&s->dev, desc->buf_addr1, buf, len);
> +        for (i = 0; i < 16; i++) {
> +            tulip_setup_filter_addr(s, buf, i);
> +        }
> +    }
> +
> +    desc->status = 0x7fffffff;
> +
> +    if (desc->control & TDES1_IC) {
> +        s->csr[5] |= CSR5_TI;
> +        tulip_update_int(s);
> +    }
> +}
> +
> +static void tulip_next_tx_descriptor(TULIPState *s,
> +    struct tulip_descriptor *desc)
> +{
> +    if (desc->control & TDES1_TER) {
> +        s->current_tx_desc = s->csr[4];
> +    } else if (desc->control & TDES1_TCH) {
> +        s->current_tx_desc = desc->buf_addr2;
> +    } else {
> +        s->current_tx_desc += sizeof(struct tulip_descriptor) +
> +                (((s->csr[0] >> CSR0_DSL_SHIFT) & CSR0_DSL_MASK) << 2);
> +    }
> +    s->current_tx_desc &= ~3ULL;
> +}
> +
> +static uint32_t tulip_ts(TULIPState *s)
> +{
> +    return (s->csr[5] >> CSR5_TS_SHIFT) & CSR5_TS_MASK;
> +}
> +
> +static void tulip_xmit_list_update(TULIPState *s)
> +{
> +    struct tulip_descriptor desc;
> +
> +    if (tulip_ts(s) != CSR5_TS_SUSPENDED) {
> +        return;
> +    }
> +
> +    for (;;) {
> +        tulip_desc_read(s, s->current_tx_desc, &desc);
> +        tulip_dump_tx_descriptor(s, &desc);
> +
> +        if (!(desc.status & TDES0_OWN)) {
> +            tulip_update_ts(s, CSR5_TS_SUSPENDED);
> +            s->csr[5] |= CSR5_TU;
> +            tulip_update_int(s);
> +            return;
> +        }
> +
> +        if (desc.control & TDES1_SET) {
> +            tulip_setup_frame(s, &desc);
> +        } else {
> +            if (desc.control & TDES1_FS) {
> +                s->tx_frame_len = 0;
> +            }
> +
> +            tulip_copy_tx_buffers(s, &desc);
> +
> +            if (desc.control & TDES1_LS) {
> +                tulip_tx(s, &desc);
> +            }
> +        }
> +        tulip_desc_write(s, s->current_tx_desc, &desc);
> +        tulip_next_tx_descriptor(s, &desc);
> +    }
> +}
> +
> +static void tulip_csr9_write(TULIPState *s, uint32_t old_val,
> +        uint32_t new_val)
> +{
> +    if (new_val & CSR9_SR) {
> +        eeprom93xx_write(s->eeprom,
> +            !!(new_val & CSR9_SR_CS),
> +            !!(new_val & CSR9_SR_SK),
> +            !!(new_val & CSR9_SR_DI));
> +    }
> +}
> +
> +static void tulip_reset(TULIPState *s)
> +{
> +    trace_tulip_reset();
> +
> +    s->csr[0] = 0xfe000000;
> +    s->csr[1] = 0xffffffff;
> +    s->csr[2] = 0xffffffff;
> +    s->csr[5] = 0xf0000000;
> +    s->csr[6] = 0x32000040;
> +    s->csr[7] = 0xf3fe0000;
> +    s->csr[8] = 0xe0000000;
> +    s->csr[9] = 0xfff483ff;
> +    s->csr[11] = 0xfffe0000;
> +    s->csr[12] = 0x000000c6;
> +    s->csr[13] = 0xffff0000;
> +    s->csr[14] = 0xffffffff;
> +    s->csr[15] = 0x8ff00000;
> +}
> +
> +static void tulip_qdev_reset(DeviceState *dev)
> +{
> +    PCIDevice *d = PCI_DEVICE(dev);
> +    TULIPState *s = TULIP(d);
> +
> +    tulip_reset(s);
> +}
> +
> +static void tulip_write(void *opaque, hwaddr addr,
> +                           uint64_t data, unsigned size)
> +{
> +    TULIPState *s = opaque;
> +    trace_tulip_reg_write(addr, tulip_reg_name(addr), size, data);
> +
> +    switch (addr) {
> +    case CSR(0):
> +        s->csr[0] = data;
> +        if (data & CSR0_SWR) {
> +            tulip_reset(s);
> +            tulip_update_int(s);
> +        }
> +        break;
> +
> +    case CSR(1):
> +        tulip_xmit_list_update(s);
> +        break;
> +
> +    case CSR(2):
> +        qemu_flush_queued_packets(qemu_get_queue(s->nic));
> +        break;
> +
> +    case CSR(3):
> +        s->csr[3] = data & ~3ULL;
> +        s->current_rx_desc = s->csr[3];
> +        qemu_flush_queued_packets(qemu_get_queue(s->nic));
> +        break;
> +
> +    case CSR(4):
> +        s->csr[4] = data & ~3ULL;
> +        s->current_tx_desc = s->csr[4];
> +        tulip_xmit_list_update(s);
> +        break;
> +
> +    case CSR(5):
> +        /* Status register, write clears bit */
> +        s->csr[5] &= ~(data & (CSR5_TI | CSR5_TPS | CSR5_TU | CSR5_TJT |
> +                               CSR5_LNP_ANC | CSR5_UNF | CSR5_RI | CSR5_RU |
> +                               CSR5_RPS | CSR5_RWT | CSR5_ETI | CSR5_GTE |
> +                               CSR5_LNF | CSR5_FBE | CSR5_ERI | CSR5_AIS |
> +                               CSR5_NIS | CSR5_GPI | CSR5_LC));
> +        tulip_update_int(s);
> +        break;
> +
> +    case CSR(6):
> +        s->csr[6] = data;
> +        if (s->csr[6] & CSR6_SR) {
> +            tulip_update_rs(s, CSR5_RS_RUNNING_WAIT_RECEIVE);
> +            qemu_flush_queued_packets(qemu_get_queue(s->nic));
> +        } else {
> +            tulip_update_rs(s, CSR5_RS_STOPPED);
> +        }
> +
> +        if (s->csr[6] & CSR6_ST) {
> +            tulip_update_ts(s, CSR5_TS_SUSPENDED);
> +            tulip_xmit_list_update(s);
> +        } else {
> +            tulip_update_ts(s, CSR5_TS_STOPPED);
> +        }
> +        break;
> +
> +    case CSR(7):
> +        s->csr[7] = data;
> +        tulip_update_int(s);
> +        break;
> +
> +    case CSR(8):
> +        s->csr[9] = data;
> +        break;
> +
> +    case CSR(9):
> +        tulip_csr9_write(s, s->csr[9], data);
> +        /* don't clear MII read data */
> +        s->csr[9] &= CSR9_MDI;
> +        s->csr[9] |= (data & ~CSR9_MDI);
> +        tulip_mii(s);
> +        s->old_csr9 = s->csr[9];
> +        break;
> +
> +    case CSR(10):
> +        s->csr[10] = data;
> +        break;
> +
> +    case CSR(11):
> +        s->csr[11] = data;
> +        break;
> +
> +    case CSR(12):
> +        /* SIA Status register, some bits are cleared by writing 1 */
> +        s->csr[12] &= ~(data & (CSR12_MRA | CSR12_TRA | CSR12_ARA));
> +        break;
> +
> +    case CSR(13):
> +        s->csr[13] = data;
> +        break;
> +
> +    case CSR(14):
> +        s->csr[14] = data;
> +        break;
> +
> +    case CSR(15):
> +        s->csr[15] = data;
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to CSR at unknown address "
> +                "0x%lx\n", __func__, addr);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps tulip_ops = {
> +    .read = tulip_read,
> +    .write = tulip_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void tulip_idblock_crc(TULIPState *s, uint16_t *srom)
> +{
> +    int word, n;
> +    char bit;
> +    unsigned char bitval, crc;
> +    const int len = 9;
> +    n = 0;
> +    crc = -1;
> +
> +    for (word = 0; word < len; word++) {
> +        for (bit = 15; bit >= 0; bit--) {
> +            if ((word == (len - 1)) && (bit == 7)) {
> +                /*
> +                 * Insert the correct CRC result into input data stream
> +                 * in place.
> +                 */
> +                srom[len - 1] = (srom[len - 1] & 0xff00) | (unsigned short)crc;
> +                break;
> +            }
> +            n++;
> +            bitval = ((srom[word] >> bit) & 1) ^ ((crc >> 7) & 1);
> +            crc = crc << 1;
> +            if (bitval == 1) {
> +                crc ^= 6;
> +                crc |= 0x01;
> +            }
> +        }
> +    }
> +}
> +
> +static uint16_t tulip_srom_crc(TULIPState *s, uint8_t *eeprom, size_t len)
> +{
> +    unsigned long crc = 0xffffffff;
> +    unsigned long flippedcrc = 0;
> +    unsigned char currentbyte;
> +    unsigned int msb, bit, i;
> +
> +    for (i = 0; i < len; i++) {
> +        currentbyte = eeprom[i];
> +        for (bit = 0; bit < 8; bit++) {
> +            msb = (crc >> 31) & 1;
> +            crc <<= 1;
> +            if (msb ^ (currentbyte & 1)) {
> +                crc ^= 0x04c11db6;
> +                crc |= 0x00000001;
> +            }
> +            currentbyte >>= 1;
> +        }
> +    }
> +
> +    for (i = 0; i < 32; i++) {
> +        flippedcrc <<= 1;
> +        bit = crc & 1;
> +        crc >>= 1;
> +        flippedcrc += bit;
> +    }
> +    return (flippedcrc ^ 0xffffffff) & 0xffff;
> +}
> +
> +static const uint8_t eeprom_default[128] = {
> +    0x3c, 0x10, 0x4f, 0x10, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x56, 0x08, 0x04, 0x01, 0x00, 0x80, 0x48, 0xb3,
> +    0x0e, 0xa7, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x08,
> +    0x01, 0x8d, 0x03, 0x00, 0x00, 0x00, 0x00, 0x78,
> +    0xe0, 0x01, 0x00, 0x50, 0x00, 0x18, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe8, 0x6b,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,
> +    0x48, 0xb3, 0x0e, 0xa7, 0x40, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static void tulip_fill_eeprom(TULIPState *s)
> +{
> +    uint16_t *eeprom = eeprom93xx_data(s->eeprom);
> +    memcpy(eeprom, eeprom_default, 128);
> +
> +    /* patch in our mac address */
> +    eeprom[10] = cpu_to_le16(s->c.macaddr.a[0] | (s->c.macaddr.a[1] << 8));
> +    eeprom[11] = cpu_to_le16(s->c.macaddr.a[2] | (s->c.macaddr.a[3] << 8));
> +    eeprom[12] = cpu_to_le16(s->c.macaddr.a[4] | (s->c.macaddr.a[5] << 8));
> +    tulip_idblock_crc(s, eeprom);
> +    eeprom[63] = cpu_to_le16(tulip_srom_crc(s, (uint8_t *)eeprom, 126));
> +}
> +
> +static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    TULIPState *s = DO_UPCAST(TULIPState, dev, pci_dev);
> +    uint8_t *pci_conf;
> +
> +    pci_conf = s->dev.config;
> +    pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
> +
> +    s->eeprom = eeprom93xx_new(&pci_dev->qdev, 64);
> +    tulip_fill_eeprom(s);
> +
> +    memory_region_init_io(&s->io, OBJECT(&s->dev), &tulip_ops, s,
> +            "tulip-io", 128);
> +
> +    memory_region_init_io(&s->memory, OBJECT(&s->dev), &tulip_ops, s,
> +            "tulip-mem", 128);
> +
> +    pci_register_bar(&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
> +    pci_register_bar(&s->dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->memory);
> +
> +    s->irq = pci_allocate_irq(&s->dev);
> +
> +    qemu_macaddr_default_if_unset(&s->c.macaddr);
> +
> +    s->nic = qemu_new_nic(&net_tulip_info, &s->c,
> +                          object_get_typename(OBJECT(pci_dev)),
> +                          pci_dev->qdev.id, s);
> +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
> +}
> +
> +static void pci_tulip_exit(PCIDevice *pci_dev)
> +{
> +    TULIPState *s = DO_UPCAST(TULIPState, dev, pci_dev);
> +
> +    qemu_del_nic(s->nic);
> +    qemu_free_irq(s->irq);
> +    eeprom93xx_free(&pci_dev->qdev, s->eeprom);
> +}
> +
> +static void tulip_instance_init(Object *obj)
> +{
> +    PCIDevice *pci_dev = PCI_DEVICE(obj);
> +    TULIPState *d = DO_UPCAST(TULIPState, dev, pci_dev);
> +
> +    device_add_bootindex_property(obj, &d->c.bootindex,
> +                                  "bootindex", "/ethernet-phy@0",
> +                                  &pci_dev->qdev, NULL);
> +}
> +
> +static Property tulip_properties[] = {
> +    DEFINE_NIC_PROPERTIES(TULIPState, c),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tulip_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = pci_tulip_realize;
> +    k->exit = pci_tulip_exit;
> +    k->vendor_id = PCI_VENDOR_ID_DEC;
> +    k->device_id = PCI_DEVICE_ID_DEC_21143;
> +    k->subsystem_vendor_id = 0x103c;
> +    k->subsystem_id = 0x104f;
> +    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
> +    dc->vmsd = &vmstate_pci_tulip;
> +    dc->props = tulip_properties;
> +    dc->reset = tulip_qdev_reset;
> +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> +}
> +
> +static const TypeInfo tulip_info = {
> +    .name          = TYPE_TULIP,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(TULIPState),
> +    .class_init    = tulip_class_init,
> +    .instance_init = tulip_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void tulip_register_types(void)
> +{
> +    type_register_static(&tulip_info);
> +}
> +
> +type_init(tulip_register_types)
> diff --git a/hw/net/tulip.h b/hw/net/tulip.h
> new file mode 100644
> index 0000000000..ffe4e123fb
> --- /dev/null
> +++ b/hw/net/tulip.h
> @@ -0,0 +1,268 @@
> +#ifndef HW_TULIP_H
> +#define HW_TULIP_H
> +
> +#include "qemu/units.h"
> +#include "net/net.h"
> +
> +#define TYPE_TULIP "tulip"
> +#define TULIP(obj) OBJECT_CHECK(TULIPState, (obj), TYPE_TULIP)
> +
> +#define CSR(_x) ((_x) << 3)
> +
> +#define CSR0_SWR        BIT(0)
> +#define CSR0_BAR        BIT(1)
> +#define CSR0_DSL_SHIFT  2
> +#define CSR0_DSL_MASK   0x1f
> +#define CSR0_BLE        BIT(7)
> +#define CSR0_PBL_SHIFT  8
> +#define CSR0_PBL_MASK   0x3f
> +#define CSR0_CAC_SHIFT  14
> +#define CSR0_CAC_MASK   0x3
> +#define CSR0_DAS        0x10000
> +#define CSR0_TAP_SHIFT  17
> +#define CSR0_TAP_MASK   0x7
> +#define CSR0_DBO        0x100000
> +#define CSR1_TPD        0x01
> +#define CSR0_RLE        BIT(23)
> +#define CSR0_WIE        BIT(24)
> +
> +#define CSR2_RPD        0x01
> +
> +#define CSR5_TI         BIT(0)
> +#define CSR5_TPS        BIT(1)
> +#define CSR5_TU         BIT(2)
> +#define CSR5_TJT        BIT(3)
> +#define CSR5_LNP_ANC    BIT(4)
> +#define CSR5_UNF        BIT(5)
> +#define CSR5_RI         BIT(6)
> +#define CSR5_RU         BIT(7)
> +#define CSR5_RPS        BIT(8)
> +#define CSR5_RWT        BIT(9)
> +#define CSR5_ETI        BIT(10)
> +#define CSR5_GTE        BIT(11)
> +#define CSR5_LNF        BIT(12)
> +#define CSR5_FBE        BIT(13)
> +#define CSR5_ERI        BIT(14)
> +#define CSR5_AIS        BIT(15)
> +#define CSR5_NIS        BIT(16)
> +#define CSR5_RS_SHIFT   17
> +#define CSR5_RS_MASK    7
> +#define CSR5_TS_SHIFT   20
> +#define CSR5_TS_MASK    7
> +
> +#define CSR5_TS_STOPPED                 0
> +#define CSR5_TS_RUNNING_FETCH           1
> +#define CSR5_TS_RUNNING_WAIT_EOT        2
> +#define CSR5_TS_RUNNING_READ_BUF        3
> +#define CSR5_TS_RUNNING_SETUP           5
> +#define CSR5_TS_SUSPENDED               6
> +#define CSR5_TS_RUNNING_CLOSE           7
> +
> +#define CSR5_RS_STOPPED                 0
> +#define CSR5_RS_RUNNING_FETCH           1
> +#define CSR5_RS_RUNNING_CHECK_EOR       2
> +#define CSR5_RS_RUNNING_WAIT_RECEIVE    3
> +#define CSR5_RS_SUSPENDED               4
> +#define CSR5_RS_RUNNING_CLOSE           5
> +#define CSR5_RS_RUNNING_FLUSH           6
> +#define CSR5_RS_RUNNING_QUEUE           7
> +
> +#define CSR5_EB_SHIFT   23
> +#define CSR5_EB_MASK    7
> +
> +#define CSR5_GPI        BIT(26)
> +#define CSR5_LC         BIT(27)
> +
> +#define CSR6_HP         BIT(0)
> +#define CSR6_SR         BIT(1)
> +#define CSR6_HO         BIT(2)
> +#define CSR6_PB         BIT(3)
> +#define CSR6_IF         BIT(4)
> +#define CSR6_SB         BIT(5)
> +#define CSR6_PR         BIT(6)
> +#define CSR6_PM         BIT(7)
> +#define CSR6_FKD        BIT(8)
> +#define CSR6_FD         BIT(9)
> +
> +#define CSR6_OM_SHIFT   10
> +#define CSR6_OM_MASK    3
> +#define CSR6_OM_NORMAL          0
> +#define CSR6_OM_INT_LOOPBACK    1
> +#define CSR6_OM_EXT_LOOPBACK    2
> +
> +#define CSR6_FC         BIT(12)
> +#define CSR6_ST         BIT(13)
> +
> +
> +#define CSR6_TR_SHIFT   14
> +#define CSR6_TR_MASK    3
> +#define CSR6_TR_72      0
> +#define CSR6_TR_96      1
> +#define CSR6_TR_128     2
> +#define CSR6_TR_160     3
> +
> +#define CSR6_CA         BIT(17)
> +#define CSR6_RA         BIT(30)
> +#define CSR6_SC         BIT(31)
> +
> +#define CSR7_TIM        BIT(0)
> +#define CSR7_TSM        BIT(1)
> +#define CSR7_TUM        BIT(2)
> +#define CSR7_TJM        BIT(3)
> +#define CSR7_LPM        BIT(4)
> +#define CSR7_UNM        BIT(5)
> +#define CSR7_RIM        BIT(6)
> +#define CSR7_RUM        BIT(7)
> +#define CSR7_RSM        BIT(8)
> +#define CSR7_RWM        BIT(9)
> +#define CSR7_TMM        BIT(11)
> +#define CSR7_LFM        BIT(12)
> +#define CSR7_SEM        BIT(13)
> +#define CSR7_ERM        BIT(14)
> +#define CSR7_AIM        BIT(15)
> +#define CSR7_NIM        BIT(16)
> +
> +#define CSR8_MISSED_FRAME_OVL           BIT(16)
> +#define CSR8_MISSED_FRAME_CNT_MASK      0xffff
> +
> +#define CSR9_DATA_MASK  0xff
> +#define CSR9_SR_CS      BIT(0)
> +#define CSR9_SR_SK      BIT(1)
> +#define CSR9_SR_DI      BIT(2)
> +#define CSR9_SR_DO      BIT(3)
> +#define CSR9_REG        BIT(10)
> +#define CSR9_SR         BIT(11)
> +#define CSR9_BR         BIT(12)
> +#define CSR9_WR         BIT(13)
> +#define CSR9_RD         BIT(14)
> +#define CSR9_MOD        BIT(15)
> +#define CSR9_MDC        BIT(16)
> +#define CSR9_MDO        BIT(17)
> +#define CSR9_MII        BIT(18)
> +#define CSR9_MDI        BIT(19)
> +
> +#define CSR11_CON       BIT(16)
> +#define CSR11_TIMER_MASK 0xffff
> +
> +#define CSR12_MRA       BIT(0)
> +#define CSR12_LS100     BIT(1)
> +#define CSR12_LS10      BIT(2)
> +#define CSR12_APS       BIT(3)
> +#define CSR12_ARA       BIT(8)
> +#define CSR12_TRA       BIT(9)
> +#define CSR12_NSN       BIT(10)
> +#define CSR12_TRF       BIT(11)
> +#define CSR12_ANS_SHIFT 12
> +#define CSR12_ANS_MASK  7
> +#define CSR12_LPN       BIT(15)
> +#define CSR12_LPC_SHIFT 16
> +#define CSR12_LPC_MASK  0xffff
> +
> +#define CSR13_SRL       BIT(0)
> +#define CSR13_CAC       BIT(2)
> +#define CSR13_AUI       BIT(3)
> +#define CSR13_SDM_SHIFT 4
> +#define CSR13_SDM_MASK  0xfff
> +
> +#define CSR14_ECEN      BIT(0)
> +#define CSR14_LBK       BIT(1)
> +#define CSR14_DREN      BIT(2)
> +#define CSR14_LSE       BIT(3)
> +#define CSR14_CPEN_SHIFT 4
> +#define CSR14_CPEN_MASK 3
> +#define CSR14_MBO       BIT(6)
> +#define CSR14_ANE       BIT(7)
> +#define CSR14_RSQ       BIT(8)
> +#define CSR14_CSQ       BIT(9)
> +#define CSR14_CLD       BIT(10)
> +#define CSR14_SQE       BIT(11)
> +#define CSR14_LTE       BIT(12)
> +#define CSR14_APE       BIT(13)
> +#define CSR14_SPP       BIT(14)
> +#define CSR14_TAS       BIT(15)
> +
> +#define CSR15_JBD       BIT(0)
> +#define CSR15_HUJ       BIT(1)
> +#define CSR15_JCK       BIT(2)
> +#define CSR15_ABM       BIT(3)
> +#define CSR15_RWD       BIT(4)
> +#define CSR15_RWR       BIT(5)
> +#define CSR15_LE1       BIT(6)
> +#define CSR15_LV1       BIT(7)
> +#define CSR15_TSCK      BIT(8)
> +#define CSR15_FUSQ      BIT(9)
> +#define CSR15_FLF       BIT(10)
> +#define CSR15_LSD       BIT(11)
> +#define CSR15_DPST      BIT(12)
> +#define CSR15_FRL       BIT(13)
> +#define CSR15_LE2       BIT(14)
> +#define CSR15_LV2       BIT(15)
> +
> +#define RDES0_OF         BIT(0)
> +#define RDES0_CE         BIT(1)
> +#define RDES0_DB         BIT(2)
> +#define RDES0_RJ         BIT(4)
> +#define RDES0_FT         BIT(5)
> +#define RDES0_CS         BIT(6)
> +#define RDES0_TL         BIT(7)
> +#define RDES0_LS         BIT(8)
> +#define RDES0_FS         BIT(9)
> +#define RDES0_MF         BIT(10)
> +#define RDES0_RF         BIT(11)
> +#define RDES0_DT_SHIFT   12
> +#define RDES0_DT_MASK    3
> +#define RDES0_LE         BIT(14)
> +#define RDES0_ES         BIT(15)
> +#define RDES0_FL_SHIFT   16
> +#define RDES0_FL_MASK    0x3fff
> +#define RDES0_FF         BIT(30)
> +#define RDES0_OWN        BIT(31)
> +
> +#define RDES1_BUF1_SIZE_SHIFT 0
> +#define RDES1_BUF1_SIZE_MASK 0x7ff
> +
> +#define RDES1_BUF2_SIZE_SHIFT 11
> +#define RDES1_BUF2_SIZE_MASK 0x7ff
> +#define RDES1_RCH       BIT(24)
> +#define RDES1_RER       BIT(25)
> +
> +#define TDES0_DE        BIT(0)
> +#define TDES0_UF        BIT(1)
> +#define TDES0_LF        BIT(2)
> +#define TDES0_CC_SHIFT  3
> +#define TDES0_CC_MASK   0xf
> +#define TDES0_HF        BIT(7)
> +#define TDES0_EC        BIT(8)
> +#define TDES0_LC        BIT(9)
> +#define TDES0_NC        BIT(10)
> +#define TDES0_LO        BIT(11)
> +#define TDES0_TO        BIT(14)
> +#define TDES0_ES        BIT(15)
> +#define TDES0_OWN       BIT(31)
> +
> +#define TDES1_BUF1_SIZE_SHIFT 0
> +#define TDES1_BUF1_SIZE_MASK 0x7ff
> +
> +#define TDES1_BUF2_SIZE_SHIFT 11
> +#define TDES1_BUF2_SIZE_MASK 0x7ff
> +
> +#define TDES1_FT0       BIT(22)
> +#define TDES1_DPD       BIT(23)
> +#define TDES1_TCH       BIT(24)
> +#define TDES1_TER       BIT(25)
> +#define TDES1_AC        BIT(26)
> +#define TDES1_SET       BIT(27)
> +#define TDES1_FT1       BIT(28)
> +#define TDES1_FS        BIT(29)
> +#define TDES1_LS        BIT(30)
> +#define TDES1_IC        BIT(31)
> +
> +struct tulip_descriptor {
> +        uint32_t status;
> +        uint32_t control;
> +        uint32_t buf_addr1;
> +        uint32_t buf_addr2;
> +};
> +
> +
> +#endif
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 0abe27a53a..11f8ab7149 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -164,6 +164,7 @@
>  #define PCI_DEVICE_ID_LSI_SAS0079        0x0079
>  
>  #define PCI_VENDOR_ID_DEC                0x1011
> +#define PCI_DEVICE_ID_DEC_21143          0x0019
>  #define PCI_DEVICE_ID_DEC_21154          0x0026
>  
>  #define PCI_VENDOR_ID_CIRRUS             0x1013
> -- 
> 2.23.0

