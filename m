Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C903EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC2220781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WRuiFWCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC2220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AoH-00008E-RN
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Ajc-0008G2-CB; Thu, 13 Aug 2020 06:45:24 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41281 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjZ-0008Q2-T7; Thu, 13 Aug 2020 06:45:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39z0vhHz9sTp; Thu, 13 Aug 2020 20:45:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315511;
 bh=T7N2pP91H/oBaCfhSYazuylqsVqca4K/3ijYhV7smpg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WRuiFWCEFTsYCNft7BoNMCz5Pz7ajjnTTQkExEsPsDNPdhsa1XLtDRcAey1isfnic
 L4a9tf7V7Bt2K4DtaHJYoigLpT6kapwWlna1MnX7pnGtsLY7ce8bSX2b3aVMgLsaNX
 CxYQEYa+D5EvlT/i0SM7WDTSgCpCVfr70BO+Hra8=
Date: Thu, 13 Aug 2020 20:30:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 10/14] spapr/xive: Fix error handling in
 kvmppc_xive_post_load()
Message-ID: <20200813103019.GM181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707850148.1489912.18355118622296682631.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4oQnj4jcM03NhqPN"
Content-Disposition: inline
In-Reply-To: <159707850148.1489912.18355118622296682631.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4oQnj4jcM03NhqPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:55:01PM +0200, Greg Kurz wrote:
> Now that all these functions return a negative errno on failure, check
> that because it is preferred to local_err. And most of all, propagate it
> because vmstate expects negative errnos.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |   35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 1686b036eb2d..005729ebffed 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -631,6 +631,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versio=
n_id)
>      Error *local_err =3D NULL;
>      CPUState *cs;
>      int i;
> +    int ret;
> =20
>      /* The KVM XIVE device should be in use */
>      assert(xive->fd !=3D -1);
> @@ -641,11 +642,10 @@ int kvmppc_xive_post_load(SpaprXive *xive, int vers=
ion_id)
>              continue;
>          }
> =20
> -        kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
> -                                     &xive->endt[i], &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -            return -1;
> +        ret =3D kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, =
i,
> +                                           &xive->endt[i], &local_err);
> +        if (ret < 0) {
> +            goto fail;
>          }
>      }
> =20
> @@ -660,16 +660,14 @@ int kvmppc_xive_post_load(SpaprXive *xive, int vers=
ion_id)
>           * previously set in KVM. Since we don't do that for all interru=
pts
>           * at reset time anymore, let's do it now.
>           */
> -        kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -            return -1;
> +        ret =3D kvmppc_xive_source_reset_one(&xive->source, i, &local_er=
r);
> +        if (ret < 0) {
> +            goto fail;
>          }
> =20
> -        kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err=
);
> -        if (local_err) {
> -            error_report_err(local_err);
> -            return -1;
> +        ret =3D kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &l=
ocal_err);
> +        if (ret < 0) {
> +            goto fail;
>          }
>      }
> =20
> @@ -686,15 +684,18 @@ int kvmppc_xive_post_load(SpaprXive *xive, int vers=
ion_id)
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &local_err=
);
> -        if (local_err) {
> -            error_report_err(local_err);
> -            return -1;
> +        ret =3D kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &l=
ocal_err);
> +        if (ret < 0) {
> +            goto fail;
>          }
>      }
> =20
>      /* The source states will be restored when the machine starts runnin=
g */
>      return 0;
> +
> +fail:
> +    error_report_err(local_err);
> +    return ret;
>  }
> =20
>  /* Returns MAP_FAILED on error and sets errno */
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4oQnj4jcM03NhqPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81FjsACgkQbDjKyiDZ
s5JPSw/9E42XcRROFSJCXqnEXINrHwfhpAjHT8+riatI6xll2Nrw4+61IPdqglf+
vj0VbGVcR3He97tuQyen/Rs4x9mSz6DMcrWPSNG5FRy2nZuQ5qLSVmxlbRolFB1I
vdY7fL94U3B+gQW8uouFahUmpx3RpPSd1W5ZL+EkqHWZHooOAegS2iTpPjxFx2HF
qlKGOG5eBwJMCRrwNExTVknioRKjIRwB1SChQILR8b4JlDzDRdmCoIWCSnn2bwkQ
cWnDjNcBxn/q8fc14qOj6mJl2MUM2o2Yk+d5smPWgfF2VNlC2HFC3pj8n8Qg72Qa
3aH/2cSqRWYtI61kqADoXULTSa+UBKD7TjEbHSjNFCsRmaL5IP21zdCUdN/fnSkc
Cq2RfSNZoz1l0xs6bY9xnWQqnL1h0d2mXvbiQTnZt21n6jkWzlVLuqbPrgxhU6AW
d8cq3bj/pYc+frdwgI2GgG/zEKNirJPZvSxyJadz8oEDRhY5yhL+YptNytd77d/2
7Y2yfwNOks3MU5zlIaQh18F4PHvyA5MaFz8TJyLhR3gkgLksnsL59WqOT54x78na
r4vEyMg6a6k9mGBLy9IW91SdWDqewEXpCUOdQ+tT0mj9EsWp4M0hRDW4kJqXjYdz
oIteXnE+Uw3Foahiyz2kHCUQ2Ky1zouO1/lGUsvQH4Dhi5N8pSY=
=vDK2
-----END PGP SIGNATURE-----

--4oQnj4jcM03NhqPN--

