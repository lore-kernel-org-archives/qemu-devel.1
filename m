Received: from eggs.gnu.org ([2001:4830:134:3::10]:39236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cuK9h-0004py-QD
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cuK9h-0008Dx-0r
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:37:29 -0400
References: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2cb95ae5-90c8-f8b8-466f-2965d12fac05@redhat.com>
Date: Sat, 1 Apr 2017 09:37:19 -0500
MIME-Version: 1.0
In-Reply-To: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d8AWl37exIsn9F9nxOAF7WcBp9RuGnv4G"
Subject: Re: [Qemu-devel] [PATCH for-2.9] nbd: fix memory leak on
 socket_connect failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yaolujing <yaolujing@huawei.com>, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: xieyingtai@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, zhangshuai13@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com, sochin.jiang@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8AWl37exIsn9F9nxOAF7WcBp9RuGnv4G
From: Eric Blake <eblake@redhat.com>
To: yaolujing <yaolujing@huawei.com>, pbonzini@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Cc: xieyingtai@huawei.com, qemu-block@nongnu.org, subo7@huawei.com,
 zhangshuai13@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org,
 wangjie88@huawei.com, sochin.jiang@huawei.com
Message-ID: <2cb95ae5-90c8-f8b8-466f-2965d12fac05@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] nbd: fix memory leak on
 socket_connect failed
References: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
In-Reply-To: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 07:15 PM, yaolujing wrote:
> From: y00357587 <yaolujing@huawei.com>
>=20
> When TCP connection fails between nbd server and client,
> the local var, sioc, memory leak.
>=20
> This patch fixes the memory leak.
>=20
> Signed-off-by: y00357587 <yaolujing@huawei.com>
> ---
>  block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 35f24be..102285e 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -313,6 +313,7 @@ static QIOChannelSocket *nbd_establish_connection(S=
ocketAddress *saddr,
>                                      saddr,
>                                      &local_err);
>      if (local_err) {
> +        object_unref(OBJECT(sioc));
>          error_propagate(errp, local_err);
>          return NULL;
>      }
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--d8AWl37exIsn9F9nxOAF7WcBp9RuGnv4G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY37sfAAoJEKeha0olJ0Nq6IAH/0Dzv5UpmSSfOh4m5zYZM1My
BFeYKEkYcWKkUO54+US3L/3iKc+LZo38YB4jrcjeTGhWbUdEDtx+/cJAjynAFw+Q
cvtifWzlSfyGY/1co3ApFX3AMgbrId5ZMAPqey6OYVmlakhkeNftmCQcJjzXWmUl
A3YmOPPUaDMt9vX6pq0BOaFUGD7wtfkexENkTtZeojP396+TGmULrotHENITkmRr
pnig38KviEBB6wBkr72BNyBMg1xrWQS7N25CcwplUjxBnzatf7Df4SoN5XzaJIHM
w8EEmcnsNkfXIBG36orsS5b4EWUJOrP/+8iFqMPHu3EIwsdoWnWHMJKCRO708Qg=
=7U2M
-----END PGP SIGNATURE-----

--d8AWl37exIsn9F9nxOAF7WcBp9RuGnv4G--
