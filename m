Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjpqh-00051r-Gu
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjpqe-0004ty-9M
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:14:31 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:55999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjpqe-0004tg-3G
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:14:28 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id AF95E26A84
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 17:14:26 +0100 (CET)
Date: Fri, 3 Mar 2017 17:14:20 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303171420.1d521bf7@bahia.lan>
In-Reply-To: <CAFEAcA-_p_N8c+4tu98MgvQsCP3SV9RD9mLP-+kj9FypqCeuJw@mail.gmail.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<CAFEAcA-_p_N8c+4tu98MgvQsCP3SV9RD9mLP-+kj9FypqCeuJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qnkwycgsmj22zhIZ18jtykC";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: G 3 <programmingkidx@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

--Sig_/qnkwycgsmj22zhIZ18jtykC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 15:58:13 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 3 March 2017 at 15:55, G 3 <programmingkidx@gmail.com> wrote:
> > Here is the patch. I think we should let Mark or some else test it to s=
ee if
> > it does fix the problem before a real patch is submitted.
> >
> > ---
> >  hw/9pfs/9p-util.h | 4 ++++
> >  1 file changed, 4 insertions(+) =20
>=20
> We can't take any patch without a Signed-off-by: line, not
> even a three line one.
>=20
> >
> > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > index 091f3ce..254d2a9 100644
> > --- a/hw/9pfs/9p-util.h
> > +++ b/hw/9pfs/9p-util.h
> > @@ -13,6 +13,10 @@
> >  #ifndef QEMU_9P_UTIL_H
> >  #define QEMU_9P_UTIL_H
> >
> > +#ifndef O_PATH
> > +    #define O_PATH 0
> > +#endif =20
>=20
> Could use a comment explaining why it's OK to define it in
> a way that means it's a no-op on hosts without it.
>=20

Right. I'll send a patch with an appropriate comment then.

> > +
> >  static inline void close_preserve_errno(int fd)
> >  {
> >      int serrno =3D errno;
> > --
> > 2.10.2 =20
>=20
> thanks
> -- PMM


--Sig_/qnkwycgsmj22zhIZ18jtykC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5ll0ACgkQAvw66wEB28IFjACgkK7rx/FBDeMpmcR9ABxvbv7q
vBEAn0OLp2QYwQ8NMaE9GlpsjDZHqF6I
=PVli
-----END PGP SIGNATURE-----

--Sig_/qnkwycgsmj22zhIZ18jtykC--
