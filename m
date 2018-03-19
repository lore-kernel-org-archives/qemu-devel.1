Received: from eggs.gnu.org ([2001:4830:134:3::10]:47001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1exqF0-0002js-RW
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 04:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1exqEw-0006w6-Ro
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 04:34:02 -0400
Received: from sauhun.de ([88.99.104.3]:54291 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1exqEw-0006vR-Kh
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 04:33:58 -0400
Date: Mon, 19 Mar 2018 09:33:55 +0100
From: Wolfram Sang <wsa@the-dreams.de>
Message-ID: <20180319083355.vw5cxkwyb4zihlcz@ninjato>
References: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
	<20180312214230.17561-4-wsa+renesas@sang-engineering.com>
	<5108cc9b-9fb9-d202-d4bc-a5c1dd4d4f76@amsat.org>
	<20180313201649.w44jtdbk4bow2f7x@ninjato>
	<f90bfd58-1f51-dc72-a67a-c0021345f9ba@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tvc27v433gqtec4q"
Content-Disposition: inline
In-Reply-To: <f90bfd58-1f51-dc72-a67a-c0021345f9ba@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] nvram: at24c: use a sane default for
 "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Michael Davidsaver <mdavidsaver@gmail.com>


--tvc27v433gqtec4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> > I don't mind much, but why? My reasoning was "let's first fix the cause
> > and then the symptom"?
>=20
> The '0' case is worst than incorrect, it segfaults, so you are right :)

Ok, thanks.

> >> Can you add a #define for this value? Such AT24C_ROMSIZE_MIN.
> >=20
> > Can do, of course. But won't that give room for regressions because
> > people are already using it with lower values?
>=20
> Your patch already introduce the regression :)

Not really. The current default setting (0) segfaults. This is how I
discovered it. So, there can't be any active user of that.

> I prefer self-explanatory #defines than magic value, but I see your
> point, so if we can not decide a value, can you add a comment to explain
> the magic value? I think the clearer is to add a #define with a comment.

I wouldn't mind a macro AT24C_ROMSIZE_DEFAULT and a comment explaining
why we chose this value. This is totally fine with me.

It was just the MIN value I saw potential usage regressions with.

> IMO there are too many AT24C eeproms to model, so the "rom-size"
> variable is the easiest way. Your patch #2 is simple enough to avoid the
> #DIV/0!

Fine with me, too. I will update my series accordingly.

Thanks,

   Wolfram

--tvc27v433gqtec4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqvde4ACgkQFA3kzBSg
KbZOHRAAjBMuJjj3SPYWkhYuHhpVGhOxnUIazf6rkz396XKFf+cuNgqSI4C7vDhN
xzDUBsDpYkGdxwtTup282x2yQbvuC155Og+B0qzACE/qlIsr1b5xDnFWISQp9DrQ
qfZjFnd9GYUVVqOz78IpB29oIed4R8vDkOZKv9wbmZxahVN5lpeVqrHm38aIsq4W
sZLIKbLwLe0KesTwBZjPDPRupstynPav4NLT1KWHW015PYI5wwXZXwHP7qq0D4vs
M4geyZ8hAhMOiyiPPZ/rIvggVNCicuri7mCyZg5KOLNnAu6wWgaBWfKAM7cozwqU
boXmyt/m4EJohPYeucqB0bfGqdj9FPNyGtP8iaqI4glE5YjdKA9YfsvQuHmVP2Kk
GsId0eznimI+Hg1Gce6uCBxocC7wwfp4LTfrQlY60sElCFhJdyOcDmoPS6K+P3Dk
T44WOH3rtiLUtdaRD2+j2ypzca8Agex4BRCQF2nQGyx1Fu2Bef7ZomI4vURt7j2V
iF71UsM+7HeQTHAC6r81K/QJd4Eya+aKQwc/XY5NKRw/SqIZ2kG0Tx6ESV/HLnQd
TUQcs0qKGUyK2HoLFDI85IVNxVK23zthnmrfYsYw8RP0hY/NXvPzCHgjh1x80omd
+T92dJ9x/Y0QQ3vfrxXAhV49OQVNZYk97oSi4yLzqqTOJ6KA8Ms=
=596v
-----END PGP SIGNATURE-----

--tvc27v433gqtec4q--
