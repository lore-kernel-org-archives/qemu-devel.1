Received: from eggs.gnu.org ([2001:4830:134:3::10]:51343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZ5r-0000y4-Qr
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZ5q-0004b4-PU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:51:19 -0400
References: <20170710083553.6167-1-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb92a87e-193a-9f61-38c5-ee69fcff2a97@redhat.com>
Date: Mon, 10 Jul 2017 08:51:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170710083553.6167-1-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IfAIVQvxPiBbsGacNVOkJFvS1NsjqnqIW"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix possible return code
 clobbering in bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IfAIVQvxPiBbsGacNVOkJFvS1NsjqnqIW
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <bb92a87e-193a-9f61-38c5-ee69fcff2a97@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix possible return code
 clobbering in bdrv_co_pdiscard
References: <20170710083553.6167-1-den@openvz.org>
In-Reply-To: <20170710083553.6167-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 03:35 AM, Denis V. Lunev wrote:
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block I/O path)
> CC: Fam Zheng <famz@redhat.com> (supporter:Block I/O path)

The commit message is a bit sparse; I might have written:

block: fix shadowed variable in bdrv_co_pdiscard

We've had a shadowed 'ret' variable, which risks returning the wrong
value, introduced in commit b9c64947.

> ---
>  block/io.c | 1 -
>  1 file changed, 1 deletion(-)

Adding qemu-stable in cc, and you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

[and I wonder why gcc doesn't flag the shadowed variable for me - I
definitely touched that code in commit 9f1963b3, but didn't notice that
I kept the shadowing in place.  I guess we don't have that compiler
warning flag turned on for default configuration]

>=20
> diff --git a/block/io.c b/block/io.c
> index ed31810c0a..e5c6dc77d3 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2464,7 +2464,6 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverStat=
e *bs, int64_t offset,
>      assert(max_pdiscard >=3D bs->bl.request_alignment);
> =20
>      while (count > 0) {
> -        int ret;
>          int num =3D count;
> =20
>          if (head) {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IfAIVQvxPiBbsGacNVOkJFvS1NsjqnqIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY4ZGAAoJEKeha0olJ0NqGh8IAJO47Qx1/hEWWQRDjcD/q+UX
8lZ+7WxXRliiCZ6hWTu3/sf2LrByVOZaBGxVkWLXPshmBQch2vPleZLaotzViVtM
mRTcBWr1N4tU1fBxS5yc2mYSRWTk7csXxPHkSkaPM4KB/qLYWt8HveoU3US3CQDV
/Dm1i54881yLJXN9QjCrPsksJFEsd48ZVsRzfWMN9OPfh1Elq5RYgLhwOxEhJ3ZE
tH/nZyXi9KUv5E7727Iq3xG8rgxcz+BPh/DX7rclgqFY6bv7RkvZx2soEje0kdpZ
G37iQhOg7Y3SHV1GRAIaDz0fOGyu9cIs9Aodl/7j3zozQOElfjEIaTtbi5gzeHY=
=2bON
-----END PGP SIGNATURE-----

--IfAIVQvxPiBbsGacNVOkJFvS1NsjqnqIW--
