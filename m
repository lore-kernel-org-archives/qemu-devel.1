Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92743C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5187420716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 05:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5187420716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnbQL-0001Br-Kh
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 01:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnbPj-0000kf-Oi
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:24:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnbPh-0000Hq-NT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 01:24:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so15384483edq.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 22:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g1E6LFwsWhHlJdaxRVJth5dRl4KQtDRE1SIJK7/oIaQ=;
 b=QfWN+HxhpTFvTeShVcOM88fNMcFSus0RDrHixradXTPFO9eyClQXt4AIWfHsRWWopK
 8pM3MiOMWJMR/yO/RyJE6YyXIgFwPudirdfH2UL1s17/8YkP3kQjJGYUD0J3tTYOrTb5
 g1B8F5t/ru4/fhmgBYk0xtnDA1Frj8RdP71743XTFDJJGm79mrsvqCyYEw/ckX1Et6Rl
 dDFSGikIdZi5jtN5h4pf8vZ1jo6XNlHwfs7pHXZUp99WIBKOVNSm+J0zFFqDWcF2ZWnk
 SIOlaQ5haBbJqD+TAj2adp/v2b+nCP4QhxxJtqwviAgQTVfySMaYnk8NANAXt4DrtZG1
 aHEw==
X-Gm-Message-State: AOAM531KW9IOaC0Nao2/4IzzjmS2C2SBuvVltN8RN98yBk0rebqoJx6o
 5RxREtKZiu5h+magMA9cgaURxd2fsLSg3Vi56V4=
X-Google-Smtp-Source: ABdhPJyZKLzosARc6fS2hveDMqyYIbO0grtaGG6eJzQSZJDo96IsEnD0irIuBJsS5z5+CBrYdV04BL9Lp+vviZKEkxY=
X-Received: by 2002:a50:c8c9:: with SMTP id k9mr19601941edh.157.1592889844199; 
 Mon, 22 Jun 2020 22:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200621145235.9E241745712@zero.eik.bme.hu>
 <20200622213237.GB3258@minyard.net>
 <20200623020601.GD3258@minyard.net>
 <da9237e0-0dd3-9da2-1707-20f5343bbf98@amsat.org>
In-Reply-To: <da9237e0-0dd3-9da2-1707-20f5343bbf98@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jun 2020 07:23:52 +0200
Message-ID: <CAAdtpL6h01mQDtzujU8TSp4Bh8-xruLrx4VH0zQz=ivg6Ujb0w@mail.gmail.com>
Subject: Re: [PATCH] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
To: Corey Minyard <cminyard@mvista.com>, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 7:15 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On 6/23/20 4:06 AM, Corey Minyard wrote:
> > On Mon, Jun 22, 2020 at 04:32:37PM -0500, Corey Minyard wrote:
> >> On Sun, Jun 21, 2020 at 04:43:38PM +0200, BALATON Zoltan wrote:
> >>> These functions have a parameter that decides the direction of
> >>> transfer but totally confusingly they don't match but inverted sense.
> >>> To avoid frequent mistakes when using these functions change
> >>> i2c_send_recv to match i2c_start_transfer. Also use bool in
> >>> i2c_start_transfer instead of int to match i2c_send_recv.
> >>
> >> Hmm, I have to admit that this is a little better.  Indeed the
> >> hw/misc/auxbus.c looks suspicious.  I can't imagine that code has ever
> >> been tested.
> >>
> >> I don't know the policy on changing an API like this with silent
> >> semantic changes.  You've gotten all the internal ones; I'm wondering =
if
> >> we worry about silently breaking out of tree things.
> >>
> >> I'll pull this into my tree, but hopefully others will comment on this=
.
> >
> > The more I think about it, the more I think it's a better idea to renam=
e
> > the function.  Like i2c_send_or_recv(), which is a little more clear
> > about what it does.  Does that sound good?
>
> Or to match the common pattern used in QEMU:
>
>   int i2c_rw(I2CBus *bus, uint8_t *data, bool is_write);

Bah there is also:

$ git grep -A1 -F _send_recv\( include
include/hw/i2c/i2c.h:78:int i2c_send_recv(I2CBus *bus, uint8_t *data,
bool send);
include/hw/i2c/i2c.h-79-int i2c_send(I2CBus *bus, uint8_t data);
--
include/qemu-common.h:100:ssize_t qemu_co_send_recv(int sockfd, void
*buf, size_t bytes, bool do_send);
include/qemu-common.h-101-#define qemu_co_recv(sockfd, buf, bytes) \
include/qemu-common.h:102:  qemu_co_send_recv(sockfd, buf, bytes, false)
include/qemu-common.h-103-#define qemu_co_send(sockfd, buf, bytes) \
include/qemu-common.h:104:  qemu_co_send_recv(sockfd, buf, bytes, true)
include/qemu-common.h-105-
--
include/qemu/iov.h:84: *   r =3D iov_send_recv(sockfd, iov, iovcnt,
offset, bytes, true);
include/qemu/iov.h-85- *
--
include/qemu/iov.h:93: * For iov_send_recv() _whole_ area being sent or rec=
eived
include/qemu/iov.h-94- * should be within the iovec, not only beginning of =
it.
--
include/qemu/iov.h:96:ssize_t iov_send_recv(int sockfd, const struct
iovec *iov, unsigned iov_cnt,
include/qemu/iov.h-97-                      size_t offset, size_t
bytes, bool do_send);
--
include/qemu/iov.h:99:  iov_send_recv(sockfd, iov, iov_cnt, offset,
bytes, false)
include/qemu/iov.h-100-#define iov_send(sockfd, iov, iov_cnt, offset, bytes=
) \
include/qemu/iov.h:101:  iov_send_recv(sockfd, iov, iov_cnt, offset,
bytes, true)
include/qemu/iov.h-102-

Maybe i2c_transact(I2CBus *bus, uint8_t *data, bool is_send)?

> Or
>
>   int i2c_bus_rw(I2CBus *bus, uint8_t *data, bool is_write);
>
> See:
>
> $ git grep -A1 -F _rw\( include
> include/exec/cpu-common.h:69:void cpu_physical_memory_rw(hwaddr addr,
> void *buf,
> include/exec/cpu-common.h-70-                            hwaddr len,
> bool is_write);
> --
> include/exec/cpu-common.h:74:    cpu_physical_memory_rw(addr, buf, len,
> false);
> include/exec/cpu-common.h-75-}
> --
> include/exec/cpu-common.h:79:    cpu_physical_memory_rw(addr, (void
> *)buf, len, true);
> include/exec/cpu-common.h-80-}
> --
> include/exec/memory.h:2059:MemTxResult address_space_rw(AddressSpace
> *as, hwaddr addr,
> include/exec/memory.h-2060-                             MemTxAttrs
> attrs, void *buf,
> --
> include/hw/pci/pci.h:786:static inline int pci_dma_rw(PCIDevice *dev,
> dma_addr_t addr,
> include/hw/pci/pci.h-787-                             void *buf,
> dma_addr_t len, DMADirection dir)
> --
> include/hw/pci/pci.h:789:    dma_memory_rw(pci_get_address_space(dev),
> addr, buf, len, dir);
> include/hw/pci/pci.h-790-    return 0;
> --
> include/hw/pci/pci.h:796:    return pci_dma_rw(dev, addr, buf, len,
> DMA_DIRECTION_TO_DEVICE);
> include/hw/pci/pci.h-797-}
> --
> include/hw/pci/pci.h:802:    return pci_dma_rw(dev, addr, (void *) buf,
> len, DMA_DIRECTION_FROM_DEVICE);
> include/hw/pci/pci.h-803-}
> --
> include/hw/ppc/spapr_xive.h:86:uint64_t kvmppc_xive_esb_rw(XiveSource
> *xsrc, int srcno, uint32_t offset,
> include/hw/ppc/spapr_xive.h-87-                            uint64_t
> data, bool write);
> --
> include/sysemu/dma.h:87:    return (bool)address_space_rw(as, addr,
> MEMTXATTRS_UNSPECIFIED,
> include/sysemu/dma.h-88-                                  buf, len, dir
> =3D=3D DMA_DIRECTION_FROM_DEVICE);
> --
> include/sysemu/dma.h:104:static inline int dma_memory_rw(AddressSpace
> *as, dma_addr_t addr,
> include/sysemu/dma.h-105-                                void *buf,
> dma_addr_t len,
> --
> include/sysemu/dma.h:116:    return dma_memory_rw(as, addr, buf, len,
> DMA_DIRECTION_TO_DEVICE);
> include/sysemu/dma.h-117-}
> --
> include/sysemu/dma.h:122:    return dma_memory_rw(as, addr, (void *)buf,
> len,
> include/sysemu/dma.h-123-
> DMA_DIRECTION_FROM_DEVICE);
>
> >
> > -corey
> >
> >>
> >> -corey
> >>
> >>>
> >>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>> ---
> >>> Looks like hw/misc/auxbus.c already got this wrong and calls both
> >>> i2c_start_transfer and i2c_send_recv with same is_write parameter.
> >>> Although the name of the is_write variable suggest this may need to b=
e
> >>> inverted I'm not sure what that value actially means and which usage
> >>> was correct so I did not touch it. Someone knowing this device might
> >>> want to review and fix it.
> >>>
> >>>  hw/display/sm501.c   |  2 +-
> >>>  hw/i2c/core.c        | 34 +++++++++++++++++-----------------
> >>>  hw/i2c/ppc4xx_i2c.c  |  2 +-
> >>>  include/hw/i2c/i2c.h |  4 ++--
> >>>  4 files changed, 21 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> >>> index 2db347dcbc..ccd0a6e376 100644
> >>> --- a/hw/display/sm501.c
> >>> +++ b/hw/display/sm501.c
> >>> @@ -1034,7 +1034,7 @@ static void sm501_i2c_write(void *opaque, hwadd=
r addr, uint64_t value,
> >>>                      int i;
> >>>                      for (i =3D 0; i <=3D s->i2c_byte_count; i++) {
> >>>                          res =3D i2c_send_recv(s->i2c_bus, &s->i2c_da=
ta[i],
> >>> -                                            !(s->i2c_addr & 1));
> >>> +                                            s->i2c_addr & 1);
> >>>                          if (res) {
> >>>                              s->i2c_status |=3D SM501_I2C_STATUS_ERRO=
R;
> >>>                              return;
> >>> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> >>> index 1aac457a2a..c9d01df427 100644
> >>> --- a/hw/i2c/core.c
> >>> +++ b/hw/i2c/core.c
> >>> @@ -91,7 +91,7 @@ int i2c_bus_busy(I2CBus *bus)
> >>>   * without releasing the bus.  If that fails, the bus is still
> >>>   * in a transaction.
> >>>   */
> >>> -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
> >>> +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv)
> >>>  {
> >>>      BusChild *kid;
> >>>      I2CSlaveClass *sc;
> >>> @@ -175,26 +175,14 @@ void i2c_end_transfer(I2CBus *bus)
> >>>      bus->broadcast =3D false;
> >>>  }
> >>>
> >>> -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
> >>> +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv)
> >>>  {
> >>>      I2CSlaveClass *sc;
> >>>      I2CSlave *s;
> >>>      I2CNode *node;
> >>>      int ret =3D 0;
> >>>
> >>> -    if (send) {
> >>> -        QLIST_FOREACH(node, &bus->current_devs, next) {
> >>> -            s =3D node->elt;
> >>> -            sc =3D I2C_SLAVE_GET_CLASS(s);
> >>> -            if (sc->send) {
> >>> -                trace_i2c_send(s->address, *data);
> >>> -                ret =3D ret || sc->send(s, *data);
> >>> -            } else {
> >>> -                ret =3D -1;
> >>> -            }
> >>> -        }
> >>> -        return ret ? -1 : 0;
> >>> -    } else {
> >>> +    if (recv) {
> >>>          ret =3D 0xff;
> >>>          if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
> >>>              sc =3D I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_dev=
s)->elt);
> >>> @@ -206,19 +194,31 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, b=
ool send)
> >>>          }
> >>>          *data =3D ret;
> >>>          return 0;
> >>> +    } else {
> >>> +        QLIST_FOREACH(node, &bus->current_devs, next) {
> >>> +            s =3D node->elt;
> >>> +            sc =3D I2C_SLAVE_GET_CLASS(s);
> >>> +            if (sc->send) {
> >>> +                trace_i2c_send(s->address, *data);
> >>> +                ret =3D ret || sc->send(s, *data);
> >>> +            } else {
> >>> +                ret =3D -1;
> >>> +            }
> >>> +        }
> >>> +        return ret ? -1 : 0;
> >>>      }
> >>>  }
> >>>
> >>>  int i2c_send(I2CBus *bus, uint8_t data)
> >>>  {
> >>> -    return i2c_send_recv(bus, &data, true);
> >>> +    return i2c_send_recv(bus, &data, false);
> >>>  }
> >>>
> >>>  uint8_t i2c_recv(I2CBus *bus)
> >>>  {
> >>>      uint8_t data =3D 0xff;
> >>>
> >>> -    i2c_send_recv(bus, &data, false);
> >>> +    i2c_send_recv(bus, &data, true);
> >>>      return data;
> >>>  }
> >>>
> >>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> >>> index c0a8e04567..d3899203a4 100644
> >>> --- a/hw/i2c/ppc4xx_i2c.c
> >>> +++ b/hw/i2c/ppc4xx_i2c.c
> >>> @@ -239,7 +239,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwadd=
r addr, uint64_t value,
> >>>                      }
> >>>                  }
> >>>                  if (!(i2c->sts & IIC_STS_ERR) &&
> >>> -                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) =
{
> >>> +                    i2c_send_recv(i2c->bus, &i2c->mdata[i], recv)) {
> >>>                      i2c->sts |=3D IIC_STS_ERR;
> >>>                      i2c->extsts |=3D IIC_EXTSTS_XFRA;
> >>>                      break;
> >>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> >>> index 4117211565..a09ab9230b 100644
> >>> --- a/include/hw/i2c/i2c.h
> >>> +++ b/include/hw/i2c/i2c.h
> >>> @@ -72,10 +72,10 @@ struct I2CBus {
> >>>  I2CBus *i2c_init_bus(DeviceState *parent, const char *name);
> >>>  void i2c_set_slave_address(I2CSlave *dev, uint8_t address);
> >>>  int i2c_bus_busy(I2CBus *bus);
> >>> -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv);
> >>> +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv);
> >>>  void i2c_end_transfer(I2CBus *bus);
> >>>  void i2c_nack(I2CBus *bus);
> >>> -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
> >>> +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv);
> >>>  int i2c_send(I2CBus *bus, uint8_t data);
> >>>  uint8_t i2c_recv(I2CBus *bus);
> >>>
> >>> --
> >>> 2.21.3
> >>>
> >
>

