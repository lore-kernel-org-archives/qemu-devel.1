Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11360C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F682173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JkJI+eCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F682173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzUT-0003Iu-7v
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSx-0006t0-E9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSs-0004DR-0U
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:31 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnzSq-0004BF-S1; Thu, 18 Jul 2019 02:00:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q3QB5TVCz9sNH; Thu, 18 Jul 2019 16:00:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563429618;
 bh=TGl9aGNMWCj3W7fGG/aGc+knLslW4zzipWE0COgEYgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JkJI+eCTCgnY5qu5Cz56RZRwP3WI7IBidruFEjYqWJt2Mey8p7EKMmRKHqcIFzQLd
 Q9v0zhlZkYCmSHMFKZmJ702I3EX4lIJFbnQZttwD4JoSUepQlkMckbeKyTMKyhSRQ6
 rT+NyND1zuN4/LMxeG4/ZAvIyTOQgtd0Cpz3ak4k=
Date: Thu, 18 Jul 2019 14:20:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190718042008.GG8468@umbus.fritz.box>
References: <156335150620.82682.9535735857478533420.stgit@lep8c.aus.stglabs.ibm.com>
 <156335159028.82682.5404622104535818162.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <156335159028.82682.5404622104535818162.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 2/4] ppc: fix memory leak in
 spapr_dt_drc()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 03:20:01AM -0500, Shivaprasad G Bhat wrote:
> Leaking the drc_name while preparing the DT properties.
> Fixing that.
>=20
> Also, remove the const qualifier from spapr_drc_name().
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr_drc.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index bacadfcac5..695a0b2285 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -226,7 +226,7 @@ static uint32_t drc_set_unusable(SpaprDrc *drc)
>      return RTAS_OUT_SUCCESS;
>  }
> =20
> -static const char *spapr_drc_name(SpaprDrc *drc)
> +static char *spapr_drc_name(SpaprDrc *drc)
>  {
>      SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =20
> @@ -827,6 +827,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner=
, uint32_t drc_type_mask)
>          Object *obj;
>          SpaprDrc *drc;
>          SpaprDrcClass *drck;
> +        char *drc_name =3D NULL;
>          uint32_t drc_index, drc_power_domain;
> =20
>          if (!strstart(prop->type, "link<", NULL)) {
> @@ -856,8 +857,10 @@ int spapr_dt_drc(void *fdt, int offset, Object *owne=
r, uint32_t drc_type_mask)
>          g_array_append_val(drc_power_domains, drc_power_domain);
> =20
>          /* ibm,drc-names */
> -        drc_names =3D g_string_append(drc_names, spapr_drc_name(drc));
> +        drc_name =3D spapr_drc_name(drc);
> +        drc_names =3D g_string_append(drc_names, drc_name);
>          drc_names =3D g_string_insert_len(drc_names, -1, "\0", 1);
> +        g_free(drc_name);
> =20
>          /* ibm,drc-types */
>          drc_types =3D g_string_append(drc_types, drck->typename);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v83gACgkQbDjKyiDZ
s5LXTxAAsB7w6SzOQTZQRYVp8GF2K7Iz+usYbe0r512IKOspRnbF9BEL3Wm92vvB
SqlGwLZb7O9E4ozOxiwSPSEMLgI1M7AmarJjg+40qMkiHPckbh1giPBd3arwpav/
L2kSez4kBP8wBYXocIKHZoqQsUzQ/H7G6oKhbJW25MoWnthuJ8r4CJkdCHlXcX9O
Zprs2VA90U1dZbJyJb217zvNYOIT/m8h3Z9Kb1D4cpJ+9xMEC1KIejA6HmMTUleb
6NyvrFCKFwydnf/dTcDihu8BGlkpLFc1QKq0LJ8NpocSe/7M37ckZwgXb43j9y2u
94B8v+b+g1OYQQaZzzvxkvma70Dp9GuUbRODLNy3bTiRukgBHmTa/8S/HCPG0PEI
tWFQD49aBXt0pQza2oT3HqpLgRDoVUjh91PsxYdVa79RSAo4UrT0NNp0OQQW1w9X
tRSAdTtsec9cTaYnjHvkmzSb9kDlxGCCPj7uoqZnfKZdoZVZJ3DfJzOV9G7vBdTP
DglZBqpt+iznfxR46956EXaBjh5W7aB/by0U3ej1MGNzemDWAjEsJ94d9POaCLy/
RLRoRK9ZiSYhf/Eia/YDcxb8fhx7xmxsh+3ySy3veKD+p3eRWLXzDpGfp2bUrfV4
Zfkn+Cxjs1fUxOofsnLFat9+vNjY0ieVniXFGuMSLI3LycPiXQA=
=0eBd
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

