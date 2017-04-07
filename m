Received: from eggs.gnu.org ([2001:4830:134:3::10]:36346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTsS-00022S-0u
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTsO-0001S7-RO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:24:36 -0400
Date: Fri, 7 Apr 2017 14:24:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407132405.GE16146@stefanha-x1.localdomain>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] mirror: Fix aio context of
 mirror_top_bs
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


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 02:54:11PM +0800, Fam Zheng wrote:
> It should be moved to the same context as source, before inserting to the
> graph.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/mirror.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY55L1AAoJEJykq7OBq3PIqwUH/RCn94zNH5loxq6bLLWyesF8
j6PJEwirmEi7mXWbOsoFq8L1DzeF9SywIyqb++XJwFnU/zsicJEPAj3JWiFZOSd6
aeEjw3AdbsDUVgrYTf0eSh9XxMYijKWLDKb22riCqNjgyF1VH1BpElSPt3ZGOmy7
cf2sUBl4imeHcE67iYzCdRBlEROoYa2J+/cgibkv0zYyIS1Zo3WlUlK9tUGOkzsK
0xN9b897/cu3YJqE7bvITWSKWcN/cY8ZUq5QtEEWf3szvEheMyTZTOz+iN5dhmPl
XaLi+kz/oRrPsxMdAqB1VtAz5hx3R65+uM6rlK4cmeXzsevAub/pg3vYnjFuYnI=
=3TpY
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
