Received: from eggs.gnu.org ([2001:4830:134:3::10]:33254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daL1m-0000VP-Dk
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daL1l-0007ys-Ev
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daL1l-0007yT-6Y
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:02:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0E81806B4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:02:55 +0000 (UTC)
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-5-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85e9156c-1a11-4757-996d-877e40e316bc@redhat.com>
Date: Wed, 26 Jul 2017 07:02:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170726115637.21558-5-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wij9unXfUpLuBRhfNPvQ51UHEkjw0ixdv"
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
--wij9unXfUpLuBRhfNPvQ51UHEkjw0ixdv
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <85e9156c-1a11-4757-996d-877e40e316bc@redhat.com>
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

Borderline between bug-fix and new feature (arguing that the bug is that
we don't represent all keys).  Does this need to be 2.11 instead?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wij9unXfUpLuBRhfNPvQ51UHEkjw0ixdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4hOgACgkQp6FrSiUn
Q2pV4wf8DZRbprFiI9miCoOo735VHF5hPOvecmPupL0sA+5lfagfaEjgF37KDi7k
0dqtsX0yagZRZJEPcgsTmusRuLT+Ko1zqzXspl/mhzcUJYGWAeycURzm9wV1PpbP
7WGAjcDtWUXC7R1UYSOOPRd0nDLtbvZPZm1CeRwFlEbvxLK85OKdKbv5075hONnj
eEInRFQW9NEM5wIJvb5xdr9d8uB5ZlJbscIJpfX59QXuxanJVGstmXINhVEoWr1P
f2G0JUlQpCzGx5/lvxURDZoXjVpu5yN4x1uWiDX7+gybDoDzYs9sEsl3pVR6E+Ob
zjwVc36qYJ+eJenG/LHbN1KGtPqU4g==
=QcDW
-----END PGP SIGNATURE-----

--wij9unXfUpLuBRhfNPvQ51UHEkjw0ixdv--
