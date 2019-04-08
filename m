Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB8C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DD220880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bD92bhxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DD220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDLwj-00060p-SH
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 00:31:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuP-0004QW-UQ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuO-0007bg-7a
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49581 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDLuM-0007XM-4w; Mon, 08 Apr 2019 00:29:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44cy9f4fwbz9sRN; Mon,  8 Apr 2019 14:29:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554697750;
	bh=wnPWOJQ4ibXm4fuiJVn2DfViClOMnHLsMQAypyN1EjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bD92bhxi9UDlz0M6dQ4nXrH2QisyfzH8B6cnVwFbWj1vs+DhCTLmBZRXPJoPyVTtp
	+warO/eKOCuYtK5X2huSQNREFOPRXcWvYoLWgseJ07i/C1UY5S86nBd7e+IuGcSyAv
	j7A42yKrAjIHacmW+GHAS5Nbgw7XF0vO1s6R7t24=
Date: Mon, 8 Apr 2019 13:38:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190408033807.GA16627@umbus.fritz.box>
References: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/2] spapr_pci: Get rid of
 duplicate code for node name creation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408033807.ADyB5JgoPiGkSL7zloIqmGDLCxIDu1s04RJlqEuNv4I@z>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 06:30:43PM +0200, Greg Kurz wrote:
> According to the changelog of 298a971024534, SpaprPhbState::dtbusname was
> introduced to "make it easier to relate the guest and qemu views of memory
> to each other", hence its name.
>=20
> Use it when creating the PHB node to avoid code duplication.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_pci.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bba3a86dda6c..c70688a0dc23 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2153,7 +2153,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
>                            uint32_t nr_msis, int *node_offset)
>  {
>      int bus_off, i, j, ret;
> -    gchar *nodename;
>      uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
>      struct {
>          uint32_t hi;
> @@ -2204,9 +2203,7 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
>      Error *errp =3D NULL;
> =20
>      /* Start populating the FDT */
> -    nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
> -    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, nodename));
> -    g_free(nodename);
> +    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, phb->dtbusname));
>      if (node_offset) {
>          *node_offset =3D bus_off;
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqwh8ACgkQbDjKyiDZ
s5KN9BAAs2JgwksKr6qPTrjmOSg1wlaRXEkCsDjpGDI4hLG9Zq02+wEqd1yMGREj
klItwF16q0ACko85Tk5UNyvT2+MEtvnQGQ+fh80sEIieeT3JJwDzRNMaU+Q7c6c+
D9Tj7h2KXguKW3TSdJaSCZXps278aQHM3RBZi3/L2cpqIv56LBO76FpGtFbCG5ye
aJ+ti2XU0Nn9NlWZ3Msm44Dje8AhboUqCUPQ5b87prJ6e4ymkorGAI45o7wrRHPm
hVmwg7JGwEzz4S8W2LUdcKJDQl2zsd7wF1JvQhdsBD6oyLrdsuY37MW2uEkIKITs
xJLAAyFQZ3+YKZOSVS5zUh512fc51DQK0Wvpj7QmagndVbu8W4ge1hg0sXI/MbVA
jPsd8ck+T7N7TSBJe/lbV/m/jF+00dtXzathq3l1Ow02Dxz+ZT+o/BilDg0aqPa7
JX9zle6XAf0t6CeGQtbptu2eczwt5IXKobDEr3FPXo5HhTg4AH+xHPhRFAQ8iJZL
F5uq2IA65J7c+1ftOU06meyE7n64QSCvppjYXE2M9Ngq8gCHuDnqGmYku3wu4SRY
BN4Kocx/fN/OjFYbC+J4QMJg4s5OYn0caMUAz8/pyP+ipucGE1QxTBiVJjSfUdfj
WNbPBTjNEdA6+K/G08p931lcQg+H3NNurqBwf7KkE+Vcku0otwU=
=jfao
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

