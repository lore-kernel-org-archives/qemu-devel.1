Received: from eggs.gnu.org ([2001:4830:134:3::10]:33506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dwaKt-0001qp-I9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dwaKs-0001wb-M2
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:50:39 -0400
References: <20170922144353.4220-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a3fadcde-f8e3-d815-131e-c6b40b32751a@redhat.com>
Date: Mon, 25 Sep 2017 22:50:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A3NFBmXKf3ScgpkM20mkjtxvXFOSwNAwE"
Subject: Re: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix use of
 uninitialized pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A3NFBmXKf3ScgpkM20mkjtxvXFOSwNAwE
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org
Message-ID: <a3fadcde-f8e3-d815-131e-c6b40b32751a@redhat.com>
Subject: Re: [PATCH] block/qcow2-bitmap: fix use of uninitialized pointer
References: <20170922144353.4220-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-22 16:43, Vladimir Sementsov-Ogievskiy wrote:
> Without initialization to zero dirty_bitmap field may be not zero
> for a bitmap which should not be stored and
> qcow2_store_persistent_dirty_bitmaps will erroneously call
> store_bitmap for it which leads to SYGSEGV on bdrv_dirty_bitmap_name.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, fixed the commit message and applied it to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--A3NFBmXKf3ScgpkM20mkjtxvXFOSwNAwE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnJbBQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATaEH+wcD9Cumn0sOXcFhjiW66qEnbqzEyW9z
+0lvjKUIvMEN7A8IoQVxExHN/X2Vr1nZn1fmXVw7wPageKMGXDCau2xGFXVuEk27
9CVWNyoUukdGmA81axP4ZPVkvPKSw98mJ+EtwnVWrYt5WSAOS91juhFuj1TeuSzh
aJ1PwJNqWUqUov3PmvCKV1EinSFlhHcMhI7gsZH0A7/d9q791GPZvxJkZlEYixrl
TquB1TWyvungrNsHElOnzUWZSRU8Kzp0fFmMD/j9Z7hbDxNj7JnjvHqbEgOMqPbT
itUjRQQAAt8DXPmXFRbSH6s9xGSjP9Qii+/z4qUOxEjmZVrVZJLpwOU=
=Xekm
-----END PGP SIGNATURE-----

--A3NFBmXKf3ScgpkM20mkjtxvXFOSwNAwE--
