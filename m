Received: from eggs.gnu.org ([2001:4830:134:3::10]:58737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRiyw-0004Vg-Pg
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRiyr-0007B2-W7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRiyr-0007Aa-Na
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:16:05 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D87A2173F
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 17:16:05 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-18-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35148de2-b3ec-4ddd-05f6-53a0f586be1f@redhat.com>
Date: Thu, 12 Jan 2017 11:16:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-18-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qJkAdb7qjDILFPh4DDQHerquJo0mjbHkj"
Subject: Re: [Qemu-devel] [PATCH 17/40] char: rename remaining CharDriver to
 Chardev
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
--qJkAdb7qjDILFPh4DDQHerquJo0mjbHkj
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <35148de2-b3ec-4ddd-05f6-53a0f586be1f@redhat.com>
Subject: Re: [PATCH 17/40] char: rename remaining CharDriver to Chardev
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> CharDriver no longer exists, it has been replaced with Chardev.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h | 40 ++++++++++++++++++++--------------------
>  qemu-char.c           | 12 ++++++------
>  2 files changed, 26 insertions(+), 26 deletions(-)
>=20

> +++ b/qemu-char.c
> @@ -3171,13 +3171,13 @@ typedef struct {
>      Chardev *chr;
>      char buf[12];
>      size_t buflen;
> -} TCPCharDriverTelnetInit;
> +} TCPChardevTelnetInit;
> =20
>  static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
>                                         GIOCondition cond G_GNUC_UNUSED=
,
>                                         gpointer user_data)
>  {
> -    TCPCharDriverTelnetInit *init =3D user_data;
> +    TCPChardevTelnetInit *init =3D user_data;
>      ssize_t ret;
> =20
>      ret =3D qio_channel_write(ioc, init->buf, init->buflen, NULL);
> @@ -3204,8 +3204,8 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel=
 *ioc,
>  static void tcp_chr_telnet_init(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> -    TCPCharDriverTelnetInit *init =3D
> -        g_new0(TCPCharDriverTelnetInit, 1);
> +    TCPChardevTelnetInit *init =3D
> +        g_new0(TCPChardevTelnetInit, 1);

This would fit within 80 columns on one line; but I'm also okay if you
don't bother with those sorts of cleanups.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qJkAdb7qjDILFPh4DDQHerquJo0mjbHkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYd7nSAAoJEKeha0olJ0Nqpc8H/A0JDPW60LdxVIIul7JNXPvt
qIW99SPuDmHGnovjJpCAv/KRzBkF5I1Dj7UVq/DBbqubuCaFBmEc+6CZ1cYB9+Q/
VxuI01XLLTP3WQyo2HuE4OK7EaTZ1EX+diRBf2xc7KJBZjMtJjwKImX6hDu5b8Ss
0L1DSE7BTnHBVt7/UhVD9W0U3grMaxD04on2XVGJpcttrtItuTwE9jk39h486LGo
cwhbHjYslH5LsB+DffElRHW6M25HLdocvLpvIU9d/PrSf8BT9PNaQW60Id7r0EZj
y/uLeHFZlJRUCbG+M0VuOspwvVlNmT7l05BEqrE8UOTLClOcuAA2rrWOsa/TINg=
=IA2I
-----END PGP SIGNATURE-----

--qJkAdb7qjDILFPh4DDQHerquJo0mjbHkj--
