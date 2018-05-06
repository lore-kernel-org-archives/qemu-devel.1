Received: from eggs.gnu.org ([2001:4830:134:3::10]:35893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fFK7P-0008DQ-Es
	for qemu-devel@nongnu.org; Sun, 06 May 2018 09:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fFK7L-0005O7-HG
	for qemu-devel@nongnu.org; Sun, 06 May 2018 09:54:27 -0400
Received: from ozlabs.org ([203.11.71.1]:58743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fFK7K-0005JM-FH
	for qemu-devel@nongnu.org; Sun, 06 May 2018 09:54:23 -0400
Date: Sun, 6 May 2018 23:39:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180506133955.GP13229@umbus.fritz.box>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
	<CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
	<CAFEAcA_fC6AmZBv4ovKunEm+2YPMdQJ0OWVVZXCuiLxGxAG=SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/EvDld9rH7KvG42"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_fC6AmZBv4ovKunEm+2YPMdQJ0OWVVZXCuiLxGxAG=SA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>


--N/EvDld9rH7KvG42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 01:23:30PM +0100, Peter Maydell wrote:
> On 5 May 2018 at 22:59, Michael Clark <mjc@sifive.com> wrote:
> > Okay, so an alternative is to call fdt_pack() and then fdt_totalsize().
> > Thanks!
> >
> > QEMU has its own wrapper around libfdt and neither the fdt_pack() nor
> > fdt_totalsize() functions are exposed.
> >
> > Some architecture use only the wrapper functions provided by
> > qemu/include/include/sysemu/device_tree.h
> >
> > It seems that target/ppc has #include <libfdt.h> and calls fdt_pack() a=
nd
> > fdt_totalsize() directly.
>=20
> Yeah, I find this combination of libfdt direct access and a
> QEMU wrapper layer a bit confusing. I think it's grown more
> than it's been actively designed.

Absolutely.  I think the history is that when fdt was first used, the
layer was created as an (arguably) simpler wrapper.  But, it was very
limited.  Once you start doing more complex things, there's no great
advantage to using that limited wrapper over the raw library, hence
the direct usage.  At least, that's what I think though I'm obviously
a) already familiar with the libfdt interface and b) biased.

> Your approach of doing
> direct calls to pack/totalsize is fine. Maybe the wrapper
> layer could be improved some day too.

Well, I'm biased of course, but I think we'd be better off just
ditching the wrapper.  In its present form it is so limited as to not
really add any value.  If it was rewritten to do something useful
(e.g. handling reallocations), I think it would be even better if
done as an extension to libfdt itself so it can benefit everyone, not
just qemu.

Although, that said, I'll re-iterate that I think qemu's fdt
manipulation is now sufficiently complex that it would be better off
using a "live" (dynamically allocated & pointer based) tree
representation that we just flatten immediately before loading it into
the guest.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N/EvDld9rH7KvG42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrvBakACgkQbDjKyiDZ
s5IZkg/3cFN82UkEv+kxDxDRw+TYLHqEk3PPEoSor3H0GdC3VBBASWbgSsrHykR6
c/AWZIMYfYtf3vJbe7EH/sXJibNw0GHb5xyUs/c/9SSL482QdTB0AcFxHTol1+jU
uA+jjeJK2L47/Go49KANnOo45VCvEJabA9GLNarXtCpxe555yLT2NsQmOOV61Byq
NCVTZA5mzpfwisqRmGmfPbx86DPSofLC1IeClp6E6K74fSQeXCD/1J0SotCnF7iW
/LfoB1kh3LeeRXxQq96y1QaZLgrEZdqpb6yTs3sMxrT2Oglt+69EP4dDo7FrtJJA
bOSyP1LiqbP0md3GmmPt/3uz8X6SajHMOj4A3kXBaWES1zZ9cmUkmnrNayKaKFX4
lzhOfc3sPJMboIZt2kO4p5eCqjjFvJxIZIkN9Tu7QfNdYrGynZg67/Ln094iLOoz
Rv8pNGrO13C6j/ZcEHyJ00cm2hSATNdGOXEOMSPucpll9cUod8b9GxEZHMoUVTL3
hVao2OoTsHC6NDE3jOyelLt9XAdKVitUaggRR/bK5aEFhXeJhNodo880IjBbyRj/
xqRo92tWlEiVid/B+n0jM6C4nr5ROQVqq9RElksOHB3I+pnYiPRqZMkdgG1AJQO4
fFkxGq/e98kmjdPDhSb++ZNh90OUC757R+f9KBs8YZECBJ0Plw==
=0jq6
-----END PGP SIGNATURE-----

--N/EvDld9rH7KvG42--
