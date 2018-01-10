Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZNI8-00051C-E1
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZNI5-0006lL-7d
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:48:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZNI4-0006kK-Te
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:48:05 -0500
References: <20180110202553.31889-1-stefanha@redhat.com>
	<20180110202553.31889-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58936cc4-19e7-ce86-1552-7edbe5b648da@redhat.com>
Date: Wed, 10 Jan 2018 14:47:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180110202553.31889-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RPC0LYi4aMMUkJreXQ9VJtX43LAXhnAEC"
Subject: Re: [Qemu-devel] [PATCH 1/3] tracetool: prefix parse errors with
 line numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RPC0LYi4aMMUkJreXQ9VJtX43LAXhnAEC
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <58936cc4-19e7-ce86-1552-7edbe5b648da@redhat.com>
Subject: Re: [PATCH 1/3] tracetool: prefix parse errors with line numbers
References: <20180110202553.31889-1-stefanha@redhat.com>
 <20180110202553.31889-2-stefanha@redhat.com>
In-Reply-To: <20180110202553.31889-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 02:25 PM, Stefan Hajnoczi wrote:
> Include the file line number in the message that is printed when
> trace-events parse errors are raised.
>=20
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__=
=2Epy
> index 0670ec17d5..fbccaaa0cf 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -300,13 +300,18 @@ def read_events(fobj):
>      """
> =20
>      events =3D []
> -    for line in fobj:
> +    for lineno, line in enumerate(fobj):

If you use enumerate(fobj, 1) here...

>          if not line.strip():
>              continue
>          if line.lstrip().startswith('#'):
>              continue
> =20
> -        event =3D Event.build(line)
> +        try:
> +            event =3D Event.build(line)
> +        except ValueError as e:
> +            arg0 =3D 'Error on line %d: %s' % (lineno + 1, e.args[0])

you could avoid the +1 here.

Up to you; either way, the patch is an improvement.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RPC0LYi4aMMUkJreXQ9VJtX43LAXhnAEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWe/0ACgkQp6FrSiUn
Q2o9Ggf+N4Fwx2TQIt3gxMXy3Q8Tfe371YkXP6fbMvU+B1/bDYTgQlF8Bn5cNo+9
47CSI5lwEDxHJ7T10+zkgqQ5bMctZnMlFIqo1XBCLRoPWSLomm5o2UYpdwiyKY6v
nkQWCmjwZYKtpdS8kT8RzN58slkP/hMojH/N6T61O41fMl2eha7M3L0cMXlfL+Uh
YLbrLHPJJCaB7jS1Ka/5AWDTExB0ETl8OG5kBhqXAioFmXBkH79w1Vj2aBaMNgWp
nesABQOa3f5fcwgMkjJWlzBjElbhSEQJOtmSrr3YozhZccjEHG9qoG/TwGJxty8E
1OVRDJRuLG8vnIHMgiHvwrfDbOKI0Q==
=etpR
-----END PGP SIGNATURE-----

--RPC0LYi4aMMUkJreXQ9VJtX43LAXhnAEC--
