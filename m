Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B73C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C822082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hw4xeqbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C822082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdB3E-0003dj-QZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 06:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdB2R-00037N-3u
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdB2P-00054v-QK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:08:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hdB2N-0004t0-4C; Tue, 18 Jun 2019 06:08:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45SkL81x98z9s4V; Tue, 18 Jun 2019 20:08:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560852496;
 bh=YrBD7ULe6WGZEMhHFRhxf/8KKQ0lH7P15Do1TcHIWvI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hw4xeqbDWwX3y7TTAcfKQqATAMVKGOrsrgtyz2N+ehIQzZwqpqSS8H8PPHgn5YiGx
 ZAynTFzKt3qctQCFQwSLSQl2NnXHhK/dqj5mjMcl703JCifbQFlODJ9DhktZFi+dqK
 e3GtpA1NasOranVrR0DmWpU4pnhxEU8jJczQkM30=
Date: Tue, 18 Jun 2019 18:46:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190618084607.GD3673@umbus.BigPond>
References: <156084737348.512412.3552825999605902691.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <156084737348.512412.3552825999605902691.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: Fix DRC owner in
 spapr_dt_pci_bus()
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


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 10:42:53AM +0200, Greg Kurz wrote:
> spapr_dt_drc() scans the aliases of all DRConnector objects and filters
> the ones that it will use to generate OF properties according to their
> owner and type.
>=20
> Passing bus->parent_dev _works_ if bus belongs to a PCI bridge, but it is
> NULL if it is the PHB's root bus. This causes all allocated PCI DRCs to
> be associated to all PHBs (visible in their "ibm,drc-types" properties).
> As a consequence, hot unplugging a PHB results in PCI devices from the
> other PHBs to be unplugged as well, and likely confuses the guest.
>=20
> Use the same logic as in add_drcs() to ensure the correct owner is passed
> to spapr_dt_drc().
>=20
> Fixes: 14e714900f6b "spapr: Allow hot plug/unplug of PCI bridges and devi=
ces under PCI bridges"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.
> ---
>  hw/ppc/spapr_pci.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index fbeb1c90ee6c..2dca1e57f36c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1343,6 +1343,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCI=
Device *pdev,
>  static int spapr_dt_pci_bus(SpaprPhbState *sphb, PCIBus *bus,
>                                 void *fdt, int offset)
>  {
> +    Object *owner;
>      PciWalkFdt cbinfo =3D {
>          .fdt =3D fdt,
>          .offset =3D offset,
> @@ -1363,7 +1364,13 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, P=
CIBus *bus,
>          return cbinfo.err;
>      }
> =20
> -    ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
> +    if (pci_bus_is_root(bus)) {
> +        owner =3D OBJECT(sphb);
> +    } else {
> +        owner =3D OBJECT(pci_bridge_get_device(bus));
> +    }
> +
> +    ret =3D spapr_dt_drc(fdt, offset, owner,
>                         SPAPR_DR_CONNECTOR_TYPE_PCI);
>      if (ret) {
>          return ret;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0IpM8ACgkQbDjKyiDZ
s5KC9w//Sg9YZixEezj6YluTRt9z3cwb+Vad4xMzJiDkwhCFp5ajM+FQSYbz3pHt
vdD8p6eGb0wFaTOmNxvs1RQUvlx7kw3RV54j7ZYRljC9IZbTRweubC686m46Nlpk
p0e/4gu3oJ6F5MBpLs8WThjz5j2BindQVuAhngyO604HceeeKM63d5oIvMQQ9HSD
eaWcwr2kkW9OCWwSzRbJOFahJNaP8hI5Ne97MWFQA+W7Pd05E7TPKN3OeDMIXZkS
D1kQOWsBnGeZr8vvjmwDppQrMAXcES5nOFacFFXEiv2taPknfSWBQfEoFXZ9byK7
eoZJ8pTAc9s2ZTrV5R75cWK/GoQziO5u6fLkgGgQFOrQWPeMEATmJMmBOD9dhOXG
5WK1z8432fYNri2A4zO1sqaPRdmJbhCFQ9G+Vo3GMboX9E+LAv+rTRQI4bb9LJbQ
Y5/FUW3AltsSLo0WXADGj0vJn+2tuETx332NBXa0pLSXVt2pJt0At09M+1nVTif3
3pYYvO7qJbgMMp9jeahw4eM1i9jBWErkPMPiDvVUACTPNrvy5hfgbmKk5MNg2Tml
cvXfDRWbdEpSyumfuaNZKhmz0B+8n73CjDPWe/LA9ZWj4lRUfq3AMomKjwTpOgK+
7XM4ZjOnaJdGejDzDFNgHTGjNjBPPbFw8CHxcmMeN7/i0KAT4cU=
=I030
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

