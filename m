Received: from eggs.gnu.org ([2001:4830:134:3::10]:33281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY8ye-0001ru-AA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY8yd-0001AV-Gk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:51:12 -0400
Date: Wed, 27 Jun 2018 12:51:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627115104.GF5955@stefanha-x1.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
	<20180626142434.22090-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20180626142434.22090-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qcow2: Fix qcow2_truncate() error
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:24:29PM +0200, Kevin Wolf wrote:
> If qcow2_alloc_clusters_at() returns an error, we do need to negate it
> to get back the positive errno code for error_setg_errno(), but we still
> need to return the negative error code.
>=20
> Fixes: 772d1f973f87269f6a4a4ea4b880680f3779bbdf
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM3ooAAoJEJykq7OBq3PIT1IH/1UazoaZ5t0w/W/nmNqPzBbP
swFSQtxgNXC6Betd0yEYBpEGn5DL/dR6a6CBbKIonh7ly4pt6Kj21OtPy2Gf2TUm
MrQrXm1iTPq+3ALlS4vmpcCXABvIPUtuEepVDU0zvUp8scx995obiLgrunurllsS
j4uPTlP53y6NMCngxqxuaRVaBhFf3ceN3umYpuOlrLQTAjHGvlLayz29n8n8baNb
zTpTNcXmzP3n0tZj6u3ruqVovMb0vmDiaS1ovpYIkMT7ej2GMHz83BXdaUP58xSw
s+rhYgYgsR4GbKvUOBCnt8GVyQoLHCjS7dqVLtVBpDAV7QwiJpb0+yFoHMKngEg=
=SGvX
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
