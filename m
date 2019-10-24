Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80081CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4174C20640
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="K3TtuPqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4174C20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTg2-0007gP-3C
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTN-0006ae-Ln
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTL-0002uz-Fj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTL-0002sY-24; Wed, 23 Oct 2019 23:07:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS4nLBz9sPh; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=OlAiewe3ff56iqjtufWZGO6NzRootkMXHPxctmaHNow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K3TtuPqQYVgxq3MTbIuXkZyCJCi6zYiajvh/8x0zKIa/gNOGqLHrX79O5hj8maXR5
 5EdFsn0yQbCJtrXTZup/7bfUVvHBTVEMiUafSW0hJbUNfFmIf9+eh7bQPb33pC6QbW
 Z6cSJTNDC3tVbBkdAmdVNa6j7rcwPBQehC2BBHPI=
Date: Thu, 24 Oct 2019 13:41:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 7/7] spapr/xive: Set the OS CAM line at reset
Message-ID: <20191024024130.GQ6439@umbus.fritz.box>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eLe8FOcWSbbyMVJD"
Content-Disposition: inline
In-Reply-To: <20191022163812.330-8-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eLe8FOcWSbbyMVJD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 06:38:12PM +0200, C=E9dric Le Goater wrote:
> When a Virtual Processor is scheduled to run on a HW thread, the
> hypervisor pushes its identifier in the OS CAM line. When running with
> kernel_irqchip=3Doff, QEMU needs to emulate the same behavior.
>=20
> Set the OS CAM line when the interrupt presenter of the sPAPR core is
> reset. This will also cover the case of hot-plugged CPUs.
>=20
> This change also has the benefit to remove the use of CPU_FOREACH()
> which can be unsafe.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Since the values here should remain constant for the lifetime of a
(PAPR) guest, it kind of seems like this belongs more in realize()
than reset.  But this definitely fixes a real problem, so that's
somethine we can tweak later.

> ---
>  include/hw/ppc/spapr_xive.h |  1 -
>  hw/intc/spapr_xive.c        | 48 +++++++++++++------------------------
>  2 files changed, 17 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index d84bd5c229f0..742b7e834f2a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -57,7 +57,6 @@ typedef struct SpaprXive {
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
> =20
>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
>  void spapr_xive_map_mmio(SpaprXive *xive);
> =20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 20a8d8285f64..d8e1291905c3 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -205,23 +205,6 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, bo=
ol enable)
>      memory_region_set_enabled(&xive->end_source.esb_mmio, false);
>  }
> =20
> -/*
> - * When a Virtual Processor is scheduled to run on a HW thread, the
> - * hypervisor pushes its identifier in the OS CAM line. Emulate the
> - * same behavior under QEMU.
> - */
> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
> -{
> -    uint8_t  nvt_blk;
> -    uint32_t nvt_idx;
> -    uint32_t nvt_cam;
> -
> -    spapr_xive_cpu_to_nvt(POWERPC_CPU(tctx->cs), &nvt_blk, &nvt_idx);
> -
> -    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_nvt_cam_line(nvt_blk, nvt=
_idx));
> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
> -}
> -
>  static void spapr_xive_end_reset(XiveEND *end)
>  {
>      memset(end, 0, sizeof(*end));
> @@ -544,21 +527,32 @@ static int spapr_xive_cpu_intc_create(SpaprInterrup=
tController *intc,
>      }
> =20
>      spapr_cpu->tctx =3D XIVE_TCTX(obj);
> -
> -    /*
> -     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> -     * don't beneficiate from the reset of the XIVE IRQ backend
> -     */
> -    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
>      return 0;
>  }
> =20
> +static void xive_tctx_set_os_cam(XiveTCTX *tctx, uint32_t os_cam)
> +{
> +    uint32_t qw1w2 =3D cpu_to_be32(TM_QW1W2_VO | os_cam);
> +    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +}
> +
>  static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
>                                       PowerPCCPU *cpu)
>  {
>      XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
> +    uint8_t  nvt_blk;
> +    uint32_t nvt_idx;
> =20
>      xive_tctx_reset(tctx);
> +
> +    /*
> +     * When a Virtual Processor is scheduled to run on a HW thread,
> +     * the hypervisor pushes its identifier in the OS CAM line.
> +     * Emulate the same behavior under QEMU.
> +     */
> +    spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
> +
> +    xive_tctx_set_os_cam(tctx, xive_nvt_cam_line(nvt_blk, nvt_idx));
>  }
> =20
>  static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
> @@ -651,14 +645,6 @@ static void spapr_xive_dt(SpaprInterruptController *=
intc, uint32_t nr_servers,
>  static int spapr_xive_activate(SpaprInterruptController *intc, Error **e=
rrp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -        /* (TCG) Set the OS CAM line of the thread interrupt context. */
> -        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
> -    }
> =20
>      if (kvm_enabled()) {
>          int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eLe8FOcWSbbyMVJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xD1oACgkQbDjKyiDZ
s5IxBxAAzCPCNMwLXSsu7xUpPWIP0iC683aKnzmx0Fmt1LRylEHRwiTQ90XMz5+g
OHM7DEI27mxB7Hj028wq0hqhasjdd/3JHxcnDHlvX25fhkzU2KCsfaS1Y77Vi6VT
rd7JH8DfrtKsYLGTuPKyz3BNs5P2UZDIovHiW4XQinXQ3KR6eA+YFiBzgiReyQ3j
+kR9z4ysB3OePqJ4ydY48ZAFfaxdYOBbI/UnlrR+ceGyoasTcgu0nu2/Jy8V050H
g6Zf+6B5emj82S4xhP4J2gtqjjzveERDs7sEojaXiRwDRP+VibYDDa2uq8untx6m
R+9R5xJYaAVfBJREpT7LII7EX6rQH4ygfHfZl7QmFyWFHSvG4HOSNHfWjg3JtVJu
4rjXEsJ+RD6MWrlEFlwsFIsqqMPNlCUmE5xBVUy0UqbbReN47qqNVi2lZrKb+eyK
e/OQowNjvvBbgZOtByMG8+gFyLo1/hxRZ2VztpeL8bPmFf7L1CUkmxu8w+G6BBc+
Csttcg7abzNtXgP4G+U+CMYmMa31Veh6up7uPS3Fcp/R6jyMYAqKpslbWrNigwzs
BFNvMcai2utWjEYByj2xgxahC+jNkELOiH2az7ix68PSilSL2z5U6dtjA76paKgm
yAxE3DAixLhHZzvKsnHvVJsKf2Fo75xOZ3+TWJwo2qM/HUtLxO0=
=rutJ
-----END PGP SIGNATURE-----

--eLe8FOcWSbbyMVJD--

