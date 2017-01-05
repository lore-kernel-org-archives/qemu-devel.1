Received: from eggs.gnu.org ([2001:4830:134:3::10]:38152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOws0-00081P-RG
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 20:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOwrw-00040z-S2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 20:29:32 -0500
Date: Thu, 5 Jan 2017 12:28:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170105012813.GC13763@umbus.fritz.box>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20170102222831.GB12761@umbus.fritz.box>
	<A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
	<20170104032811.GY12761@umbus.fritz.box>
	<CAFEAcA91zZTPzXGfRSGSQM9kK5cG4Ci-hm7Q4Jd5odfxT+OHHw@mail.gmail.com>
	<20170105002007.GA13763@umbus.fritz.box>
	<404AAC02-2CF3-4F5D-9A1B-2AEA2ADB462E@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <404AAC02-2CF3-4F5D-9A1B-2AEA2ADB462E@163.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 08:53:07AM +0800, =E8=B5=B5=E5=B0=8F=E5=BC=BA wrote:
> Ok=EF=BC=81
>=20
> Just one more comment=EF=BC=9A
> After check the code flow, It's clear that the initialized memory
> region must be add to address space by calling
> memory_region_add_subregion in platform code before it can be
> accessed.

Yes.. but I don't see how that's relevant to the discussion at hand.

>=20
> Best wishes =EF=BC=81
>=20
> > =E5=9C=A8 2017=E5=B9=B41=E6=9C=885=E6=97=A5=EF=BC=8C08:20=EF=BC=8CDavid=
 Gibson <david@gibson.dropbear.id.au> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> >> On Wed, Jan 04, 2017 at 05:04:02PM +0000, Peter Maydell wrote:
> >>> On 4 January 2017 at 03:28, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> >>>> On Tue, Jan 03, 2017 at 10:02:21PM +0800, =E8=B5=B5=E5=B0=8F=E5=BC=
=BA wrote:
> >>>> Hi=EF=BC=8Cdavid=EF=BC=9A
> >>>>=20
> >>>>   To my understanding=EF=BC=8Cwhat must be put in the realize functi=
on  is
> >>>>   code which depends on property values. What's the benefit of
> >>>>   moving memory region initialization into realize function?  I can
> >>>>   not figure out, can you make some explanations?
> >>>=20
> >>> If nothing else it's better in realize() for consistency with other
> >>> devices.
> >>=20
> >> I'm not sure we're terribly consistent at all, really. My understanding
> >> was about the same as =E8=B5=B5=E5=B0=8F=E5=BC=BA -- put stuff in init=
 unless it has to
> >> go in realize because it depends on properties or might fail or
> >> has permanent effects on the simulation.
> >> Lots of existing devices do memory_region_init* calls in
> >> their init functions.
> >> We should probably write down our preferences somewhere, perhaps
> >> http://wiki.qemu.org/Documentation/QOMConventions
> >>=20
> >>> I'm not familiar enough with the details to be sure, but I also think
> >>> it's not safe in instance_init.  Once memory regions are registered,
> >>> the device can potentially interact with other devices in the virtual
> >>> machine.  realize() is sequenced to expect that, instance_init is not.
> >>=20
> >> Hmm, that doesn't sound right to me. The other devices will only
> >> interact with the memory regions when the calling code has
> >> finished doing the create/realize/map memory regions sequence --
> >> an MR on its own doesn't do anything unless somebody maps it into
> >> an address space.
> >=20
> > Huh.  Ok, I guess I was wrong.
> >=20
> > Alright, =E8=B5=B5=E5=B0=8F=E5=BC=BA, feel free to repost addressing ju=
st the other
> > comments and I'll merge.
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbaErAAoJEGw4ysog2bOSfT4P/1wFOLa+pwFZjM6ykjiswU93
wpOAqTql2Ma+A17Atcvp+wTLVvCaxVeJvtosAhTNxZik/m3RWgbT9ETn7WQ2MjG7
fi1VFWs0miShkaIcC2kqHZwTjcKAUaV3fCAzUrxSv0vo4oeEyqTUOJvRAJ2YsC2W
4NzCxDfl4NDZtqWugd7Du9NSYUh9coi3wUG84EzbAHVBNYFmM0L2Pfm45UMCwYDZ
0FdWRuS0Z68GtXLbH3ExvyFtv+RZETHBXI7AYlf+tQQPyqAaiBtp0kVaEX+mbZX8
E5vbZF+1TGhQyV6ePCb8ZtWX3cu6ytEKP/lFDXqolr62PnoXbzIZscb+BXqZi039
L0d1iZwsNKC8ySNJ14PK8G9wz1ZCKKd9rxI8DwwgGKs2OWmoP6RGLv1FkA6JPN6n
dHlaiICOS7fGZoHsXjMFLlacaZF/GMpoY5WnWnuL9zWImKj08ZSRK9gOVY/tpHEw
Aycn11Kdxqy5sWeEW1QRnYThOlfxfukHUemckwYI9iR0AtnCn+i0Q8FJrWUBjGrF
cUj0nGMuBaBzF94l8H6hnchBIE7wU5yTvczTxFimop+eYbori8UTjw69iXJsnfXG
3RMhRh4cOjTYuGqcxnK/lObOSEo2NoXCEws13Au/J8KYyYw1OKi9zz67eGZVCgrn
iMutgmuTKqcGusTeXHKY
=gRmR
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
