Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E3C48BE2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E0A2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PMU2WSCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E0A2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsOu-0007tT-FB
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57648)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsGb-0001uW-WB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hds65-0004PA-C8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:07:08 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39279 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hds63-0004Cj-3w; Thu, 20 Jun 2019 04:07:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TvY36Bzrz9sCJ; Thu, 20 Jun 2019 18:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561018007;
 bh=MMKRSJhUNUXZnIHRyb9AyZ2Cj/9d97iwNstp4d2Qzb0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PMU2WSCvRIHtHySJAddQhKpU8qlcJkKtfIV+H8EOoQaKvZegQGI9DG9X3R5GESZBW
 zA9U+JhbnBKnnZRIN7hALiK75O/1rk50w3VfjuPeaz3az2tFpGk+mxMeWe0D+0c8+1
 gFbk1Bbei8mOPld/DbZv4VUS9ESJ4a8Wlkpy2bJo=
Date: Thu, 20 Jun 2019 18:04:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190620080407.GA8232@umbus.BigPond>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077920657.433243.13541093940589972734.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <156077920657.433243.13541093940589972734.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 3/6] xics/kvm: Skip rollback when KVM XICS
 is absent
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


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:46:46PM +0200, Greg Kurz wrote:
> There is no need to rollback anything at this point, so just return an
> error.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics_kvm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 534515143ea8..377ff88701c2 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -348,7 +348,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error =
**errp)
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
>          error_setg(errp,
>                     "KVM and IRQ_XICS capability must be present for in-k=
ernel XICS");
> -        goto fail;
> +        return -1;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-x=
ive");
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0LPfcACgkQbDjKyiDZ
s5LNNg/+Px8E6CvkJEqU9hhR+S6E4FX5SDmSFD84aM+XNkk6yC8tAyt9Vj7Wd0jd
0Vd+MKAmMxxMt2FL+f3dGyHPc3W2iyEMdRBpPoxjLETEPOznf+P3+TmTC1A4bS3D
7JbH1tEC8/5JJxZuThpgQdJRq/QemaJYjR64XeWUncMUNmvKWn9e2Cuww/I6cDVD
cntQMlP3CxJXGNrF2liKSapk1OT/I1LOvRANYerjGSBJZ++qM/U6AGVYW5iHjo6Z
FO5sBFMXoIQ72oMd9cDsoaI6BJDESv17KcQZk6hl7kMRKgS3JWCfRSDkQe4A7Fgx
yxUYwKMzNeOH3rPyXGXYG0OCLbSX1AWJ4IIvwJ1xz8fHr1DUiVs+3SofK1yRaijT
2Y3U8B38s4a/lXcTQEnLRh+7dJzgDOSBDDi4kYoVAgnYBLf+R4GEJZjCS3Wk/sLv
lamYbMbO7FqZ3tU6OFVIrkP1egupGUHYkZeM7cCXRanK0Q+8KLmYTfCZKB4iXUnk
mfbBqy0AOEh/goKxpngvXrKcgKapk4o1FlLg6iu9vaZrnPufTX0QMurXolsnMPqz
R2MosZOaGtGGy83VcYrUWzoyWNdOfhEQt3ptvfN1RBiIHBCea5ZofDIs06IGhZXN
X/EeSpEz8gO0y+8IT7fWln3rHdqHM6byDnFqHy2fOMPd5mwUyb0=
=4Vn7
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

