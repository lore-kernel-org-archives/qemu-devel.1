Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ewqLk-0004pq-F2
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ewqLj-000530-Ni
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:28:52 -0400
Date: Thu, 15 Mar 2018 13:52:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180315135249.GC7015@stefanha-x1.localdomain>
References: <20180315034507.6341-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <20180315034507.6341-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vvfat: Fix inherit_options flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 11:45:07AM +0800, Fam Zheng wrote:
> Overriding flags violates the precedence rules of
> bdrv_reopen_queue_child. Just like the read-only option, no-flush should
> be put into the options. The same is done in bdrv_temp_snapshot_options.
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com

^--- please add the missing '>' when merging this patch

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/vvfat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaqnqwAAoJEJykq7OBq3PITbUIAKW3ueNc74msnGeIb4kaPuSg
AO8RcbhQ0uSF92l3YmX2LPs0Cey1QL7d9Nv6/7Xil7z4xXU2G16H9iv2nB0nFwOg
sDSDy1hH3KTkAIaYVsXW3APsjsFDzYtJh/n7bcb7oKOsiFqBbekph2PPiEADmIdp
Oli55cowuMFnDIEKFlCFvkoLZQxgqh6M13RSTrSieRM7MRusEjLLCeMfgBzukkyM
wIKU/u4VELyFmZNC66r+7YPX0b6CWdAoRPayO6p95rxCzbgoNiRDkrmEI9yOg1Sk
b3bauRquZOJZaoVd4FGERrAm/AEMetWprq5VxeOwjqLFjl1xAVsfyo09oFE/UeM=
=gVf1
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
