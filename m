Received: from eggs.gnu.org ([2001:4830:134:3::10]:44719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3L8-0007RR-3G
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3L2-0002Qd-Gk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr3L2-0002Q4-8U
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:03:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3ED9CC1C5DFB
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 14:03:40 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <56e47d56-3ed5-b4ed-b362-536588be0309@redhat.com>
Date: Thu, 23 Mar 2017 09:03:37 -0500
MIME-Version: 1.0
In-Reply-To: <1490266548-22500-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fqOm1tWj8wKTl1jrIj1V1v9hcVxGOS2X1"
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/5] rbd: Clean up runtime_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fqOm1tWj8wKTl1jrIj1V1v9hcVxGOS2X1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <56e47d56-3ed5-b4ed-b362-536588be0309@redhat.com>
Subject: Re: [PATCH for-2.9 1/5] rbd: Clean up runtime_opts
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490266548-22500-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 05:55 AM, Markus Armbruster wrote:
> runtime_opts is used for three different purposes:
>=20
> * qemu_rbd_open() uses it to accept options it recognizes, such as
>   "pool" and "image".  Other .bdrv_open() methods do it similarly.
>=20
> * qemu_rbd_open() accepts additional list-valued options
>   auth-supported and server, with the help of qemu_rbd_array_opts().
>   The list elements are again dictionaries.  qemu_rbd_array_opts()
>   uses runtime_opts to accept their members.  Thus, runtime_opts
>   contains recognized sub-sub-options "auth", "host", "port" in
>   addition to recognized options.  No other block driver does that.
>=20
> * qemu_rbd_create() uses it to converts the QDict produced by

s/converts/convert/

>   qemu_rbd_parse_filename() to QemuOpts.  No other block driver does
>   that.  The keys produced by qemu_rbd_parse_filename() are "pool",
>   "image", "snapshot", "conf", "user" and "keyvalue-pairs".
>   qemu_rbd_open() accepts these, so no additional ones here.
>=20
> This is a confusing mess.  Dates back to commit 0f9d252.  First step

That commit is unreleased, so we are still free to improve it before 2.9
is finalized.

> to clean it up is documenting runtime_opts.desc[]:
>=20
> * Reorder entries to match the QAPI schema, like we do in other block
>   drivers.
>=20
> * Document why the schema's "server" and "auth-supported" aren't in
>   .desc[].
>=20
> * Document why "keyvalue-pairs", "host", "port" and "auth" are in
>   .desc[], but not the schema.
>=20
> * Delete "filename", because none of the three users actually uses it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fqOm1tWj8wKTl1jrIj1V1v9hcVxGOS2X1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09W5AAoJEKeha0olJ0Nq5lUH/3ItW7iJAvjxSyllrAWA9IDg
Kv210zTkUAI7ZEpt5nNnGm00SlluoHx/xKW2q1HvABbU64BC5AOZ8F9yk5PKWugU
CxrwDb8dogYSHxFuWWys4WwC9gJbCwoB/An2hNbfy2d0Pc6i8e1TXLFBnt1sZajd
HW6+rCwVvezj33WewVEvC9+wXuy1fSpmxjaSFSiuLkiN7YCQR5gl6Hj1eQsheRhu
pKcc1kf4okadIIncYH1qlqw87KlaqFt7MiWYEzOjmnS+DWqL4f5sfklwTG51GhLH
F/xtAH26bt1HRfzOOb+sPiVNJSPplK0VMhyMq8F09ElCo3uxTuvyhxaC05ti8CE=
=0gAT
-----END PGP SIGNATURE-----

--fqOm1tWj8wKTl1jrIj1V1v9hcVxGOS2X1--
