Received: from eggs.gnu.org ([209.51.188.92]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gn3Y4-0002bf-Js
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gn3Y3-0005Dh-P7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:37:40 -0500
Date: Fri, 25 Jan 2019 15:37:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190125153714.GB305@stefanha-x1.localdomain>
References: <20190123212234.32068-1-stefanha@redhat.com>
	<20190123212234.32068-3-stefanha@redhat.com>
	<f58f9085-c895-1fa5-9fae-afe4ac8de39a@redhat.com>
	<20190125102842.GB28305@stefanha-x1.localdomain>
	<CAFEAcA-Dy0B-qCdojx9j49vF_p7OcAyQAiXYMv-_EZq7CCgT1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Dy0B-qCdojx9j49vF_p7OcAyQAiXYMv-_EZq7CCgT1A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pflash: flush rom device memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@mail.ru>, Richard Henderson <rth@twiddle.net>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 10:36:17AM +0000, Peter Maydell wrote:
> On Fri, 25 Jan 2019 at 10:28, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Thu, Jan 24, 2019 at 12:11:55PM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > > The device realize() is also executed before the guest is started, is
> > > this call really necessary?
> >
> > My rationale was that machine init only happens before the guest is
> > started while ->realize() is called by hotplug too.
>=20
> Yes, but before realize the flash memory can't actually be
> visible to the guest, so there's no need to invalidate anything.
>=20
> > That said, can pflash devices be hotplugged?
>=20
> I guess you could have one inside a hotplugged device in theory;
> they can't be directly hotpluggged. (I bet that in practice
> there are leaks though if you did do that, and we don't have
> any devices that do so today.)
>=20
> > If you guys prefer not flushing from pflash ->realize() then I'll drop
> > it.
>=20
> I think it makes more sense not to do a flush in the realize method.

Okay, I'll resend this patch.

Stefan

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSy0qAAoJEJykq7OBq3PIKz8H/jOHIMRSb+Nz1Hy0qxPEA8Wu
qg338TxsVVQgKLvcr6kMCDuV8MaCHrT29cODfBWocjAqyCR98ReizZfiennDvgjQ
6ovAbvJPHPo+I4vNoNdxvtJJsyYYDJbkvk0c1dqPR1Cyb2S3ZitUBi4QVwcE9A9Z
RqaYfvjOTHQxFTN0QWotTsiu9SyRpIblj0SdhyvTkhUlA3rYt42XnnGem3tV1BDL
iTQ6OcD8kseUFLI3fJtlsDLstZGTZOoGB7//dz9RWHYDpWHVT289g7Lr7F+C2cPh
UxuHOcxggGcJir1oF/Ay72N+nr1Co/h2JwTCeEaWrHnnJaOCnRaDLWM8/7aVLAo=
=mBGV
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
