Received: from eggs.gnu.org ([2001:4830:134:3::10]:57499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8Zt-0000SY-Fn
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8Zq-0004yg-9a
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:25:53 -0500
Date: Tue, 21 Feb 2017 11:25:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170221112546.GE22731@stefanha-x1.localdomain>
References: <20170220165204.1980-1-stefanha@redhat.com>
	<9ae46905-78f4-7bb9-8e83-9c7e2f8b982a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <9ae46905-78f4-7bb9-8e83-9c7e2f8b982a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-options: explain disk
 I/O throttling options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 01:40:21PM -0600, Eric Blake wrote:
> On 02/20/2017 10:52 AM, Stefan Hajnoczi wrote:
> > The disk I/O throttling options have been listed for a long time but
> > never explained on the QEMU man page.
> >=20
> > Suggested-by: Nini Gu <ngu@redhat.com>
> > Cc: Alberto Garcia <berto@igalia.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qemu-options.hx | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 5633d39..b2254cc 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -587,6 +587,31 @@ file sectors into the image file.
> >  conversion of plain zero writes by the OS to driver specific optimized
> >  zero write commands. You may even choose "unmap" if @var{discard} is s=
et
> >  to "unmap" to allow a zero write to be converted to an UNMAP operation.
> > +@item bps=3D@var{b},bps_rd=3D@var{r},bps_wr=3D@var{w}
> > +Specify bandwidth throttling limits in bytes per second, either for al=
l request
> > +types or for reads or writes only.  Values must be larger than the max=
imum
> > +request size to avoid timeouts or hangs in the guest.  At minimum use =
2 MB/s
>=20
> s/At minimum/At a minimum,/
>=20
> With that tweak,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Will fix when merging.

Stefan

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrCO6AAoJEJykq7OBq3PIhysH/RU0znxlJPlNwbFXFRRfNog0
gRxfTG6ntgR/SRYDd/eblDPemHl6Xt+L49V6J4JiXFkSDkanvh4uyS4I2tOOL5Dw
Y7tJRRqQekpdo8RmhTLHZxURE5knud7qh/m9ohXD7RAIQs3UugfItpPDxq3+gmr3
UnKbqo2q03EfW6yodgsyaPBaPI7r6GiCI1u0JDaXCqWEXx3QKcLukPWwwdZ1NclG
JNb+EuAn9S8Hr3FWPELWoWoZ9QnAxaLOsNLlWCbnuj/sg8FJVVQF4HZ/xgwwCjxP
QNCanlZMPdw6jrMlmKQLsYX/2oC9ZhrlfoMMHOWSoPzZVjzaFB0XZVdMbu5T7Cg=
=mpQe
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
