Received: from eggs.gnu.org ([2001:4830:134:3::10]:54501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwBJk-0003IY-TJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwBJk-0005gr-1J
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:35:32 -0400
References: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
	<1491498851-16709-2-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af573474-b17f-4c53-f592-e8147ad5a79e@redhat.com>
Date: Thu, 6 Apr 2017 12:35:21 -0500
MIME-Version: 1.0
In-Reply-To: <1491498851-16709-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BI8RxDWdUX0jQEep60DkGlahNXfi8wNoW"
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] commit: Set
 commit_top_bs->aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BI8RxDWdUX0jQEep60DkGlahNXfi8wNoW
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <af573474-b17f-4c53-f592-e8147ad5a79e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] commit: Set
 commit_top_bs->aio_context
References: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
 <1491498851-16709-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491498851-16709-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 12:14 PM, Kevin Wolf wrote:
> The filter driver that is inserted by the commit job needs to use the
> same AioContext as its parent and child nodes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BI8RxDWdUX0jQEep60DkGlahNXfi8wNoW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5nxZAAoJEKeha0olJ0NqexgIAJPcAvbXedZEOFlu2nDdcLQD
tM0JiLZ1YY1C+e/v0wKtDm/POmWXFwZKWCHX56ZPQTVq2R6EN3C3lKiTNjribpX7
EpjeJyU0DpZnjkZVV25Y2sL7CXKsB1ZjSDkVDdilDus5fZalQySoGeptUQz8UEUg
joFBbF4fXJyLNAr5J1gPdqxClxqYy/5468eqsfU7q2JJ/dPB0WzNFnkb2Cf7civl
aew/Irk3UTow7J9NRMw+XYbTwjjBmj7VL/6iSXUznDbSVvr0VreQlvK9H8cWbm97
uaspWWwN63hR2d1jlzPrMRFEbyWFVBcvcPJaAaAw66naDxecCu6Y9/070cgFqzw=
=DxXe
-----END PGP SIGNATURE-----

--BI8RxDWdUX0jQEep60DkGlahNXfi8wNoW--
