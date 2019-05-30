Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B95C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 01:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35223243C7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 01:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qIcSxYnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35223243C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56021 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW9Rv-0000YW-0R
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 21:01:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hW9Qs-0008VW-MR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 21:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hW9Qp-0000oR-6p
	for qemu-devel@nongnu.org; Wed, 29 May 2019 21:00:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53995 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hW9Qo-0000l0-2e; Wed, 29 May 2019 21:00:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45Dq4m4Dwrz9s7h; Thu, 30 May 2019 11:00:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559178024;
	bh=5LHXgl9OJi34YOiH97XN7iEDHUqRZeXacKuiKsVzGfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIcSxYnIXNaSDrj6CpMkfZ+d3SRFafmSP+oAytEWOkS/LYH3txX0kMBz162ZOnHy7
	gzG1fnn8msi/9ZXsIM+/XZ8rTWOKW8xjaMs9XnyfJ2Mf/qPLJRyTJsDA2UbTnQ0OeY
	jHmQfH8ms9oHNfKPwtLj33/NBzClRextnlBBtd3M=
Date: Thu, 30 May 2019 10:40:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190530004049.GA2017@umbus.fritz.box>
References: <155915010892.2061314.10485622810149098411.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <155915010892.2061314.10485622810149098411.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: Improve error message
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


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 07:15:09PM +0200, Greg Kurz wrote:
> Every PHB must have a unique index. This is checked at realize but when
> a duplicate index is detected, an error message mentioning BUIDs is
> printed. This doesn't help much, especially since BUID is an internal
> concept that is no longer exposed to the user.
>=20
> Fix the message to mention the index property instead of BUID. As a bonus
> print a list of indexes already in use.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_pci.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 97961b012859..fb8c54f4d90f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1699,7 +1699,14 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>      }
> =20
>      if (spapr_pci_find_phb(spapr, sphb->buid)) {
> -        error_setg(errp, "PCI host bridges must have unique BUIDs");
> +        SpaprPhbState *s;
> +
> +        error_setg(errp, "PCI host bridges must have unique indexes");
> +        error_append_hint(errp, "The following indexes are already in us=
e:");
> +        QLIST_FOREACH(s, &spapr->phbs, list) {
> +            error_append_hint(errp, " %d", s->index);
> +        }
> +        error_append_hint(errp, "\nTry another value for the index prope=
rty\n");

I like the idea, but I think newlines in error messages are frowned
upon.  You certainly don't need the trailing one.

>          return;
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzvJo8ACgkQbDjKyiDZ
s5LzFA//eP19/eWm3ui7QDWYCMdCEqEYNcIBiHujmYtATEC8/wKuRpUHJkQMs0eS
bFnIV0yT/UrB8JUureFELec/UXLjhgxjgOAMipkoF4gSZ1Aj42PXedMH5Wp/M/oh
nwsvAUUIorXje9dWeurxXmWd5hx9Q2fclT/EPwaY218cc3JM1MXbGrsGc6576zwR
v1LQVmTzKiWN49BPuQeYcFuHEQjp1EDwsrJoixG5J2mI5BmLdtajh895Qe+Iph+Q
GV3U4bhFedtgGKOigpDKXoadOoaw9oDZQt1JJCtuRJww3D1/TmLi3ElVzek7Qrfc
VFjEbJ8aLwgc7YHTN/uOuNDp7sk9aulUb6wHhQ8Bd08m/BT1FIH4bfzX4xPtYSVL
TfUDriBhnwmg4McYzH92qry5GUwdO2VmcF/IWGrLOuByfKBab6PxatsxtV7bomim
dpJI2EcQZ/HEiCdczYmb/H+tkzIryigJXMbLflKWcQ0lE9WunAlxXK3MbL5kNLyp
3Tr9t2IkCERpzFXH9Fq2WtRVSzRUjYNEy7wVY23wxlFpPJ6CocjAp6Ma+MmHEZYs
GN2AAn0xCBgqII6dHa0SziHP6FLvyFziZxFK1ks+ZcgJyMiDtfwF0HcGOz2Xk5nX
3D4bufk0TsCp7NLfru9HFZauWFU4rhgXm/mQH3fQRCzBzy9XOZI=
=8r4/
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

