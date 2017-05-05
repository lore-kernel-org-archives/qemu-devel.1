Received: from eggs.gnu.org ([2001:4830:134:3::10]:45449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d6a5D-0006PB-LI
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d6a5C-0007oc-Pq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:03:31 -0400
Date: Fri, 5 May 2017 11:03:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170505100319.GB10435@stefanha-x1.localdomain>
References: <20170504102339.31971-1-stefanha@redhat.com>
	<22096620-8f3b-88b2-3e6d-e40869b567c2@redhat.com>
	<20170504105458.GA6865@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20170504105458.GA6865@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] aio: add missing aio_notify() to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 06:54:58PM +0800, Fam Zheng wrote:
> On Thu, 05/04 12:36, Paolo Bonzini wrote:
> > On 04/05/2017 12:23, Stefan Hajnoczi wrote:
> > > diff --git a/include/block/aio.h b/include/block/aio.h
> > > index 406e323..5294b04 100644
> > > --- a/include/block/aio.h
> > > +++ b/include/block/aio.h
> > > @@ -456,6 +456,7 @@ static inline void aio_enable_external(AioContext=
 *ctx)
> > >  {
> > >      assert(ctx->external_disable_cnt > 0);
> > >      atomic_dec(&ctx->external_disable_cnt);
>=20
> This can be changed to atomic_fetch_dec and only call aio_notify if it re=
turned
> 1, which is cleaner.

Nice idea.  Will send v2.

Stefan

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDE3nAAoJEJykq7OBq3PIuakH/0Wo4D7j2lc/xnBUXd3E8tSZ
vwfAa9ky6afWXDv0c/LmT9f4nX/Zkk4vK+KEjxRVMbhW8y98/BaXAAzg1oZV9h1X
4Ub/2w55kJbAWQw7k51MswJiUGc8//Wmr+sKfeCB0BsSGEjiOVR+0mhZ8ahkw4Go
Pvzc1rB5jKBZuBFXNJTjT3I0r9dpXsIlJeJeCsjmT4p0pme8uu5JBf37B2HQWV26
b/5WTHwdWFA5KGTBQY7pLaL/KngN1135UkdaK4Q/3pU/FcChkLgJXRBgu/jq6fUk
z1NVulmURcl53qa6AAw30U00pkVPC66VRLaAnCJFsPN4oG6HiBjNwIawb3lRIuY=
=SaQ2
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
