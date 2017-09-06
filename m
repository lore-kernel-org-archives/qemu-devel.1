Received: from eggs.gnu.org ([2001:4830:134:3::10]:49674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpVlt-0001kC-Oh
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpVlk-0005Ar-7D
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:33:17 -0400
Date: Wed, 6 Sep 2017 10:32:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906083256.GA3753@dhcp-200-186.str.redhat.com>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-7-el13635@mail.ntua.gr>
	<20170905161643.GO4633@localhost.localdomain>
	<20170905190621.GQ4633@localhost.localdomain>
	<a861d95e-553c-4797-486c-2601c2b6e17b@redhat.com>
	<20170906082622.7idtvai3xpclicrg@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20170906082622.7idtvai3xpclicrg@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 6/6] qemu-iotests: add 184
 for throttle filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.09.2017 um 10:26 hat Manos Pitsidianakis geschrieben:
> On Tue, Sep 05, 2017 at 04:13:39PM -0500, Eric Blake wrote:
> > On 09/05/2017 02:06 PM, Kevin Wolf wrote:
> > > Am 05.09.2017 um 18:16 hat Kevin Wolf geschrieben:
> > > > Am 25.08.2017 um 15:20 hat Manos Pitsidianakis geschrieben:
> > > > > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > > > > Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> > > >=20
> > > > Does this test actually (still) pass for you? I can't see that it's
> > > > related to any recent change in master, but this is the diff that I=
 get.
> > > >=20
> > > > I can update the reference output while applying, but obviously if =
it's
> > > > currently passing for you, it will fail after I "fix" it.
> > >=20
> > > For the record, we discussed this on IRC. The test works correctly on
> > > master, but on my block branch there is a conflict with "block: pass
> > > bdrv_* methods to bs->file by default in block filters".
> > >=20
> > > The correct action is to merge this throttle driver series after the
> > > conflicting patch because throttle doesn't implement .bdrv_get_info a=
nd
> > > needs the forwarding that the other patch implements.
> > >=20
> > > I updated the test output accordingly and applied the series to my bl=
ock
> > > branch.
> >=20
> > Could you also squash this in to 5/6? (as long as we're intentionally
> > basing throttle on top of defaults, then we should use the right default
> > instead of duplicating things)
>=20
> Yes, this change makes sense, if it's no trouble with Kevin.

Already done, I was just waiting for your opinion. :-)

Kevin

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZr7K4AAoJEH8JsnLIjy/WKyIP/ijB0DeEx7w/dSR5ifH642xV
iJQkZ7W7BKHn/ZM5RkmBt3HW2qAQaKwJN2dkcfGzLQOgQwfi7zsCBYDwTDhEVSLI
QRgpeXUq0jUc32rxEQk91OmeImpnEHFucUAnUkx65/7729mhl9OIUNXtluSJuHKY
SyiRs32hwdn11UdQ2UtnQazuUcmg0GMMDWXIeOH7VAdsSMai3Zbnvhra82gIh+ls
S4Fn3F3gs/XlH97vsqRSblEY1qq5Pu7E2vvXRQyJ4ryiM8q8vmlt7EnNuTGaqO1J
1f2a6TEZT6MnChFwrW8QiYzLSrTmbcsM2ybDvsms+GzEdTthMajys6V5qbNzya3K
VLnqpx8RHt3HVUSMMJwrvausPSncHREcv16zzyqsTsDddC57sURvwHM5qzjwC0ff
VAHIx/45Gf49bbRuZNT64UGSqQ3HIYxDAbPn4mw8rNPX9x59viPS+NlTtp6H1Zo+
oWl/EiTWukrLLhBT1sk6XahfLikAWddUlYNfViFwOJu4CrtXUfnKKsSgbxO1qimU
8jA23QkX0Ku33s9wEANPRMz5zrIoyPoTxJp+AgwslyXU3rR+hsZPehbfPQsIhtOS
9IVjPiVIAI2hSpDKTJLWgvbV/Qa84QIGmZZ8oYpwMQxmCvCrik7yfndr+Eui84kj
obvq7NfPzQlh+oJN6tIM
=9+6z
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
