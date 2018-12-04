Received: from eggs.gnu.org ([2001:4830:134:3::10]:59970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gU7zt-0005px-1n
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gU7zo-00076W-P0
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:32:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gU7zo-00075m-GD
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:32:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id b14so1755001wru.12
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 02:32:04 -0800 (PST)
Date: Tue, 4 Dec 2018 10:32:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181204103200.GB5541@stefanha-x1.localdomain>
References: <CAG48ez2Rq18M+a84Ae+N5_=eS2A6zZNrG9r19MWS6hddq=x4Rw@mail.gmail.com>
	<CAFEAcA_+oq2H=-_7+AxqpXb_VhUsSAgVgN8K7Q+ffeKXxs5gWQ@mail.gmail.com>
	<CAG48ez2CkA4jS8WiJ7Yj6dTsvoC_ozNdoQeOXxfg7JmRaK8srw@mail.gmail.com>
	<0aadcc23-ae86-bb04-a7e2-be654fe5144a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <0aadcc23-ae86-bb04-a7e2-be654fe5144a@redhat.com>
Subject: Re: [Qemu-devel] insecure git submodule URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>, jeff@codyprime.org, Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 02:17:39PM -0500, Eric Blake wrote:
> On 7/15/18 7:56 PM, Jann Horn via Qemu-devel wrote:
> > On Sun, Jul 15, 2018 at 11:18 PM Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> > >=20
> > > On 15 July 2018 at 20:50, Jann Horn via Qemu-devel
> > > <qemu-devel@nongnu.org> wrote:
> > > > I noticed that when I build QEMU from git for the first time, it pu=
lls
> > > > in submodules over the insecure git:// protocol - in other words, as
> > > > far as I can tell, if I'm e.g. on an open wifi network while buildi=
ng
> > > > QEMU for the first time, even if I cloned the main repository over
> > > > https, anyone could smuggle in malicious code as part of e.g. a
> > > > submodule's makefile.
> > >=20
> > > Yes, this came up the other week.
> > >=20
> > > > I'm not sure what your preferred fix for this is, so I'm not sendin=
g a
> > > > patch yet. As far as I can tell, the two options are:
> > > >=20
> > > >   - change .gitmodules to use https for everything
> > >=20
> > > We should probably do this...
> > >=20
>=20
> > > > As far as I can tell, the QEMU git server only supports the "dumb" =
git
> > > > protocol when accessed over HTTPS, not the "smart" protocol. I'm not
> > > > sure whether that might be why QEMU is currently still using the
> > > > insecure git protocol instead of git over HTTPS?
> > >=20
> > > This is why we haven't switched over the submodules yet, yes.
> > > It's on Jeff's todo list for the server, though.
>=20
> Did we ever get this done? (And updating this thread to pull in Jeff's new
> email). (Reminded of this now that there is yet another submodule being
> proposed for mirroring)

For the record, Jeff Cody set up smart HTTP for https://git.qemu.org/
and QEMU 3.1.0 will use https for submodules.

Stefan

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcBlegAAoJEJykq7OBq3PIe6YH/Ra9AgrPAdoivWKxDh/Kjqtx
J8Nhv7a8XMtnn0ZjaPxn2wUQvq3FsfdrhyM33n7l0pGOWWztI1FyUfd0gpBat1qF
nCTnHJxs6iqrUIm6YZuu4OHabKrvNuotMAWMFZg+GaBmLqe2cX9n36FA+VJ+Mre/
YTcMgses2vUFIl+Ox28/Bc0nlKD0HClSwrm4FNsAnnZ6D+djI7DZBy6fsmg//wFH
l9QYUa8E6PoGr0GzVr9fUIblEpAHYS5zHLnh3696R7lCb+vkDS8M46vGh9qRr1E+
IiL/F99zA37zP2Kb1kf3OkY6kd7zCyrxmBZuYw8apxOTM2oPjYMEFza+uV9dD9Y=
=kdy6
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
