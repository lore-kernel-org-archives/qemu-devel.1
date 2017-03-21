Received: from eggs.gnu.org ([2001:4830:134:3::10]:58220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8zR-000638-BX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8zO-0004X4-AC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:53:37 -0400
References: <1490060356096-474442.post@n7.nabble.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0268b783-e9fb-8c16-8198-c0bb4e6ca9d3@redhat.com>
Date: Mon, 20 Mar 2017 20:53:30 -0500
MIME-Version: 1.0
In-Reply-To: <1490060356096-474442.post@n7.nabble.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UFPeqJFR6ibu3mu7duNk91M6fXVjUjx60"
Subject: Re: [Qemu-devel] [PATCH v5]COLO:Fix spell error in Colo doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UFPeqJFR6ibu3mu7duNk91M6fXVjUjx60
From: Eric Blake <eblake@redhat.com>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org,
 qemu-trivial <qemu-trivial@nongnu.org>
Message-ID: <0268b783-e9fb-8c16-8198-c0bb4e6ca9d3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5]COLO:Fix spell error in Colo doc
References: <1490060356096-474442.post@n7.nabble.com>
In-Reply-To: <1490060356096-474442.post@n7.nabble.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 08:39 PM, wangguang wrote:
> Subject: [PATCH]COLO:Fix spell error in Colo doc

I added qemu-trivial in v4; you should keep it in the loop.

Still missing a space after ':' in the subject line, and still the
awkward duplication of the subject line in the body of the commit message=
=2E

>=20
> This is an error in COLO-FT.txt.=20
> secondeary-disk0 should be secondary-disk0.=20
>=20
> Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>

Since I gave R-b on v4, it's worth adding it here to save time to show
that no code has changed since that submission.  Otherwise, it's nice to
mention (after the --- separator) what changed from the previous version
to cause you to send the next revision.

At any rate,
Reviewed-by: Eric Blake <eblake@redhat.com>

> ---=20
>  docs/COLO-FT.txt | 2 +-=20
>  1 file changed, 1 insertion(+), 1 deletion(-)=20
>=20
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt=20
> index e289be2..bec7547 100644=20
> --- a/docs/COLO-FT.txt=20
> +++ b/docs/COLO-FT.txt=20
> @@ -139,7 +139,7 @@ Secondary:=20
>  { 'execute': 'nbd-server-start',=20
>    'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx=
',
> 'port': '8889'} } }=20
>  }=20
> -{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk=
0',
> 'writable': true } }=20
> +{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0=
',
> 'writable': true } }=20
>  =20
>  Note:=20
>    a. The qmp command nbd-server-start and nbd-server-add must be run=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UFPeqJFR6ibu3mu7duNk91M6fXVjUjx60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0IeaAAoJEKeha0olJ0NqLEAIAKapqYMiyWqGhKoJCF7B7Eav
SLKyFd15EoSrrFMYJoqXCd+AAj5F7gAFMeee/+bfDcVTliJSGnpn77WU1CV59y0S
srSYpiCnC+uGN0ybP4tAuBjfc6Iq/Dmm2iAGohVgycp/0qoQ3Xvay1gLIJW1NKmm
Id11qNBwz+YIPhWz7oIZB13yxD8JqyVxnrF2T7z5zPlp5v59yzB/1avFMtOjvvd6
HGmXKGN8N8937ioYTQLizwRmeGIbfnlq9CVwq5m8yHltmrSuSgi63bZHjr5AVDJw
qlbZcvlnhkGgLFNjafGRRThZOVBJydBRnNNZzAUvuOli2SAHcAR0BaWXPYexnj8=
=S0tQ
-----END PGP SIGNATURE-----

--UFPeqJFR6ibu3mu7duNk91M6fXVjUjx60--
