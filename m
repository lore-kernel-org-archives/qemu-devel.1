Received: from eggs.gnu.org ([2001:4830:134:3::10]:47840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLMX-0007tR-4w
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLMR-0004hd-97
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daLMR-0004h4-0E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:24:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17B12C058EBD
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:24:18 +0000 (UTC)
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-5-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0edd3c83-ddcc-622d-5805-3e3a7788ad4d@redhat.com>
Date: Wed, 26 Jul 2017 07:24:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170726115637.21558-5-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UlqrV0U3Ja1FxnTFQpjPUvqH21kK8uqFh"
Subject: Re: [Qemu-devel] [PATCH 4/5] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UlqrV0U3Ja1FxnTFQpjPUvqH21kK8uqFh
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <0edd3c83-ddcc-622d-5805-3e3a7788ad4d@redhat.com>
Subject: Re: [PATCH 4/5] ui: add multimedia keys
References: <20170726115637.21558-1-kraxel@redhat.com>
 <20170726115637.21558-5-kraxel@redhat.com>
In-Reply-To: <20170726115637.21558-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
> Add multimedia keys to QKeyCodes and to the keymaps.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/input-keymap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi-schema.json  | 17 ++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)

> +++ b/qapi-schema.json
> @@ -4843,6 +4843,16 @@
>  # @henkan: since 2.9
>  # @yen: since 2.9
>  #
> +# @sleep: since 2.10
> +# @wake: since 2.10
> +# @audio*: since 2.10
> +# @volume*: since 2.10
> +# @mediaselect: since 2.10
> +# @mail: since 2.10
> +# @calculator: since 2.10
> +# @computer: since 2.10
> +# @ac_*: since 2.10

I wondered if this would work, but didn't mention anything on the
assumption that it built for you.  But now that patchew is complaining
about a failed build, I suspect your attempt at abbreviation here is the
reason.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UlqrV0U3Ja1FxnTFQpjPUvqH21kK8uqFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4ie4ACgkQp6FrSiUn
Q2rFuQgAltVWeAr0q05mH8H5YtmenlYXPBe9MD2mQBdyB5nVX1u+uZeNbOvI2/gp
0P6OOv0G8V2TQpOcCUFoDZeog4l8wrxdOEpdadGT5tySNPTr+ejsTjtmy4LRWFNW
KQWSDbKDXiEb8NHH6iNyNEOLHMHLwGVrs6lRa4OVzIAK4gi/8OYEdad7fAFYf/zV
zeKxYemWNn0SkanbxjxJm+hNpJHmEjntfYU2zqAxiEYeYb00272ueqwewI6ePQss
uBcGljGK0eAVUihjyWYOzm+47WmXaxhVRZ9mdbyT30W+Z6ysZTR60JouAdFW1p/g
Owq5IWeXnXy4MD6Yfdcm+6Cy+uqojw==
=IVy5
-----END PGP SIGNATURE-----

--UlqrV0U3Ja1FxnTFQpjPUvqH21kK8uqFh--
