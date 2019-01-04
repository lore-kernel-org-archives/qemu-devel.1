Received: from eggs.gnu.org ([208.118.235.92]:49950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwY-0002ls-Sl
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwX-0002tA-W4
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:50 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:34877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gfHwX-0002YN-3L
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:49 -0500
Date: Fri, 4 Jan 2019 16:03:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190104050301.GB2801@umbus.fritz.box>
References: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
	<9b211327-06a8-9739-e984-4b05557c12b4@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <9b211327-06a8-9739-e984-4b05557c12b4@suse.de>
Subject: Re: [Qemu-devel] can we update QEMU's version of u-boot.e500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 12:44:59AM +0100, Alexander Graf wrote:
>=20
>=20
> On 03.01.19 18:38, Peter Maydell wrote:
> > Hi; currently we ship with a u-boot.e500 which is from u-boot
> > v2017.07. It would be nice to move that forward, specifically
> > to at least v2017.11, which contains upstream u-boot's part of the
> > fix for https://bugs.launchpad.net/qemu/+bug/1714750 .
> > (There are more recent releases than that; it's just the first
> > that contains the fix.)
> >=20
> > Then we could remove the workaround in scripts/make-release and
> > close out the bug.
> >=20
> > I've cc'd David as the current maintainer of pc-bios/u-boot.e500
> > and Alex as the last person who did an update.
>=20
> I think it's a great idea to update it.
>=20
> David, do you want to do that or rather have me send a patch?

Please send a patch.

I'm maintainer of all the ppc boards by default, but I really don't
know anything much about e500 or u-boot.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwu6QQACgkQbDjKyiDZ
s5Isaw//S5AuXbKmahIAghqX2Adhd0K8G+Z4LfdNq3GcZdbXYf+DO7QIKAo3+NhN
4zpKBGdyci2Gl/HUml0kFhICF/mu4PorQ1CPnGwk/xCG0zjfiyqmh4kY5QPJ32Hm
DdoNO3Fq2Nb+O1FVrEPeoIlSKo/mSGSp2jJpBQitl73nAZqfvkNv0S6hUUifTXMr
Oc/zeeR0UrZ301aBnquc/39S5dPGX85pQKkr/22vSStRIxOjGjy3IziYaVYHjZ79
55xnFRNRCJzUKLVIwCAqXt3qyxF2nyjTXlWcHpIxaCNvZxn/+X89UudNwdqeWYZJ
SuHI628LZyHTLQoZQ8E7rK1lzTPq/ypkMA5SIb9X9meoT6gvT290snmUYVDe44TV
SF8z51f0K2s33AAaCE6OUgh8/SSQlPe/+av90ZSEluJ/+Wmd/ChaDpQpByigJLm+
WiMSEj3vsH4/jxbVoB/dKNwsLW8CiMfnJdq/SlQTtxpbyIXtcjF7MxHO1WvFXy8j
y346YI1FNmBvJEfbQBorl69NgVVJH/TEWcmkeBTF1jUBDnfFg49FaKyUuE0Lkgp9
wCJypSusU7zN4Wmlh9ylmKAM14uUM0vkixtsJEURXi8D02OtPr0t4L3Vj8Acw9Ta
OJbHGdvLp7SNHRUmLfS/+rYVQu1LOoR5oE01lMIJ7lX8F6aygZ8=
=sjSJ
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
