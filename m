Received: from eggs.gnu.org ([2001:4830:134:3::10]:58260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1ffjXr-0004GH-1F
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1ffjXn-0000xp-NT
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:18:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1ffjXn-0000x9-Gs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:18:51 -0400
Date: Wed, 18 Jul 2018 12:18:45 +0200
From: Pavel Hrdina <phrdina@redhat.com>
Message-ID: <20180718101844.GB22954@antique-laptop>
References: <CANhJxzwZny93TOTKTpEoThN8bnw1tXENPH_S60wczUAQodBMNw@mail.gmail.com>
	<20180718095034.GJ9812@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20180718095034.GJ9812@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] CPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Hetz Ben Hamo <hetz@hetz.biz>, qemu-devel@nongnu.org, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 10:50:34AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jul 18, 2018 at 12:41:48PM +0300, Hetz Ben Hamo wrote:
> > Hi,
> >=20
> > I've been looking at the CPU list and although I see lots of CPU's, I
> > cannot find 2 CPU families:
> >=20
> > * AMD Ryzen
> > * AMD Threadripper
> >=20
> > Although EPYC has been added recently.
> >=20
> > Are there any missing details which preventing adding those CPU's to the
> > list?
>=20
> Libvirt adds CPU models based on what QEMU supports. So from libvirt side=
 the
> answer is simply that QEMU doesn't expose any models for Ryzen/Threadripp=
er,
> but I'm not clear why it doesn't...
>=20
> For a while I thought Ryzen/Threadripper would have same feature set as
> EPYC, but I've seen bugs recently suggesting that is not in fact the
> case. So it does look like having those models exposed by QEMU might
> be useful.
>=20
> Copy'ing QEMU devel & the CPU model maintainers for opinions.

I think that QEMU should figure out some pattern for naming CPU models
because it's one big mess.  EPYC and Ryzen are bad names for QEMU as
Core/Xeon would be for Intel CPUs.  It's the name of a model families
and it will probably remain the same but with different
microarchitecture.

Better name would be similarly like for the latest Inter CPUs,
Skylake-Client and Skylake-Server.  Currently AMD has already two
microarchitectures, Zen and Zen+ and there is third one Zen 2 planned.

Zen has AMD Ryzen, AMD Ryzen Threadripper and AMD Epyc.
Zen+ has AMD Ryzen, AMD Ryzen Threadripper

And I bet that Zen 2 will follow the same model families.

We probably cannot rename EPYC now, but before we introduce Ryzen and
Threadripper let's thing about it and come up with better names, for
example Zen-Client/Zen-Server Zen+-Client or something like that.

Pavel

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAltPFAQACgkQUi1kczAH
4Yyc7xAAkdeKTN81XVoQW2OkjCjshujh+s7mG20VUxDHeP5lB5kiyIt5X4DG9aGP
SG2HNDvp4ooA9ZNOzjfDpGLjOYXfzJPY7Eqj8b2eO6yYHOyzsNTzuaTv/u0scxZV
uCV492BWrVPfLxfnig1Zi09NDtJtArL7jfMCtMbnkwilYYxz7bX6U5mIKHpfZ7QT
rL5YOiIES/WT9INCu0xKFJs6WyFUQdWGFJZvVL5I0Ab9WqHK8+lXmOcr/36mqzuQ
QPxHdNBe87AkJeCOnR4w9Sd53fdyvu7WbMiq/LAjF7hkqD+sQ1OJ20HZz6la7zjv
91mlJrJNyiZHWgYByhvGNPq7G8+SNRNp4fPhqUwDuB6JuMuginhOAZrbf/PSHaz6
PN8Bhnv6elvRQt0uxWD+00taxkNDrH2duh03w7L/L88tf9SZR5Cyq+vUvwENLFsr
Mi5JU9b+qVk4fjo/tWMoV1gkiN6qNSUSnCy8qiy7D2HXGd+Mt2ePmOrnIqXGFl05
lkHHkdcAaNcFvS8D6q05TapjdrY10FwYU2wCmU/qkJoXlOzW+La8rQHPF6zOS39m
3T4629T1BR9+7gjMHsIkwO9eetYCPk3/kc6NxhxLgbChtg6GrFIdOTBs5EgJtBF+
R9X6shV1jUFjzaw3iw8c3+KiygmYc3s7PYui0lA2PxkKdGeTkls=
=RhUq
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
