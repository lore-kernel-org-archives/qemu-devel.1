Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041C120828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UHZYabeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041C120828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9fZK-0002vn-4J
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fXz-0000NF-SH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j9fXy-0006oK-FI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:43:35 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:55973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j9fXx-0006k4-HC; Wed, 04 Mar 2020 20:43:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48XtnF35mkz9sPg; Thu,  5 Mar 2020 12:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583372609;
 bh=WnF4EbyTVEE98hFHp6dQ7kazdwVyphRJIl7npVTSmEk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UHZYabeEYyimAvKXFTeO2rYthqed4x4AZ/h9zdGAJ6FA9E8RqS2J1z00cxU4oZvy0
 YRzIWeWs6TiL5MMXBVnyAucJyv5q4r8JJ3XwXPJDHgyeqVSuRFZxPBl/BUIuNig/3/
 s/kvdpibuWkGPuFoJa+WGsvFa3AGlo/9Lx56mr9s=
Date: Thu, 5 Mar 2020 11:40:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/5] hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of
 sizeof flexible array
Message-ID: <20200305004003.GH593957@umbus.fritz.box>
References: <20200304153311.22959-1-philmd@redhat.com>
 <20200304153311.22959-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
In-Reply-To: <20200304153311.22959-3-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 04:33:08PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Replace sizeof() flexible arrays union srp_iu/viosrp_iu by the
> SRP_MAX_IU_LEN definition, which is what this code actually meant
> to use.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Applied to ppc-for-5.0

> ---
>  hw/scsi/spapr_vscsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 7d584e7732..7e397ed797 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -671,8 +671,8 @@ static void vscsi_process_login(VSCSIState *s, vscsi_=
req *req)
>       */
>      rsp->req_lim_delta =3D cpu_to_be32(VSCSI_REQ_LIMIT-2);
>      rsp->tag =3D tag;
> -    rsp->max_it_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
> -    rsp->max_ti_iu_len =3D cpu_to_be32(sizeof(union srp_iu));
> +    rsp->max_it_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
> +    rsp->max_ti_iu_len =3D cpu_to_be32(SRP_MAX_IU_LEN);
>      /* direct and indirect */
>      rsp->buf_fmt =3D cpu_to_be16(SRP_BUF_FORMAT_DIRECT | SRP_BUF_FORMAT_=
INDIRECT);
> =20
> @@ -1088,7 +1088,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_=
crq *crq)
>       * in our 256 bytes IUs. If not we'll have to increase the size
>       * of the structure.
>       */
> -    if (crq->s.IU_length > sizeof(union viosrp_iu)) {
> +    if (crq->s.IU_length > SRP_MAX_IU_LEN) {
>          fprintf(stderr, "VSCSI: SRP IU too long (%d bytes) !\n",
>                  crq->s.IU_length);
>          vscsi_put_req(req);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5gSmMACgkQbDjKyiDZ
s5IZ1RAAgfz6S9kTnMTqlbNjPqvK2ayGzrCDP5tD945SFHyy0RiWEcVaNCGxbeL5
iQnswbAA7RM0BG4qkbauMX+sLFnfU84suzVgWp4ptYyjEHCNFG18vsooPayfvZ/v
44Y2ZkyZetrSRS5lqZxsKeLgt2ldC/YGd+J7ZraIdikHyik60dqoZBnpgp7r6YVk
zE93CnuahHYKxPRZSeqrPaxVPyNQDGe5D/rIu19HmDygJ66sCFDxETFhEzXBvd7O
7zGEAHj1nnxVohF4wRMHRR60JeEjE5S5n2UOLCxcib7Zy8Llu2W7ABy9x8GpWraA
ydPqNYvJaG2WWwIz1ckAnfKJc22HSpTOJzqMPHX776qWe6+GsD3itIGz6gdEkRDj
1IcC2MHCH2I0Tpq73mlvm50cBjuQnKIBS/DuatkVLNl+c5ZbTo1xDptsDDmS53OM
QWixiy6EmpB9eCtpNp+ASBbzNSnzNPr/4EhrHLGurIHPBwU36ZH9OllbxNuIi3OP
GFNuO5b2ggcJ6kmftyworqGEVT9e/ByrMkEaUSvEIu2arhslRWWcPrjRhZ2VnkSP
8fgbyQIuKrBzmADzQI4pJb9YzbjPvENBxyEbNdp6Ua+v96MCPKzmu+WDTk7aIjyl
ckgiGsqlQTAAGi4APhWTz56cnyED6byZHcEKyoHa4OsTJm6VaBU=
=HE75
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--

