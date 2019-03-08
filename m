Received: from eggs.gnu.org ([209.51.188.92]:46885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h27fs-0002T7-D5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 00:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h27fr-0002rT-F0
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 00:04:00 -0500
Date: Fri, 8 Mar 2019 15:39:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308043911.GV7722@umbus.fritz.box>
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-8-armbru@redhat.com>
	<87va15lds9.fsf@zen.linaroharston>
	<87tvgfuq0g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t0wvWpvf5IekHbuL"
Content-Disposition: inline
In-Reply-To: <87tvgfuq0g.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 07/11] ppc405_boards: Don't size flash
 memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com


--t0wvWpvf5IekHbuL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 08:01:35AM +0100, Markus Armbruster wrote:
> Alex Benn=E9e <alex.bennee@linaro.org> writes:
>=20
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
> >> Image size is rounded up to the next multiple of 64KiB.  Useless,
> >> because pflash_cfi02_realize() fails with "failed to read the initial
> >> flash content" unless the rounding is a no-op.
> >>
> >> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
> >> other stuff.  No idea how that would play out, but a useful outcomes
> >> seem unlikely.
> >>
> >> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
> >> regardless of image size, to match the physical hardware.
> >>
> >> Machine "taihu" maps its boot flash memory similarly.  The code even
> >> has a comment /* XXX: should check that size is 2MB */, followed by
> >> disabled code to adjust the size to 2MiB regardless of image size.
> >>
> >> Its code to map its application flash memory looks the same, except
> >> there the XXX comment asks for 32MiB, and the code to adjust the size
> >> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
> >> to read the initial flash content" for images smaller than 32MiB.
> >>
> >> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
> >> to match the physical hardware.  Delete dead code from application
> >> flash mapping, and simplify some.
> >
> > It seems to me the DEBUG_BOARD_INIT code is probably out of date cruft
> > that could be excised all together. But that doesn't stop this being
> > useful:
>=20
> David, would you like me to excise DEBUG_BOARD_INIT?

If you have the chance to look at it, that would be great.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t0wvWpvf5IekHbuL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyB8e8ACgkQbDjKyiDZ
s5IfOg//XHAgad/iDnVxwgZK6tDdfoegGJOn7fUQicEA5xR20bbUQJTh2+0BV3GU
KjL1bQAqGr0cbXgA2vFSkEXJZ8imEUn+vmCzN0kCbvovoAlHaR5qthslW9JcT5oq
bvlIBZHBEcCq7AOWqlgnVPhcoDd3TJ6KbXhk/2oLv0nD8m01WxM/Eyu9eZ9wVG58
odV3A1oVJ/v38FY7dIiaLIBRkc5l4g8/yYeTJ0WRRBqpB6erPYNwEj/LAjd82+vx
zVaEugawvjpj0r6zVKzSylwrQxDi7eGmv8+K4a7yXld7iL+C3vd0P3vW6sh0G0h8
2PSbtSyXYP7YuQdktGgrzB11tSQQLsFbwUmdU0kPp55LirlaNBos61LJvmPnJ/qo
Xga8N0E8CY4bXP1+llQRfWOClvu0SWcXY87cAd9kWNT9MnXvQBRHQeDI1WfLH0p2
g+Ju87TRtMKRGFIK0r0R28LVRkmO20GrtxJmcpKRDbFY0J15LCNGe5VnrY/+AMiq
9NqQw4hhDBRFh5pa40NQTawdD5zWILnCBkiYv84D20RJnfsrVJ4razPH431FMh1k
THLo/8rkHFGuVU10MJFXunDYpk6q7mPUIkPST8+WblmMH3ffeliIdPTO0RqViYUb
N/aITJQi6PCP/+REAgcYHEqPfAgZzjdbunwikV0yIViSomALyJg=
=2KQt
-----END PGP SIGNATURE-----

--t0wvWpvf5IekHbuL--
