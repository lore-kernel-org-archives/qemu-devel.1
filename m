Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKiro-00070i-Bv
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKirk-0003p1-DN
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:16:08 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKirk-0003oZ-4b
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:16:04 -0400
Received: by mail-lf0-x242.google.com with SMTP id x81so11887887lfb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 03:16:04 -0700 (PDT)
Date: Tue, 13 Jun 2017 11:16:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170613101600.GC29273@stefanha-x1.localdomain>
References: <20170608182113.nmxnvus26vplg5du@postretch>
	<w51k24ll1ke.fsf@maestria.local.igalia.com>
	<20170609160609.r2ivmny4pqvycwp5@postretch>
	<w51wp8hpek1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <w51wp8hpek1.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Proposal] I/O throttling through new -object
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 02:37:34PM +0200, Alberto Garcia wrote:
> On Fri 09 Jun 2017 06:06:09 PM CEST, Manos Pitsidianakis wrote:
>=20
> >>>     -drive file=3Dfoo.qcow2,throttling.group=3Dbar \
> >>>     -object throttle-group,iops-total=3D100,id=3Dbar
> >>
> >>, and I guess the name would be throttling-group?
> >
> > Hm, I thought throttle-group would be nicer because it's shorter, but
> > I can change it, of course. I am not certain if there's a semantic
> > difference (because I am not a native speaker).
>=20
> I'm not a native speaker either, I was pointing out that we would have
> throttling.group for -drive and then the throttle-group object.

I prefer "throttling-group" but it's not a big deal either way.

Stefan

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZP7tgAAoJEJykq7OBq3PIT98H/iAeiP2JdoDbsr+hHhVVV6fZ
UHeA1AlulWj3jSsuYSv7PcQb3W/+0IDugcWrzmW0dapRZVkp2Zy6rlQbNK40y1WT
1zRxle8dD4JOdtbHfvnGT44XdDUGV/hkBer+IKJJPLx21u8MQRV3wcFuOIIw52bn
niD5WaCZdECimNwdhhAVryZ2Pk9S4nJrExldpUB7QfWP7XvOSp1ZO+tF2dTPe3B7
uAObNuOymroNWXLN1v0w85khzoiUSoF9nN+iUrOmhRgWstH4l/51p+Mt9vrsMUc2
yvLnPfEunY5azuuIPEOP1xvjUhWy21RBeDdYBLsztBPeYb/EnfCEwEKleat315k=
=cdLc
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
