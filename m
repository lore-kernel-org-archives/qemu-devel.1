Received: from eggs.gnu.org ([209.51.188.92]:33935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gogHE-0002Mz-0n
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gogHD-0003bP-91
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:11:00 -0500
Date: Wed, 30 Jan 2019 11:10:53 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190130031053.GB20241@stefanha-x1.localdomain>
References: <20190125164601.130556-1-vsementsov@virtuozzo.com>
	<20190129033155.GD3264@stefanha-x1.localdomain>
	<fa3cc31b-937c-a22c-4079-2ad7d968aac5@virtuozzo.com>
	<CAJSP0QUCeM2wHA5Z4wnBYHoE9=sLxxAqyDMZ5-i4g12v2DQEiQ@mail.gmail.com>
	<49f1af0b-a245-3b17-7e74-6b3837e42406@virtuozzo.com>
	<20190129123448.GD4467@dhcp-200-176.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20190129123448.GD4467@dhcp-200-176.str.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 01:34:48PM +0100, Kevin Wolf wrote:
> Am 29.01.2019 um 12:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > 29.01.2019 13:32, Stefan Hajnoczi wrote:
> > > On Tue, Jan 29, 2019 at 6:24 PM Vladimir Sementsov-Ogievskiy
> > > <vsementsov@virtuozzo.com> wrote:
> > >> 29.01.2019 6:31, Stefan Hajnoczi wrote:
> > >>> On Fri, Jan 25, 2019 at 07:46:01PM +0300, Vladimir Sementsov-Ogievs=
kiy wrote:
> > >> Hmm. In this case we definitely will have tiny extra memory usage, b=
ut we gain beautiful
> > >> readability.
> > >>
> > >> So, like this:
> > >>
> > >> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> > >> index 5f433c7768..53de1b38bb 100644
> > >> --- a/include/qemu/iov.h
> > >> +++ b/include/qemu/iov.h
> > >> @@ -134,9 +134,31 @@ typedef struct QEMUIOVector {
> > >>        struct iovec *iov;
> > >>        int niov;
> > >>        int nalloc;
> > >> -    size_t size;
> > >> +    union {
> > >> +        struct {
> > >> +            void *__unused_iov_base;
> > >=20
> > > This could be struct iovec *iov for nalloc > 0 users.  Must resist ha=
ckiness! :)
> >=20
> > can't be iov, gcc complains:
> > include/qemu/iov.h:139:27: error: duplicate member =E2=80=98iov=E2=80=99
> >               struct iovec *iov;
>=20
> I think Stefan meant moving the existing iov here. But then we would
> have to make sure that it's never used for local qiovs, which would
> probably involve touching a lot more code.
>=20
> Your original suggestion to put nalloc there looks a bit more practical
> if we want to save those bytes.

Sounds good.

Stefan

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcURW9AAoJEJykq7OBq3PItdgH/19P3eFuILEt3aQhn5D9/8qe
brbnPUInpNzTENLxt855eVxN4teiznW4SJ2BgqEzmL+x+V39jnNITpbwHvPogSPV
jSiX9iWwGJOSSxBhNU37MNsRU58U688vZBChoN7aNVjw7+VKmdsRxXeUpsrYk74l
ghN+5P2kLbBN3mJkx8iCKOGiJBSqHbFxdValPH52h9ARH+93MrvCfN8C/p+WCHL7
IGWQg7yIWMHW/3vlkcYPmOYoOyYg5OONgB5/XQrI+4O+uoOAJruSRTNYmiMJd8Ft
23LafoOan7pTibfPLvn4sMnDI5y0pftJBZ5O1QGIYxYElstXLNL8Rkb9GAXopPM=
=Ym7T
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
