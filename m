Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEaT-0004Tx-0f
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEaR-0007ci-Vh
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:51:17 -0400
Date: Wed, 11 Jul 2018 13:51:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711125112.GF31228@stefanha-x1.localdomain>
References: <20180630091343.14391-1-stefanha@redhat.com>
	<20180630091343.14391-2-stefanha@redhat.com>
	<CAFEAcA-boywojdasSCZ5EnnGMtETMH7JZw30fOR7fepMQaqctQ@mail.gmail.com>
	<CAFEAcA8AzjD3f44U+He1Y10p8iNR8EaWODdv3XRUQtQiDdCotg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8AzjD3f44U+He1Y10p8iNR8EaWODdv3XRUQtQiDdCotg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/arm: extract ARM M Profile base
 class from ARMv7-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 04:49:22PM +0100, Peter Maydell wrote:
> On 5 July 2018 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 30 June 2018 at 10:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >> The ARMv7-M code is largely similar to what other M Profile CPUs need.
> >> Extract the common M Profile aspects into the ARMMProfileState base
> >> class.  ARMv6-M will inherit from this class in the following patch.
> >>
> >> It might be possible to make ARMv6-M the base class of ARMv7-M, but it
> >> seems cleaner to have an M Profile base class instead of saying an
> >> "ARMv7-M is an ARMv6-M".
> >>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > This makes sense, I guess (though it currently leaves us in the
> > odd position that we have separate a object for v6m, but the v7m
> > object handles both v7m and v8m...)
>=20
> ...though I guess the counter-argument is that the only thing that
> the v7m object is doing that v6m doesn't want is creating
> the bitbanding device, and in fact bitbanding is optional in v7m
> (you can configure a Cortex-M3 without it). So maybe we should
> instead just have a QOM property to let you turn off the
> bitbanding ?

Okay, we can do that.  So how about a single ARMMProfileState class for
v6, v7, and v8?

Stefan

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRf1AAAoJEJykq7OBq3PI45MIALDNi9sqZmezhnoluWeZUJZd
4IArjNNhqOpcKHO6gz86WZfBVdkqtIX6EdniBM6uHwNcbhUntFALq5+J1N0QcgF2
CpTDiiecMMsKO+9yqtnfJSvRv78hMCUkwy71TkWIgljR/ai6k6zxyM1WfkxBiA5H
LZoOIUPxpU3x6GeQVaw3QRlZ2+72Z99OcTb8UUrJMR7ZWBUPdxA3AtnirebtD9dc
nukh+e9B1RMgu0juyN3r93LH039zjRJcNecmylac7IeRgzs2wC/h/+sVQGwBHHA2
SLmVLbgy7WB/vcVe/+71eyptqawEGny2AFIeExfT9LrKuJLi8Q7eq9r8jxIVVbU=
=w5i6
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
