Received: from eggs.gnu.org ([209.51.188.92]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1qLK-0002pO-8i
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1qLJ-0002kc-Jd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:33:38 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1qLJ-0002kF-Br
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:33:37 -0500
Received: by mail-wm1-x342.google.com with SMTP id a188so8640758wmf.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 02:33:37 -0800 (PST)
Date: Thu, 7 Mar 2019 10:33:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190307103334.GD2843@stefanha-x1.localdomain>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2019 at 07:12:33PM +0100, Paolo Bonzini wrote:
> lately I have been thinking of converting the QEMU build system to
> Meson.  Meson is a relatively new build system that can replace
> Autotools or hand-written Makefiles such as QEMU; as a die-hard
> Autotools fan, I must say that Meson is by far better than anything else
> that has ever tried to replace Autotools, and actually has the potential
> to do so.

Meson is gaining in popularity and I recently got some experience with
it.  It doesn't feel much worse or better than what QEMU or Linux have
for basic tasks.  For advanced tasks, I can't say.

One frustration is that any time the meson package is upgraded (when
your distro pushes an update) it forces a rebuild from scratch :(.

I think for 95% of people Meson vs Make will make little difference (the
syntax is easy enough) and 5% of people might be able to do more
advanced things cleanly with Meson.  Sounds good to me.

Stefan

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgPN+AAoJEJykq7OBq3PIvpUH/3hC0097PYfjcYOIogQYvMu6
Ib1lxUssiO6g8teb0Bn29Mk4FqLp4oLtcQrSv1fbGhJY5PsR1zHTTFSmKbjEG24X
T22N966qK76eoevO/KXKtZvfIC3V7yX7QJXsjFQQIv/Jrts8UM+y3tceBtYNzoRZ
/qmbbwFpU+UxVpfyQNVqx56wWAA7+Nwu50YBa6kfRSYpLztd8/WEdqh82ntbioy9
c2de2VBYS8EB4jPx2QQ5ZOF5VAS7LKitkyalLwHhs4nZ/MQO3d1rDwq2VJjUNM9W
3pDrwr3F4Ddi7z7Wb1ZlkRBqp1cf1OhFvIogKl18mU+iJI5zH5SabgMykcGMimw=
=ZZZB
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
