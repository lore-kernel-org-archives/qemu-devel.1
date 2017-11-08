Received: from eggs.gnu.org ([2001:4830:134:3::10]:32864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCTwD-0001gB-Ue
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCTwD-0000pp-01
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:14:53 -0500
Date: Wed, 8 Nov 2017 18:14:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171108171441.GH30890@localhost.localdomain>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-19-mreitz@redhat.com>
	<w51o9okwtgx.fsf@maestria.local.igalia.com>
	<15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 18/25] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 02.11.2017 um 17:18 hat Max Reitz geschrieben:
> On 2017-11-02 17:11, Alberto Garcia wrote:
> > On Fri 29 Sep 2017 06:53:40 PM CEST, Max Reitz wrote:
> >>      QLIST_ENTRY(BlockDriver) list;
> >> +
> >> +    /* Pointer to a NULL-terminated array of names of significant opt=
ions that
> >> +     * can be specified for bdrv_open(). A significant option is one =
that
> >> +     * changes the data of a BDS.
> >> +     * If this pointer is NULL, the array is considered empty.
> >> +     * "filename" and "driver" are always considered significant. */
> >> +    const char *const *sgfnt_runtime_opts;
> >>  };
> >=20
> > Is sgfnt a common acronym? I actually had to look it up...
>=20
> I'm open for other suggestions to shorten "significant". :-)
>=20
> (Actually, I can't remember where I got it from.  I think I just made it
> up, but then I don't know why I didn't use sgfcnt -- maybe because cnt
> looks either like count (or like something else, but that's a different
> matter)...?)

Because in reality you were abbreviating "signifant"? ;-)

Anyway, I found the inline initialisation as part of BlockDriver rather
ugly. The places where you used a separate static const array look
much nicer. Maybe use that consistently in all places?

Kevin

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaAzuBAAoJEH8JsnLIjy/WBcIQAINMAhn/6fhUKhKSL7QyPLWg
+7Yh6VdpY0SGjzNIfc4rnMvrVot9MZSeK9IlfLkAl2x6VbDzrBGXXpJ7o/Y2ndeq
NXD6YwmyYTCb2z1GAVme6PbAEgTHBQdp7WkKAD/0KNUSTNJYvB4Qq61ZB+rGOrEY
70/s5PCkYqgicw5kAh60aalcfO5Qr65Ngzwww68IVYSy5J2aMAfRkhWhTbdg7LdI
JegOuhAL4Hofe1M2ZSt+tgFyrAZXE6t4H/T/q5RFL8EEpYHYUuL2npZcBBtLd6QC
BrTkj00Htq29K2U1A2OcdXO9DN07iJS2/0fFkoOVBNLCdIfsJJYSOmiVEgtZJZ3u
UT+FFyVe2pu86jOeZssa4dk/XSVkmbMynIXpzINH86KW7y8EbDlQhfx5hQByOBMs
sATZFfavtyEKm9wMDq/yaqIrlwvyAI6rN5z0Ace/UICy861JjCGnnmCoggbrMszf
R/pqZ/bIuqi8IGkg5XDxomcOHl8bz4E+Vua6Sp4leqA5pjCwLF+jpIoxBSdZXcur
9jyDcWf3lJqXQpKibsqYpev03xNKplRp5NJJylvBLhIYxXP5QLgaXJORTwrZJnbv
iIER9LQ9A2tNO0HfDwKCEfNPFHtRZDLGo1CdKu62DbwItT6UfLadOuZTPHKKl9Go
I4hzArfQ6ll8nXoG/imx
=ESHs
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
