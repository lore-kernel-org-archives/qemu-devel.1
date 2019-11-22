Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08DEC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C1920706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C1920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYAPF-0004IV-Ud
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iYAOX-0003cg-5Q
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iYAOV-0004To-Gk
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:58:48 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:48125)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iYAOV-0004TH-9z
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:58:47 -0500
Received: from player159.ha.ovh.net (unknown [10.109.160.25])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3A9E214CB55
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 15:58:44 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 93AE7C577976;
 Fri, 22 Nov 2019 14:58:39 +0000 (UTC)
Date: Fri, 22 Nov 2019 15:58:36 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 18/23] ppc/xive: Move the TIMA operations to
 the controller model
Message-ID: <20191122155836.0b716213@bahia.lan>
In-Reply-To: <20191115162436.30548-19-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-19-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17844106150614702475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.79.46
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

On Fri, 15 Nov 2019 17:24:31 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On the P9 Processor, the thread interrupt context registers of a CPU
> can be accessed "directly" when by load/store from the CPU or
> "indirectly" by the IC through an indirect TIMA page. This requires to
> configure first the PC_TCTXT_INDIRx registers.
>=20
> Today, we rely on the get_tctx() handler to deduce from the CPU PIR
> the chip from which the TIMA access is being done. By handling the
> TIMA memory ops under the interrupt controller model of each machine,
> we can uniformize the TIMA direct and indirect ops under PowerNV. We
> can also check that the CPUs have been enabled in the XIVE controller.
>=20
> This prepares ground for the future versions of XIVE.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h |  1 -
>  hw/intc/pnv_xive.c    | 35 ++++++++++++++++++++++++++++++++++-
>  hw/intc/spapr_xive.c  | 33 +++++++++++++++++++++++++++++++--
>  hw/intc/xive.c        | 29 -----------------------------
>  4 files changed, 65 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 97bbcddb381d..dcf897451589 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -462,7 +462,6 @@ typedef struct XiveENDSource {
>  #define XIVE_TM_OS_PAGE         0x2
>  #define XIVE_TM_USER_PAGE       0x3
> =20
> -extern const MemoryRegionOps xive_tm_ops;
>  void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offs=
et,
>                          uint64_t value, unsigned size);
>  uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr o=
ffset,
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index d75053d0baad..4501c671d8df 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1473,6 +1473,39 @@ static const MemoryRegionOps xive_tm_indirect_ops =
=3D {
>      },
>  };
> =20
> +static void pnv_xive_tm_write(void *opaque, hwaddr offset,
> +                              uint64_t value, unsigned size)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> +    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> +
> +    xive_tctx_tm_write(XIVE_PRESENTER(xive), tctx, offset, value, size);
> +}
> +
> +static uint64_t pnv_xive_tm_read(void *opaque, hwaddr offset, unsigned s=
ize)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> +    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> +
> +    return xive_tctx_tm_read(XIVE_PRESENTER(xive), tctx, offset, size);
> +}
> +
> +const MemoryRegionOps pnv_xive_tm_ops =3D {
> +    .read =3D pnv_xive_tm_read,
> +    .write =3D pnv_xive_tm_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
>  /*
>   * Interrupt controller XSCOM region.
>   */
> @@ -1845,7 +1878,7 @@ static void pnv_xive_realize(DeviceState *dev, Erro=
r **errp)
>                            "xive-pc", PNV9_XIVE_PC_SIZE);
> =20
>      /* Thread Interrupt Management Area (Direct) */
> -    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,
> +    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &pnv_xive_tm_ops,
>                            xive, "xive-tima", PNV9_XIVE_TM_SIZE);
> =20
>      qemu_register_reset(pnv_xive_reset, dev);
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index bb3b2dfdb77f..6292da58f62c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -205,6 +205,35 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, bo=
ol enable)
>      memory_region_set_enabled(&xive->end_source.esb_mmio, false);
>  }
> =20
> +static void spapr_xive_tm_write(void *opaque, hwaddr offset,
> +                          uint64_t value, unsigned size)
> +{
> +    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
> +
> +    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
> +}
> +
> +static uint64_t spapr_xive_tm_read(void *opaque, hwaddr offset, unsigned=
 size)
> +{
> +    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
> +
> +    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size);
> +}
> +
> +const MemoryRegionOps spapr_xive_tm_ops =3D {
> +    .read =3D spapr_xive_tm_read,
> +    .write =3D spapr_xive_tm_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
>  static void spapr_xive_end_reset(XiveEND *end)
>  {
>      memset(end, 0, sizeof(*end));
> @@ -314,8 +343,8 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
>      qemu_register_reset(spapr_xive_reset, dev);
> =20
>      /* TIMA initialization */
> -    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
> -                          "xive.tima", 4ull << TM_SHIFT);
> +    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &spapr_xive_tm_o=
ps,
> +                          xive, "xive.tima", 4ull << TM_SHIFT);
>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> =20
>      /*
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a9298783e7d2..ab779c4c2a0f 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -523,35 +523,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, Xive=
TCTX *tctx, hwaddr offset,
>      return xive_tm_raw_read(tctx, offset, size);
>  }
> =20
> -static void xive_tm_write(void *opaque, hwaddr offset,
> -                          uint64_t value, unsigned size)
> -{
> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> -
> -    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
> -}
> -
> -static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
> -{
> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> -
> -    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size);
> -}
> -
> -const MemoryRegionOps xive_tm_ops =3D {
> -    .read =3D xive_tm_read,
> -    .write =3D xive_tm_write,
> -    .endianness =3D DEVICE_BIG_ENDIAN,
> -    .valid =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -    },
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -    },
> -};
> -
>  static char *xive_tctx_ring_print(uint8_t *ring)
>  {
>      uint32_t w2 =3D xive_tctx_word2(ring);


