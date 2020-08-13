Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D19C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7088220791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fhGruMMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7088220791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6B8b-0002Ne-JG
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7X-0000Zg-UB; Thu, 13 Aug 2020 07:10:07 -0400
Received: from ozlabs.org ([203.11.71.1]:35533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7T-0002nz-Uq; Thu, 13 Aug 2020 07:10:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS3kb6RNNz9sTM; Thu, 13 Aug 2020 21:09:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597316999;
 bh=TbJS5t+qCXPmwjhY5HkRknZWUtlf6R8cS2xLuwILDW4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fhGruMMSfN5T5/H9ATXeptYiOOCsjLA/qLbIPeLOKi9mL565MHa+rpi4ASJXhwsQQ
 x5AHMDuKKcza1AjBgS1nPSyyHQW2s07PoRxXQnCVhfylgSJB08SAIEiaG/R8rwa71G
 8qc6wHt0tHQ0oBK8TwjfT9oa3lRdARDNtjcJ7ww4=
Date: Thu, 13 Aug 2020 21:00:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 for-5.2 3/3] spapr/xive: Convert KVM device fd checks
 to assert()
Message-ID: <20200813110018.GA6255@yekko.fritz.box>
References: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
 <159679994169.876294.11026653581505077112.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <159679994169.876294.11026653581505077112.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:45:10
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 01:32:21PM +0200, Greg Kurz wrote:
> All callers guard these functions with an xive_in_kernel() helper. Make
> it clear that they are only to be called when the KVM XIVE device exists.
>=20
> Note that the check on xive is dropped in kvmppc_xive_disconnect(). It
> really cannot be NULL since it comes from set_active_intc() which only
> passes pointers to allocated objects.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-5.2.

> ---
> v2: Take the helper name change into account in the changelog
> ---
>  hw/intc/spapr_xive_kvm.c |   35 +++++++----------------------------
>  1 file changed, 7 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 6130882be678..82a6f99f022d 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -79,10 +79,7 @@ void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error *=
*errp)
>      uint64_t state[2];
>      int ret;
> =20
> -    /* The KVM XIVE device is not in use yet */
> -    if (xive->fd =3D=3D -1) {
> -        return;
> -    }
> +    assert(xive->fd !=3D -1);
> =20
>      /* word0 and word1 of the OS ring. */
>      state[0] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS]);
> @@ -101,10 +98,7 @@ void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error =
**errp)
>      uint64_t state[2] =3D { 0 };
>      int ret;
> =20
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd =3D=3D -1) {
> -        return;
> -    }
> +    assert(xive->fd !=3D -1);
> =20
>      ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
>      if (ret !=3D 0) {
> @@ -156,10 +150,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error *=
*errp)
>      unsigned long vcpu_id;
>      int ret;
> =20
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd =3D=3D -1) {
> -        return;
> -    }
> +    assert(xive->fd !=3D -1);
> =20
>      /* Check if CPU was hot unplugged and replugged. */
>      if (kvm_cpu_is_enabled(tctx->cs)) {
> @@ -245,10 +236,7 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, i=
nt srcno, Error **errp)
>      SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      uint64_t state =3D 0;
> =20
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd =3D=3D -1) {
> -        return -ENODEV;
> -    }
> +    assert(xive->fd !=3D -1);
> =20
>      if (xive_source_irq_is_lsi(xsrc, srcno)) {
>          state |=3D KVM_XIVE_LEVEL_SENSITIVE;
> @@ -592,10 +580,7 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
> =20
>  void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
>  {
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd =3D=3D -1) {
> -        return;
> -    }
> +    assert(xive->fd !=3D -1);
> =20
>      /*
>       * When the VM is stopped, the sources are masked and the previous
> @@ -622,10 +607,7 @@ int kvmppc_xive_pre_save(SpaprXive *xive)
>  {
>      Error *local_err =3D NULL;
> =20
> -    /* The KVM XIVE device is not in use */
> -    if (xive->fd =3D=3D -1) {
> -        return 0;
> -    }
> +    assert(xive->fd !=3D -1);
> =20
>      /* EAT: there is no extra state to query from KVM */
> =20
> @@ -845,10 +827,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController=
 *intc)
>      XiveSource *xsrc;
>      size_t esb_len;
> =20
> -    /* The KVM XIVE device is not in use */
> -    if (!xive || xive->fd =3D=3D -1) {
> -        return;
> -    }
> +    assert(xive->fd !=3D -1);
> =20
>      /* Clear the KVM mapping */
>      xsrc =3D &xive->source;
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81HUIACgkQbDjKyiDZ
s5LelQ/9GwnD8m+1cyl/p3aDS1LZ+MG87Q/xE5DBKdGEmn2oKxsx5s99A7jwoGtR
QbHPKO1kgTUFzZPLWdNA/w0PsaiqPpzJPuyB2xo4YkRHmX//EaL+bFAFQyZHimPV
B8FEeB9qXuvvi1jSHmliY+a2UQr3MZNZqOirH1F6wg1lFc7/3Xu6y7RrK9iEJAO/
T6tPVcCh7JXcQQQFAhNHKOwHsxTh8kFdCyC7EQ1KhM9a9G3Ht23UrxQv1A9kiFeZ
mfW9iTcasI+s/peICruu6EsJbgjabttJkoU732DwIQovzHVCmyTyehzC+61LrC1h
cjls9w3GqWhlHKMDrsa8EAASK3PU6SolXdZWcVno6vPC/GOFMELOJuJESRs09Iwk
CSdEN8xGS4ug6WFg22HjePdg3pD+fXN4ig+gy0/NrufN7yAzKTkEY+H5JFtRetBn
+hDJq+74MpG2bv+941OS7nq1vrM5lFLxQzlJvhDGL2IUFRCrwJZHg3/5VRU/Kglq
U6jxPR/+M2ppneVqbAjy5w2HJdhxIVgfz4dw3AtrpJu+nTg/uy/9DgaiovTS1Q93
IvfijJ4zHkvXwn9N91l0tJ0Md/IxSrmPigSA+5hF8frxMuZ3+dVIuqFRfPxiNi+d
946Ti/FHBkeeDnyeUhXuDWAbc4/7oQVUTHndwCe0zW3mZ2KKDJY=
=Cho3
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

