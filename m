Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA552C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C94B22D05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wcg5VB3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C94B22D05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Yqk-0006vw-DP
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3Ypv-0005mz-0w; Thu, 06 Aug 2020 01:53:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38353 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3Yps-0006wM-EB; Thu, 06 Aug 2020 01:53:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BMd231hqYz9sTM; Thu,  6 Aug 2020 15:52:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596693179;
 bh=LPLa0JwpoVxbqvCXOZR3Fv9qjqxm+hiQg7iaMLxmG+Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wcg5VB3pKQxadkiyvDI0hvw/uaZlan12GAfK6h4UH0gLTgORjAawENr8UVvvYzN6o
 YVIVLTsveQIPVviiLvH/sc+f12CPJfEhkGN31kHVDZY3i+2PDyj9pSyWrx35/++z2o
 m0pRntm4Ld0a+H1abnadnUHecxgi9n6Bl+uVhjD4=
Date: Thu, 6 Aug 2020 15:12:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Clarify error and documentation for broken KVM XICS
Message-ID: <20200806051217.GF100968@yekko.fritz.box>
References: <159664243614.622889.18307368735989783528.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <159664243614.622889.18307368735989783528.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 01:10:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Satheesh Rajendran <sathnaga@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 05:47:16PM +0200, Greg Kurz wrote:
> When starting an L2 KVM guest with `ic-mode=3Ddual,kernel-irqchip=3Don`,
> QEMU fails with:
>=20
> KVM is too old to support ic-mode=3Ddual,kernel-irqchip=3Don
>=20
> This error message was introduced to detect older KVM versions that
> didn't allow destruction and re-creation of the XICS KVM device that
> we do at reboot. But it is actually the same issue that we get with
> nested guests : when running under pseries, KVM currently provides
> a genuine XICS device (not the XICS-on-XIVE device that we get
> under powernv) which doesn't support destruction/re-creation.
>=20
> This will eventually be fixed in KVM but in the meantime, update
> the error message and documentation to mention the nested case.
> While here, mention that in "No XIVE support in KVM" section that
> this can also happen with "guest OSes supporting XIVE" since
> we check this at init time before starting the guest.
>=20
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890290
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  docs/specs/ppc-spapr-xive.rst |    5 ++++-
>  hw/ppc/spapr_irq.c            |   12 +++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
> index 7199db730b82..7144347560f1 100644
> --- a/docs/specs/ppc-spapr-xive.rst
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -126,6 +126,9 @@ xics            XICS KVM       XICS emul.     XICS KVM
> =20
>  (1) QEMU warns with ``warning: kernel_irqchip requested but unavailable:
>      IRQ_XIVE capability must be present for KVM``
> +    In some cases (old host kernels or KVM nested guests), one may hit a
> +    QEMU/KVM incompatibility due to device destruction in reset. QEMU fa=
ils
> +    with ``KVM is incompatible with ic-mode=3Ddual,kernel-irqchip=3Don``
>  (2) QEMU fails with ``kernel_irqchip requested but unavailable:
>      IRQ_XIVE capability must be present for KVM``
> =20
> @@ -148,7 +151,7 @@ xics            XICS KVM       XICS emul.     XICS KVM
>      mode (XICS), either don't set the ic-mode machine property or try
>      ic-mode=3Dxics or ic-mode=3Ddual``
>  (4) QEMU/KVM incompatibility due to device destruction in reset. QEMU fa=
ils
> -    with ``KVM is too old to support ic-mode=3Ddual,kernel-irqchip=3Don``
> +    with ``KVM is incompatible with ic-mode=3Ddual,kernel-irqchip=3Don``
> =20
> =20
>  XIVE Device tree properties
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2f8f7d62f875..72bb938375ef 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -139,6 +139,7 @@ SpaprIrq spapr_irq_dual =3D {
> =20
>  static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  {
> +    ERRP_GUARD();
>      MachineState *machine =3D MACHINE(spapr);
> =20
>      /*
> @@ -179,14 +180,19 @@ static int spapr_irq_check(SpaprMachineState *spapr=
, Error **errp)
> =20
>      /*
>       * On a POWER9 host, some older KVM XICS devices cannot be destroyed=
 and
> -     * re-created. Detect that early to avoid QEMU to exit later when the
> -     * guest reboots.
> +     * re-created. Same happens with KVM nested guests. Detect that earl=
y to
> +     * avoid QEMU to exit later when the guest reboots.
>       */
>      if (kvm_enabled() &&
>          spapr->irq =3D=3D &spapr_irq_dual &&
>          kvm_kernel_irqchip_required() &&
>          xics_kvm_has_broken_disconnect(spapr)) {
> -        error_setg(errp, "KVM is too old to support ic-mode=3Ddual,kerne=
l-irqchip=3Don");
> +        error_setg(errp,
> +            "KVM is incompatible with ic-mode=3Ddual,kernel-irqchip=3Don=
");
> +        error_append_hint(errp,
> +            "This can happen with an old KVM or in a KVM nested guest.\n=
");
> +        error_append_hint(errp,
> +            "Try without kernel-irqchip or with kernel-irqchip=3Doff.\n"=
);
>          return -1;
>      }
> =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8rkTEACgkQbDjKyiDZ
s5J5EhAA3YO0c+U77Thwwkj82jFW3siYC2n42AGN9SSBdFKviD8yz1jQj9B2Togr
oSj3cLz7pnFbo05iXJH6GEyvGY362q0HVVmGQ4+nRYY03msEylCArP6soHAAydx2
KSHN+8fuzrz2lB8ZxPUSFapE+4mlcA+Xyr/JXxdhPmwvaH+aLxo0v8FU0zKWyEhZ
T0RRa5gXEXRXeGNP8x/Awt4Z70Ewzlg8A7HFwPOi06ft446sgPbpRbPG3SAOnp5w
riruQtfj0HRHU5wzy1B/Rv34KTiMoJ36ocqNTH2AJJcHoF5lE2f6YPtBrHrT2j88
kj0SAp/EiCu0NA/VOWKeuv0Wpx4hRvozdfFACADhD/iYIQuX58BiIkyN+RsajWW2
wYGwgLZHwXrI3deePbLsTvIPY8IxWbWRB3Y9j/Fxkry25/j31hRLGb0Qw/Jl0IWY
x0pQySR6cps3ALeMsjeCEqpibizNTYid8qBLRVxMGOSp1Voi5zSTGcMHMCQPrx6y
E/DNMlTvI/7CKzoP8k6Ho7mefN+seJNer/xKV1aCz8x8yA4JldmKtyOYiv2STyko
CSV2CQXDBPOjIZ4SoxL7J2cEtPPIM9oud55NO/OSgNz+8Aw/Qy2l8i1IabFH4ycQ
NwuBhTlMqje33ruX7tmET+MKO3YKJ+cNSKRqxQ0MHWi3BE03f6g=
=toyb
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--

