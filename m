Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9B4C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F47020658
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY61V-0006TX-Ca
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iY5zl-0005MZ-VU
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iY5zf-0006sP-9P
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:16:55 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:33354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iY5zY-0006fQ-PT
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:16:46 -0500
Received: from player168.ha.ovh.net (unknown [10.109.160.244])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id DF0AB1EE376
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 11:16:33 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id CC6A4C5168FC;
 Fri, 22 Nov 2019 10:16:29 +0000 (UTC)
Date: Fri, 22 Nov 2019 11:16:27 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 16/23] ppc/xive: Extend the TIMA operation
 with a XivePresenter parameter
Message-ID: <20191122111627.5812c34b@bahia.lan>
In-Reply-To: <20191115162436.30548-17-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-17-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13078734796566010251
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudeikedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.125.228
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 17:24:29 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The TIMA operations are performed on behalf of the XIVE IVPE sub-engine
> (Presenter) on the thread interrupt context registers. The current
> operations supported by the model are simple and do not require access
> to the controller but more complex operations will need access to the
> controller NVT table and to its configuration.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h |  7 +++---
>  hw/intc/pnv_xive.c    |  4 +--
>  hw/intc/xive.c        | 58 ++++++++++++++++++++++++-------------------
>  3 files changed, 38 insertions(+), 31 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index b00af988779b..97bbcddb381d 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -463,9 +463,10 @@ typedef struct XiveENDSource {
>  #define XIVE_TM_USER_PAGE       0x3
> =20
>  extern const MemoryRegionOps xive_tm_ops;
> -void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
> -                        unsigned size);
> -uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size);
> +void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offs=
et,
> +                        uint64_t value, unsigned size);
> +uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr o=
ffset,
> +                           unsigned size);
> =20
>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 4c8c6e51c20f..3ee28f00694a 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1436,7 +1436,7 @@ static void xive_tm_indirect_write(void *opaque, hw=
addr offset,
>  {
>      XiveTCTX *tctx =3D pnv_xive_get_indirect_tctx(PNV_XIVE(opaque));
> =20
> -    xive_tctx_tm_write(tctx, offset, value, size);
> +    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
>  }
> =20
>  static uint64_t xive_tm_indirect_read(void *opaque, hwaddr offset,
> @@ -1444,7 +1444,7 @@ static uint64_t xive_tm_indirect_read(void *opaque,=
 hwaddr offset,
>  {
>      XiveTCTX *tctx =3D pnv_xive_get_indirect_tctx(PNV_XIVE(opaque));
> =20
> -    return xive_tctx_tm_read(tctx, offset, size);
> +    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size);
>  }
> =20
>  static const MemoryRegionOps xive_tm_indirect_ops =3D {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index ab62bda85788..a9298783e7d2 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -144,19 +144,20 @@ static inline uint32_t xive_tctx_word2(uint8_t *rin=
g)
>   * XIVE Thread Interrupt Management Area (TIMA)
>   */
> =20
> -static void xive_tm_set_hv_cppr(XiveTCTX *tctx, hwaddr offset,
> -                                uint64_t value, unsigned size)
> +static void xive_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
> +                                hwaddr offset, uint64_t value, unsigned =
size)
>  {
>      xive_tctx_set_cppr(tctx, TM_QW3_HV_PHYS, value & 0xff);
>  }
> =20
> -static uint64_t xive_tm_ack_hv_reg(XiveTCTX *tctx, hwaddr offset, unsign=
ed size)
> +static uint64_t xive_tm_ack_hv_reg(XivePresenter *xptr, XiveTCTX *tctx,
> +                                   hwaddr offset, unsigned size)
>  {
>      return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
>  }
> =20
> -static uint64_t xive_tm_pull_pool_ctx(XiveTCTX *tctx, hwaddr offset,
> -                                      unsigned size)
> +static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tct=
x,
> +                                      hwaddr offset, unsigned size)
>  {
>      uint32_t qw2w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
>      uint32_t qw2w2;
> @@ -166,13 +167,14 @@ static uint64_t xive_tm_pull_pool_ctx(XiveTCTX *tct=
x, hwaddr offset,
>      return qw2w2;
>  }
> =20
> -static void xive_tm_vt_push(XiveTCTX *tctx, hwaddr offset,
> +static void xive_tm_vt_push(XivePresenter *xptr, XiveTCTX *tctx, hwaddr =
offset,
>                              uint64_t value, unsigned size)
>  {
>      tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] =3D value & 0xff;
>  }
> =20
> -static uint64_t xive_tm_vt_poll(XiveTCTX *tctx, hwaddr offset, unsigned =
size)
> +static uint64_t xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
> +                                hwaddr offset, unsigned size)
>  {
>      return tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] & 0xff;
>  }
> @@ -315,13 +317,14 @@ static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hw=
addr offset, unsigned size)
>   * state changes (side effects) in addition to setting/returning the
>   * interrupt management area context of the processor thread.
>   */
> -static uint64_t xive_tm_ack_os_reg(XiveTCTX *tctx, hwaddr offset, unsign=
ed size)
> +static uint64_t xive_tm_ack_os_reg(XivePresenter *xptr, XiveTCTX *tctx,
> +                                   hwaddr offset, unsigned size)
>  {
>      return xive_tctx_accept(tctx, TM_QW1_OS);
>  }
> =20
> -static void xive_tm_set_os_cppr(XiveTCTX *tctx, hwaddr offset,
> -                                uint64_t value, unsigned size)
> +static void xive_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
> +                                hwaddr offset, uint64_t value, unsigned =
size)
>  {
>      xive_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
>  }
> @@ -330,8 +333,8 @@ static void xive_tm_set_os_cppr(XiveTCTX *tctx, hwadd=
r offset,
>   * Adjust the IPB to allow a CPU to process event queues of other
>   * priorities during one physical interrupt cycle.
>   */
> -static void xive_tm_set_os_pending(XiveTCTX *tctx, hwaddr offset,
> -                                   uint64_t value, unsigned size)
> +static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
> +                                   hwaddr offset, uint64_t value, unsign=
ed size)
>  {
>      ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
>      xive_tctx_notify(tctx, TM_QW1_OS);
> @@ -366,8 +369,8 @@ static void xive_tctx_set_os_cam(XiveTCTX *tctx, uint=
32_t qw1w2)
>      memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
>  }
> =20
> -static uint64_t xive_tm_pull_os_ctx(XiveTCTX *tctx, hwaddr offset,
> -                                    unsigned size)
> +static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> +                                    hwaddr offset, unsigned size)
>  {
>      uint32_t qw1w2;
>      uint32_t qw1w2_new;
> @@ -396,9 +399,11 @@ typedef struct XiveTmOp {
>      uint8_t  page_offset;
>      uint32_t op_offset;
>      unsigned size;
> -    void     (*write_handler)(XiveTCTX *tctx, hwaddr offset, uint64_t va=
lue,
> -                              unsigned size);
> -    uint64_t (*read_handler)(XiveTCTX *tctx, hwaddr offset, unsigned siz=
e);
> +    void     (*write_handler)(XivePresenter *xptr, XiveTCTX *tctx,
> +                              hwaddr offset,
> +                              uint64_t value, unsigned size);
> +    uint64_t (*read_handler)(XivePresenter *xptr, XiveTCTX *tctx, hwaddr=
 offset,
> +                             unsigned size);
>  } XiveTmOp;
> =20
>  static const XiveTmOp xive_tm_operations[] =3D {
> @@ -444,8 +449,8 @@ static const XiveTmOp *xive_tm_find_op(hwaddr offset,=
 unsigned size, bool write)
>  /*
>   * TIMA MMIO handlers
>   */
> -void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
> -                        unsigned size)
> +void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offs=
et,
> +                        uint64_t value, unsigned size)
>  {
>      const XiveTmOp *xto;
> =20
> @@ -462,7 +467,7 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
>              qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access a=
t TIMA "
>                            "@%"HWADDR_PRIx"\n", offset);
>          } else {
> -            xto->write_handler(tctx, offset, value, size);
> +            xto->write_handler(xptr, tctx, offset, value, size);
>          }
>          return;
>      }
> @@ -472,7 +477,7 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
>       */
>      xto =3D xive_tm_find_op(offset, size, true);
>      if (xto) {
> -        xto->write_handler(tctx, offset, value, size);
> +        xto->write_handler(xptr, tctx, offset, value, size);
>          return;
>      }
> =20
> @@ -482,7 +487,8 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
>      xive_tm_raw_write(tctx, offset, value, size);
>  }
> =20
> -uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
> +uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr o=
ffset,
> +                           unsigned size)
>  {
>      const XiveTmOp *xto;
> =20
> @@ -500,7 +506,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr off=
set, unsigned size)
>                            "@%"HWADDR_PRIx"\n", offset);
>              return -1;
>          }
> -        return xto->read_handler(tctx, offset, size);
> +        return xto->read_handler(xptr, tctx, offset, size);
>      }
> =20
>      /*
> @@ -508,7 +514,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr off=
set, unsigned size)
>       */
>      xto =3D xive_tm_find_op(offset, size, false);
>      if (xto) {
> -        return xto->read_handler(tctx, offset, size);
> +        return xto->read_handler(xptr, tctx, offset, size);
>      }
> =20
>      /*
> @@ -522,14 +528,14 @@ static void xive_tm_write(void *opaque, hwaddr offs=
et,
>  {
>      XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> =20
> -    xive_tctx_tm_write(tctx, offset, value, size);
> +    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
>  }
> =20
>  static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> =20
> -    return xive_tctx_tm_read(tctx, offset, size);
> +    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size);
>  }
> =20
>  const MemoryRegionOps xive_tm_ops =3D {


