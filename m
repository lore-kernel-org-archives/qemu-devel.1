Received: from eggs.gnu.org ([209.51.188.92]:47252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBoW-0004tb-LL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkBoW-0002WR-0s
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkBoV-0002VF-OZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:50:47 -0500
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50bd9e34-6d50-c991-e42e-69b36f9fab4f@redhat.com>
Date: Thu, 17 Jan 2019 11:50:41 -0600
MIME-Version: 1.0
In-Reply-To: <20190117114359.5164-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j7qYSBAxVk1F2aR16CJZB056cpVajLpTz"
Subject: Re: [Qemu-devel] [PATCH 04/27] net/slirp: fix leaks on forwaring
 rule registration error
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
--j7qYSBAxVk1F2aR16CJZB056cpVajLpTz
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, pbonzini@redhat.com
Message-ID: <50bd9e34-6d50-c991-e42e-69b36f9fab4f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/27] net/slirp: fix leaks on forwaring rule
 registration error
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
 <20190117114359.5164-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 5:43 AM, Marc-Andr=C3=A9 Lureau wrote:

In the subject: s/forwaring/forwarding/

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  net/slirp.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/slirp.c b/net/slirp.c
> index 750105a466e..0b15f427f5c 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -807,6 +807,7 @@ static int slirp_guestfwd(SlirpState *s, const char=
 *config_str, Error **errp)
>          qemu_chr_fe_init(&fwd->hd, chr, &err);
>          if (err) {
>              error_propagate(errp, err);
> +            object_unparent(OBJECT(chr));
>              g_free(fwd);
>              return -1;
>          }
> @@ -815,6 +816,7 @@ static int slirp_guestfwd(SlirpState *s, const char=
 *config_str, Error **errp)
>                                 &server, port) < 0) {
>              error_setg(errp, "Conflicting/invalid host:port in guest "=

>                         "forwarding rule '%s'", config_str);
> +            qemu_chr_fe_deinit(&fwd->hd, true);
>              g_free(fwd);
>              return -1;
>          }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--j7qYSBAxVk1F2aR16CJZB056cpVajLpTz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAwHEACgkQp6FrSiUn
Q2qocQf+IM40ZVirg8xSJzNd2mnZ4rvIE3HAA5LVx95sTjUbgWET7neSk33PZWrQ
kxR65W19NVKFcW2T+Rj2GQeI6yocCu1DiOLbAwqjzuq7N9J44ftdCSfD2e8g6iHK
vb+/kUxAQqwACxh4J9HUMPWwHLfa0qMJ3qpzD0EREDyFxbH/C2DAPC4OqQ0FW4CY
OebHlKztd3puxABNMP3cdTKamhyfzMpWweNxEfqI/vR3pNJX9kVlJbDOfrcAqTyH
DJqSyU6NmHiM3IblRxZTHsQv+Zs5+IAtbK7O6AMG+CUEyxvvtuwKDATLeq+JVOe0
WG3Ph+IhW/B8CGdB3zjh1HImH4MT2A==
=POot
-----END PGP SIGNATURE-----

--j7qYSBAxVk1F2aR16CJZB056cpVajLpTz--
