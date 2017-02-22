Received: from eggs.gnu.org ([2001:4830:134:3::10]:54484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgYmC-00018X-EC
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgYm9-0006z2-3L
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:24:20 -0500
Date: Wed, 22 Feb 2017 15:24:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170222152413.GE10201@stefanha-x1.localdomain>
References: <20170217194028.8398-1-pbonzini@redhat.com>
	<20170217194028.8398-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <20170217194028.8398-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] iscsi: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 08:40:28PM +0100, Paolo Bonzini wrote:
> Now that all bottom halves and callbacks take care of taking the
> AioContext lock, we can migrate some users away from it and to a
> specific QemuMutex or CoMutex.
>=20
> Protect libiscsi calls with a QemuMutex.  Callbacks are invoked
> using bottom halves, so we don't even have to drop it around
> callback invocations.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/iscsi.c | 83 +++++++++++++++++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 64 insertions(+), 19 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYra0dAAoJEJykq7OBq3PIQecH/3Socz4ay6HKvX7hl9TIrRTX
mMjleeH75YaemjgA8O/dmDD8l+B7gIqVbb9oSDn67BNEC5eeGO0gDT3q72i9ETSb
n/SiE3ASGN09X/xG3CLEIlq9nDm9lpuzAheSBh2GS+R1yqOdkQCvfc6z1yxxdl8X
J/kgx871Clo6UUpxnOgdSpZNFiu1qgEO3FVz5LwSVPcGr22tG1cVW3eXlUH4e1kp
xIjTr/vObvLCjikQY7phzofa8uHpEi/nvBX545A0DMrdKRNOttUv/B5qb8hffiSF
gUeSTQ1kdI6yFqndwibWvN6sPTAhXhBGhODoLOXwQTA5R+9+HarnZ4IGbJ4Ta0U=
=JZsP
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
