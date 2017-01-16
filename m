Received: from eggs.gnu.org ([2001:4830:134:3::10]:33488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTAtY-0007tv-PP
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTAtX-0005LF-V0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:16:36 -0500
References: <20161201020508.24417-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b2b5e83-a875-745e-4f19-6f9e53f3b9a0@redhat.com>
Date: Mon, 16 Jan 2017 18:16:22 +0100
MIME-Version: 1.0
In-Reply-To: <20161201020508.24417-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SmQGTjDxe5haAXotj2PwdcvJUaxLSdCbi"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Improve commit invalid base
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SmQGTjDxe5haAXotj2PwdcvJUaxLSdCbi
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9b2b5e83-a875-745e-4f19-6f9e53f3b9a0@redhat.com>
Subject: Re: [PATCH] qemu-img: Improve commit invalid base message
References: <20161201020508.24417-1-mreitz@redhat.com>
In-Reply-To: <20161201020508.24417-1-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.12.2016 03:05, Max Reitz wrote:
> When trying to invoke qemu-img commit with a base image file name that
> is not part of the top image's backing chain, the user receives a rathe=
r
> plain "Base not found" error message. This is not really helpful becaus=
e
> it does not explain what "not found" means, potentially leaving the use=
r
> wondering why qemu cannot find a file despite it clearly existing in th=
e
> file system.
>=20
> Improve the error message by clarifying that "not found" means "not
> found in the top image's backing chain".
>=20
> Reported-by: Ala Hino <ahino@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Reported in: https://bugzilla.redhat.com/show_bug.cgi?id=3D1390991
> ---
>  qemu-img.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to my block tree.

Max


--SmQGTjDxe5haAXotj2PwdcvJUaxLSdCbi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh8/+cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUToIAKlA8GPdrkL4aOnXT7tpgM70zrU8vAcJ
diJBlEOGE91WXXGXY8zizYo/5MaWMFZAqYE6G0SDFRyJlMANt4rPQftMJqMu6qal
JCGSCKdDf3KCZKoZK70u0lXt00yPiadJqUi5pgaR+d8MCU1ikHv3fNkIgWyqvEFS
wQmHrQsFGEEcKmcIYXxcNfsGsflzp+cFvEurOsEw/yLJyrQdCRL0YUpH7KpOwPo2
YWwODzLAbBAqFVVz7m01Pn5pUkij5d28ylMFPyAj3Sre74xczS7PfjORuhxYTuS8
fG+c/iqHdMezD0NOyEwdqq1U284p16DLFHYEwR7iICxDm88HpAiwZYY=
=2zXb
-----END PGP SIGNATURE-----

--SmQGTjDxe5haAXotj2PwdcvJUaxLSdCbi--
