Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B279C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D312072A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 02:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KmAr/GdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D312072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOBQG-00085c-8s
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 22:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBN5-00035p-UZ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jOBN3-0003b6-Js
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 22:32:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45881 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jOBMw-0003RC-9w; Mon, 13 Apr 2020 22:32:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 491TxN29T5z9sT5; Tue, 14 Apr 2020 12:26:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586831448;
 bh=3/Xw54vw/w/PtyLjYDuN8rCsI7SEMGcyTcOiWJniLyk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KmAr/GdXzjCuTn57fzRzIBAEojD+Z8/hJlqKJyA0EfGjbWey8S3NESFLek9Q1JhiU
 M62OWCo0xl/O2s1msbGU1tAzKGcddGGX7CxT8bl4joMZL+ImnUrTut/r7n0SQmTGR2
 DRH3YtzNBzyzqeV/sEKyvT63TgdymX0dlckpPmEI=
Date: Tue, 14 Apr 2020 12:12:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v3 11/23] hw/pci-host/pnv_phb3: Add missing
 error-propagation code
Message-ID: <20200414021203.GI48061@umbus.fritz.box>
References: <20200412224144.12205-1-f4bug@amsat.org>
 <20200412224144.12205-12-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOmey7/79ja+7F5w"
Content-Disposition: inline
In-Reply-To: <20200412224144.12205-12-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BOmey7/79ja+7F5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2020 at 12:41:32AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Patch created mechanically by running:
>=20
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-host/pnv_phb3.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> index 57d717ed23..a9029f5a02 100644
> --- a/hw/pci-host/pnv_phb3.c
> +++ b/hw/pci-host/pnv_phb3.c
> @@ -1008,7 +1008,11 @@ static void pnv_phb3_realize(DeviceState *dev, Err=
or **errp)
> =20
>      /* LSI sources */
>      object_property_set_link(OBJECT(&phb->lsis), OBJECT(pnv), "xics",
> -                                   &error_abort);
> +                                   &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &loca=
l_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1023,9 +1027,17 @@ static void pnv_phb3_realize(DeviceState *dev, Err=
or **errp)
> =20
>      /* MSI sources */
>      object_property_set_link(OBJECT(&phb->msis), OBJECT(phb), "phb",
> -                                   &error_abort);
> +                                   &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>      object_property_set_link(OBJECT(&phb->msis), OBJECT(pnv), "xics",
> -                                   &error_abort);
> +                                   &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&phb->msis), true, "realized", &loca=
l_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1034,7 +1046,11 @@ static void pnv_phb3_realize(DeviceState *dev, Err=
or **errp)
> =20
>      /* Power Bus Common Queue */
>      object_property_set_link(OBJECT(&phb->pbcq), OBJECT(phb), "phb",
> -                                   &error_abort);
> +                                   &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&phb->pbcq), true, "realized", &loca=
l_err);
>      if (local_err) {
>          error_propagate(errp, local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOmey7/79ja+7F5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6VG/MACgkQbDjKyiDZ
s5Kj5A//flfCOAGrQZ4AQGWz+ImUTGrwmNeULxS4KBuYciYvnReneGKdVyjLIVAM
knHQZ+iRkW0ceFNvxIsAkfPINl3UHedgkQPAVK0atpWRWdl0T5HFGiBR66OOO5O8
YVi1+hL3bV5MAyHnZg/J7YdswPuJoJnZdeIQcFqen+5aO6xa+iVNWLi9aM7HwU8E
ynzoe+ZbxNHzDTxwK+pX6st0eEOzn6+FOlyJLSrbc6lwGVr07ZdBc/aH/eNLgM1C
lTNLOXiwqAij5U9l3QBfR52WFy/7RepWz+5dHkzgFYRZCF/EeTYNxXwwdRD7aLxR
O0YFI2VxAXffHEGf9OYELNbYoUO6+IK1YY3Q7U/l2f/MrsTFI0PULQL1LRXKEmsF
jT5KbYjtgqeezz8Qp9cqWOxVBUUyumXVjZiz7R5J0/OoF8SPidnunDroORf1Q6po
/1U+DWT8wi/+Z1z+04cW2VwNRbWmbaQgLAPPB3/SL7wvGCTWa7mbdapaVkyEJfHe
+4q88351waRSlmwFo6YDNTlbiVUdkwZQB3BuBI69OC5wXwWkRcl+bG/M4w09yre/
MgJWkIi9G1jxVMBVfGB63hfc8D+UiHkf4bUfZONwPFnxXp2gamBBvI7ZkuSzj31t
SvJD80PaT341DXvDvX30nQ8w3MdWFOwKxn2cBye13CeOLlfVF54=
=xhgF
-----END PGP SIGNATURE-----

--BOmey7/79ja+7F5w--

