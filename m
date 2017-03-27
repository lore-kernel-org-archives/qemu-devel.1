Received: from eggs.gnu.org ([2001:4830:134:3::10]:38316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXfF-00033k-7o
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXfB-0007ZZ-97
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXfB-0007Xz-1E
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:38:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE7D07E9EA
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:38:35 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-7-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ef833d21-78b6-d4da-90c7-ca2a54956d48@redhat.com>
Date: Mon, 27 Mar 2017 18:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a4j5a2G2uSMjrsiTi0BvdCUD03gI13Ph7"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 06/11] rbd: Clean up
 runtime_opts, fix -drive to reject filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a4j5a2G2uSMjrsiTi0BvdCUD03gI13Ph7
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <ef833d21-78b6-d4da-90c7-ca2a54956d48@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 06/11] rbd: Clean up runtime_opts, fix
 -drive to reject filename
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
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
> * qemu_rbd_create() uses it to convert the QDict produced by
>   qemu_rbd_parse_filename() to QemuOpts.  No other block driver does
>   that.  The keys produced by qemu_rbd_parse_filename() are "pool",
>   "image", "snapshot", "conf", "user" and "keyvalue-pairs".
>   qemu_rbd_open() accepts these, so no additional ones here.
>=20
> This is a confusing mess.  Dates back to commit 0f9d252.  First step
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
>   This fixes -drive to reject parameter filename instead of silently
>   ignoring it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--a4j5a2G2uSMjrsiTi0BvdCUD03gI13Ph7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZQAgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzNEH/3KWBbuskmimjem2CYoaXI1n1nFJtEWz
Ns3iVKUd6x1LsLN5zD1PB5ObQPyBQrJA5Ouc4b7TBqVQiPg1uyJRiDUurzxldxXE
nfFeXSHbDVVMPu1PjusUmkXkiQ6lCqo1E8fz63ny1o8EKD0nqQT4ceZfbnaPvo6K
igypGWuuQxjjpi1siQADvx+H+9ec9twm4f/RqxDC9RGKGO89MeQo73likcQcsB6d
MqUhLOYZ3XAjlhJUIYD1ZiVxhilWT+qqbLYkYsY+fI45Xe4L6oRV36zCAEQpxL+q
IPV6xJhwVNkz4bvFWX6Scr879tNn4M8bRY1Qc32V6RL+5/KzptUmr2k=
=7JAM
-----END PGP SIGNATURE-----

--a4j5a2G2uSMjrsiTi0BvdCUD03gI13Ph7--
