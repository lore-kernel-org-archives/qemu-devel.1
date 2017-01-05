Received: from eggs.gnu.org ([2001:4830:134:3::10]:58552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOw6T-00088C-8J
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOw6P-0004oe-9z
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 19:40:25 -0500
Date: Thu, 5 Jan 2017 11:20:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170105002007.GA13763@umbus.fritz.box>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20170102222831.GB12761@umbus.fritz.box>
	<A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
	<20170104032811.GY12761@umbus.fritz.box>
	<CAFEAcA91zZTPzXGfRSGSQM9kK5cG4Ci-hm7Q4Jd5odfxT+OHHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <CAFEAcA91zZTPzXGfRSGSQM9kK5cG4Ci-hm7Q4Jd5odfxT+OHHw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 05:04:02PM +0000, Peter Maydell wrote:
> On 4 January 2017 at 03:28, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
> > On Tue, Jan 03, 2017 at 10:02:21PM +0800, =E8=B5=B5=E5=B0=8F=E5=BC=BA w=
rote:
> >> Hi=EF=BC=8Cdavid=EF=BC=9A
> >>
> >>    To my understanding=EF=BC=8Cwhat must be put in the realize functio=
n  is
> >>    code which depends on property values. What's the benefit of
> >>    moving memory region initialization into realize function?  I can
> >>    not figure out, can you make some explanations?
> >
> > If nothing else it's better in realize() for consistency with other
> > devices.
>=20
> I'm not sure we're terribly consistent at all, really. My understanding
> was about the same as =E8=B5=B5=E5=B0=8F=E5=BC=BA -- put stuff in init un=
less it has to
> go in realize because it depends on properties or might fail or
> has permanent effects on the simulation.
> Lots of existing devices do memory_region_init* calls in
> their init functions.
> We should probably write down our preferences somewhere, perhaps
> http://wiki.qemu.org/Documentation/QOMConventions
>=20
> > I'm not familiar enough with the details to be sure, but I also think
> > it's not safe in instance_init.  Once memory regions are registered,
> > the device can potentially interact with other devices in the virtual
> > machine.  realize() is sequenced to expect that, instance_init is not.
>=20
> Hmm, that doesn't sound right to me. The other devices will only
> interact with the memory regions when the calling code has
> finished doing the create/realize/map memory regions sequence --
> an MR on its own doesn't do anything unless somebody maps it into
> an address space.

Huh.  Ok, I guess I was wrong.

Alright, =E8=B5=B5=E5=B0=8F=E5=BC=BA, feel free to repost addressing just t=
he other
comments and I'll merge.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbZE3AAoJEGw4ysog2bOSAFsQAKLS2zVK9pklBRgVDiX7QP6x
F1EokSyNz31qBUc+wqhtiQJCJZrhepg070EGx9n80aygZThBE1+etkGPgtpkPGwI
bMIwvkh6QsEixR1DSGdsp7Rc+gLY/o0RVqW+CZQs7gzIFmAir/W1Xi75q77mPJvp
OQsA51HoKmotnq2xpieF4ZH5jXeY1E4DIoCcWcenWv21Gxn1Z8WDuYF0+bDBThkQ
O7vszGetk9L9hIkX+tImU12cdNpvC7IFHiE2tmy9aUJzIWI1u4eGeSqbboJeWd5E
BjNGbq0vl6V93qThdAljGVOHteq/UobG4/JmiWloD888yoqryhQfzeuq7aCoxHw2
okf8NJ1tpCpyjpnRV0S6xUpGxZrtTw24+DFzoYNpIcHqodzTfO8g4FKXfSOEA2+M
hGzJgdGz/ZpPOFTBQ2yRGlwLYOOwS/OlKUM0i4K2uqa3xzM0hA4wQNscV/W5adBu
u4x/WZHka7mxNG5POx0MnmBvviouP6AmyvdTJzyoCwdTnA+O8g5NYt5CIfAKVQF4
H5wOoEgtfcSppfwVH2+iCYSCbfDo/JLVLIymQwCMr5hT8hiHDF7qAIt/KQwqzeAo
lx/ghUWJVSG+s4BJCKAYxSRm6L65rf0znopfMA8MjYtSmGWG9vlwfsXk0MMo1Fx1
5pwwWu7gORu176tvhCmv
=vZ67
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
