Received: from eggs.gnu.org ([2001:4830:134:3::10]:59099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe1A-0004oi-Uk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe17-0000JR-44
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:04:08 -0400
Date: Tue, 16 May 2017 16:03:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516150347.GM8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-16-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/18] migration/block: reset dirty bitmap
 before reading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:42:05PM +0200, Paolo Bonzini wrote:
> Any data that is returned by read may be stale already, the bitmap
> has to be cleared before issuing the read.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: new
>=20
>  migration/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxTTAAoJEJykq7OBq3PIztQH/00K699nJ7kK8g4Vm1aX6v/D
rGaFH+HX7qkFGsHR9XAPQFO/PEgg8x4U2eekK0DgbbO6sfNtg+sUMOVOd5p1xBw/
zEPwoWKsPXQeuIGdPAyL/RD7w0GNEf+LGKLGSC6XZ0ipDkom6icbgRGCHrwtn2+o
OgA1LoW4hfx5sxVaXmoZA+bJ7eNXMqTgWqx3qzTFTxzsVh8wEhE6F7PMfkXZo/99
2vN/CoqEQmtrYf5GIuEtejl28wsmwAINXfdLI9PjV5W09n99RxNtHjI1PVbvG+cR
OgWnopj01BWlNqLynLXdNMI6pOgX+hcJ/p3lHruxvkPckuWNbx8CYuTxBSptqG8=
=bW9D
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
