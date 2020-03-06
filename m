Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571B2C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1F220409
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1F220409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAEcI-0000Rz-BM
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 10:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jAEbe-0008Gm-Os
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jAEbb-0002Bw-BG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:09:41 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:57659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jAEbb-00029y-1J
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:09:39 -0500
Received: from player157.ha.ovh.net (unknown [10.110.171.131])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 73E8387D27
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 16:09:36 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 17CE410266499;
 Fri,  6 Mar 2020 15:09:17 +0000 (UTC)
Subject: Re: [PATCH 5/6] hw/net: Make NetCanReceive() return a boolean
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305175651.4563-1-philmd@redhat.com>
 <20200305175651.4563-6-philmd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <34548e91-0cbc-fe0a-7131-b8b8f0871056@kaod.org>
Date: Fri, 6 Mar 2020 16:09:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305175651.4563-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7471190309724982227
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudduvddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.233
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 6:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The NetCanReceive handler return whether the device can or
> can not receive new packets. Make it obvious by returning
> a boolean type.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

ftgmac100 looks good.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> ---
>  hw/net/i82596.h         |  2 +-
>  include/net/net.h       |  2 +-
>  hw/net/allwinner_emac.c |  2 +-
>  hw/net/cadence_gem.c    |  8 ++++----
>  hw/net/dp8393x.c        |  8 +++-----
>  hw/net/e1000.c          |  2 +-
>  hw/net/e1000e.c         |  2 +-
>  hw/net/ftgmac100.c      |  6 +++---
>  hw/net/i82596.c         | 10 +++++-----
>  hw/net/imx_fec.c        |  2 +-
>  hw/net/opencores_eth.c  |  5 ++---
>  hw/net/rtl8139.c        |  8 ++++----
>  hw/net/smc91c111.c      |  2 +-
>  hw/net/spapr_llan.c     |  4 ++--
>  hw/net/sungem.c         |  6 +++---
>  hw/net/sunhme.c         |  4 ++--
>  hw/net/virtio-net.c     | 10 +++++-----
>  hw/net/xilinx_ethlite.c |  2 +-
>  net/filter-buffer.c     |  2 +-
>  net/hub.c               |  6 +++---
>  20 files changed, 45 insertions(+), 48 deletions(-)
>=20
> diff --git a/hw/net/i82596.h b/hw/net/i82596.h
> index 1238ac11f8..f0bbe810eb 100644
> --- a/hw/net/i82596.h
> +++ b/hw/net/i82596.h
> @@ -48,7 +48,7 @@ void i82596_ioport_writel(void *opaque, uint32_t addr=
, uint32_t val);
>  uint32_t i82596_ioport_readl(void *opaque, uint32_t addr);
>  uint32_t i82596_bcr_readw(I82596State *s, uint32_t rap);
>  ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t =
size_);
> -int i82596_can_receive(NetClientState *nc);
> +bool i82596_can_receive(NetClientState *nc);
>  void i82596_set_link_status(NetClientState *nc);
>  void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInf=
o *info);
>  extern const VMStateDescription vmstate_i82596;
> diff --git a/include/net/net.h b/include/net/net.h
> index e175ba9677..d191ee777e 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -42,7 +42,7 @@ typedef struct NICConf {
>  /* Net clients */
> =20
>  typedef void (NetPoll)(NetClientState *, bool enable);
> -typedef int (NetCanReceive)(NetClientState *);
> +typedef bool (NetCanReceive)(NetClientState *);
>  typedef ssize_t (NetReceive)(NetClientState *, const uint8_t *, size_t=
);
>  typedef ssize_t (NetReceiveIOV)(NetClientState *, const struct iovec *=
, int);
>  typedef void (NetCleanup) (NetClientState *);
> diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
> index e9bbff8710..ddddf35c45 100644
> --- a/hw/net/allwinner_emac.c
> +++ b/hw/net/allwinner_emac.c
> @@ -178,13 +178,13 @@ static uint32_t fifo8_pop_word(Fifo8 *fifo)
>      return ret;
>  }
> =20
> -static int aw_emac_can_receive(NetClientState *nc)
> +static bool aw_emac_can_receive(NetClientState *nc)
>  {
>      AwEmacState *s =3D qemu_get_nic_opaque(nc);
> =20
>      /*
>       * To avoid packet drops, allow reception only when there is space
>       * for a full frame: 1522 + 8 (rx headers) + 2 (padding).
>       */
>      return (s->ctl & EMAC_CTL_RX_EN) && (fifo8_num_free(&s->rx_fifo) >=
=3D 1532);
>  }
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 6340c1eaf8..51ec5a072d 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -505,44 +505,44 @@ static void phy_update_link(CadenceGEMState *s)
>      }
>  }
> =20
> -static int gem_can_receive(NetClientState *nc)
> +static bool gem_can_receive(NetClientState *nc)
>  {
>      CadenceGEMState *s;
>      int i;
> =20
>      s =3D qemu_get_nic_opaque(nc);
> =20
>      /* Do nothing if receive is not enabled. */
>      if (!(s->regs[GEM_NWCTRL] & GEM_NWCTRL_RXENA)) {
>          if (s->can_rx_state !=3D 1) {
>              s->can_rx_state =3D 1;
>              DB_PRINT("can't receive - no enable\n");
>          }
> -        return 0;
> +        return false;
>      }
> =20
>      for (i =3D 0; i < s->num_priority_queues; i++) {
>          if (rx_desc_get_ownership(s->rx_desc[i]) !=3D 1) {
>              break;
>          }
>      };
> =20
>      if (i =3D=3D s->num_priority_queues) {
>          if (s->can_rx_state !=3D 2) {
>              s->can_rx_state =3D 2;
>              DB_PRINT("can't receive - all the buffer descriptors are b=
usy\n");
>          }
> -        return 0;
> +        return false;
>      }
> =20
>      if (s->can_rx_state !=3D 0) {
>          s->can_rx_state =3D 0;
>          DB_PRINT("can receive\n");
>      }
> -    return 1;
> +    return true;
>  }
> =20
>  /*
>   * gem_update_int_status:
>   * Raise or lower interrupt based on current status.
>   */
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 8a3504d962..900ba5ca65 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -414,7 +414,7 @@ static void dp8393x_do_stop_timer(dp8393xState *s)
>      dp8393x_update_wt_regs(s);
>  }
> =20
> -static int dp8393x_can_receive(NetClientState *nc);
> +static bool dp8393x_can_receive(NetClientState *nc);
> =20
>  static void dp8393x_do_receiver_enable(dp8393xState *s)
>  {
> @@ -718,13 +718,11 @@ static void dp8393x_watchdog(void *opaque)
>      dp8393x_update_irq(s);
>  }
> =20
> -static int dp8393x_can_receive(NetClientState *nc)
> +static bool dp8393x_can_receive(NetClientState *nc)
>  {
>      dp8393xState *s =3D qemu_get_nic_opaque(nc);
> =20
> -    if (!(s->regs[SONIC_CR] & SONIC_CR_RXEN))
> -        return 0;
> -    return 1;
> +    return !!(s->regs[SONIC_CR] & SONIC_CR_RXEN);
>  }
> =20
>  static int dp8393x_receive_filter(dp8393xState *s, const uint8_t * buf=
,
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 0b833d5a15..6b89df8f0a 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -845,7 +845,7 @@ static bool e1000_has_rxbufs(E1000State *s, size_t =
total_size)
>      return total_size <=3D bufs * s->rxbuf_size;
>  }
> =20
> -static int
> +static bool
>  e1000_can_receive(NetClientState *nc)
>  {
>      E1000State *s =3D qemu_get_nic_opaque(nc);
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index a91dbdca3c..f49fa1c7b1 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -199,7 +199,7 @@ static const MemoryRegionOps io_ops =3D {
>      },
>  };
> =20
> -static int
> +static bool
>  e1000e_nc_can_receive(NetClientState *nc)
>  {
>      E1000EState *s =3D qemu_get_nic_opaque(nc);
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 2f92b65d4e..041ed21017 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -562,24 +562,24 @@ static void ftgmac100_do_tx(FTGMAC100State *s, ui=
nt32_t tx_ring,
>      ftgmac100_update_irq(s);
>  }
> =20
> -static int ftgmac100_can_receive(NetClientState *nc)
> +static bool ftgmac100_can_receive(NetClientState *nc)
>  {
>      FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_opaque(nc));
>      FTGMAC100Desc bd;
> =20
>      if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_=
EN))
>           !=3D (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN)) {
> -        return 0;
> +        return false;
>      }
> =20
>      if (ftgmac100_read_bd(&bd, s->rx_descriptor)) {
> -        return 0;
> +        return false;
>      }
>      return !(bd.des0 & FTGMAC100_RXDES0_RXPKT_RDY);
>  }
> =20
>  /*
>   * This is purely informative. The HW can poll the RW (and RX) ring
>   * buffers for available descriptors but we don't need to trigger a
>   * timer for that in qemu.
>   */
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index fe9f2390a9..e5547fa3c2 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -474,23 +474,23 @@ void i82596_h_reset(void *opaque)
>      i82596_s_reset(s);
>  }
> =20
> -int i82596_can_receive(NetClientState *nc)
> +bool i82596_can_receive(NetClientState *nc)
>  {
>      I82596State *s =3D qemu_get_nic_opaque(nc);
> =20
>      if (s->rx_status =3D=3D RX_SUSPENDED) {
> -        return 0;
> +        return false;
>      }
> =20
>      if (!s->lnkst) {
> -        return 0;
> +        return false;
>      }
> =20
>      if (USE_TIMER && !timer_pending(s->flush_queue_timer)) {
> -        return 1;
> +        return true;
>      }
> =20
> -    return 1;
> +    return true;
>  }
> =20
>  #define MIN_BUF_SIZE 60
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 6a124a154a..5dec813d6d 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1047,11 +1047,11 @@ static void imx_eth_write(void *opaque, hwaddr =
offset, uint64_t value,
>      imx_eth_update(s);
>  }
> =20
> -static int imx_eth_can_receive(NetClientState *nc)
> +static bool imx_eth_can_receive(NetClientState *nc)
>  {
>      IMXFECState *s =3D IMX_FEC(qemu_get_nic_opaque(nc));
> =20
>      FEC_PRINTF("\n");
> =20
>      return !!s->regs[ENET_RDAR];
>  }
> diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
> index 6b338c2f29..2ba0dc8c2f 100644
> --- a/hw/net/opencores_eth.c
> +++ b/hw/net/opencores_eth.c
> @@ -349,12 +349,11 @@ static void open_eth_reset(void *opaque)
>      open_eth_set_link_status(qemu_get_queue(s->nic));
>  }
> =20
> -static int open_eth_can_receive(NetClientState *nc)
> +static bool open_eth_can_receive(NetClientState *nc)
>  {
>      OpenEthState *s =3D qemu_get_nic_opaque(nc);
> =20
> -    return GET_REGBIT(s, MODER, RXEN) &&
> -        (s->regs[TX_BD_NUM] < 0x80);
> +    return GET_REGBIT(s, MODER, RXEN) && (s->regs[TX_BD_NUM] < 0x80);
>  }
> =20
>  static ssize_t open_eth_receive(NetClientState *nc,
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index be9a0af629..70aca7ec26 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -793,26 +793,26 @@ static bool rtl8139_cp_rx_valid(RTL8139State *s)
>      return !(s->RxRingAddrLO =3D=3D 0 && s->RxRingAddrHI =3D=3D 0);
>  }
> =20
> -static int rtl8139_can_receive(NetClientState *nc)
> +static bool rtl8139_can_receive(NetClientState *nc)
>  {
>      RTL8139State *s =3D qemu_get_nic_opaque(nc);
>      int avail;
> =20
>      /* Receive (drop) packets if card is disabled.  */
>      if (!s->clock_enabled) {
> -        return 1;
> +        return true;
>      }
>      if (!rtl8139_receiver_enabled(s)) {
> -        return 1;
> +        return true;
>      }
> =20
>      if (rtl8139_cp_receiver_enabled(s) && rtl8139_cp_rx_valid(s)) {
>          /* ??? Flow control not implemented in c+ mode.
>             This is a hack to work around slirp deficiencies anyway.  *=
/
> -        return 1;
> +        return true;
>      }
> =20
>      avail =3D MOD2(s->RxBufferSize + s->RxBufPtr - s->RxBufAddr,
>                   s->RxBufferSize);
>      return avail =3D=3D 0 || avail >=3D 1514 || (s->IntrMask & RxOverf=
low);
>  }
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index 02be60c955..b3240b9335 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -667,9 +667,9 @@ static void smc91c111_writefn(void *opaque, hwaddr =
addr,
>      }
>  }
> =20
> -static int smc91c111_can_receive_nc(NetClientState *nc)
> +static bool smc91c111_can_receive_nc(NetClientState *nc)
>  {
>      smc91c111_state *s =3D qemu_get_nic_opaque(nc);
> =20
>      return smc91c111_can_receive(s);
>  }
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 80f5a1dd37..a2377025a7 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -110,17 +110,17 @@ typedef struct SpaprVioVlan {
>      RxBufPool *rx_pool[RX_MAX_POOLS];  /* Receive buffer descriptor po=
ols */
>  } SpaprVioVlan;
> =20
> -static int spapr_vlan_can_receive(NetClientState *nc)
> +static bool spapr_vlan_can_receive(NetClientState *nc)
>  {
>      SpaprVioVlan *dev =3D qemu_get_nic_opaque(nc);
> =20
> -    return (dev->isopen && dev->rx_bufs > 0);
> +    return dev->isopen && dev->rx_bufs > 0;
>  }
> =20
>  /**
>   * The last 8 bytes of the receive buffer list page (that has been
>   * supplied by the guest with the H_REGISTER_LOGICAL_LAN call) contain
>   * a counter for frames that have been dropped because there was no
>   * suitable receive buffer available. This function is used to increas=
e
>   * this counter by one.
>   */
> diff --git a/hw/net/sungem.c b/hw/net/sungem.c
> index 89da51f7f6..b01197d952 100644
> --- a/hw/net/sungem.c
> +++ b/hw/net/sungem.c
> @@ -433,31 +433,31 @@ static bool sungem_rx_full(SunGEMState *s, uint32=
_t kick, uint32_t done)
>      return kick =3D=3D ((done + 1) & s->rx_mask);
>  }
> =20
> -static int sungem_can_receive(NetClientState *nc)
> +static bool sungem_can_receive(NetClientState *nc)
>  {
>      SunGEMState *s =3D qemu_get_nic_opaque(nc);
>      uint32_t kick, done, rxdma_cfg, rxmac_cfg;
>      bool full;
> =20
>      rxmac_cfg =3D s->macregs[MAC_RXCFG >> 2];
>      rxdma_cfg =3D s->rxdmaregs[RXDMA_CFG >> 2];
> =20
>      /* If MAC disabled, can't receive */
>      if ((rxmac_cfg & MAC_RXCFG_ENAB) =3D=3D 0) {
>          trace_sungem_rx_mac_disabled();
> -        return 0;
> +        return false;
>      }
>      if ((rxdma_cfg & RXDMA_CFG_ENABLE) =3D=3D 0) {
>          trace_sungem_rx_txdma_disabled();
> -        return 0;
> +        return false;
>      }
> =20
>      /* Check RX availability */
>      kick =3D s->rxdmaregs[RXDMA_KICK >> 2];
>      done =3D s->rxdmaregs[RXDMA_DONE >> 2];
>      full =3D sungem_rx_full(s, kick, done);
> =20
>      trace_sungem_rx_check(!full, kick, done);
> =20
>      return !full;
>  }
> diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
> index 8863601f6c..9c38583180 100644
> --- a/hw/net/sunhme.c
> +++ b/hw/net/sunhme.c
> @@ -657,11 +657,11 @@ static void sunhme_transmit(SunHMEState *s)
>      sunhme_update_irq(s);
>  }
> =20
> -static int sunhme_can_receive(NetClientState *nc)
> +static bool sunhme_can_receive(NetClientState *nc)
>  {
>      SunHMEState *s =3D qemu_get_nic_opaque(nc);
> =20
> -    return s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_ENABLE;
> +    return !!(s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_ENABLE);
>  }
> =20
>  static void sunhme_link_status_changed(NetClientState *nc)
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 3627bb1717..a46e3b37a7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1234,26 +1234,26 @@ static void virtio_net_handle_rx(VirtIODevice *=
vdev, VirtQueue *vq)
>      qemu_flush_queued_packets(qemu_get_subqueue(n->nic, queue_index));
>  }
> =20
> -static int virtio_net_can_receive(NetClientState *nc)
> +static bool virtio_net_can_receive(NetClientState *nc)
>  {
>      VirtIONet *n =3D qemu_get_nic_opaque(nc);
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>      VirtIONetQueue *q =3D virtio_net_get_subqueue(nc);
> =20
>      if (!vdev->vm_running) {
> -        return 0;
> +        return false;
>      }
> =20
>      if (nc->queue_index >=3D n->curr_queues) {
> -        return 0;
> +        return false;
>      }
> =20
>      if (!virtio_queue_ready(q->rx_vq) ||
>          !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> -        return 0;
> +        return false;
>      }
> =20
> -    return 1;
> +    return true;
>  }
> =20
>  static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index cf07e698b3..71d16fef3d 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -175,10 +175,10 @@ static const MemoryRegionOps eth_ops =3D {
>      }
>  };
> =20
> -static int eth_can_rx(NetClientState *nc)
> +static bool eth_can_rx(NetClientState *nc)
>  {
>      struct xlx_ethlite *s =3D qemu_get_nic_opaque(nc);
>      unsigned int rxbase =3D s->rxbuf * (0x800 / 4);
> =20
>      return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
>  }
> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
> index 88da78f821..12e0254287 100644
> --- a/net/filter-buffer.c
> +++ b/net/filter-buffer.c
> @@ -59,28 +59,28 @@ static void filter_buffer_release_timer(void *opaqu=
e)
>  /* filter APIs */
>  static ssize_t filter_buffer_receive_iov(NetFilterState *nf,
>                                           NetClientState *sender,
>                                           unsigned flags,
>                                           const struct iovec *iov,
>                                           int iovcnt,
>                                           NetPacketSent *sent_cb)
>  {
>      FilterBufferState *s =3D FILTER_BUFFER(nf);
> =20
>      /*
>       * We return size when buffer a packet, the sender will take it as
>       * a already sent packet, so sent_cb should not be called later.
>       *
>       * FIXME: Even if the guest can't receive packets for some reasons=
,
>       * the filter can still accept packets until its internal queue is=
 full.
>       * For example:
>       *   For some reason, receiver could not receive more packets
> -     * (.can_receive() returns zero). Without a filter, at most one pa=
cket
> +     * (.can_receive() returns false). Without a filter, at most one p=
acket
>       * will be queued in incoming queue and sender's poll will be disa=
bled
>       * unit its sent_cb() was called. With a filter, it will keep rece=
iving
>       * the packets without caring about the receiver. This is suboptim=
al.
>       * May need more thoughts (e.g keeping sent_cb).
>       */
>      qemu_net_queue_append_iov(s->incoming_queue, sender, flags,
>                                iov, iovcnt, NULL);
>      return iov_size(iov, iovcnt);
>  }
> diff --git a/net/hub.c b/net/hub.c
> index 5795a678ed..e7de173171 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -90,23 +90,23 @@ static NetHub *net_hub_new(int id)
>      return hub;
>  }
> =20
> -static int net_hub_port_can_receive(NetClientState *nc)
> +static bool net_hub_port_can_receive(NetClientState *nc)
>  {
>      NetHubPort *port;
>      NetHubPort *src_port =3D DO_UPCAST(NetHubPort, nc, nc);
>      NetHub *hub =3D src_port->hub;
> =20
>      QLIST_FOREACH(port, &hub->ports, next) {
>          if (port =3D=3D src_port) {
>              continue;
>          }
> =20
>          if (qemu_can_send_packet(&port->nc)) {
> -            return 1;
> +            return true;
>          }
>      }
> =20
> -    return 0;
> +    return false;
>  }
> =20
>  static ssize_t net_hub_port_receive(NetClientState *nc,
>=20


