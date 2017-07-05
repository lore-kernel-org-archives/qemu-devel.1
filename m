Received: from eggs.gnu.org ([2001:4830:134:3::10]:39077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSkUa-0005HU-Sj
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSkUX-0004Pb-P1
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:20 -0400
Date: Wed, 5 Jul 2017 15:37:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170705133709.GB5297@noname.redhat.com>
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
	<20170704084059.6278-2-el13635@mail.ntua.gr>
	<20170704094417.GA4253@noname.str.redhat.com>
	<d04ba821-25a5-8cc8-9645-af667cf59dc3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <d04ba821-25a5-8cc8-9645-af667cf59dc3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] block: Pass bdrv_* methods to
 bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.07.2017 um 14:43 hat Eric Blake geschrieben:
> On 07/04/2017 04:44 AM, Kevin Wolf wrote:
> > Am 04.07.2017 um 10:40 hat Manos Pitsidianakis geschrieben:
> >> The following functions fail if bs->drv does not implement them:
> >>
>=20
> >> @@ -511,6 +513,8 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGe=
ometry *geo)
> >> =20
> >>      if (drv && drv->bdrv_probe_geometry) {
> >>          return drv->bdrv_probe_geometry(bs, geo);
> >> +    } else if (drv && bs->file && bs->file->bs) {
> >> +        return bdrv_probe_geometry(bs->file->bs, geo);
> >>      }
> >> =20
> >>      return -ENOTSUP;
> >=20
> > The probed geometry would refer to the physical image file, not to the
> > actually presented image. So propagating this to bs->file is wrong for
> > image formats.
> >=20
> > Possibly checking .is_filter in addition would be enough.
>=20
> In fact, this made me think: if we define .is_filter as an enum instead
> of a bool, we could implement 0 for no filter, 1 for file filter, and 2
> for backing filter.  Then instead of having to have 2 separate default
> bdrv_get_block_status_for_*() generic functions in patch 4, we could
> instead patch bdrv_co_get_block_status() to check .is_filter, and
> automatically fall back to bs->file or bs->backing according to the enum
> value stored in .is_filter.

After reviewing the rest of the series, I'm not completely convinced of
using .is_filter any more. If you look at the patch for the raw format
driver, it actually turns out that even though we would intuitively call
it a filter, it has different properties than for example a throttle
filter and passing through function calls to bs->file makes sense for a
different set of functions.

Kevin

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZXOuFAAoJEH8JsnLIjy/W3wcP/1IPsTaPumZ8vtO+BC1UDUJ3
Q0wYXPEtGz1ekMCrhi04aYw03oaTS8xu9m0BbVB1ivcU7n/cqpLYnBeQOSMz1urq
a5rXpSyYjdCMhxwtwxHdqY2cO2A3E6+9gAxn7LsUpkXvxkcQ6lWCwRu96RPB5AyS
ShImXXQ0MOl1MW3w0sT1ytk8BuPByTV6pmErBlLtOEiO6NDHw2OuVrVhV1OQ0Wal
nLkRodZnLHatSaeSqVt6WvyoW+JxCMFSFCSYxg457O2rWn6OnDixgmciB/Z+YZKB
hplVUBpqr79CLIQIszdFWzcFk9M0dk6Kr90ypiCapwTc3UCgfqjb2tEko1XI7rVE
9QFxmm3kX8GIiunXHCMlBrSIakc4sZ0W75wS+ALhNI96wtxeGm7AxnAoTIJXVo9Z
t3i4fOZ6N8mwtuhNF2U9Swf2IYh8kMjtrYqzMjFbqv+0oAKsa20xepp2pIWd1bIl
uJYiLTvn0JrAz8nWMmRclXLf5zHnX9TojHsZPLwhr2o0/+OiZLjnIPBI5kdQDRlp
5YLUCRcwIFctGOIFp7E+zBRWJiBpmUPuPT0j0sT8mKxw4wVb8RXniB+TP2GsEXsG
j8CZR8fFXoZCLNo6KSK4ixAI9UBGaHqm1eCLMmtAx/3dndPaxzUl6RqbiS00i55z
t5qCA0hAn7EiQYtDEVSo
=VpcI
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
