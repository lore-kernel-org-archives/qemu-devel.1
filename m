Received: from eggs.gnu.org ([2001:4830:134:3::10]:36202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTsB-0001rR-LJ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTsA-0001Ik-FC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:24:19 -0400
Date: Fri, 7 Apr 2017 14:23:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407132358.GC16146@stefanha-x1.localdomain>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] block: Fix unpaired
 aio_disable_external in external snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 02:54:09PM +0800, Fam Zheng wrote:
> bdrv_replace_child_noperm tries to hand over the quiesce_counter state
> from old bs to the new one, but if they are not on the same aio context
> this causes unbalance.
>=20
> Fix this by setting the correct aio context before calling
> bdrv_append().
>=20
> Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  blockdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY55LuAAoJEJykq7OBq3PIXNAIAJY8nwlRSEi+0mX3xGu+MzUl
+Se6ycSbjhcbrVXMss0OkdS3cH5+/RLSfXJo5JZuNgOhFBm9YwabDARBRk4vuaZJ
g23JxaLnacFsRiGneDnqchVm9OOH8KG/QsCASHJFiW+2Dpb0QQJ+yMXXf/9pp7Nv
UxqwCceXcfW8mx4+ZkO19RvD2Fp4gX7JunpeYiKrCGRkYa36FHOb04upjtFfPnWQ
X5/Z3qySPzlC3nVugbbwxpd4dukCvvBWeiVwZH3bvLCG2oIeD2ieJQRf6mgMehji
Al97EQs/MfpCNupkAVUZDHRjL1BCaB+HDEUC2zh2D/C9PlfKWaf9EoGV6ku14mU=
=n8Ai
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
