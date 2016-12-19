Received: from eggs.gnu.org ([2001:4830:134:3::10]:33412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJ5IM-0004SC-Rl
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJ5IH-0008QK-Ux
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:16:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJ5IH-0008Q2-PC
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:16:25 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B745F68E3B
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 21:16:24 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-7-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72ddda8b-d4d2-b282-4565-c8328414b986@redhat.com>
Date: Mon, 19 Dec 2016 15:16:23 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-7-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sv2P3EhkblXdrSF09l0MAw4rxHjrRRevO"
Subject: Re: [Qemu-devel] [PATCH 06/54] char: introduce generic
 qemu_chr_get_kind()
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
--Sv2P3EhkblXdrSF09l0MAw4rxHjrRRevO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <72ddda8b-d4d2-b282-4565-c8328414b986@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/54] char: introduce generic
 qemu_chr_get_kind()
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-7-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> This allows to remove the "is_mux" field from CharDriverState.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c             |  2 +-
>  qemu-char.c           | 21 ++++++++++-----------
>  include/sysemu/char.h | 15 +++++++++++++--
>  3 files changed, 24 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Sv2P3EhkblXdrSF09l0MAw4rxHjrRRevO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWE4nAAoJEKeha0olJ0Nq7TIH/jUjmN/4L4CguLidgvOwI5Yd
7BbbN0JMqFUp4FyoWucXKdyu0M+C3Pl3UmDDBpfwnclUeTX+FuH01gheJDKEx1GD
xk7b0G9CEr6cyj/DndztT0fFNoYnJBQbD3U1kimZo1G4ll+88AbUmefc2s1zd57v
FMUhGRMnyRnoOFP0grW0pb1b7ny5mJKCS2zyWIn52P6xLTXLW3zzkPA/OZ0nVtHz
R9lEbe7G1fjBsFWoCBtpMP6RZVS8ll7ahvaaIe8D61uN+HUpntXfoWKdM/QwpNOk
COgNntejnvJC+UA7A8xxCxnj+HRZRZD8F0LR7FTKLWAvaDFboDjzQ0smUF3NyEg=
=l6RZ
-----END PGP SIGNATURE-----

--Sv2P3EhkblXdrSF09l0MAw4rxHjrRRevO--
