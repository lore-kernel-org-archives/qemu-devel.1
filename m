Received: from eggs.gnu.org ([209.51.188.92]:48176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBso-0007gY-Kp
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBsn-0006Uz-Tn
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:55:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkBsn-0006PO-J8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:55:13 -0500
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-10-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0a4639f-eaf8-868e-f731-6863c480c785@redhat.com>
Date: Thu, 17 Jan 2019 11:55:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190117114359.5164-10-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hlqXSSb6g8TQ0FrU1R4Ju0zAhPECAK9SM"
Subject: Re: [Qemu-devel] [PATCH 09/27] slirp: replace qemu_set_nonblock()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hlqXSSb6g8TQ0FrU1R4Ju0zAhPECAK9SM
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, pbonzini@redhat.com
Message-ID: <c0a4639f-eaf8-868e-f731-6863c480c785@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/27] slirp: replace qemu_set_nonblock()
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
 <20190117114359.5164-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 5:43 AM, Marc-Andr=C3=A9 Lureau wrote:
> Replace qemu_set_nonblock() with slirp_set_nonblock()
>=20
> qemu_set_nonblock() does some event registration with the main
> loop. Add a new callback register_poll_fd() for that reason.
>=20
> Always build the fd-register stub, to avoid #if WIN32.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/slirp/util.c
> @@ -43,6 +43,18 @@ int inet_aton(const char *cp, struct in_addr *ia)
>  }
>  #endif
> =20
> +void slirp_set_nonblock(int fd)
> +{
> +#ifndef _WIN32
> +    int f;
> +    f =3D fcntl(fd, F_GETFL);
> +    fcntl(fd, F_SETFL, f | O_NONBLOCK);

No error checking?  Is that wise?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hlqXSSb6g8TQ0FrU1R4Ju0zAhPECAK9SM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAwX4ACgkQp6FrSiUn
Q2oaiAgAmS+uzrzqyOM7BqYvjYh1oBn3g+Jb8AI4h9sPvbncTaEGxAEGo1UG+LEG
SGixdxe8S4uo3nNgWqqLD2Nz4Vblbb9WqGIt8PFUrG3W7HKfyzpgN0tznctEdrwD
mpxxE5KEFQbjvSVUliyxDNqwPfa/N1yQC+dGQvD3u1m2tg37b1CfGcMOMqYaVys7
2vS4sWUqA9DG7pN9UJKmQRc08C9JJQ1zKS5VMv9niWchYvMfZ/0oz/Br7E6LfBEQ
B7u0tmKEbednja6ds5PCoeI15Y733HFPcFR8YUWt5tKtYDJ3RQRVynzmFa29srao
LUtIrQwycqQJRQ7CkvtHGWHeM2oI8g==
=60Fw
-----END PGP SIGNATURE-----

--hlqXSSb6g8TQ0FrU1R4Ju0zAhPECAK9SM--
