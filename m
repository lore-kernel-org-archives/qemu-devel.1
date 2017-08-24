Received: from eggs.gnu.org ([2001:4830:134:3::10]:54601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkv1Z-0008C3-Bi
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkv1W-0006mc-8U
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:30:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkv1V-0006lq-Uq
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:30:26 -0400
References: <20170824091907.17676-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd7ebf5c-6d81-6cdf-f6b2-87af4cb00f85@redhat.com>
Date: Thu, 24 Aug 2017 11:30:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170824091907.17676-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F5E6UWS3cbAS0dPfFpOv8Jx8xA40GAmRp"
Subject: Re: [Qemu-devel] [PATCH] vga: stop passing pointers to
 vga_draw_line* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: d@vidbuchanan.co.uk, P J P <ppandit@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F5E6UWS3cbAS0dPfFpOv8Jx8xA40GAmRp
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: d@vidbuchanan.co.uk, P J P <ppandit@redhat.com>
Message-ID: <cd7ebf5c-6d81-6cdf-f6b2-87af4cb00f85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vga: stop passing pointers to vga_draw_line*
 functions
References: <20170824091907.17676-1-kraxel@redhat.com>
In-Reply-To: <20170824091907.17676-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 04:19 AM, Gerd Hoffmann wrote:
> Instead pass around the address (aka offset into vga memory).
> Add vga_read_* helper functions which apply vbe_size_mask to
> the address, to make sure the address stays within the valid
> range, simliar to the cirrus blitter fixes (commits ffaf857778

s/simliar/similar/

> and 026aeffcb4).
>=20
> Impact:  DoS for priviledged guest users.  qemu crashes with

s/priviledged/privileged/

> a segfault, when hitting the guard page after vga memory
> allocation, while reading vga memory for display updates.
>=20
> Fixes: CVE-2017-xxxx

Do we have the actual number? Are we trying to get this in 2.10-rc4, or
is it merely 2.11 + qemu-stable (2.10.1) material?

> Cc: P J P <ppandit@redhat.com>
> Reported-by: David Buchanan <d@vidbuchanan.co.uk>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga-helpers.h | 202 ++++++++++++++++++++++++++-------------=
--------
>  hw/display/vga_int.h     |   1 +
>  hw/display/vga.c         |   5 +-
>  3 files changed, 114 insertions(+), 94 deletions(-)
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--F5E6UWS3cbAS0dPfFpOv8Jx8xA40GAmRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme/xoACgkQp6FrSiUn
Q2q7pQf9HB9PelHXlukMeAXzdn/k8MlrqO4c755T3xEt6txNM8A54WC96KQ6iKOt
jKXgdABUrqEUKwhsXc0PwXQoOfsz2W94wTmkPUEzl0qOFREXDSKAd3tpYUjHLWQ7
iaygmFnWdhhKysZs4pbup0SC4xqdAZt1Uh056KFNuHyUpvdnzmZkUzQWJplVfZfl
BXcw3Qvh+VObr+jlIcLsB/5j2Gb+TPlf5zdgoo48iywP0vc4dv2eDw+Sj8elOcK4
9c6v0SQcwJFnXIdQu0g8TYgjsfyUVzvF/RQxJ4W4/zhE8451+WC4lkLM0YpnkCK2
2p2gqm1Ly5kP6DJKvH3KJb/Uhf9a2A==
=Qlgl
-----END PGP SIGNATURE-----

--F5E6UWS3cbAS0dPfFpOv8Jx8xA40GAmRp--
