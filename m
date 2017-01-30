Received: from eggs.gnu.org ([2001:4830:134:3::10]:51123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYIEj-00008c-R4
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYIEg-0002dB-La
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:07:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYIEg-0002cm-FY
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:07:34 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90FC18EB54
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 20:07:34 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-29-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <521aad2e-e1a7-12f7-40c4-49824b5a9d92@redhat.com>
Date: Mon, 30 Jan 2017 14:07:32 -0600
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-29-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="quevfRF4E1NqvjvfgXFxgCFStUsXQOF2B"
Subject: Re: [Qemu-devel] [PATCH v2 28/41] char: move QIOChannel-related
 stuff to char-io.h
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
--quevfRF4E1NqvjvfgXFxgCFStUsXQOF2B
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <521aad2e-e1a7-12f7-40c4-49824b5a9d92@redhat.com>
Subject: Re: [PATCH v2 28/41] char: move QIOChannel-related stuff to char-io.h
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
 <20170130133954.31353-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 07:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-io.h     |  46 ++++++++++++
>  chardev/char-io.c     | 192 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  chardev/char.c        | 174 +-----------------------------------------=
---
>  chardev/Makefile.objs |   1 +
>  4 files changed, 240 insertions(+), 173 deletions(-)
>  create mode 100644 chardev/char-io.h
>  create mode 100644 chardev/char-io.c
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--quevfRF4E1NqvjvfgXFxgCFStUsXQOF2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj50EAAoJEKeha0olJ0NqYF0H/38gAXV0KzaZwgcxXF2QihbR
WLxCcvE3u+3b3MABDGLfMrwmDP8CWPAeJP10pBBrKhZ2NmjyppO7r0v+Dc0G1fke
GI4c4ZeWvNiKktRgBxzusAR4EuX9D94E2YOX5ICd0ZYeYTUHco0xInRIt5iRfR2J
AF70260nfWRuxFEaY7V4p2wYcnPA+3JxDBytkFFFHC/K0hdp7b+M7ZqeB7sYlQx6
uH/a7I5K5svjK5ex0l5QHWe+ZpM0fn/bf+1YR45YGmB1ol9ioY9nU1CNSdMD/+tj
/xQQJdnxLJzVkLN0uvz9VzT5iB+E1XC2pH8an3HzzDrVA4rdTOZIwHGqof62cQA=
=R+6B
-----END PGP SIGNATURE-----

--quevfRF4E1NqvjvfgXFxgCFStUsXQOF2B--
