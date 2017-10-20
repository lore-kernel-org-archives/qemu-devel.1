Received: from eggs.gnu.org ([2001:4830:134:3::10]:38348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5ZGk-0004W4-5T
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5ZGh-0002gr-2W
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:31:30 -0400
Date: Fri, 20 Oct 2017 17:31:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171020153100.GA31112@localhost.localdomain>
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-8-eblake@redhat.com>
	<20171020143124.GB3667@localhost.localdomain>
	<009ec057-2324-4614-6185-623edd22f559@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <009ec057-2324-4614-6185-623edd22f559@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/24] block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.10.2017 um 17:12 hat Eric Blake geschrieben:
> On 10/20/2017 09:31 AM, Kevin Wolf wrote:
> > Am 12.10.2017 um 05:47 hat Eric Blake geschrieben:
> >> We are gradually moving away from sector-based interfaces, towards
> >> byte-based.  In the common case, allocation is unlikely to ever use
> >> values that are not naturally sector-aligned, but it is possible
> >> that byte-based values will let us be more precise about allocation
> >> at the end of an unaligned file that can do byte-based access.
> >>
>=20
> >>   *
> >> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MA=
SK)
> >> - * represent the offset in the returned BDS that is allocated for the
> >> - * corresponding raw data; however, whether that offset actually cont=
ains
> >> - * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follo=
ws:
> >> + * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MA=
SK) of
> >> + * the return value (old interface) or the entire map parameter (new
> >> + * interface) represent the offset in the returned BDS that is alloca=
ted for
> >> + * the corresponding raw data.
> >=20
> > Are there any functions using the old interface left at the end of the
> > series or do we want a final patch that removes the old interface from
> > the description?
>=20
> Done here, in series 4, where we get rid of the old interface in the
> drivers:
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02941.html

Oh, right, I forgot about the driver callbacks. Makes sense.

Kevin

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ6ha0AAoJEH8JsnLIjy/WFAkQAIhuKv15ZwgyHN7XM+QmoHFH
Yt2wviUZzi4SIlzJxLMpafa3C7E9UDZIQZBm73pgcAMTlUDVmj8gxoLuC/AmLZ0H
4ZXvNnQV4d3bHIPPPN8kkjqQecPIw8UHwFqlNGYOAvwpBoITfCpKbDJMIzywGTtY
a+q2YUB6wRcUBmHIjYUh8cy2bHd26bCUNijvvRXj5FelTi2pDMfEtLHj9Zpj9Gd3
3W/i9u1Cj6Iwidg3qUcc7Nb8TpQjcurKRtajSmPE6+mRmiNf44Ec0SLL5jvWGq6q
qYa36wtIAkojWaPP7VFCFKXgpdC6ydWJdbRbzQSnhAmUFOxqXGBjutO4ix9/6knn
g6iWrHJjZQfGm/pvfHcOw+zqQOUW/sarNFdXZExzjRL7G9snL6QSt7Rf6nGVtR3+
mBKUj6dzKiw3PPZbrTFqmuXgL4F2VaE85OsabayakQ2scmvdxNfkz5Bb9uhZB+v+
lQvdj1kkY29VJpr0jcnC2t1uikx5B/lm2W6r159+g9kAyo1WpNCoXdLCb/wAarWg
Q+h3/cY0WOYPZYBcb5gCWwWq/yq6gYfgOHoEI1dwZNywMn8Z4kORglbm7b/brq4c
hNLSpyoJ3LbJS5/DQSwZ0AuYMREtzxhBAYjzlGQruRq4H2+2UUW/7Mzyr8goNynF
Vd/odXrypFa9yl/Mwlqs
=TJKt
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
