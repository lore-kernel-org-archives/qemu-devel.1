Received: from eggs.gnu.org ([2001:4830:134:3::10]:52296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT8HJ-0005BU-BZ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT8HG-0001id-74
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dT8HF-0001hY-UY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:01:10 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <208b5f98-c085-b7df-ea6f-6000ded0e2bb@redhat.com>
Date: Thu, 6 Jul 2017 10:01:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f733IqmvP0kvN29JNqPQGKP4FInj01GTC"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f733IqmvP0kvN29JNqPQGKP4FInj01GTC
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <208b5f98-c085-b7df-ea6f-6000ded0e2bb@redhat.com>
Subject: Re: [PATCH v2 6/6] nbd: use generic trace subsystem instead of TRACE
 macro
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Starting from this patch to enable traces use -trace option of qemu or
> -T, --trace option of qemu-img, qemu-io and qemu-nbd. For qemu traces
> also can be managed by qmp commands trace-event-{get,set}-state.
>=20
> Recompilation with CFLAGS=3D-DDEBUG_NBD is no more needed, furthermore,=

> DEBUG_NBD macro is removed from the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/nbd/client.c

> @@ -565,7 +561,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>              goto fail;
>          }
>          *size =3D be64_to_cpu(s);
> -        TRACE("Size is %" PRIu64, *size);
> +        trace_nbd_receive_negotiate_export_size(*size);
> =20

This one is redundant...

>          if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
>              error_prepend(errp, "Failed to read export flags");
> @@ -582,7 +578,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
> =20
> -    TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags)=
;
> +    trace_nbd_receive_negotiate_size_flags(*size, *flags);

=2E..with this one.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f733IqmvP0kvN29JNqPQGKP4FInj01GTC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXlCvAAoJEKeha0olJ0NqdEgIAK4qEAnJeNnkCJyA0D9T9SjW
ItLp06d9HEElm7/EGlMHDi7w+o/PpHpap5r54qHVxhGFK9r3yiPxyiaZ2CG6h9X+
E73NrxHfunEUXcJ9lccQ69PWzS6XeNdrjGku7gIQLgAOsd2wAtDmbrfyOBfEAYrM
Z0btnMce0egVU2QBHN3F3uONMAlH/uUoLkhogpuO4OK9pNSNc2I2bfJyF00NIfP8
OCcuhVRk7tEbVxltbzzFdQrD8iaPj6qiro2OWUagQridXbrEDfQxaMrQMHKTNSP0
VcP7psQ9ogKae3NY+2hIu5Y/6H8BigjgO7CtlifrIvNjkDzqfi06Cq2vwYkyTOs=
=WgMi
-----END PGP SIGNATURE-----

--f733IqmvP0kvN29JNqPQGKP4FInj01GTC--
