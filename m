Received: from eggs.gnu.org ([2001:4830:134:3::10]:48989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1flLOR-0006bf-79
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 17:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1flLOM-0005Uu-C6
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 17:44:23 -0400
Date: Thu, 2 Aug 2018 13:43:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180802124345.GA25289@stefanha-x1.localdomain>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-7-stefanha@redhat.com>
	<CAFEAcA8m2f-DRiDNF0ry4nMH9bzZ1gODV4MTgtLwR5jTNdgeJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
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


--fUYQa+Pmc3FrFX/N
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

I'm not sure I understand the purpose of the generic loader.

As a user -kernel <myfile> is easier than -device
loader,file=3D<myfile>,cpu-num=3D1.

Can you explain the advantage to moving hex file loading to the generic
loader?

Stefan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbYvyBAAoJEJykq7OBq3PIHOsH/0NIl2L/Bj0r1WKdxLUFCWP7
lMsdYvs6cXmRo6UfgtjR6QIuAG54YSQn0lzVlHlH1Hxp76yT0Tql5XJOatRUp0A8
Rc83O0mdwT9CsxAzD3PTHjXH0kfYo/D6AHSfUsCzuO0h3V5GTz0S+WwSD69wRxmg
ICif0rwO92TQfQkyYoofEy0VtesofE6o/1vIXDZSJyzWwKMW5BMVFLct5FoO4UqO
uUP6pu/gHTHqwd3gAmr6KQ5e61EVYwaPfvAl5Ga3PclovQ0K8H18ngte8XT4lonB
L8I9e2+yp0sti/PwT2dUJE0zj0XsD4K5gDYLwrY3KlLj2Q+DiNhp7izBDleh6K8=
=bq7k
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
