Received: from eggs.gnu.org ([2001:4830:134:3::10]:48201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWWUq-0006jQ-VB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 17:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWWUn-00057w-Sh
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 17:56:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cWWUn-00057k-Mi
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 17:56:53 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8330561BA2
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 22:56:53 +0000 (UTC)
References: <1485381149-19044-1-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d586519-da5a-b5d1-6c17-d71965174dd9@redhat.com>
Date: Wed, 25 Jan 2017 16:56:45 -0600
MIME-Version: 1.0
In-Reply-To: <1485381149-19044-1-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b6jJcGiOaQUf2w0svadOsEvUhwDKNDk2d"
Subject: Re: [Qemu-devel] [PATCH] qxl: switch to constants within
 BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b6jJcGiOaQUf2w0svadOsEvUhwDKNDk2d
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <5d586519-da5a-b5d1-6c17-d71965174dd9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qxl: switch to constants within BUILD_BUG_ON
References: <1485381149-19044-1-git-send-email-mst@redhat.com>
In-Reply-To: <1485381149-19044-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2017 03:52 PM, Michael S. Tsirkin wrote:
> We are switching BUILD_BUG_ON to verify that it's parameter is a
> compile-time constant, and it turns out that some gcc versions
> (specifically gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609) are
> not smart enough to figure it out for expressions involving local
> variables. This is harmless but means that the check is ineffective for=

> these platforms.  To fix, replace variables with macros.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/display/qxl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--b6jJcGiOaQUf2w0svadOsEvUhwDKNDk2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYiS0tAAoJEKeha0olJ0NqEPYH/jMFN71q6EAlaAjZwr/zb59m
wrcVCRUmc2aVwHtPzc4P0dxESq+yVDUSX6HrKf033Qe4EFMF8rjF5+5epibLNXsG
CBeOa/EakhWvsK92fdmKECXgBA8wsh143Lg2BeHeDO5X0rlB3WoT62lbD7yigvyo
DfAmlfkrMPYQnFg8o4CQfDI0Lm3Z4XIHjag0f73zYNoFN3G91cwMwPVTMifHPoat
3rxPw25ehoGGODouRM+W6s+u9oTnFu1aBAu1WeyHTLBA2odFMvcVcLDK5y+Iw3bI
vR9LbMCQrLSrguq8Q/QUMJ/Nw20L+GkAq6XlVZGXUPaYcbPMLUqpSpqsGJr3w44=
=3GKX
-----END PGP SIGNATURE-----

--b6jJcGiOaQUf2w0svadOsEvUhwDKNDk2d--
