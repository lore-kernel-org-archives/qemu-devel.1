Received: from eggs.gnu.org ([2001:4830:134:3::10]:47619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1flXNe-0002MO-BY
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1flXNa-00047B-Bi
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:32:22 -0400
Date: Fri, 3 Aug 2018 11:32:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180803103214.GA14905@stefanha-x1.localdomain>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-7-stefanha@redhat.com>
	<CAFEAcA8m2f-DRiDNF0ry4nMH9bzZ1gODV4MTgtLwR5jTNdgeJA@mail.gmail.com>
	<20180802124345.GA25289@stefanha-x1.localdomain>
	<CAFEAcA9SHbSf8=UhS697fkTe9h2bBBoF66DVj04_i9t53YvOOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9SHbSf8=UhS697fkTe9h2bBBoF66DVj04_i9t53YvOOg@mail.gmail.com>
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2018 at 11:04:46PM +0100, Peter Maydell wrote:
> On 2 August 2018 at 13:43, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Mon, Jul 30, 2018 at 07:01:53PM +0100, Peter Maydell wrote:
> >> I'm still not convinced we want to add another random
> >> special case only-works-on-one-architecture-and-some-boards
> >> feature to the -kernel command line option.
> >>
> >> Adding it to the "generic loader" device might be more plausible?
> >
> > I'm not sure I understand the purpose of the generic loader.
> >
> > As a user -kernel <myfile> is easier than -device
> > loader,file=3D<myfile>,cpu-num=3D1.
> >
> > Can you explain the advantage to moving hex file loading to the generic
> > loader?
>=20
> It means we have a command line option for loading hex files
> that works for every board and every CPU architecture.
> (Similarly, if you want a way to load an ELF file that
> works the same way for all boards and CPUs, the generic
> loader is it -- -kernel will not reliably do the job.
> You can also use it to load more than one ELF file or
> to load different ELF files for different CPUs, neither
> of which you can do with -kernel.)
>=20
> -kernel, like all our legacy short options, is, yes,
> easier to use; it's also a twisted mess of different
> "do what I mean" functionality that varies depending
> on the guest CPU architecture and subtype, the machine
> being emulated, and other random things like "did the
> user also tell us to start a BIOS image". It mostly means
> "run a Linux kernel", with some extras wedged in on the
> side where we thought we could do it without breaking the
> kernel case. Oh, and we don't document anywhere what
> it actually does. I'm reluctant to add yet another layer of
> "do what I mean" to it that only has an effect on a subset
> of Arm boards.

Okay, I understand better now.  Thanks!

I'll resend with the generic loader instead of -kernel.

Stefan

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbZC8uAAoJEJykq7OBq3PIPp8H/R2Aq4x/Mh26uXs8de8aeNBW
HW10uD3wk8SjsQ2Qde4pVPHOUeyPapOVkRgCzLp6ejGUWHT+QehY7EtKjUsoWapW
fY2+ZhY1Fa1AcGL6dC3aWUagcJoZ/tHGreIrfvEM/XqGZcT3LXeieh6vAqHreVA6
cIgZrN/KxPbWRKNv5h6IGAtxircw1wIoSRZTLwzSRmLgFFYM1+twSQp5aLmVshKn
PfnYQFQdz9KgwZaXeGuTSShOFKIiUhH8qqb4eeEytMwfVe6Vn2PtIpq8BKdswi8G
o7UgAtg2OYppmKcm4MxoqCGXl9z5ar0MdCpnrLDKrDadF2c47HZHcxSHGXBCkEI=
=xC8R
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
