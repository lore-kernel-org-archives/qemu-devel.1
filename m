Received: from eggs.gnu.org ([2001:4830:134:3::10]:47917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fl7SN-0007qu-Ql
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fl7SK-00042c-Nt
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:51:31 -0400
Date: Thu, 2 Aug 2018 07:51:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180802065125.GB13481@stefanha-x1.localdomain>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-7-stefanha@redhat.com>
	<CAFEAcA8m2f-DRiDNF0ry4nMH9bzZ1gODV4MTgtLwR5jTNdgeJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8m2f-DRiDNF0ry4nMH9bzZ1gODV4MTgtLwR5jTNdgeJA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] loader: Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Su Hang <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 07:01:53PM +0100, Peter Maydell wrote:
> On 25 July 2018 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > From: Su Hang <suhang16@mails.ucas.ac.cn>
> >
> > This patch adds Intel Hexadecimal Object File format support to the
> > loader.  The file format specification is available here:
> > http://www.piclist.com/techref/fileext/hex/intel.htm
> >
> > This file format is often used with microcontrollers such as the
> > micro:bit, Arduino, STM32, etc.  Users expect to be able to run them
> > directly with qemu -kernel program.hex instead of converting to ELF or
> > binary.
>=20
> I'm still not convinced we want to add another random
> special case only-works-on-one-architecture-and-some-boards
> feature to the -kernel command line option.
>=20
> Adding it to the "generic loader" device might be more plausible?

I'll look into this and let you know what I find.

> Or just get the user to create ELF files or plain binary files,
> both of which we already handle.

Plain binary definitely won't work because the .hex files contain sparse
(discontiguous) data.

But even using ELF would be very inconvenient to users since .hex is
*the* format that micro:bit IDEs and toolchains use.  Our goal is for
less technical users (even kids learning to program) to use QEMU has a
micro:bit simulator, so the ability to directly use .hex files is very
important.

Stefan

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbYqntAAoJEJykq7OBq3PIdiEH/jy1o2ThFcTcodswmRHfDola
11bsGUd7lpfi1BB02D96OCFpJfG6Jt7GoquvacYExSS2kGs4QLL9RWsTnbP2RHWL
xJ7mG/5gOmLoj+BJSqWwgGtgrbJpK4veViuV+ZN/so9FXEch0fm7eN8TWK3tPU0b
kijUqEKWT7/49Y2/xbu8+CVnZ1J3SxZMr93IjTQffiRBsjqAnybCycfehWbxpH+C
hbcaXulAs1Mwni67eUJybIRwf8TSSmILs5isTeWyR6W3Mg3AGV7UF59xl1aTMSvz
LO99EasIM1tAx8O2QpOvy8UiwbaSyP5FkNhCyFrWSa/TLch35FvA96CWOOkrb7A=
=h5Ss
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
