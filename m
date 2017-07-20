Received: from eggs.gnu.org ([2001:4830:134:3::10]:39186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDkb-0003lJ-8V
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDka-0001lY-7w
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:52:29 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-2-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72303744-31bc-1c28-2d34-5926975b0b2d@redhat.com>
Date: Thu, 20 Jul 2017 10:52:19 -0500
MIME-Version: 1.0
In-Reply-To: <1500560441-5670-2-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MoEdw8t2BdcpcFCpLdEwJPocP7BNtWrrS"
Subject: Re: [Qemu-devel] [PATCH V4 01/10] specs/qcow2: add compress format
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MoEdw8t2BdcpcFCpLdEwJPocP7BNtWrrS
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <72303744-31bc-1c28-2d34-5926975b0b2d@redhat.com>
Subject: Re: [PATCH V4 01/10] specs/qcow2: add compress format extension
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
 <1500560441-5670-2-git-send-email-pl@kamp.de>
In-Reply-To: <1500560441-5670-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 09:20 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  docs/interop/qcow2.txt | 43 ++++++++++++++++++++++++++++++++++++++++++=
-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>=20

> +=3D=3D Compress format extension =3D=3D
> +
> +The compress format extension is an optional header extension. It prov=
ides
> +the ability to specify the compress algorithm and compress parameters
> +that are used for compressed clusters. This new header MUST be present=
 if
> +the incompatible-feature bit "compress format bit" is set and MUST be =
absent
> +otherwise.
> +
> +Note: Ommitting the incompatible "Compress format bit" results in the =
usage

s/Ommitting/Omitting/

> +of zlib compression with default compression level (default before QEM=
U 2.10).
> +However, this old default has a smaller compression window size which =
results in
> +lower compression ratio and slightly worse compression speed compared =
to
> +explicity specifying zlib compression with default compression level i=
n the

s/explicity/explicitly/

> +compress format extension.

If window size affects decompression, then we absolutely must specify
what window size is in use, both for the old-style compression (bug that
we haven't mentioned window size in the past), and for the new-style.
That is, if you have to tell zlib at decompression time what size window
was used at compression, then our choices for window size should be
mentioned in this spec.  Furthermore, if window size matters, it sounds
like it should be a zlib-specific tunable.  I really would like to be
able to document that having the extension header present with
parameters XYZ is the same as omitting the extension header (but that is
only doable if window size is a tunable parameter).

I haven't yet checked your code implementation to see where you are
setting window sizes, to know if window size is something that should be
a tunable in the file format.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MoEdw8t2BdcpcFCpLdEwJPocP7BNtWrrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw0bMACgkQp6FrSiUn
Q2rGnwgAlH01oydrAqGg4gmpFvNchgnWL2XSs9r4VmYsJ+Quc7c+xct8NNul4jpC
vubmRqWDTM4/w6Tfv9CtvHTDou32zY51EHBlfPod9dE83QIubjlNF2OhZF0FpC+J
gAmhknCv4Q8NTUWqXsIa0/a1W/+j13/vvujbe7cu1FHLmkyRUdBpdQXfSSnbSOaq
zfhgzk5fy2HNSwT95wcrziziLje+ToqeJ6nZ7gHcZiHbY75x/AuGHJnLruyMrQ4r
GvH9SuPY9baxLpy4ER6Hg3998J3SRFlUx40NrYzajNWVQf76gyc+DZ8QsgTTE86R
m+wdZP7EuEaWdfc0QJSzi8gJju31Wg==
=/gzq
-----END PGP SIGNATURE-----

--MoEdw8t2BdcpcFCpLdEwJPocP7BNtWrrS--
