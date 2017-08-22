Received: from eggs.gnu.org ([2001:4830:134:3::10]:54864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk7Lz-0008JE-UX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk7Ly-0000wl-S9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:28:15 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dk7Ly-0000vT-Ff
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:28:14 -0400
Date: Tue, 22 Aug 2017 21:20:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170822112046.GC12356@umbus.fritz.box>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i483Pv/KqyjCUwB1"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--i483Pv/KqyjCUwB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 10:35:17AM +0100, Peter Maydell wrote:
> On 22 August 2017 at 09:49, Laurent Vivier <lvivier@redhat.com> wrote:
> > On 22/08/2017 10:47, Peter Maydell wrote:
> >> On 22 August 2017 at 02:09, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> >>> On Wed, Aug 16, 2017 at 12:18:07PM +0100, Peter Maydell wrote:
> >>>> On 16 August 2017 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
> >>>>> On 16/08/2017 10:26, Cornelia Huck wrote:
> >>>>>> Prefer to use the tcg accelarator if it is available: This is our =
only
> >>>>>> real smoke test for tcg, and fast enough to use it for that.
> >>>>>
> >>>>> I'm not sure this is required for 2.10.  Yes, it means the coverage=
 from
> >>>>> "make check" is worse, but that's it.
> >>>>
> >>>> Yes, I'd put it under "if we need to roll an rc4 anyway for
> >>>> some more significant bug we might as well put this in too,
> >>>> but it doesn't merit cutting rc4 by itself."
> >>>
> >>> It does entirely break "make check" on a ppc host.  And that in turn
> >>> has held up my testing cycle for a couple of ppc regressions from 2.9
> >>> that I was hoping to squeeze in.  Does that change your calculations?
> >>
> >> I have a PPC64 box in my standard set of build tests, and it
> >> runs 'make check' without problems...
> >
> > You need to use KVM HV to have the problem, not KVM PR.
> > Is that the case?
>=20
> I don't have access to KVM at all on that box, so it will be
> using TCG only.

That would explain it, it's the attempt to use KVM that triggers the
problem.

Obviously it's not a thing to fix right now, but I've really been
thinking that none of the tests should use this "TCG or KVM" stuff.
They should instead be run with *both* options - or at least the ones
that are available on the host.

That would have caught the bug in the pull request I sent you, and
would at least have given you a chance at seeing the problem with
boot-serial-test.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i483Pv/KqyjCUwB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmcE4sACgkQbDjKyiDZ
s5LSUg/+Lw0B4lp6MYd5NJNWvJ58NPt06WO5ya1qMBz4y+9UyTLSSgoxcw2i6UCt
eAbu5uVdHFVbvp7Q2PXC0LSOcTglZY7eIs+VQSv0XXDWniDFfdznHXzkJBekR1WH
KbGFlUllJbemxiQueSmOkuBRZcV9JcmKu+M3YeZSJseix9O5v8QOp6vaq6ThP0wS
G5ZLh1yNE6okmCUDZyLz00WDI97AWLsY2ZZfARU3VNGNP1KnAqL0LDDbTBS79DL8
HUnjJBc0Mfl7nmHnN2Z0UNSZGRMsGYly5w92Ge2XSS7014X+RwcRZTGsV5KSle4D
1SqNT60olrhHL1Wrf2L/1QyOU6nx7s3HbEpg2dbBz5WVgPlE8pqeVPTgWMhLWwrs
k1AL0DNE4MMj20yLfkw69OcmwyCkw6MSGg/m+pp8BGJjTsBYxipPMODGdOsjWl25
PJU6i2gQ94aeAnJseXRwgnBX7X9BtCIDojAzUvy3eoYoCNoRQbE76NcrWhe1o2zx
X3R1NHbb8+YK0WvDJPDYpppc/9GLJ6b1P7vZjB4EfnpFOeGgx0wPNA09UH5pnXcG
D9EBVspo98ic/taMh7QouLW50RFkB+qhEDCwdgwUUaXP8NVEu5hvK7kko63Xq3r1
XHCY6KhAvS5Sj+LRNBW56Bgg1HjVhNf7QknAS6Iit4VOyU8tdkE=
=CT3h
-----END PGP SIGNATURE-----

--i483Pv/KqyjCUwB1--
