Received: from eggs.gnu.org ([2001:4830:134:3::10]:46950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejS2l-0002wG-Cd
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejS2k-0005hR-EO
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:53:55 -0500
Date: Wed, 7 Feb 2018 15:53:45 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180207155345.GC1446@stefanha-x1.localdomain>
References: <20180207071758.6818-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20180207071758.6818-1-w.bumiller@proxmox.com>
Subject: Re: [Qemu-devel] [PATCH] ratelimit: don't align wait time with
 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 08:17:58AM +0100, Wolfgang Bumiller wrote:
> It is possible for rate limited writes to keep overshooting a slice's
> quota by a tiny amount causing the slice-aligned waiting period to
> effectively halve the rate.
>=20
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
> Copied the Ccs from the discussion thread, hope that's fine, as I also
> just noticed that for my reply containing this snippet I had hit reply
> on the mail that did not contain those Ccs yet, sorry about that.
>=20
>  include/qemu/ratelimit.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeyEJAAoJEJykq7OBq3PINHcIAJLr/zZyf7siADqH2lnJChr4
c774v2NdxuNqad65nCLiYjkCd5FnOmikJC/jqveNswYjyo6p6OVIx6cLYZH2UbLx
iOvC7VfuoAnOhwG1MOFgT4tDjMMJZimPMD5BljDNLA41ZMXWp6/ejgQwuiQisMBO
8m8OtdF1ll6c5zKkOrDItFuCrXruZLoSkbzwLRiYdzpKhe5WCaUQMRaR48G8vEpt
S18BEwDrA7B/9wB8cvWFqEcZHrE+fy1ILvHjbZB9Y/uAxth8nQMxrRMT/Gf1+zcg
06RHVPmN1rLrqfJe6gk4Va3TLDwfSVI321eny8w6qAo4VycLu0PPPO17J2zP3lc=
=65sE
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
