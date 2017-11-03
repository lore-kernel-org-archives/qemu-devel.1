Received: from eggs.gnu.org ([2001:4830:134:3::10]:33962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAdhm-0002X3-Lq
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAdhh-0003Yh-37
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:16:22 -0400
Date: Fri, 3 Nov 2017 15:16:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103151613.GB10959@stefanha-x1.localdomain>
References: <20170126153837.25597-1-stefanha@redhat.com>
	<3ca6376a-ae3e-1e5c-503f-239e4e62799c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <3ca6376a-ae3e-1e5c-503f-239e4e62799c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] aio-posix: drop QEMU_AIO_POLL_MAX_NS env
 var
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 07:31:13AM +0100, Thomas Huth wrote:
> On 26.01.2017 16:38, Stefan Hajnoczi wrote:
> > This hunk should not have been merged but I forgot to remove it.  Let's
> > remove it before it slips into a QEMU release.
>=20
> Too late - looks like this patch has never been committed :-(
>=20
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  aio-posix.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >=20
> > diff --git a/aio-posix.c b/aio-posix.c
> > index 9453d83..9a6348b 100644
> > --- a/aio-posix.c
> > +++ b/aio-posix.c
> > @@ -723,13 +723,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
> > =20
> >  void aio_context_setup(AioContext *ctx)
> >  {
> > -    /* TODO remove this in final patch submission */
> > -    if (getenv("QEMU_AIO_POLL_MAX_NS")) {
> > -        fprintf(stderr, "The QEMU_AIO_POLL_MAX_NS environment variable=
 has "
> > -                "been replaced with -object iothread,poll-max-ns=3DNUM=
\n");
> > -        exit(1);
> > -    }
> > -
> >  #ifdef CONFIG_EPOLL_CREATE1
> >      assert(!ctx->epollfd);
> >      ctx->epollfd =3D epoll_create1(EPOLL_CLOEXEC);
> >=20
>=20
> Could we get this at least added for QEMU 2.11 ?
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

I am sending a new version of this patch (it needs to be rebased).

Stefan

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/Ig9AAoJEJykq7OBq3PIKZQIAJz+Wifjl5lIIVVZkd5vY9DG
J0af5Z9gXYj/MHSA/MuiMYRsxX9xkcuUgbGxxON/Gg6JzimHeK7B7oyUJ20wRLJ9
U8ylpjHCdfR3EFygdoeju796hQPORc04fjI1dHDpwZJViP+D0ojLNstyFGbJkUnR
/FAT2AVB7T0af2Rbusk+pGTIq5lm6PSXsr135kJ579WB8DqksXA2NVElkLu0arU6
WLGKI3LyzCCXG2t+Cnj1TxLyYVEVMR3/ZUIULZ0vPO+3OgqXkJG7iuCZgjbuRGAV
U4me9yUrfc3fmSd02MJKclVZI1wwMTuOCfuPiAgJH0noRhgEvhwpH6nS2WJA/bw=
=bLgj
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
