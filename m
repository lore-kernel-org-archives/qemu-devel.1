Received: from eggs.gnu.org ([2001:4830:134:3::10]:33929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enb3V-0003oo-Fz
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 21:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enb3U-0008AZ-7S
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 21:19:49 -0500
Date: Mon, 19 Feb 2018 13:19:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180219021918.GF1109@umbus.fritz.box>
References: <cover.1518730026.git.balaton@eik.bme.hu>
	<dffa45c9-48a6-ef85-3b28-d8ce1daf72e4@redhat.com>
	<alpine.BSF.2.21.1802161145230.98686@zero.eik.bme.hu>
	<5c7c64f7-90bd-7ddb-59f6-e3d7f4f8b21d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <5c7c64f7-90bd-7ddb-59f6-e3d7f4f8b21d@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2018 at 12:07:34AM +0100, Thomas Huth wrote:
> On 16.02.2018 11:55, BALATON Zoltan wrote:
> > On Fri, 16 Feb 2018, Thomas Huth wrote:
> >> On 15.02.2018 22:27, BALATON Zoltan wrote:
> >>> Remaining patches for Sam460ex emulation. The original cover letter
> >>> with more details is here:
> >>>
> >>> http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00112.html
> >>>
> >>> We'll need to also add binaries for firmware (customised u-boot
> >>> version) and dtb but I'm not sure how to submit those.
> >>
> >> For the dtb, I think you could simply provide a patch that adds the dts
> >> file to the pc-bios directory and another one that adds the dtb. Just
> >> like it is already done with pc-bios/bamboo.dts / pc-bios/bamboo.dtb.
> >=20
> > OK thanks, I'll do that. Does it have to be two separate patches?
>=20
> I don't think so, I just thought that would be cleaner ... but one patch
> should be fine, too, I guess. David?

I'd actually prefer them both in one patch.

>=20
> >> For u-boot, can you use the same upstream level as e500 ? I.e. check
> >> whether "git submodule status roms/u-boot" is fine for you? If that's
> >> ok, just do a "git submodule update roms/u-boot" and build uboot from
> >> that directory - you then can submit a binary patch with that file for
> >> pc-bios, too.
> >>
> >> In case you need another u-boot version, I think you've got to update
> >> the submodule to the newer upstream version first, and then also rebui=
ld
> >> the e500 binary... Cumbersome, but that's necessary since we've got to
> >> ship the u-boot sources in the QEMU release tarballs, too, to be
> >> compliant with the GPL.
> >=20
> > Unfortunately we can't use the same u-boot as e500 because this board
> > uses a forked and patched version which is not in upstream u-boot and
> > upstream u-boot has even dropped support for this CPU in latest version
> > so we actually need an older version (with patches) and not a newer one.
>=20
> That's very unfortunate ... any chance that you could try to get that
> CPU activated in upstream u-boot again and get the patches included there?
>=20
> > Therefore, it needs to be a binary built from a separate source so I
> > think a new submodule will need to be added for this. How to do that?
> > Where to host this git repo? Should I put it on github and refer to that
> > as an external repo or should it be hosted in qemu repo somehow?
>=20
> No clue ... adding Stefan and Jeff to CC:, maybe they can recommend
> something here.
>=20
>  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqKNCMACgkQbDjKyiDZ
s5JpixAAxKAieezVoh3RhSFClhfqeWNNqATcFGk7IKfD7H1iLgljgzM7+qjk+pz4
av6Q+WLeiEUIe0c1m9LEwJ8yopjniBS1JNcKrmlgsN/d3Fq+BUl94o19dNXRnfel
TqW3ukiH49pelLwPkBDC2vwillMdH7YH3064jGrnpPq1i5kfRV9r3kHNXWNqJ/Dw
c5CBO/PMSbd2tTjSPWdeQuVIi9edEB3ADFQvvcT/WMGiqxSP1C7dWmYJQc3VQUs9
d+n3Jlr+UEl6CVwHxJDBvX/NhA/rQVN+i9y6v68++pB5Ze7ueaOiN9cuTCnStWP/
Qw3XJQl7vCo1jFUhzojmbRLqCi6/0NBvXupPx49i1Bfz98ugDy5UNbjT+SOvB9A1
PLDD/OECmc1u5NV4y+3GcavgcTuT2q32KYpJJF/rac/nZhjN5km6mBv68e+wxf6T
LvKG+ZMpfpr9K27jsJA1LdlzbR0lSeVGh+AXye6oEmQwrdJr9LYdb18g0xdcYs2T
zAJou49yx+Fky7QBO1165LRjRuVYRW7LA8gme1QzDaWQ03dcbMlWHUoufl/elet/
2jK4tgJHlTo248/WNPbeWvvYmYcfhUnNuTvdoEPwKOxlqlCKSrIPaTT5usDTL/7V
sq+4PskvKH13ikRZnw4ZXBuR6rRUXZ3eA7kBZncRvf5CaFXcyE8=
=Wb0O
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
