Received: from eggs.gnu.org ([2001:4830:134:3::10]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lqb-0006d4-LI
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lqW-0006ol-RD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:49:21 -0400
Date: Mon, 8 May 2017 12:49:13 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508164913.GF22428@stefanha-x1.localdomain>
References: <20170505100255.11145-1-stefanha@redhat.com>
	<20170505101955.GG21435@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <20170505101955.GG21435@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2] aio: add missing aio_notify() to
 aio_enable_external()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 06:19:55PM +0800, Fam Zheng wrote:
> On Fri, 05/05 11:02, Stefan Hajnoczi wrote:
> > diff --git a/include/block/aio.h b/include/block/aio.h
> > index 406e323..b3d6f76 100644
> > --- a/include/block/aio.h
> > +++ b/include/block/aio.h
> > @@ -454,8 +454,14 @@ static inline void aio_disable_external(AioContext=
 *ctx)
> >   */
> >  static inline void aio_enable_external(AioContext *ctx)
> >  {
> > -    assert(ctx->external_disable_cnt > 0);
> > -    atomic_dec(&ctx->external_disable_cnt);
> > +    int old;
> > +
> > +    old =3D atomic_dec_fetch(&ctx->external_disable_cnt);
>=20
> Did you mean atomic_fetch_dec? atomic_dec_fetch is new, not old.

Yes :(.  Will send another revision.

It's good to have both semantics available but clearer naming would
help, e.g. atomic_dec_then_fetch() or atomic_dec_before_fetch().  Glad
you spotted the bug!

Stefan

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEKGJAAoJEJykq7OBq3PIpRMH/3e7ncJfkSpPHsJqTctbzpn/
C7Kb/0W0tx2I2C218iTDPOQMuDBPE6as7FxVV8wTS4hVe1GqWwBO0GSGHQBf3Lys
PaSezvqfOj58gVKY+MVNQs8otzc/B3nT5AvClL9b511OI0ySNrwdJjNfK8RDuXTF
wCfXcfb5Z4Y0AyE0oUxY0eGL1VnAOPODv+KIC9AePhK0An4YiXWp/YElIHn1LKBo
Y5y0sBImXJFDOK7DyP+myyjTgltkWByZpCvzPJgsyaKhELHOB/NgAKDggo9EtLjs
FZzhlHcXRDUjxV8YVKGlDMvFgZvLVXvOGzdj/Y7oYQtwXBZSslFSKuG1NPyYph8=
=9uN0
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
