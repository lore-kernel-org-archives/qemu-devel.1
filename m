Received: from eggs.gnu.org ([2001:4830:134:3::10]:48651)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1fBex8-0007em-Tb
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1fBex5-0005BY-QL
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:20:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:59537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1fBex5-0005Am-Eo
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:20:39 -0400
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
	<CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <28c598cc-40e4-8191-a48c-5edf8eeb9cf0@gmx.com>
Date: Thu, 26 Apr 2018 13:22:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hJuoi5FoIHA7QWBpP5V8dxCMnTrqOvCGh"
Subject: Re: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hJuoi5FoIHA7QWBpP5V8dxCMnTrqOvCGh
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <28c598cc-40e4-8191-a48c-5edf8eeb9cf0@gmx.com>
Subject: Re: [Qemu-devel] Large patch set advice
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
 <CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.04.2018 10:11, Peter Maydell wrote:
> On 25 April 2018 at 20:57, Warner Losh <imp@bsdimp.com> wrote:
>> I=E2=80=99ve foolishly volunteered to rebase all the changes that the =
bad-user
>> mode folks have done to a recent master rev to get these changes upstr=
eamed.
>> A number of people have been working on this for a long time. It=E2=80=
=99s possible
>> now to run almost any FreeBSD binary from all the architectures. We us=
e it
>> to do =E2=80=98native=E2=80=99 builds of tens of thousands of packages=
 in a chroot (so
>> building FreeBSD/arm packages on a FreeBSD amd64 box). The diffs are q=
uite
>> large (on the order of 42k lines), so I anticipate some bumps in movin=
g
>> this stuff upstream.
>=20
> So, first up, thanks for agreeing to do this. It sounds from your
> mail like you're already pretty well aware of the usual pitfalls
> with this kind of work, and I don't really have much to add that's
> QEMU specific that nobody else has said already.
>=20
> One question I do have is about the other BSDs: bsd-user at least
> in theory is supposed to support freebsd, netbsd and openbsd.
> Your patchsets should fix freebsd, but do you know what the status
> is of netbsd and openbsd? Upstream we do compiletest but no runtime
> testing; I think last time I tried it they didn't work very well,
> but it would be worth checking with the other BSDs downstream to
> see if they're using bsd-user and to make sure we don't break anything
> that is currently working for netbsd/openbsd...
>=20

I'm looking forward to see it updated for FreeBSD first. We can
reschedule NetBSD part for later.

Feel free to CC me for code review.

> thanks
> -- PMM
>=20



--hJuoi5FoIHA7QWBpP5V8dxCMnTrqOvCGh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlrhtoYMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsJwsP/2x1ubnUzil252P/Br81GDk1312MMl2mu7GhlLeh
kcmFTF5OZoQJhOF7ImkpO1Yh2syiHLCv2vmrDI0ZbJxDzjqgRQJ1HJdcbwad5NpD
scQkSrhxQ9egcJMBwjqx4hGFeBFbTqVxv61l2XZ2owpbgpNM8Q7zl6yWDC2mWkfF
FrdtvPnJyFdmvAKghg9Qqm3Ge6sDxf9UhNxR4KSci93UEIZB63VXWjX3SnZZJNJa
YIWDMY9j3ygLXAHgDnwL4Wr4qTxW7npylo6J1686ubuM77CN6Ta6pg8Kelcto1bM
PMuliURmF8FDFdYzScUCiJQOSrDzoAL3wiMcjOHh9IVsVrHT1iCIeuf9wa/qxTtk
eO6HBdcXYw9d4cNZqdM6JU+gQVFYDe1yRExHngDpQm+MQ1BPzBnb1ANdJCl4ZcKm
LBX4HvwSqZ2uqFSUyZkYkofarouze8FkdRCg4xLFaXPTvZ9ZNcA3OMiE9t8SoVXo
42WQTPY9i8Sx5/c2JopM0tJZpj1WSf6y8reKh+I/eJw4m4GPcQaQsEZ1lD4S6sae
NFd+zH6cJmWQ9mGQettAAZBx4Gg8lMFkuQoci7xYnCYDJ/vWtzytXM5Klvl5ew5C
8dG2yuYjNVwfB0p1NnkC0E4vYW5kCeFNjvDvF40CcgOrbHl9HWxQyLBThf9HDv1N
WJFP
=1C0n
-----END PGP SIGNATURE-----

--hJuoi5FoIHA7QWBpP5V8dxCMnTrqOvCGh--
