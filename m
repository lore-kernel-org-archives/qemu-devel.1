Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE06FC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB672084B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TbTkiw6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB672084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdt1W-00054R-Sz
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsjB-0006r2-Ch
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsag-0000i9-RT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:38:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35551 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hdsag-0000gd-9h; Thu, 20 Jun 2019 04:38:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TwFn002Sz9s5c; Thu, 20 Jun 2019 18:38:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561019917;
 bh=mECB6+fTZ+CTXAi3DV9iTCXLQi0Ww7b/s+aCMx5dV0w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TbTkiw6WyuC3t7uafjEU/BVZ4MsQ/ZrtQ753BgCRcVfXZw3vlKoz6TfRjXoi3fX/8
 nDMy4GOc7Q13MFQYJWouwLG2mzUDfH1TxBuqOF6ReSd/JytzmO6Tv5lpQCUESb7cWw
 FJxivZFExvvfkLs+ygVQU9r6bjeLPQgyM24Ku4cU=
Date: Thu, 20 Jun 2019 18:31:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190620083144.GC8232@umbus.BigPond>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077921763.433243.4614327010172954196.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <156077921763.433243.4614327010172954196.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 5/6] xics/kvm: Add error propagation to
 ic*_set_kvm_state() functions
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


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:46:57PM +0200, Greg Kurz wrote:
> This allows errors happening there to be propagated up to spapr_irq,
> just like XIVE already does.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics.c        |   39 ++++++++++++++++++++++++++++++++++-----
>  hw/intc/xics_kvm.c    |   37 ++++++++++++++++++++++---------------
>  include/hw/ppc/xics.h |    6 +++---
>  3 files changed, 59 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 1dc3a0f12280..69152e3d9ff6 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -267,7 +267,14 @@ static int icp_post_load(void *opaque, int version_i=
d)
>      ICPState *icp =3D opaque;
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        return icp_set_kvm_state(icp);
> +        Error *local_err =3D NULL;
> +        int ret;
> +
> +        ret =3D icp_set_kvm_state(icp, &local_err);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
>      }
> =20
>      return 0;
> @@ -300,7 +307,12 @@ static void icp_reset_handler(void *dev)
>      qemu_set_irq(icp->output, 0);
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        icp_set_kvm_state(ICP(dev));
> +        Error *local_err =3D NULL;
> +
> +        icp_set_kvm_state(ICP(dev), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>      }
>  }
> =20
> @@ -555,7 +567,12 @@ static void ics_simple_reset(DeviceState *dev)
>      icsc->parent_reset(dev);
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        ics_set_kvm_state(ICS_BASE(dev));
> +        Error *local_err =3D NULL;
> +
> +        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>      }
>  }
> =20
> @@ -671,7 +688,14 @@ static int ics_base_post_load(void *opaque, int vers=
ion_id)
>      ICSState *ics =3D opaque;
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        return ics_set_kvm_state(ics);
> +        Error *local_err =3D NULL;
> +        int ret;
> +
> +        ret =3D ics_set_kvm_state(ics, &local_err);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
>      }
> =20
>      return 0;
> @@ -757,8 +781,13 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool=
 lsi)
>          lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
> =20
>      if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
>          ics_reset_irq(ics->irqs + srcno);
> -        ics_set_kvm_state_one(ics, srcno);
> +        ics_set_kvm_state_one(ics, srcno, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>      }
>  }
> =20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index c9e25fb051bb..4bfbe1a84092 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -106,7 +106,7 @@ void icp_synchronize_state(ICPState *icp)
>      }
>  }
> =20
> -int icp_set_kvm_state(ICPState *icp)
> +int icp_set_kvm_state(ICPState *icp, Error **errp)
>  {
>      uint64_t state;
>      int ret;
> @@ -126,10 +126,11 @@ int icp_set_kvm_state(ICPState *icp)
>          | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SHIFT=
);
> =20
>      ret =3D kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
> -    if (ret !=3D 0) {
> -        error_report("Unable to restore KVM interrupt controller state (=
0x%"
> -                PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(icp-=
>cs),
> -                strerror(errno));
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +                         "Unable to restore KVM interrupt controller sta=
te (0x%"
> +                         PRIx64 ") for CPU %ld", state,
> +                         kvm_arch_vcpu_id(icp->cs));
>          return ret;
>      }
> =20
> @@ -240,10 +241,9 @@ void ics_synchronize_state(ICSState *ics)
>      ics_get_kvm_state(ics);
>  }
> =20
> -int ics_set_kvm_state_one(ICSState *ics, int srcno)
> +int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp)
>  {
>      uint64_t state;
> -    Error *local_err =3D NULL;
>      ICSIRQState *irq =3D &ics->irqs[srcno];
>      int ret;
> =20
> @@ -278,16 +278,15 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno)
>      }
> =20
>      ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                            srcno + ics->offset, &state, true, &local_er=
r);
> -    if (local_err) {
> -        error_report_err(local_err);
> +                            srcno + ics->offset, &state, true, errp);
> +    if (ret < 0) {
>          return ret;
>      }
> =20
>      return 0;
>  }
> =20
> -int ics_set_kvm_state(ICSState *ics)
> +int ics_set_kvm_state(ICSState *ics, Error **errp)
>  {
>      int i;
> =20
> @@ -297,10 +296,12 @@ int ics_set_kvm_state(ICSState *ics)
>      }
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
> +        Error *local_err =3D NULL;
>          int ret;
> =20
> -        ret =3D ics_set_kvm_state_one(ics, i);
> -        if (ret) {
> +        ret =3D ics_set_kvm_state_one(ics, i, &local_err);
> +        if (ret < 0) {
> +            error_propagate(errp, local_err);
>              return ret;
>          }
>      }
> @@ -402,12 +403,18 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
>      }
> =20
>      /* Update the KVM sources */
> -    ics_set_kvm_state(spapr->ics);
> +    ics_set_kvm_state(spapr->ics, &local_err);
> +    if (local_err) {
> +        goto fail;
> +    }
> =20
>      /* Connect the presenters to the initial VCPUs of the machine */
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        icp_set_kvm_state(spapr_cpu_state(cpu)->icp);
> +        icp_set_kvm_state(spapr_cpu_state(cpu)->icp, &local_err);
> +        if (local_err) {
> +            goto fail;
> +        }
>      }
> =20
>      return 0;
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index eb65ad7e43b7..1eb7b5cd6847 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -190,13 +190,13 @@ Object *icp_create(Object *cpu, const char *type, X=
ICSFabric *xi,
> =20
>  /* KVM */
>  void icp_get_kvm_state(ICPState *icp);
> -int icp_set_kvm_state(ICPState *icp);
> +int icp_set_kvm_state(ICPState *icp, Error **errp);
>  void icp_synchronize_state(ICPState *icp);
>  void icp_kvm_realize(DeviceState *dev, Error **errp);
> =20
>  void ics_get_kvm_state(ICSState *ics);
> -int ics_set_kvm_state_one(ICSState *ics, int srcno);
> -int ics_set_kvm_state(ICSState *ics);
> +int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp);
> +int ics_set_kvm_state(ICSState *ics, Error **errp);
>  void ics_synchronize_state(ICSState *ics);
>  void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0LRG0ACgkQbDjKyiDZ
s5IpHxAAvvn/2/tKLOS9+BdbbDu1dEVeU+eYiQxOJuHl12RjUN2nXoajaZlyJRh2
hmvBcjmucXVYcqEkSi9/Qfz9PMCfcYS+8OMT7fjzRem60Ytl4JoiMvT2t+FB3qOO
mVuoRGhzSjGrfJN5nG+e8L/9LsLrlOUnTAVaZWW6iEtunXXxYaXJsdRgM0vXiWxU
9b20yyURcdEp1e8zgwDmCayN7l2bJj0wzV2eZDP8WjzjVbjH9dCV4N+lz/u9AkpZ
XxUPGD6aM0xwp/ptz1TDDUBBvkumFz67haJsg5qaISwSN/LlCVDOZfZZuqeq2EO6
Zo/AZx/4XxIsMVVuMzeRktbRIp5UyT2TQL/M3mhyFPTOorWNV8e/pDk0kogkmLGx
4tQyt7/2TpFEQC5WJag5Gf1gMG1QVqsIG03pexK0t7o+fcfiP0pkVTh8ZSEdictP
8aQ9EdzlF0wurNi4qxLpR/OQcYLDy3LZil0E/yqAvv8X+brDopEpJyZ3E10ht4+C
0kueBlxeTUOqNU65jpzipW+gKNEOeDYPoVQn+RiuuFoYm/bYK/2ZcltpTDY7erXd
XAo2abaMphj2Qi9i2wT8VCzCeuNWkkQ4UJoK0qiCbv6mypIofmdf72rM5Zp6JeVU
OR65/vR2gDhsMXFr3Mxy1Oh5C02PUYMbExWtaegaWLb69al0DzM=
=U+C/
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

