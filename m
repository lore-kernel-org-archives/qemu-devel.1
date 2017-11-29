Received: from eggs.gnu.org ([2001:4830:134:3::10]:54260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2pz-0001ck-6Z
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2py-0001eX-Ir
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:55:43 -0500
Date: Wed, 29 Nov 2017 13:55:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171129135539.GD4281@stefanha-x1.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/4] blockjob: introduce
 block_job_do_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:25:12AM +0100, Paolo Bonzini wrote:
> Hide the clearing of job->busy in a single function, and set it
> in block_job_enter.  This lets block_job_do_yield verify that
> qemu_coroutine_enter is not used while job->busy =3D false.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHrxbAAoJEJykq7OBq3PI6SkH/Rur4MxEuz4NrtPqYz4IOYSO
yxR/bzbsn7EKe8acmsvcxiSFD2hUkM1R9vbp2t6S8VF9EwbGKwAXj50xGlTVUdhq
p6xndmrPkIe+iKGvRWvPd9kj62gbgwL00t9RCF2IEtuIvot7S9EAZDwsF9V25p/4
Wpcly4VXi1vg1Xfqj52CpYf5QEN4NYt6Ozj/UaKO6o+qK85+62tJHNOICmaeqsUD
Sje0RSxBikN8rgY+bVlJlPIzc1ur6Zd2UOTixe0nPEeTv2jBhj8Dv/qvR3M+vq+O
AHbVh7UuYy8rbpr3ZAKHTz9bk89yzqh4d+Sg0XHU/dtfz9ux6IRzIWLeUyFRMoU=
=QcNX
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
