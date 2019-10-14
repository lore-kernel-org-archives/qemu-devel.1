Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E0C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38EF20650
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ispLL6kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38EF20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJtcS-0008G9-UV
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 02:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJtbj-0007l6-GW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 02:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJtbi-0002Kb-4a
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 02:13:27 -0400
Received: from ozlabs.org ([203.11.71.1]:60739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iJtbh-0002Jc-P3; Mon, 14 Oct 2019 02:13:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46s7Xd0Jgkz9sPj; Mon, 14 Oct 2019 17:13:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571033601;
 bh=bbr38Vy+6E26aimSStDAkf3wkCQ+2u2N7Kpmu0BuaVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ispLL6kR6wDJlqfAf78o8mJmBx5HHYy6gwqFhPJqH5UXBEamXBu8r4kzPGA9A1o1G
 e9OTAPCwuK7H3E16u3z1kgaMu4wcWCGqugbaDb0TjAuA//oYxPwa9HuITG2xdAk1yc
 cCjbUuN285Y4Bcgki9sW3ezu4Uhdgzo+z0iXsc6U=
Date: Mon, 14 Oct 2019 17:12:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 7/7] spapr: Set VSMT to smp_threads by default
Message-ID: <20191014061247.GZ4080@umbus.fritz.box>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010411885.246126.12610015369068227139.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KLINyTCByxgMLuN/"
Content-Disposition: inline
In-Reply-To: <157010411885.246126.12610015369068227139.stgit@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KLINyTCByxgMLuN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2019 at 02:02:00PM +0200, Greg Kurz wrote:
> Support for setting VSMT is available in KVM since linux-4.13. Most distr=
os
> that support KVM on POWER already have it. It thus seem reasonable enough
> to have the default machine to set VSMT to smp_threads.
>=20
> This brings contiguous VCPU ids and thus brings their upper bound down to
> the machine's max_cpus. This is especially useful for XIVE KVM devices,
> which may thus allocate only one VP descriptor per VCPU.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr.c         |    7 ++++++-
>  include/hw/ppc/spapr.h |    1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8f59f08c102e..473ce1d04775 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2503,6 +2503,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineState =
*ms, uint32_t id, int *idx)
>  static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      Error *local_err =3D NULL;
>      bool vsmt_user =3D !!spapr->vsmt;
>      int kvm_smt =3D kvmppc_smt_threads();
> @@ -2529,7 +2530,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
>              goto out;
>          }
>          /* In this case, spapr->vsmt has been set by the command line */
> -    } else {
> +    } else if (!smc->smp_threads_vsmt) {
>          /*
>           * Default VSMT value is tricky, because we need it to be as
>           * consistent as possible (for migration), but this requires
> @@ -2538,6 +2539,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
>           * overwhelmingly common case in production systems.
>           */
>          spapr->vsmt =3D MAX(8, smp_threads);
> +    } else {
> +        spapr->vsmt =3D smp_threads;
>      }
> =20
>      /* KVM: If necessary, set the SMT mode: */
> @@ -4452,6 +4455,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
>      smc->linux_pci_probe =3D true;
> +    smc->smp_threads_vsmt =3D true;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -4519,6 +4523,7 @@ static void spapr_machine_4_1_class_options(Machine=
Class *mc)
> =20
>      spapr_machine_4_2_class_options(mc);
>      smc->linux_pci_probe =3D false;
> +    smc->smp_threads_vsmt =3D false;
>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cbd1a4c9f390..2009eb64f9cb 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -122,6 +122,7 @@ struct SpaprMachineClass {
>      bool broken_host_serial_model; /* present real host info to the gues=
t */
>      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
>      bool linux_pci_probe;
> +    bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KLINyTCByxgMLuN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2kEd8ACgkQbDjKyiDZ
s5JVAw/9HM8d+gpCy83C6nv7Ir+2lO4pVGdCro3z8T9bmjHEv/SrQfZRuqy9Bmtz
aktGpQownsy88z2IPldN1VCwIKtkJNoBoeKYqMXHEzisEi9S68fDUw2cZIF4tOZe
zTHTIijvpCiuZ2sS4NTBPod8Lyva4uUzR7tdT5X3TwKi0NdfNC/ayktaOmWeusMw
oBlrfynuBLXTGRDLDshYhsNCmrZDq7ifrb094mXnXIOo+oqeDe9gByn7I/1d32xt
6uYW+2SHskagtBQmgYlKzJP0Hu1b1dqkx8zq3OyzpzMxV0OTNeSc8vsqGUrMgFcv
mTlb7z68tMLo2zcK+GK/nPkyafLQRiFlnJecSCQWDBljwX0tI2GmxD821NV074Si
2aRcuUrOFmji+vw7+xyqgJASk0HQD03UHi3KD6AIMqQyWw8HqxuiPoO4vtlpJr/e
2nYeFP8yjI/aSMq3Me4T5RlxJv8tWhQxmMCL2WeetBtl/Atg3Mlm07g8tSY5nwTI
u9AdRlngqOe0jfV9D8t/bAwKI3+dvpXskewb1WY13xaCasVgn5sREd96evj2yrni
w8xExJXjBAoXXjizBXQuZxaLQgKcjh3iOheLK9RuH1y5GoE8k0i+A69/FLiCctCy
/FxDch7LNB2KhA4xF+7Ve64Vq4juNRAbk9ft9Mdj0s416/LJuX0=
=X7Jd
-----END PGP SIGNATURE-----

--KLINyTCByxgMLuN/--

