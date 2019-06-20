Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C433C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EDB2084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VNA0VODT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EDB2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsIo-0003TY-77
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsFp-0001oZ-Sz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hds63-0004Nd-Bw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:07:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57267 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hds61-0004Bk-8V; Thu, 20 Jun 2019 04:07:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TvY31Tjcz9s9y; Thu, 20 Jun 2019 18:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561018007;
 bh=WJgzY+vfV4JWBtQ43FdVwqiK28gRU1gvbDQUOO60lgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VNA0VODTUK6c3sr+OB5/VjORYwBeioTPBdaxXjNRdoqL4WbFROKnuMp6PfIlRkkvE
 bK1dWNnJWGthzbyHD1AETxAkJqJZtiEzr6RB5/doKC9mZk82Wtfn9a1+0JAUTW4yVN
 51roxQIpOZ8OYDocQW2QTLgP+Q3FcKumKcSrmE8U=
Date: Thu, 20 Jun 2019 18:00:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190620080048.GD2066@umbus.BigPond>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077919546.433243.8748677531446035746.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <156077919546.433243.8748677531446035746.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 1/6] xics/spapr: Drop unused function
 declaration
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


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:46:35PM +0200, Greg Kurz wrote:
> Commit 9fb6eb7ca50c added the declaration of xics_spapr_connect(), which
> has no implementation and no users.
>=20
> This is a leftover from a previous iteration of this patch. Drop it.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/xics_spapr.h |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index d968f2499ca7..330448126223 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -37,6 +37,5 @@ int xics_kvm_init(SpaprMachineState *spapr, Error **err=
p);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
>  void xics_spapr_init(SpaprMachineState *spapr);
> -void xics_spapr_connect(SpaprMachineState *spapr);
> =20
>  #endif /* XICS_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0LPS0ACgkQbDjKyiDZ
s5K0zRAAvGvTpbq1J1lgdy3ooX2oVXMqyO40e1OhF16K8VB7HnHE17dehXC0/GcU
d/UKebnzZrHUPeja9jDm9cP3jS/e+TlvWDDj0Lnv0raiOx9mzcZVpv4aRgK3I/3/
AFZdQQzUyIvbO6Qr4kWarQ0mZJa3b84053I9p0N472buHfT0CTgIF07Cj72Abx0Q
plyv3BySTEKO3SpnTLnTgoYLnrftUttPcfTNkl/cUH0OinAY1MAOr1iaA1kAGNej
xO3Ts326xSaWUD5J+euQ8dGtLI/8RgFAfSWRTcIPHAplLUWAFCL6L/4seTvCAuE1
FPoHCiR9zsFFHvQjgP0TYPvzVf9nb4LZoept6BXahr0ZKEKO8EwqgkVQ1jdYqCvP
Tm3hs6mMaXXE18op36ol+bX1OryNAfObdT9QoknsT5IFUWqewYSaOxD5+wBgKCW9
94AHq2z5g3wRqNcvPLIDa3hsMnSKcwyRIAIhiAmLG4vIViL6iDdfyB/pLxzG3fV3
CuuAyV7pW2jqD8pISKATdR2CZmqBEHw4Skk10C6Itd49tANVNfp7vR3b2IsHl5Dv
oGujmq7qVjztC4IJjr6180LsQtgVUnPq1s4l/a2epF1yP86uFvH04w4iu4MNp5ls
sr5ZiYBDgnObpuuTjp7C+WzqfeZN1AdfJiUtIU3gjyscwDzUQgI=
=8Lta
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

