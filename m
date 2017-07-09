Received: from eggs.gnu.org ([2001:4830:134:3::10]:38176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUJqH-0004FK-Bp
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUJqG-0006ie-KR
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:34:13 -0400
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
	<20170707143028.692-3-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff06c980-331d-4845-761a-14e43c6cf901@redhat.com>
Date: Sun, 9 Jul 2017 23:34:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170707143028.692-3-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XsCpnFBxjGlHHWtxxvEOj7gDiDToGmSiQ"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qcow2: add qcow2_cache_discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XsCpnFBxjGlHHWtxxvEOj7gDiDToGmSiQ
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <ff06c980-331d-4845-761a-14e43c6cf901@redhat.com>
Subject: Re: [PATCH v3 2/4] qcow2: add qcow2_cache_discard
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
 <20170707143028.692-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170707143028.692-3-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-07 16:30, Pavel Butsykin wrote:
> Whenever l2/refcount table clusters are discarded from the file we can
> automatically drop unnecessary content of the cache tables. This reduce=
s
> the chance of eviction useful cache data and eliminates inconsistent da=
ta
> in the cache with the data in the file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2-cache.c    | 26 ++++++++++++++++++++++++++
>  block/qcow2-refcount.c | 14 ++++++++++++++
>  block/qcow2.h          |  3 +++
>  3 files changed, 43 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--XsCpnFBxjGlHHWtxxvEOj7gDiDToGmSiQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYqFKEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOrf
CACFb+WbZ7vlr3Pfae8bhyIaNwIWLzzpEDdUOaAGDiLAKTnNzaC6LCesLku0P9xi
piizWps3960qxPW93B0MYVWBYWgfR8c3n5xYdwswVxQTiqXZImiZqjhmwhwaU1zS
cjKnbNzcNEpku6mzj5WQxDA2xBpOXUk9NQx9E7EdgaQYjzqGdwDHQYvTjQ7XEiz6
lNYL/gydl7xacWZhxU+wxizD6yZykJRh8cAIA/EmDeGorwXd+SVSoHSHskorcJ45
UZYedwj1LcxT1/nqZHLw+8Op7vTVtUKUqEZT78nQp8knuGpWoFqO0ZpW0u8ImVVJ
eQhZQNSjtK7cePIAKQqfEibC
=u3+0
-----END PGP SIGNATURE-----

--XsCpnFBxjGlHHWtxxvEOj7gDiDToGmSiQ--
