Received: from eggs.gnu.org ([2001:4830:134:3::10]:54609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk0jp-0000rP-Na
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk0jm-0007zq-JK
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:24:25 -0400
Received: from ozlabs.org ([103.22.144.67]:39007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dk0jm-0007xl-6x
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:24:22 -0400
Date: Tue, 22 Aug 2017 14:06:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170822040621.GB12356@umbus.fritz.box>
References: <CAFEAcA94_GuyZXRq_WSoD7No3h6AeHSJwbZoPdhRpiniJpdW6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TJ9V72hR/LoebVea"
Content-Disposition: inline
In-Reply-To: <CAFEAcA94_GuyZXRq_WSoD7No3h6AeHSJwbZoPdhRpiniJpdW6g@mail.gmail.com>
Subject: Re: [Qemu-devel] Any release-critical issues for 2.10 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


--TJ9V72hR/LoebVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 11:51:00AM +0100, Peter Maydell wrote:
> Last call -- are there any release critical issues for 2.10?
> If not then I'll tag the current rc3 as the final release tomorrow,
> so please reply here to let me know if there's anything we should
> be considering as needing an rc4.

Uh.. kind of, yeah.  I have some real-guest-affecting regressions from
2.9 that I have fixes for.  Sorry they're so late - that's partly my
fault, but then they were delayed further as I tried to do my usual
pre-pull tests by the change in boot-serial-test which breaks make
check on a ppc host.

I'm just finishing up my final tests now, then I'll send the pull
request.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TJ9V72hR/LoebVea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmbrb0ACgkQbDjKyiDZ
s5JHcw//ZTQeedwbzZcUBGIVXER+HnCgJTaN3k+b/qzbQW5F+9LKdZeHslZujHe8
bVfQqU+EubFA/t6er/sFRaeEtSfjat3jb9K+mTjr6ZjAWvGNhK3BQmIepyKf98eP
GjICU3mbrSBzaJ6k2cxR91MZPnM1lJHzIiBcHR26L93PlSjPtUY+jSx+MmZ8zW4E
ItCP3cycWMuI9UsDyFd06eKsDXJ4yVE8trnh8WmF/2ulrvZUJnTjYdVjI5Wkb9JY
ryL40wB6r26Wch2k5Xy3urnuoB1yd1uB/JXLgY26Y9L/eKnFv4n21actTfTIqpit
Nw7DeNWLCQ63NozKDySC7XEFWiKKjCJy+J3/Fy1N9JNwfkfk8H/uAFvxX4m2hnZU
xUDOmhoqorTk5UrKwIAEEIJOtzdMr/cuTAyuPmSjg29sai1amDrfXP5PU16n7qMC
0q5fA2FrlDXG65I+Be7HkkWnKb4yowCK33UkU8uLo0mNLwJXgJ6QpbvkYUMHgto3
zJSWNpZClzl8ewdNcaT8gLXGatcr03Q2QZ23s+/M3q0NnVtNiMlSEmiKgZx3X522
mXBGsS2IRcvd4X3utLAFaSYDStSzcN/A+3df5Heje2RXtMUgYl6R5BIlsYjZ1Zpt
2cA/oqXFVJLNVX5HkvNrGbwtL47if1wpmTovzkQCioUzScE7oQ4=
=TUcw
-----END PGP SIGNATURE-----

--TJ9V72hR/LoebVea--
