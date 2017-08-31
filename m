Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnQfe-0005V3-ME
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnQfb-0006Mr-JX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnQfb-0006Mh-9e
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41313461DC
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:42:10 +0000 (UTC)
References: <20170831095057.22923-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c565619b-4e00-7bc1-9791-76ceebbacfe8@redhat.com>
Date: Thu, 31 Aug 2017 09:42:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170831095057.22923-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GBpC4aRUXiNArGF6n5RPvfrN72twXqBku"
Subject: Re: [Qemu-devel] [PATCH] io: fix typo in docs comment for
 qio_channel_read
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
--GBpC4aRUXiNArGF6n5RPvfrN72twXqBku
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c565619b-4e00-7bc1-9791-76ceebbacfe8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: fix typo in docs comment for
 qio_channel_read
References: <20170831095057.22923-1-berrange@redhat.com>
In-Reply-To: <20170831095057.22923-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 04:50 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/channel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/io/channel.h b/include/io/channel.h
> index db9bb022a1..54f3dc252f 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -299,7 +299,7 @@ ssize_t qio_channel_writev(QIOChannel *ioc,
>                             Error **errp);
> =20
>  /**
> - * qio_channel_readv:
> + * qio_channel_read:
>   * @ioc: the channel object
>   * @buf: the memory region to read data into
>   * @buflen: the length of @buf
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GBpC4aRUXiNArGF6n5RPvfrN72twXqBku
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoIEAACgkQp6FrSiUn
Q2opSwf/VA8dY6WsRuZvGMacnVv96dRyAqxaw3LSjaXR79XraTtFH7LU6RPq43RT
U8E3ZhYHRiJQlvckxT8n40JoPASgJ567lCC1ujgMuFlrC2rM9XQzSknavskL+jSj
pRGzrzUz4GetYT4vvFERcvFVzVqYOds1tnKjFhc/lUvZq4XRfhQ7ee2knqP4EyYo
a/vKkTfz+oO6ktAxiutqmJHX+x1KZoQSUGWbFKx6ySAz8YCJtO+g495Y8KoFPeL3
G9UFi84qAA6BLYXJNfDIXdAyvpTJj/eSDAFYh2Vy+Pu5sKc4mZcK5T+FBLGPK6Te
5nK/IYUKTrq45jpSBuvi1mfX9aLRrg==
=DaR/
-----END PGP SIGNATURE-----

--GBpC4aRUXiNArGF6n5RPvfrN72twXqBku--
