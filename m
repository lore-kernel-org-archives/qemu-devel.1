Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F8620792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d5kjx2n+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F8620792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjgJ8-0001th-JA
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jjgIU-0001O1-9G; Fri, 12 Jun 2020 05:48:26 -0400
Received: from ozlabs.org ([203.11.71.1]:58797)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jjgIR-0007sH-6A; Fri, 12 Jun 2020 05:48:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49jwrn4pgdz9sSS; Fri, 12 Jun 2020 19:48:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591955289;
 bh=Yeuxc3YUx6pTc5HBQAoGbxnEMUfRmb2Zh2IGdLOBi+M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d5kjx2n+n7RI/mQE1CHkwsZYBgO19S8F332tQ96O1kd5fH3RiPZzAMG+r/mXJpgBK
 YsXVP9ROiGFVceNM8Fjq0MsWk4CBhdwJ7kqY0Ug0eGySjiK+CEiz/QVryDgIHT0UC7
 nZklEDu7SdnunhoiOIXQizbwd9bN9TKxYqzljEOA=
Date: Fri, 12 Jun 2020 19:46:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 1/4] spapr: Simplify some warning printing paths in
 spapr_caps.c
Message-ID: <20200612094651.GB5861@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188281098.70166.18387926536399257573.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <159188281098.70166.18387926536399257573.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 05:48:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 03:40:11PM +0200, Greg Kurz wrote:
> We obviously only want to print a warning in these cases, but this is done
> in a rather convoluted manner. Just use warn_report() instead.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.1, thanks.

> ---
>  hw/ppc/spapr_caps.c |   28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index efdc0dbbcfc0..0c2bc8e06e44 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -248,23 +248,18 @@ SpaprCapPossible cap_cfpc_possible =3D {
>  static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>                                   Error **errp)
>  {
> -    Error *local_err =3D NULL;
>      uint8_t kvm_val =3D  kvmppc_get_cap_safe_cache();
> =20
>      if (tcg_enabled() && val) {
>          /* TCG only supports broken, allow other values and print a warn=
ing */
> -        error_setg(&local_err,
> -                   "TCG doesn't support requested feature, cap-cfpc=3D%s=
",
> -                   cap_cfpc_possible.vals[val]);
> +        warn_report("TCG doesn't support requested feature, cap-cfpc=3D%=
s",
> +                    cap_cfpc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
>                     "Requested safe cache capability level not supported =
by kvm,"
>                     " try appending -machine cap-cfpc=3D%s",
>                     cap_cfpc_possible.vals[kvm_val]);
>      }
> -
> -    if (local_err !=3D NULL)
> -        warn_report_err(local_err);
>  }
> =20
>  SpaprCapPossible cap_sbbc_possible =3D {
> @@ -277,23 +272,18 @@ SpaprCapPossible cap_sbbc_possible =3D {
>  static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_=
t val,
>                                          Error **errp)
>  {
> -    Error *local_err =3D NULL;
>      uint8_t kvm_val =3D  kvmppc_get_cap_safe_bounds_check();
> =20
>      if (tcg_enabled() && val) {
>          /* TCG only supports broken, allow other values and print a warn=
ing */
> -        error_setg(&local_err,
> -                   "TCG doesn't support requested feature, cap-sbbc=3D%s=
",
> -                   cap_sbbc_possible.vals[val]);
> +        warn_report("TCG doesn't support requested feature, cap-sbbc=3D%=
s",
> +                    cap_sbbc_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
>  "Requested safe bounds check capability level not supported by kvm,"
>                     " try appending -machine cap-sbbc=3D%s",
>                     cap_sbbc_possible.vals[kvm_val]);
>      }
> -
> -    if (local_err !=3D NULL)
> -        warn_report_err(local_err);
>  }
> =20
>  SpaprCapPossible cap_ibs_possible =3D {
> @@ -309,24 +299,18 @@ SpaprCapPossible cap_ibs_possible =3D {
>  static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
>                                             uint8_t val, Error **errp)
>  {
> -    Error *local_err =3D NULL;
>      uint8_t kvm_val =3D kvmppc_get_cap_safe_indirect_branch();
> =20
>      if (tcg_enabled() && val) {
>          /* TCG only supports broken, allow other values and print a warn=
ing */
> -        error_setg(&local_err,
> -                   "TCG doesn't support requested feature, cap-ibs=3D%s",
> -                   cap_ibs_possible.vals[val]);
> +        warn_report("TCG doesn't support requested feature, cap-ibs=3D%s=
",
> +                    cap_ibs_possible.vals[val]);
>      } else if (kvm_enabled() && (val > kvm_val)) {
>          error_setg(errp,
>  "Requested safe indirect branch capability level not supported by kvm,"
>                     " try appending -machine cap-ibs=3D%s",
>                     cap_ibs_possible.vals[kvm_val]);
>      }
> -
> -    if (local_err !=3D NULL) {
> -        warn_report_err(local_err);
> -    }
>  }
> =20
>  #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7jTwsACgkQbDjKyiDZ
s5KNNRAAl8Vgqn00NlRD9odBplnQc7GoyWyc/nyFH4PkHsnbiwRduSwCHQZYK/rU
h0D/dyTJRJmAPGjTJDL1+Jeq1kl1AUI04DHwq7PjAVK6D52RuMHEa1MTJxlDcTnC
dy3jJR3IhUi6OkBc1PsVqg36+VHmpzvvbd6VebCfMNgUSSa4ltrb6CLNTjgZEWus
T8oTCZJgoQOuPbzL23K5/RLutmKA0snSUeJBzR8ruimM3amm4lu/ERZLpBSc+pwe
2QtV1zkCzK+ecGuusiSJBPgheP0KfePefHuhx05iSyE/Uc4wGc3f+81HfZer8Zcv
e22QLI0BfxAMEcPImvOGVWcxTVir+GYvINkSfT15VxY/kAUNGgqhyjExDx9mRMaA
782GMoMQxHGC1len8di8v2JrpzXhKQVm73juwlw+SqctXNnFrzyUBtxyt0+ZNIyA
/+ChbmesnmmS2RH6UsV2u84Quvr6AALb8ugBoFHYvbws83/4RQGPmZdeVOshBG/3
I/2d6KL0PWflH3S4dNnOeCI/eZwOZR7TwAa7+HFlxWLu2sIdKlbz4FmHlYmqbeB7
5Xfs7rnITd14fz076OO3qJioXC41oP+HkNYpRroRprCVowxPiOqhLY6/5xMeO4gl
xyutF8uwTesXz9TTwr/RSNkkle9UdpO+NI2Pq+HpgShor87g5V8=
=Vxuu
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

