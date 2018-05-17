Received: from eggs.gnu.org ([2001:4830:134:3::10]:44817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJFk9-00008n-2M
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJFk5-0008Kg-Tl
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:02:41 -0400
Date: Thu, 17 May 2018 11:02:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180517100227.GC18718@stefanha-x1.localdomain>
References: <20180511120823.7892-1-famz@redhat.com>
	<20180511120823.7892-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20180511120823.7892-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 05/10] file-posix: Implement
 bdrv_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, eblake@redhat.com


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 08:08:18PM +0800, Fam Zheng wrote:
> With copy_file_range(2), we can implement the bdrv_co_copy_range
> semantics.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c      | 96 +++++++++++++++++++++++++++++++++++++++++++=
++++--
>  include/block/raw-aio.h | 10 ++++--
>  2 files changed, 101 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa/VMzAAoJEJykq7OBq3PIqPYIAIpIXsGptmpAWUCNhc4RciEL
3wwscHc29RvqVuiNQzywTF3pvD8m/wvEAbexZDD4pe0e/HAiOBaJUg36AhX5/iY4
XCr7PWHsUR+ohgLpEz9qDiHy8xWzRXMZxFy3SrlrJwprY7NKqc5vbXYKyhPI7/q5
Xba0WDNbyH7F3nnZUVmPmSlyGtg3h2AYcd/xeIKtHGUlWrCyeTxH9u4eZcZHKV4s
01Km/NzNNGUWGc00eiiBMkcVRSacp9apKnfqoTPpHikJM4J/GLwVK9rxuLpPX9Go
5qchXw8SfkAEssckx+dq9PUUxOrM6QYjjKGDCnf7740Fah5IqDRRASr7cPFlym8=
=H6Uf
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
