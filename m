Received: from eggs.gnu.org ([2001:4830:134:3::10]:51020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1didLw-0004fs-30
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1didLu-000722-UP
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:14:04 -0400
Date: Fri, 18 Aug 2017 16:11:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170818061149.GV5509@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<675e091387248b49c97ff99ef07eb23ed316aefb.1502643878.git.balaton@eik.bme.hu>
	<20170814044454.GG3452@umbus.fritz.box>
	<alpine.BSF.2.21.1708141258050.10227@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l/3WCmqZNZ+BnHMk"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708141258050.10227@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 11/12] ppc4xx: Export ECB and PLB
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--l/3WCmqZNZ+BnHMk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 01:06:42PM +0200, BALATON Zoltan wrote:
> On Mon, 14 Aug 2017, David Gibson wrote:
> > On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> > > These devices are found in some other ppc4xx cores too.
>=20
> Thanks for the quick review, hope more will follow for other patches too
> maybe also from others.
>=20
> > Elsewhere in the series you moved things that were used elsewhere out
> > of 405_uc, why not do that here as well?
>=20
> I've moved those because those devices needed to be modified extensively
> while these two in this patch are used basically unchanged (they may not
> even be completely correct for 460EX but seem to work well enough) so I've
> left them here. I could add this explanation to the commit message or may=
be
> move them to ppc4xx_devs to make it clearer that they are not only used by
> 405 emulation.

I think move them.  Probably to their own file - I think smaller files
are usually going to be more readable than one big file with heaps of
4xx devices.

> > > Also add some more PLB registers for 460EX.
> >=20
> > Separate patch for that please, it's logically unrelated.  Plus the
> > commit message should say what these registers are, where they appear,
> > why do we need them?
>=20
> OK. I don't really know what these registers are. I guess we need them
> because U-Boot or other guests poke them but they are only added to avoid
> the crash, not really emulated (just read zero, ignore write) for
> now.

Ok, so say that in the commit message.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l/3WCmqZNZ+BnHMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWhSUACgkQbDjKyiDZ
s5JPjw//SOki7rxilAfkfLLVjJ9sVDC8PY8DQUMFhpVyMIW9VR/9bKLeeCvHuwVG
MURMkrefKNtZmNKvmIQ4XILWoLr4rwv0ge3pz0OYWcO8ymZ+tzxAvQTe8zwzjX/b
/ArT52BZIvZYJQQrH7PPnAe3YDWWq+a9SCa2lU5FUs0tQbVy9b3eDs/LOfz12awn
9NSEgFw2wsSgTofDjLPfdP5kulFJeAtttZPvlcT21990AogwqH1W4jxsPfXmD41S
2sGmjXhxE0QVX7X3EIwedjFsL1UcawK6/hALjwVU/4on/KzTBKfD7k6gI1ZZnpco
RT1evNsWmhHCh8gF1PxYyHojHsiE+GJXV9W1MXVHci0ZRuC0pG1nRYings5iNjYb
RcbuzNPmKkBe1xgnMheAPDtlgoePbRmcj44kcsjSZYs8J/PWfONYBLUAvP8AQnZ1
hPgBVtQGN33ypf7rZaTdaEvor47aZq2KQMT0fwHo0LwDHos9ZHXW9aruULSZyZgZ
V8XHcBRxJGlIplh7Q+JM8RWkEIDj8WdRj+lk7diLjZ8eBnanqJkKMg2lg1z55lhH
5qNPhGN4pG6Vk6EgSl50ehieFc1qX1jGZxq4DAlJuu03J+fsnFiRrEl+owGHRqMN
UimlyfHe1TIUMSgJkZH50jeV/Lc5F5HcpPlePPd9dnNmBGch2RU=
=qRAl
-----END PGP SIGNATURE-----

--l/3WCmqZNZ+BnHMk--
