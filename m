Received: from eggs.gnu.org ([2001:4830:134:3::10]:58652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fONiz-0003Iw-9K
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fONiy-0003L7-ET
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:34:41 -0400
Date: Thu, 31 May 2018 14:34:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180531133432.GB799@stefanha-x1.localdomain>
References: <20180530194238.22774-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20180530194238.22774-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] main-loop: drop spin_counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 08:42:38PM +0100, Stefan Hajnoczi wrote:
> Commit d759c951f3287fad04210a52f2dc93f94cf58c7f ("replay: push
> replay_mutex_lock up the call tree") removed the !timeout lock
> optimization in the main loop.
>=20
> The idea of the optimization was to avoid ping-pongs between threads by
> keeping the Big QEMU Lock held across non-blocking (!timeout) main loop
> iterations.
>=20
> A warning is printed when the main loop spins without releasing BQL for
> long periods of time.  These warnings were supposed to aid debugging but
> in practice they just alarm users.  They are considered noise because
> the cause of spinning is not shown and is hard to find.
>=20
> Now that the lock optimization has been removed, there is no danger of
> hogging the BQL.  Drop the spin counter and the infamous warning.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/main-loop.c                 | 25 -------------------------
>  tests/qemu-iotests/common.filter |  1 -
>  2 files changed, 26 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD/noAAoJEJykq7OBq3PIzRYIALK6s1lfSmm7yIdzsasp7X9u
CI8fy6vEn4X3WDSdOet50M9q4boMPIgwZgWYn4rnX2ZMqGJlVP7veNXo21khanm9
1wUaD4C2LE2fjhSyC1HhJj3f9fwzVjE4iVnpFMndGfeWetpyzaVFn+h0t9UkrIKg
j8dtzIHTuelYDqNavPySqfJfec+Z3yXlo0mpEbb9FJoaM8E2Obd5FNlIj5mrEhLp
s5/NYdz9t+k4EMZf33rw/8GYo2PHGITJzbEOciQYyA4UIE4s8KO/5VY6Wgc6H8gk
uyeBb2Xrj9yEIjW7doyQ/EZdyMYhTda6U7v5p14cSXIFe13M+quWyVkgo0+VrB4=
=yscf
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
