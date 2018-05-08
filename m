Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzpF-0004tL-Mo
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzpA-0005l8-LZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:26:29 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFzpA-0005kA-FN
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:26:24 -0400
Received: by mail-wm0-x241.google.com with SMTP id a137-v6so18565394wme.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:26:24 -0700 (PDT)
Date: Tue, 8 May 2018 11:26:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508102621.GF19710@stefanha-x1.localdomain>
References: <20180502100422.8688-1-peterx@redhat.com>
	<20180502100422.8688-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <20180502100422.8688-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] monitor: rename out_lock to mon_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 06:04:19PM +0800, Peter Xu wrote:
> The out_lock was only protecting a few Monitor fields.  In the future
> the monitor code will start to run in multiple threads.  We turn it into
> a bigger lock to protect not only the out buffer but also all the rest.
> For now we share the lock.  We can split the lock when needed.
>=20
> Since at it, arrange the Monitor struct a bit.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 53 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8XtNAAoJEJykq7OBq3PIHNIH/3FzfNhI9MsvYUmfeXvET7L2
ccTul7dpkm0+TZkaVrJSO5sgnYzQF0gT2Ro9LVR3edTIgtQkjNZASAsV5Ujr1wdf
2vmg3Ras7PaDAp+FkEQKV6HK9OfEWD0fw4t9AG1Z3WtNH7Ufg/qEfwOPDzybTinT
bY8uTDxtbZ1Vm1/JVXwy2LXEHsezd9vSx3/25ZUYYNMtu4A3xGdtAuPRZ8PHFi2y
icv7OxODkedJvFH9oJ7Kyx4AgsDl52lRMXEqKH/E5aDkOnVcl4y6lvxzBDfiDhmh
Ld3mY6N0IhtP14rErk9tTOIvnGG/s74hBQSntY/wze0QpiqPfDCekdr5WMf9wic=
=02X9
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
