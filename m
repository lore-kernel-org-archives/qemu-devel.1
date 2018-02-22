Received: from eggs.gnu.org ([208.118.235.92]:54909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eogiy-00035d-0v
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eoghH-0002sc-0n
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:35:07 -0500
Date: Thu, 22 Feb 2018 13:11:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180222021116.GA2164@umbus.fritz.box>
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
	<20180220204450.GA27101@flamenco>
	<CAFEAcA-p_og1Dc3DOTbAYofqAUEn0rnuuizoU8xtWrtOtzpp-w@mail.gmail.com>
	<alpine.BSF.2.21.1802211754370.60913@zero.eik.bme.hu>
	<CAFEAcA-UaWGqLHfN_Z7h+C-k=1A5ic_REaWUu0-w19ALcNJy_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-UaWGqLHfN_Z7h+C-k=1A5ic_REaWUu0-w19ALcNJy_A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "Emilio G. Cota" <cota@braap.org>, Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 06:33:42PM +0000, Peter Maydell wrote:
> On 21 February 2018 at 17:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > It's not that upstream u-boot has abandoned board support (it only remo=
ved
> > support for the PPC440 CPU it once had). The board itself never had sup=
port
> > in upstream u-boot, it only exists in vendor's fork which is the reason=
 we
> > need a separate source and cannot use upstream u-boot source we already
> > have.
> >
> > In my opinion we don't aim to take on support for this board in u-boot,=
 we
> > only need to include the firmware binary for the emulation to be useful
> > which then requires us to also include the source for the GPL it's lice=
nsed
> > under. I've also found a few bugs in the firmware which I've fixed but =
apart
> > from such occasional bug fixes when needed I don't expect to take over
> > support for the board from the hardware vendor so this source is only s=
o we
> > can include the firmware binary which is needed for the board emulation.
> > Does this answer your concerns?
>=20
> We have lots of boards we don't ship firmware blobs for and
> which we expect the users to provide the guest code for
> if they're going to use them. If we had a git submodule
> for every random dev board model that needs some hardware
> vendor's BSP and bootloader we'd probably have 50 submodules...
>=20
> Which isn't to say I'm definitely against this -- I'm just
> trying to figure out where we should draw the line of
> "these bits of guest code we build for you and ship with
> QEMU" versus "we provide the model of the hardware for you
> to run whatever guest code you happen to have".

So, I encouraged Zoltan to attempt this because I thought boards
without suitable firmware blobs were the exception.  If they're common
it's probably fine as is.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqOJsIACgkQbDjKyiDZ
s5LnfRAA3wbr6wYDeBHYNpc7HGayL7HOsuX7IEp23GhhJHxGXIxCIlGGVhgjfEfe
lMzOU/t78vuAkOdiIAHbG6mapOUGYAcGtNwGHb/r8bb2HxlOVqTnxse67ZeKJBYp
UBhInnNuhCY74gtr3aN8S5j/gdnRsEIoZ1CRziQ4rrBer6m0LMKIYQF7r7tjvERp
nKcfdbHHodIT1B+0M6KRrDIcwL/I0bLOGfSSaPUZU5LXhHILjiVQCdOOlfb6d29W
wGtH9kcn8kad4mYIWrpgplQC1+hSDpt9cmGpiKtDhP/VTVOypQb6LMWprBVr1TWY
Iv78C2otVWZqcL+L8ITndlvIQtWDDwmQvJAeBjMIu7RM5liVglAtb++FKsKxOm6X
ENuw2hNsW8TtZkFAhmtf4M3SYflWRMGn/Gy87y7L8FDTqHxxnFDhC9DZ9Q1NXwzE
MnuK7toEMRzdDZBTa+uBXSoJJ0PnyQ3dFFc5PgY7gISlKbgvjJLgj0CpBYWtQcJr
qeYmTBdaLp0wYqIL/ZsJZNkQ6Pm4TAWSIXjYVoU49LgjN6gTg7lNtLpgpGs53Nsm
jAIbFtKmamsTpyEnEr8wlYybVwyZGwYvXvTyiTS0mFXnOrXdvV/joZ9sQVB39pWN
kM8tPnH8fAVvhW+J5q06SjLSR/VzYDR5EJfrLWmE0e5rcr3fwcs=
=OYsV
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
