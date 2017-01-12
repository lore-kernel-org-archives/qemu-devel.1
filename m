Received: from eggs.gnu.org ([2001:4830:134:3::10]:47827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRo56-0000jP-Vt
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 17:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRo52-000155-5K
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 17:42:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRo51-00014w-VY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 17:42:48 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC8F84E4CD
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 22:42:47 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-22-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0fa9a9c2-d10d-d65f-7809-595c4a6f3b49@redhat.com>
Date: Thu, 12 Jan 2017 16:42:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-22-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JrIOaUar5VGrLHjKV5E3GhWI8uq6NnCeh"
Subject: Re: [Qemu-devel] [PATCH 21/40] char: make null_chr_write() the
 default method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JrIOaUar5VGrLHjKV5E3GhWI8uq6NnCeh
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <0fa9a9c2-d10d-d65f-7809-595c4a6f3b49@redhat.com>
Subject: Re: [PATCH 21/40] char: make null_chr_write() the default method
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> All chardev must implement chr_write(), but parallel and null chardev
> both use null_chr_write(). Move it to the base class, so we don't need
> to export the function when splitting the chardev in respective files.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JrIOaUar5VGrLHjKV5E3GhWI8uq6NnCeh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeAZlAAoJEKeha0olJ0NqQW4H/RWiiJP58jF0xXKFNCEqN/4Z
o0jETFXBud08MmVCEZuE7f6jorBYZROYLdTtpcSV47MofNKVGLBrezeNGhkycmXH
S/2S7+3Lbjmc4lAYJrNZk6qA+g03ftV7LnCs3vcjYvAC1gICzA33GI19JmKpbSuh
FsnMYZufXAtv0OJ8B1GrKMY1XjEXbtbXMnt1DIyjvm+K819TjhG/yS/l7P9mlRoD
mDRH5Tm27bp3qZU988zpDmqXrHU5kkUdrzsBSSddmRqRxGqKqsdlWW2+VMoRTv4d
MS8RlaOt1K+CR5bv1PLnok3dc0YA1pzyllQRywjvtaDLHN/deDtnoimUE5ozAL4=
=rIwh
-----END PGP SIGNATURE-----

--JrIOaUar5VGrLHjKV5E3GhWI8uq6NnCeh--
