Received: from eggs.gnu.org ([2001:4830:134:3::10]:41601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePC86-0003nf-Tv
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePC83-0008CW-0n
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:51:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePC82-0008Bw-QN
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:51:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A993916AB
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 18:51:37 +0000 (UTC)
References: <20171212141859.3761-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7da517ca-5671-7832-18cd-8ecc7ea49544@redhat.com>
Date: Wed, 13 Dec 2017 12:51:35 -0600
MIME-Version: 1.0
In-Reply-To: <20171212141859.3761-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D4i3bPRphrlWuHoOrfagA80NeHn6MLP0G"
Subject: Re: [Qemu-devel] [PATCH v2] docs: update information for TLS
 certificate management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D4i3bPRphrlWuHoOrfagA80NeHn6MLP0G
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Message-ID: <7da517ca-5671-7832-18cd-8ecc7ea49544@redhat.com>
Subject: Re: [PATCH v2] docs: update information for TLS certificate
 management
References: <20171212141859.3761-1-berrange@redhat.com>
In-Reply-To: <20171212141859.3761-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2017 08:18 AM, Daniel P. Berrange wrote:
> The current docs for TLS assume only VNC is using TLS. Some of the info=
rmation
> is also outdated (ie lacking subject alt name info for certs). Rewrite =
it to
> more accurately reflect the current situation.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Changed in v2:
>=20
>   - Misc typos (Eric)
>=20
>  qemu-doc.texi | 368 +++++++++++++++++++++++++++++++++++++++++++-------=
--------
>  1 file changed, 275 insertions(+), 93 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D4i3bPRphrlWuHoOrfagA80NeHn6MLP0G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloxdrcACgkQp6FrSiUn
Q2pyXAf/S51690/0LbkVkehhrN/oC/2wF2cVExdQ8OXtxiF0vhLpoVJoa2FTFuhS
7dgbVY2MVyA465ahuGq5QFbwhHEMT3I2odwfg8vN9PZELo633D7BFb7mL7D2aCk6
d2mRvZaTlgdCtpBVI4RWbKmUA/XzkY8iymyCThCBITn1f+zJsEZ9qabDgi0eSbxT
8INJEoicBc0WWTB59PrGN0NwRdLjI7hUaCvfciuZAEatxCUKd3EZsqy4mulg1hvB
3MQoJ58hgcpO2Ix60OZenBLdaVw6VKgUjrp0aHcXqG4xr/VY8hhTsw1GHcKTIwAn
eM9RG4slIGZE42xJUPeo6x5Ta15A2Q==
=Q94j
-----END PGP SIGNATURE-----

--D4i3bPRphrlWuHoOrfagA80NeHn6MLP0G--
