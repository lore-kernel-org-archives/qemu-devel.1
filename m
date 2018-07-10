Received: from eggs.gnu.org ([2001:4830:134:3::10]:58830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fctnu-0001Qs-5s
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fctnt-0007qI-BQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:39:46 -0400
Date: Tue, 10 Jul 2018 16:39:31 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180710143931.GQ1148@andariel.pipo.sk>
References: <20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L0TNCHh3fkwjpuuE"
Content-Disposition: inline
In-Reply-To: <20180710162208.7b1b5cdc.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>


--L0TNCHh3fkwjpuuE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 16:22:08 +0200, Cornelia Huck wrote:
> On Tue, 10 Jul 2018 07:59:15 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> > In addition to actively pulling libvirt developers into review of
> > deprecation patches, we should pursue the idea to optionally let QEMU
> > fail on use of deprecated features, then have libvirt run its test suite
> > that way.
>=20
> What about the following:
>=20
> qemu_deprecated_option("old_option", "modern_option");

I think this is too simplified. You can deprecate only a certain value
for an option or even just a combination of values and options. The
check will need to be programatic and error reporting probably can't be
reasonably machine readable anyways.

> Which would then print (in normal operation)
>=20
> "WARNING: 'old_option' is deprecated and will be removed; use 'modern_opt=
ion' instead"
>=20
> to the monitor (or to stderr? to both?).
>=20
> If you start QEMU with a -no-deprecated-options switch, it would print
>=20
> "ERROR: 'old_option' is deprecated and will be removed; use 'modern_optio=
n' instead"
>=20
> and do an exit(1).
>=20
> Would that be workable?

For delivering the warnings via monitor you'll need a store that will
collect all the warnings and prepare them for delivery. You've got
basically two options:

1) monitor command to poll for deprecated options
2) event with deprecated options

Both require storing them since libvirt connects to the monitor only
after the command line is processed.

Warnings printed to stderr are nearly useless because until something
breaks nobody bothers to read the log files.

To make any reasonable use of -no-deprecated-options we'd also need
something that simulates qemu startup (no resources are touched in fact)
so that we can run it against the testsuite. Otherwise the use will be
limited to developers using it with the configuration they are
currently testing.

--L0TNCHh3fkwjpuuE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAltExR8ACgkQHGwCByjY
1GrSMw//YaRudC2FzE6aN94MiLaaGA5YU2yHS1kzyA0SIgTHs6miCM3QzSM46NvZ
srBQBbBC8eaXjK5tjuWW1WGpMD/Ps47UBOYK16CNXurY7AC5AtdOaWSSmBYYhWsY
qND5i3ODJ5bSEPH3T+bH/HNPvFeWhhDExwLDjFAyBNvcQNitjP/80GG68BPr2871
NPXEG1eSIFtRpqPGKH5D139bX5gOdlH8ytONyNvmHUZUmDmzNh01tHyjYP3NMqMx
MbcJPb7LG95nN94IejEwBt5C6AHZJp56xDilFLZnE3AAZsZ9NiWZ2VbaFgmuvAPo
+WI1l4PaOHE5nt2BIAfbL3TqH9TqekmIHdTxJMf+SNQCnM0/HR9lcvlmAdy4GVOC
ZJgUvqHTIwbaFYqyddHJRoKnt2M/QmbUlK6Cn6GpSdx48Dt1FGQWcmRCRfqCLkJS
jjkMn7RXHTNhFLu8nWTldj0hCQaTKIna7NqMkaTRhpz0eL9xmYsNihdP8G63BuEU
LgenLa1UoYh0gJ+ihTP2aGSVXCn898c35dvx/C6njyl22AZ0M9EFRmk2USp2sjxW
ebpIcstbzjxZubMbMgCP1jg+oC62r7zcmGWhNRb2ROhZRC5FEd1o8YCE9DN9TFXF
oIwOPFvIYHSadzGSUo+kexXanHZWthM8AzzaK1HgcN5zKZE6WXo=
=eJ2I
-----END PGP SIGNATURE-----

--L0TNCHh3fkwjpuuE--
