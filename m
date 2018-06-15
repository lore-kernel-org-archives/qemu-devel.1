Received: from eggs.gnu.org ([2001:4830:134:3::10]:39134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeDE-0002nt-EV
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeDA-0004rH-Dg
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:11:40 -0400
Date: Fri, 15 Jun 2018 11:45:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615014501.GI4129@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
	<ea3044c2-d8cd-d41d-91a6-5d78bff86e76@linaro.org>
	<20180615000020.2a3372a5@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qVyHzDF4yf4A8jkR"
Content-Disposition: inline
In-Reply-To: <20180615000020.2a3372a5@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--qVyHzDF4yf4A8jkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 12:00:20AM +0200, Greg Kurz wrote:
> On Thu, 14 Jun 2018 09:52:55 -1000
> Richard Henderson <richard.henderson@linaro.org> wrote:
>=20
> > On 06/12/2018 10:19 PM, Greg Kurz wrote:
> > > I'm confused... I don't see anything related to HTM in TCG. Also we h=
ave
> > > the following in cap_htm_apply():
> > >=20
> > >     if (tcg_enabled()) {
> > >         error_setg(errp,
> > >                    "No Transactional Memory support in TCG, try cap-h=
tm=3Doff");
> > >=20
> > > I'm probably missing something... can you enlighten me ? =20
> >=20
> > One of the two IBM machines -- and I thought it was ppc not s390x, but =
the code
> > you quote seems to deny that memory -- has stub support for TM within T=
CG.
>=20
> Oh ? I didn't know and didn't check :)

That is true, there are stub implementations of the TM instructions.

>=20
> > To wit, the instructions are recognized and transactions always fail.  =
Which is
> > not a bad way to test the required fallback paths that rarely fail on h=
ardware.
> >  ;-)
>=20
> If TM instructions don't cause an exception, I guess its reasonable to say
> they're supported :)

That argument has come up before, and I disagree.  I don't think it's
reasonable to advertise TM support as available if the instructions
always fail.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qVyHzDF4yf4A8jkR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjGhoACgkQbDjKyiDZ
s5JEAQ//UFwjIoGJHUN/IDUvqmetRRjAKC7Xi84KmndPnfEMzXeDExaCwQEs+9zE
SGsJMaVoj4vWHVEeWoyUUmuw739mhNfV8gOGgUlBodc9x11QO1+IYEhf35ZyPCYY
ayCe9+SzyzYGvgjqwtn2ZGzrCu+f58+eP6ICnFwwIn5dloU6dfROfsKMiTd2itwi
AF8huHw6DYQrJ+12Kw0DtijkRhFkWI0wfOjkflPStb6Ki4FjufW+OV04iClX8ZO9
s5+UvQp8x2uJkaQNG8+aaa4A3YpPZSDpTrhiNXnoK1AZMVmJCs1JtNW4LrtU12m5
2bheQ8EsibvtTV+duoKKo4Ie8+Y7SKoxA9SUF+RQ0cFJI4kGi6iM9JfLe57af9Gn
nhhGLaeEPcQ9OvgndhqucwGIkcTT6J4kb1DdY47JsuIUu+twznigvioRVz4Fkmml
h9h1KT5ujWCtby5H20OHoyWTMhwueKCgt3OEeQB/HOcBWCsxSaQ/WgMprK826IQ+
vqBMqUahCb/5DCDKMf5pCYut60wDHmUG3AJLwsCOQtzDYN/mYpl3CMTlXx5/ZQev
KcIt5kVMrO43BQoIZLcG4R7B95rS7XSQeL393epER8xFzgSNoJz+mpjdWqNcSQQz
cu1tfywaF3S3jg5HNON62r0p0JeEYc5KF8PjD/SBB+pfZxqQ2zY=
=4137
-----END PGP SIGNATURE-----

--qVyHzDF4yf4A8jkR--
