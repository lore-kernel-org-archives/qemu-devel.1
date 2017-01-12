Received: from eggs.gnu.org ([2001:4830:134:3::10]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoZB-0005FK-0d
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoZ7-0002YR-SF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:13:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRoZ7-0002Wt-Lz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:13:53 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3026A89D
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 23:13:53 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-25-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0222545a-2e3b-048d-7847-aec32186b5be@redhat.com>
Date: Thu, 12 Jan 2017 17:13:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-25-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EdFNwTakQFpwJLwnDF4JnCsn6Uc2REjPo"
Subject: Re: [Qemu-devel] [PATCH 24/40] char: move ringbuf/memory to its own
 file
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
--EdFNwTakQFpwJLwnDF4JnCsn6Uc2REjPo
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <0222545a-2e3b-048d-7847-aec32186b5be@redhat.com>
Subject: Re: [PATCH 24/40] char: move ringbuf/memory to its own file
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-ringbuf.c | 226 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  chardev/char.c         | 218 -----------------------------------------=
------
>  chardev/Makefile.objs  |   1 +
>  3 files changed, 227 insertions(+), 218 deletions(-)
>  create mode 100644 chardev/char-ringbuf.c
>=20

Looks mechanical, same story about copyright blurb.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--EdFNwTakQFpwJLwnDF4JnCsn6Uc2REjPo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeA2vAAoJEKeha0olJ0NqzoUIAJcpbVZ6zCFfOuSLEEty4aHo
D62gCmdMGuySunR6ol0Kqvg9Yi8+GbdAqxRABoXZd71yfWND8SGFpMVLg/80cuAW
W/zkKi88khDh/O8y4u1AGGy6eQ80UkubFiDtqLoa8RvSsiwN/7o2xgB1h1a14YRc
ZO5QqKEPOk4w5jHMDdBRsuzZwriOG9VSVcxkTUf5P22Zw+GjdC3C1DvZJgD+2bKW
bmGxL55zWvDOFnvw6fMLdhDcpoLjBulPlJp7m4ca1UfUd5EGoauTr17IrCroJ7IO
2L6aHCx90MCJWqLumPOfXDI7CImgJdGy3U6Ij9A7emQIS6TFHVUOBvX33D6DwVU=
=RpX4
-----END PGP SIGNATURE-----

--EdFNwTakQFpwJLwnDF4JnCsn6Uc2REjPo--
