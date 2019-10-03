Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CFEC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6AD222C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SeEJPB1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6AD222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFr7T-0001wk-Jf
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5N-00007q-9T
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5L-0000yM-3x
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43429 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5K-0000wt-9L; Wed, 02 Oct 2019 22:43:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHPB0DMkz9sPd; Thu,  3 Oct 2019 12:43:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070590;
 bh=u+uCZCaCBXL67IBVelmcQPIxTDuXjr23etMrKCUmF50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SeEJPB1zXTjpSaEQ6S5T7eQGrjCglKdnCMI0taE7bOIjqIGvHseqm4NfSw2YEeedJ
 UGZI6NR6PPvcJxvqpMrUtOf3yWJrfbmMr7QyeehyN4ZY3NTsvj3yz2+5SKXPAZi4+F
 pySPBz77ivWSsbulivxseSKs/q4vyv//RKABumqU=
Date: Thu, 3 Oct 2019 11:58:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 07/25] ppc/spapr: Implement the XiveFabric interface
Message-ID: <20191003015815.GI11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="McTFpSeH7KqpdXA3"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-8-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--McTFpSeH7KqpdXA3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:27PM +0200, C=E9dric Le Goater wrote:
> The CAM line matching sequence in the pseries machine does not change
> much apart from the use of the new QOM interfaces. There is an extra
> indirection because of the sPAPR IRQ backend of the machine. Only the
> XIVE backend implements the new 'match_nvt' handler.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_irq.h |  6 ++++++
>  hw/ppc/spapr.c             | 34 ++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_irq.c         | 25 +++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5db305165ce2..859780efaf95 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -31,6 +31,8 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint3=
2_t num, bool align,
>                          Error **errp);
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
> =20
> +struct XiveTCTXMatch;
> +
>  typedef struct SpaprIrq {
>      uint32_t    nr_irqs;
>      uint32_t    nr_msis;
> @@ -50,6 +52,10 @@ typedef struct SpaprIrq {
>      void (*set_irq)(void *opaque, int srcno, int val);
>      const char *(*get_nodename)(SpaprMachineState *spapr);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
> +    int (*match_nvt)(SpaprMachineState *spapr, uint8_t format,
> +                     uint8_t nvt_blk, uint32_t nvt_idx,
> +                     bool cam_ignore, uint8_t priority,
> +                     uint32_t logic_serv, struct XiveTCTXMatch *match);

Obviously this will need some rework against my stuff.

But more importantly, I don't see the point of indirecting via here,
when the method is only relevant for the xive case.  Why not just
assert that XIVE is in use in the XiveFabric hook, and go directly  to
the XIVE matching code.

>  } SpaprIrq;
> =20
>  extern SpaprIrq spapr_irq_xics;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2725b139a7f0..90f6f5fb9536 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4360,6 +4360,37 @@ static void spapr_pic_print_info(InterruptStatsPro=
vider *obj,
>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
>  }
> =20
> +static int spapr_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool cam_ignore, uint8_t priority,
> +                                uint32_t logic_serv, XiveTCTXMatch *matc=
h)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
> +    int count;
> +
> +    count =3D spapr->irq->match_nvt(spapr, format, nvt_blk, nvt_idx, cam=
_ignore,
> +                                  priority, logic_serv, match);
> +    if (count < 0) {
> +        return count;
> +    }
> +
> +    /*
> +     * When we implement the save and restore of the thread interrupt
> +     * contexts in the enter/exit CPU handlers of the machine and the
> +     * escalations in QEMU, we should be able to handle non dispatched
> +     * vCPUs.
> +     *
> +     * Until this is done, the sPAPR machine should find at least one
> +     * matching context always.
> +     */
> +    if (count =3D=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispatche=
d\n",
> +                      nvt_blk, nvt_idx);
> +    }
> +
> +    return count;
> +}
> +
>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
>  {
>      return cpu->vcpu_id;
> @@ -4456,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
> =20
>      mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
>      mc->ignore_boot_device_suffixes =3D true;
> @@ -4514,6 +4546,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       */
>      mc->numa_mem_align_shift =3D 28;
>      mc->numa_mem_supported =3D true;
> +    xfc->match_nvt =3D spapr_xive_match_nvt;
> =20
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> @@ -4547,6 +4580,7 @@ static const TypeInfo spapr_machine_info =3D {
>          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>          { TYPE_XICS_FABRIC },
>          { TYPE_INTERRUPT_STATS_PROVIDER },
> +        { TYPE_XIVE_FABRIC },
>          { }
>      },
>  };
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d8f46b6797f8..8a6d79a59af2 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -257,6 +257,7 @@ SpaprIrq spapr_irq_xics =3D {
>      .set_irq     =3D spapr_irq_set_irq_xics,
>      .get_nodename =3D spapr_irq_get_nodename_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
> +    .match_nvt   =3D NULL, /* should not be used */
>  };
> =20
>  /*
> @@ -406,6 +407,18 @@ static void spapr_irq_init_kvm_xive(SpaprMachineStat=
e *spapr, Error **errp)
>      }
>  }
> =20
> +static int spapr_irq_match_nvt_xive(SpaprMachineState *spapr, uint8_t fo=
rmat,
> +                                    uint8_t nvt_blk, uint32_t nvt_idx,
> +                                    bool cam_ignore, uint8_t priority,
> +                                    uint32_t logic_serv, XiveTCTXMatch *=
match)
> +{
> +    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> +
> +    return xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
> +                          priority, logic_serv, match);
> +}
> +
>  /*
>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>   * with XICS.
> @@ -431,6 +444,7 @@ SpaprIrq spapr_irq_xive =3D {
>      .set_irq     =3D spapr_irq_set_irq_xive,
>      .get_nodename =3D spapr_irq_get_nodename_xive,
>      .init_kvm    =3D spapr_irq_init_kvm_xive,
> +    .match_nvt   =3D spapr_irq_match_nvt_xive,
>  };
> =20
>  /*
> @@ -585,6 +599,15 @@ static const char *spapr_irq_get_nodename_dual(Spapr=
MachineState *spapr)
>      return spapr_irq_current(spapr)->get_nodename(spapr);
>  }
> =20
> +static int spapr_irq_match_nvt_dual(SpaprMachineState *spapr, uint8_t fo=
rmat,
> +                                    uint8_t nvt_blk, uint32_t nvt_idx,
> +                                    bool cam_ignore, uint8_t priority,
> +                                    uint32_t logic_serv, XiveTCTXMatch *=
match)
> +{
> +    return spapr_irq_current(spapr)->match_nvt(spapr, format, nvt_blk, n=
vt_idx,
> +                                     cam_ignore, priority, logic_serv, m=
atch);
> +}
> +
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -608,6 +631,7 @@ SpaprIrq spapr_irq_dual =3D {
>      .set_irq     =3D spapr_irq_set_irq_dual,
>      .get_nodename =3D spapr_irq_get_nodename_dual,
>      .init_kvm    =3D NULL, /* should not be used */
> +    .match_nvt   =3D spapr_irq_match_nvt_dual,
>  };
> =20
> =20
> @@ -825,4 +849,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .set_irq     =3D spapr_irq_set_irq_xics,
>      .get_nodename =3D spapr_irq_get_nodename_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
> +    .match_nvt   =3D NULL, /* should not be used */
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--McTFpSeH7KqpdXA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VVbcACgkQbDjKyiDZ
s5LlsA//R8o9fgAMr5vY1x3XVP6+55/vXjxopBkJMW4mueu4cB2aC09n7KT1xNEH
Bt7AxjOvgGO3MOnkPb2R1+rHKzVKO4t6hGRAns8/r9SQrpRf4dtYDHYVaetWkc7u
uvbpV27hncgPE9ZQU2BwUcMbGg9KM3u8t4OkNnhJWO9P2AJB1aXMqHPASpLqr0hb
gAomTT68HAtFDB6km7cPz0bqSwGk/EBhwIbe/b0bXWl7TCoV2IjeVv/Ur6TBLdmq
FSw24RSg+bzoLzecBt8s6OOK7YBznQe2x0sSgRvlKcn9BuLQcBBoZUCKssv2hdz9
V4FslZF4gGmQdKYOPM5ZP0gGxuzm0TRDFSdcDXHhwMIElgD2HhnmCWdB6EnZTW8A
7/xID8O+K+OKZKqRYVQUJmymiy22n1FOv2SyZ0kspCGi4kEUjvYZ4Q8O15HJHoxB
Up2lcH1Dh2xxPvBm8qwmLvOOUblSCRcGRF1Vl6oa/XeL23oDULdoihmbg1L8nBD2
DPLqbWKC45Egg2d3QKisejYSUujfxUZSxc1vuOrZvu8jQm/srZFZzV3A2jsWe/5i
MmfnBKY/iBTPwhgrQRAbD1gqsahcOg9qYLxgLlDrB9c2F31kH1r3MfswkRkenftt
/X1OqfzuOO9zN+pALYlBUNoPIom/otDO20ZAFiwTZqY1y58WueE=
=JY4/
-----END PGP SIGNATURE-----

--McTFpSeH7KqpdXA3--

