Received: from eggs.gnu.org ([2001:4830:134:3::10]:58198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2wo-0001QU-6w
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2wn-0004C0-Gm
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:41:58 -0400
Date: Wed, 31 May 2017 13:41:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124149.GT16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-20-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bxF9Dep5HzwGj9mC"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-20-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 19/29] qed: Add return value
 to qed_aio_write_main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--bxF9Dep5HzwGj9mC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:00PM +0200, Kevin Wolf wrote:
> Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
> just return an error code and let the caller handle it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 55 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bxF9Dep5HzwGj9mC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLroNAAoJEJykq7OBq3PI0p4IAIPIy1t8VyaWSkpA1LPUyVIi
yYnsYtKLqsL9hcBef7ISWQgOcYAdTl4rIijXFB3spLyDWJwaE2X2Wy9jUwfkQqnh
O26/Wqju366aIQ1AgrL5XRjqBQZhtxfPtoeXnWyrpw2Sp7w48ubwlJb4SmzIUsmw
WJbd3lSMg+nurCSD2vGOLLlBPqjFP9NMDRYLfUTEXDiJgszUYsWm2H+vt4XYpgF0
NVWwwX/yhcoven+z/+MlX6lYM2c0DsohRblX4GWxNaSFVfl5ICmabvmOmmRqWu3H
ShgwebwMyHDbX+d8PHKHPs+X9Immdr71Rs2yZxeln+j/psxSmRw7KTVxKdfuVMk=
=2W5/
-----END PGP SIGNATURE-----

--bxF9Dep5HzwGj9mC--
