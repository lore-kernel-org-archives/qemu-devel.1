Received: from eggs.gnu.org ([2001:4830:134:3::10]:57147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d1aqC-0004kI-9n
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d1aqB-0007Hl-Jg
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:51:24 -0400
Date: Fri, 21 Apr 2017 16:51:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170421155114.GC28249@stefanha-x1.localdomain>
References: <20170401155751.14322-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <20170401155751.14322-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC for-3.0 0/4] block: Add
 qcow2-rust block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 05:57:47PM +0200, Max Reitz wrote:
> The issues of using C are well understood and nobody likes it. Let's use
> a better language. C++ is not a better language, Rust is. Everybody
> loves Rust. Rust is good. Rust is hip. It will attract developers, it
> will improve code quality, it will improve performance, it will even
> improve your marriage. Rust is the future and the future is now.
>=20
> As the block layer, let's show our commitment to the future by replacing
> one of our core parts, the the LEGACY (Bah! Yuck! Ugh!) qcow2 driver, by
> a shiny (Oooh! Aaah!) Rust driver. Much better. My VMs now run thrice as
> fast. Promise.

This is actually a good exercise.

Did you feel like there were places where Rust allowed you to express
things better than C?

I like pattern matching, wish C had it.

Stefan

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY+ipyAAoJEJykq7OBq3PIqgEH/09+jov4sfMFlzqw1sSnhI58
hBxwKKRPXNcCeF2gKJotLjP6wyGufVGkiLzOzZYh+Le3wKu454lcNdEvcC8fdT2u
ztxm7fTz3JKAc78DIGWioVjvjEKz3h9D1AQfmzGtTnWf/W5DIpHdUEAz+8ME1WJ2
mqTt811k46wqVTgakOCIQMJv2TgBkQ3ZA1gbcsICKygbRcO2eZamEniJeQ8CA3zh
ZGQoMFBdaeIimaeC4fiwISpmKq57za0nbnxRzSFGCXc6fpqhVtvoRn/oDsHJSoM0
/bR4MIso8oqnPtrkeyC0t5RCYHsD202bwOMpKBCSJhYiekEGiRbDMy/e7nyq5Lc=
=Hy6D
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
