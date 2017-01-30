Received: from eggs.gnu.org ([2001:4830:134:3::10]:48491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYI5a-00048T-7M
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYI5W-0008JN-Ao
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:58:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYI5W-0008JB-4F
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:58:06 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3370E3A768A
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 19:58:06 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-24-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6310bde7-26ee-ed89-305d-a366fba3197a@redhat.com>
Date: Mon, 30 Jan 2017 13:58:03 -0600
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-24-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4hqpaJ0eL3ERWW6KpGlDRf9geLB6tP9vK"
Subject: Re: [Qemu-devel] [PATCH v2 23/41] char: move null chardev to its
 own file
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
--4hqpaJ0eL3ERWW6KpGlDRf9geLB6tP9vK
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <6310bde7-26ee-ed89-305d-a366fba3197a@redhat.com>
Subject: Re: [PATCH v2 23/41] char: move null chardev to its own file
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
 <20170130133954.31353-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 07:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-null.c   | 54 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  chardev/char.c        | 23 ----------------------
>  chardev/Makefile.objs |  1 +
>  3 files changed, 55 insertions(+), 23 deletions(-)
>  create mode 100644 chardev/char-null.c
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4hqpaJ0eL3ERWW6KpGlDRf9geLB6tP9vK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj5rLAAoJEKeha0olJ0NqwLMIAIVGZdHK71GS+0O+CsRX5yxd
C1jCIhLPaXfE5g8ZfQTTd23x9OeTgPqI+cmT6PmZhipLhoBhrtFXlxUOIOxWwvGg
DPnfNe6/uVgSIbnSpTXcTEjeyVcsot8ihDlZva5fyC2kHpK4LSF4UOv+Al+TUOL0
YIcS+5zuLpGPLBltAfWIcDc8PsRwN0nlcsEFOB7iI43btHOTqR1TOk5voqIyQwNT
7WeTlHTMzQ53N86N8PjpK8bfTsHVfzfbwL9VD1arvL1iDk2TRBTtdKpoCdlehjdN
d4TSretcQkhPyuntuGBeW0EBBaNRgraQ9vpfdpnshHHyA6E/nDeZV/iu3CXDN3Q=
=aqR8
-----END PGP SIGNATURE-----

--4hqpaJ0eL3ERWW6KpGlDRf9geLB6tP9vK--
