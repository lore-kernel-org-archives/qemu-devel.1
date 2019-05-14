Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA4C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE4C208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jBeVi8YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE4C208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQMgp-0004Te-6V
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 21:57:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQMfT-0003bR-Cc
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQMfN-0008TK-SS
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:55:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35573 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQMfK-0008Iy-TN; Mon, 13 May 2019 21:55:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45313n6krkz9sBK; Tue, 14 May 2019 11:55:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557798933;
	bh=+zob9GBJFjUNdapnKjRBziCPjm3MCa+xYbJmlWbLwxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBeVi8YULV2DoktkDfQjkaOMkhlpQr7+0YZSpMHto0OJQlaVa5vgc56vRyFP51tfL
	r9zJnVfqSWF9SN/0uZAYrAYPWhlP/cEsxwwsktAGb9l58fifQ4fanMpXCloS8HUayW
	SCZot2Ehy47C0mAoFtNmE08wpWojFs5RxA0gXUyI=
Date: Tue, 14 May 2019 11:48:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190514014828.GC6441@umbus.fritz.box>
References: <20190513084245.25755-1-clg@kaod.org>
	<20190513084245.25755-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20190513084245.25755-5-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 04/14] spapr/xive: add state
 synchronization with KVM
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 10:42:35AM +0200, C=E9dric Le Goater wrote:
> This extends the KVM XIVE device backend with 'synchronize_state'
> methods used to retrieve the state from KVM. The HW state of the
> sources, the KVM device and the thread interrupt contexts are
> collected for the monitor usage and also migration.
>=20
> These get operations rely on their KVM counterpart in the host kernel
> which acts as a proxy for OPAL, the host firmware. The set operations
> will be added for migration support later.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr_xive.h |  8 ++++
>  include/hw/ppc/xive.h       |  1 +
>  hw/intc/spapr_xive.c        | 17 ++++---
>  hw/intc/spapr_xive_kvm.c    | 90 +++++++++++++++++++++++++++++++++++++
>  hw/intc/xive.c              | 10 +++++
>  5 files changed, 119 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 03685910e76b..7e49badd8c9a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -44,6 +44,13 @@ typedef struct SpaprXive {
>      void          *tm_mmap;
>  } SpaprXive;
> =20
> +/*
> + * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
> + * to the controller block id value. It can nevertheless be changed
> + * for testing purpose.
> + */
> +#define SPAPR_XIVE_BLOCK_ID 0x0
> +
>  bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
>  bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
> @@ -74,5 +81,6 @@ void kvmppc_xive_set_queue_config(SpaprXive *xive, uint=
8_t end_blk,
>  void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
>                                   uint32_t end_idx, XiveEND *end,
>                                   Error **errp);
> +void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index dd115da30ebc..78c919c4a590 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -435,5 +435,6 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc, i=
nt srcno, Error **errp);
>  void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
> +void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
> =20
>  #endif /* PPC_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 6beda26ee440..84cd30e1faff 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -40,13 +40,6 @@
> =20
>  #define SPAPR_XIVE_NVT_BASE 0x400
> =20
> -/*
> - * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
> - * to the controller block id value. It can nevertheless be changed
> - * for testing purpose.
> - */
> -#define SPAPR_XIVE_BLOCK_ID 0x0
> -
>  /*
>   * sPAPR NVT and END indexing helpers
>   */
> @@ -157,6 +150,16 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Moni=
tor *mon)
>      XiveSource *xsrc =3D &xive->source;
>      int i;
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_synchronize_state(xive, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return;
> +        }
> +    }
> +
>      monitor_printf(mon, "  LISN         PQ    EISN     CPU/PRIO EQ\n");
> =20
>      for (i =3D 0; i < xive->nr_irqs; i++) {
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 964bad0c23fb..8dd4f96e0b97 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -60,6 +60,54 @@ static void kvm_cpu_enable(CPUState *cs)
>  /*
>   * XIVE Thread Interrupt Management context (KVM)
>   */
> +static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
> +{
> +    uint64_t state[2] =3D { 0 };
> +    int ret;
> +
> +    ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
> +    if (ret !=3D 0) {
> +        error_setg_errno(errp, errno,
> +                         "XIVE: could not capture KVM state of CPU %ld",
> +                         kvm_arch_vcpu_id(tctx->cs));
> +        return;
> +    }
> +
> +    /* word0 and word1 of the OS ring. */
> +    *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
> +}
> +
> +typedef struct {
> +    XiveTCTX *tctx;
> +    Error *err;
> +} XiveCpuGetState;
> +
> +static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
> +                                                 run_on_cpu_data arg)
> +{
> +    XiveCpuGetState *s =3D arg.host_ptr;
> +
> +    kvmppc_xive_cpu_get_state(s->tctx, &s->err);
> +}
> +
> +void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
> +{
> +    XiveCpuGetState s =3D {
> +        .tctx =3D tctx,
> +        .err =3D NULL,
> +    };
> +
> +    /*
> +     * Kick the vCPU to make sure they are available for the KVM ioctl.
> +     */
> +    run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
> +               RUN_ON_CPU_HOST_PTR(&s));
> +
> +    if (s.err) {
> +        error_propagate(errp, s.err);
> +        return;
> +    }
> +}
> =20
>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>  {
> @@ -227,6 +275,19 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int sr=
cno, uint32_t offset,
>      }
>  }
> =20
> +static void kvmppc_xive_source_get_state(XiveSource *xsrc)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        /* Perform a load without side effect to retrieve the PQ bits */
> +        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +
> +        /* and save PQ locally */
> +        xive_source_esb_set(xsrc, i, pq);
> +    }
> +}
> +
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>  {
>      XiveSource *xsrc =3D opaque;
> @@ -353,6 +414,35 @@ void kvmppc_xive_reset(SpaprXive *xive, Error **errp)
>                        NULL, true, errp);
>  }
> =20
> +static void kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    int i;
> +
> +    for (i =3D 0; i < xive->nr_ends; i++) {
> +        if (!xive_end_is_valid(&xive->endt[i])) {
> +            continue;
> +        }
> +
> +        kvmppc_xive_get_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
> +                                     &xive->endt[i], &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +}
> +
> +void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
> +{
> +    kvmppc_xive_source_get_state(&xive->source);
> +
> +    /* EAT: there is no extra state to query from KVM */
> +
> +    /* ENDT */
> +    kvmppc_xive_get_queues(xive, errp);
> +}
> +
>  static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
>                                Error **errp)
>  {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 78047adb11e6..7f1c54a7b581 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -493,6 +493,16 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon)
>      int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
>      int i;
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return;
> +        }
> +    }
> +
>      monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC A=
GE PIPR"
>                     "  W2\n", cpu_index);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzaHmcACgkQbDjKyiDZ
s5LbQg/+MbdGnFuaZwScsggbGjeiQvsYpgGKfA/vXn97dFIZ8XgHjetigYLwPnqu
F1SO+8K2mnN4dBmPyKvFZjpBFqUpD3vudFj+4knVomr+jMtJjK8J6RL/A/5NLWCW
A6qzADjznlEbWBA/4jMoznpE4/VNFTOElWDiWL00on1hNr9n3wRzXFLPJWrGASjq
JBwfn4OIbOzabhgyvEw6dmI/jC6OncFGIcWuhZRAqfAqBTjiM3RKYqQ773jA+eNf
2Bj79kFeCoazJEQDpcGrpipIm0npBk28eEapGtuKY+7+epZW1XAM7D6ZHyvBb9bx
H1jR2CzFhvzdm5YDk/04ODVAllt1JbKAhn7I+eqAeMbYA/udCdFYEbJlAGkO8+Z9
tZXoljmTwmpuFdlkqZZBokZvbTBdKBW5Y8U4lTi2Fvw0YMMYpZ/PNg2orebWC6BP
KSdYBeFf9nSln1uMbjPj021B50kRqrXQFaGEAvvalZmdIaM9JLpd+NS6voVJPjBQ
uhhennshnW6oHNGaVRpccnvDpFIGDF9RQ+M+Ym8WktMme0qu3EZ617LWLvOXwuIt
SgO3ACp2K3iJSZJEXRTZ/h0eLwRGAAB0zqu820e3Pfh5x5yLcsFmg691jbew4o5d
gRKT6mhjFKbnP6o+TzZU5senY5qVxv9QP5p7MtNzHt/F9ihb6rk=
=8HUl
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

