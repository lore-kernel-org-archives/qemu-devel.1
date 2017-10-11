Received: from eggs.gnu.org ([2001:4830:134:3::10]:59448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2K1v-00078G-UW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2K1s-0002O6-04
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2K1r-0002Nj-Mc
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4322581DE7
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 16:38:42 +0000 (UTC)
References: <20171011153843.9876-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb4d0ab0-fb08-edf6-0779-abf332a7af6a@redhat.com>
Date: Wed, 11 Oct 2017 11:38:39 -0500
MIME-Version: 1.0
In-Reply-To: <20171011153843.9876-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C9JA0m0eUF54tcckuQdehf1Grf2s40m3M"
Subject: Re: [Qemu-devel] [PATCH] io: fix mem leak in websock error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C9JA0m0eUF54tcckuQdehf1Grf2s40m3M
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <bb4d0ab0-fb08-edf6-0779-abf332a7af6a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: fix mem leak in websock error path
References: <20171011153843.9876-1-berrange@redhat.com>
In-Reply-To: <20171011153843.9876-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/11/2017 10:38 AM, Daniel P. Berrange wrote:
> Coverity pointed out the 'date' is not free()d in the error
> path
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index aa35ef3274..a1c10ab719 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -355,6 +355,7 @@ static void qio_channel_websock_handshake_send_res_=
ok(QIOChannelWebsock *ioc,
>                              QIO_CHANNEL_WEBSOCK_GUID_LEN,
>                              &accept,
>                              errp) < 0) {
> +        g_free(date);
>          qio_channel_websock_handshake_send_res_err(
>              ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_SERVER_ERR);
>          return;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C9JA0m0eUF54tcckuQdehf1Grf2s40m3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlneSQ8ACgkQp6FrSiUn
Q2rVrAf9FXVHRLWGOB8r4TL4XCaMk60ymTnZguSJ9rtK7rKKh4bl696uGy/x9J4y
z8wgf+J1x40EeItKKb3f4+3BNiE6XJKtwAy19vDwApjXKuFgLBAfcvkKkAr3ngbX
agO5WJ8humjUclK0bjy3gtzqq1xw1plX9uvVXp42n7ptEPD7UzTXdnrQMJ7VZfqv
3uOp6wQ7A09tVV9NtEYSBV8QA5OK6Gt2QcsGyB1hsQSSLgfzWYpKXizy6k24GgRB
VxSUqbF2fsFOXfp2YlOQILZHOiwOP96XPKfTwj6z0vlusUpLm1g6rh2j78sCrcu7
0wSta0s5Xul31URSd27wx4V4yHQ7Ug==
=AYwK
-----END PGP SIGNATURE-----

--C9JA0m0eUF54tcckuQdehf1Grf2s40m3M--
