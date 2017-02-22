Received: from eggs.gnu.org ([2001:4830:134:3::10]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZqD-0000FW-SK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZqC-0003ns-V7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:32:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgZqC-0003ng-Ml
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:32:32 -0500
References: <20170222162507.25987-1-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ef09310-78f4-a6bb-84f5-bf66db7e6435@redhat.com>
Date: Wed, 22 Feb 2017 10:32:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170222162507.25987-1-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TEQJLmxnqkBt5xXcJV4AQQbRcDejg4wwJ"
Subject: Re: [Qemu-devel] [PATCH] hmp: add PC information for ARM vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TEQJLmxnqkBt5xXcJV4AQQbRcDejg4wwJ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <9ef09310-78f4-a6bb-84f5-bf66db7e6435@redhat.com>
Subject: Re: [PATCH] hmp: add PC information for ARM vCPUs
References: <20170222162507.25987-1-alex.bennee@linaro.org>
In-Reply-To: <20170222162507.25987-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 10:25 AM, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  cpus.c           |  6 ++++++
>  hmp.c            |  3 +++
>  qapi-schema.json | 14 +++++++++++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi-schema.json
> @@ -1277,7 +1277,7 @@
>  # Since: 2.6
>  ##
>  { 'enum': 'CpuInfoArch',
> -  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
> +  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'arm', 'other' ] =
}

Is it possible to document "'arm' since 2.9" somewhere for this enum?

Otherwise looks fine to me.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TEQJLmxnqkBt5xXcJV4AQQbRcDejg4wwJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrb0dAAoJEKeha0olJ0Nqq50H/0NrYWB2ZuNQ7JyHTwYee6Bj
vdbMeIEBZadrzG91tPZAQAGDUdovkzIIrDi5wZ1BCOSXP8lq5FDUtsaWk6TS944y
5OWJzO3YvM49SVWOpHfUILjrtlQP+OgCjNMKGCp5tCD7sLATvkT9vIidZbDlKX0D
QEUu1Phev6Ny86jgaSM8UxotlDlfe0BxakX7ij2+UKrXU6EXer0l5hCXtNmo3cBD
1B3InQEqBWn2b8lEobCFXFh9/h43GlcGnshSPn+WF2iPYuD/9ETbWzQqKbbhHpNL
NrOfFz6KSFZRDxChWjucLsIkmjF33Kel2Vd487M1bLrBWNtwc8Z8J1p/D3dsScw=
=8PKf
-----END PGP SIGNATURE-----

--TEQJLmxnqkBt5xXcJV4AQQbRcDejg4wwJ--
