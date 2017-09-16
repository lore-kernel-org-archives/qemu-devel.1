Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtEZ3-0005iJ-08
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtEZ2-0001aR-6j
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:59:25 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
	<20170817091542.9403-3-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <09978310-5fb0-21d4-2908-8cbbee8f1ac8@redhat.com>
Date: Sat, 16 Sep 2017 16:59:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170817091542.9403-3-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9DxpO2BxKGaCqu6AjQ3lJh9G8u41LnRlu"
Subject: Re: [Qemu-devel] [PATCH v7 2/4] qcow2: add qcow2_cache_discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9DxpO2BxKGaCqu6AjQ3lJh9G8u41LnRlu
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 den@openvz.org
Message-ID: <09978310-5fb0-21d4-2908-8cbbee8f1ac8@redhat.com>
Subject: Re: [PATCH v7 2/4] qcow2: add qcow2_cache_discard
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
 <20170817091542.9403-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170817091542.9403-3-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-17 11:15, Pavel Butsykin wrote:
> Whenever l2/refcount table clusters are discarded from the file we can
> automatically drop unnecessary content of the cache tables. This reduce=
s
> the chance of eviction useful cache data and eliminates inconsistent da=
ta
> in the cache with the data in the file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cache.c    | 26 ++++++++++++++++++++++++++
>  block/qcow2-refcount.c | 20 ++++++++++++++++++--
>  block/qcow2.h          |  3 +++
>  3 files changed, 47 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

(This patch has changed since I last reviewed it in v5.)


--9DxpO2BxKGaCqu6AjQ3lJh9G8u41LnRlu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9PD4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2foH+wThHoUAHvg3djj22XgA7waGm9Pnwuz3
QbCKD1WpIJeeSOj/Q3ecgLYlTg0eW20IYgvd3H/TM66EHNgvo2xVyJBM4eB7w+zL
e1PauM9hLb86HNj7Qdh+Yjser95ucS+71OtzMgrqLUR7SbDSW1cu7/TCKaETAyzf
/4PCbQ3B5fAMD1LxvqbCjSKME6YOhMQvplEyUiTxhAKRfwuMJ/ru6whvrKdR9bCz
HMqB2Wmc1F4uj+WKIKR4go+rONqev+NCqNxbp2E6vueqsJxXp6P85ZIW6bngNoah
4bwTYSGKdTATQKHtUAKXZ8La4HfMe7xP8ZbcjS831nJrT+HnKBG9P4U=
=wU7o
-----END PGP SIGNATURE-----

--9DxpO2BxKGaCqu6AjQ3lJh9G8u41LnRlu--
