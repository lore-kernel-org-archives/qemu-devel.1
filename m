Received: from eggs.gnu.org ([2001:4830:134:3::10]:59767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dvP-0007rE-6m
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dvL-0004pv-6t
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2dvK-0004pO-Tm
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:19 -0400
References: <20171012132546.1741-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <baddd4eb-e445-68a1-0edd-44236db4461d@redhat.com>
Date: Thu, 12 Oct 2017 08:53:15 -0500
MIME-Version: 1.0
In-Reply-To: <20171012132546.1741-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9rk5uGVwW9SWobHXiocUSQFQQ48e3rxVS"
Subject: Re: [Qemu-devel] [PATCH v2] io: fix mem leak in websock error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9rk5uGVwW9SWobHXiocUSQFQQ48e3rxVS
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <baddd4eb-e445-68a1-0edd-44236db4461d@redhat.com>
Subject: Re: [PATCH v2] io: fix mem leak in websock error path
References: <20171012132546.1741-1-berrange@redhat.com>
In-Reply-To: <20171012132546.1741-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 08:25 AM, Daniel P. Berrange wrote:
> Coverity pointed out the 'date' is not free()d in the error
> path
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index aa35ef3274..df2c3a9f99 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -341,7 +341,7 @@ static void qio_channel_websock_handshake_send_res_=
ok(QIOChannelWebsock *ioc,
>      char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
>                        QIO_CHANNEL_WEBSOCK_GUID_LEN + 1];
>      char *accept =3D NULL;
> -    char *date =3D qio_channel_websock_date_str();
> +    char *date =3D NULL;
> =20
>      g_strlcpy(combined_key, key, QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN + =
1);
>      g_strlcat(combined_key, QIO_CHANNEL_WEBSOCK_GUID,
> @@ -360,6 +360,7 @@ static void qio_channel_websock_handshake_send_res_=
ok(QIOChannelWebsock *ioc,
>          return;
>      }
> =20
> +    date =3D qio_channel_websock_date_str();
>      qio_channel_websock_handshake_send_res(
>          ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9rk5uGVwW9SWobHXiocUSQFQQ48e3rxVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnfc8sACgkQp6FrSiUn
Q2qmFAf8DYtwibNYfGHZ1UuLYQaciKQiyc5JmNv1nXheOqNRe2BuSDvWzwBH3eVb
4ZZzRf+LFJglwy3vJbn9rz6KKS7tsuke+A3/Qad91/MrlYH18GwAz1RsLcuDII6o
/c9S1oGjRvSTQ/uvzHeaXzVgpif7i5Cg84R1Ra0o7lZVTQGxe7fETW7rUsmKSyGj
Sf8VusAkethKUVDU7SnMw9d3KVchjkyxTTBbCztx6crU+Fjl4jys4vmkb4D5aYjO
gItvE+9NSja5yacHTfImKeG3jN4GeNxVlPFcR2Lw+ohK7zmQH4O/925KLf7aipnx
nnSg5cQH07x/5OurA7oHw4PF8kgCwA==
=L/bX
-----END PGP SIGNATURE-----

--9rk5uGVwW9SWobHXiocUSQFQQ48e3rxVS--
