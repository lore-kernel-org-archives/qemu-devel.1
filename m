Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCplX-00030a-9Z
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCplT-00015E-7k
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:33:19 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9efcfcce-5c7c-c5a0-5985-3b0e7598cadd@redhat.com>
Date: Thu, 9 Nov 2017 10:33:06 -0600
MIME-Version: 1.0
In-Reply-To: <20171109141631.25688-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pner5xufWlpietB6Bjqj9Va4wxqX7N3ks"
Subject: Re: [Qemu-devel] [PATCH] blockdev-backup: enable non-root nodes for
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pner5xufWlpietB6Bjqj9Va4wxqX7N3ks
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <9efcfcce-5c7c-c5a0-5985-3b0e7598cadd@redhat.com>
Subject: Re: [PATCH] blockdev-backup: enable non-root nodes for backup
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171109141631.25688-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 08:16 AM, Vladimir Sementsov-Ogievskiy wrote:
> This is needed to implement image-fleecing scheme, when we create
> a temporary node, mark our active node to be backing for the temp,
> and start backup(sync=3Dnone) from active node to the temp node.
> Temp node then represents a kind of snapshot and may be used
> for external backup through NBD.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> What was the reason to abandon non-root nodes?

I think the original restriction was that we didn't know all the
implications to having multiple readers to an intermediate node, so it
was easier to prevent it with plans to add it later than to add it up
front and deal with the fallout.  But I think that now we are
sufficiently versed in handling BDS trees with multiple readers, with
proper op-blocking in place; so you are right that we can probably
support it now.

However, I'm a bit worried that there is no documentation change about
this in a .json QAPI file, nor any easy way to introspect via QMP
whether a particular qemu implementation supports this (short of trying
it and seeing whether it works).  I'm also thinking that this is 2.12
material, unless we can prove it is fixing a bug for 2.11 that was not
previously present.

>=20
>  blockdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 56a6b24a0b..d0a5a107f0 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3345,7 +3345,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *back=
up, BlockJobTxn *txn,
>          backup->compress =3D false;
>      }
> =20
> -    bs =3D qmp_get_root_bs(backup->device, errp);
> +    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
>      if (!bs) {
>          return NULL;
>      }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pner5xufWlpietB6Bjqj9Va4wxqX7N3ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEg0IACgkQp6FrSiUn
Q2pOGAf/eYoeV3utryzJCn9Lg839Tg3YX0Gk1OxmxBB5neYOHL+BUv3hqrV8yeVN
cLeBydAgqYBaA8eom2GpYezWMG1h79wdxMF4bxZzV3o1ewllzbR7t3go7wmMIKpg
oa/7LS5zowxntciuElQumPuaZDt4kjrd92ENHjkYCMuki652iV79LX7MvvEXfG2/
YfnSdhR7it6w0i4WBYUbKDXcqesIOD430zdndWjBOSXJY4aa20T+D0O/4gRan9k1
0QruIM9sxKRbpYFSKcTK0ariImGOyg8Ws8XiZkpU+oTCAd5uvgymWuQHwTAbTW2q
uTDdIv4GgiE8mYrS03J+RM/lzqEGcQ==
=PITZ
-----END PGP SIGNATURE-----

--pner5xufWlpietB6Bjqj9Va4wxqX7N3ks--
