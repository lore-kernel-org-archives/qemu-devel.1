Received: from eggs.gnu.org ([2001:4830:134:3::10]:57565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwUjQ-0002CR-Dd
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwUjP-0006g1-BH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:19:20 -0400
References: <20170406190847.29347-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f2c42a58-098c-549d-31cf-32792835f03a@redhat.com>
Date: Fri, 7 Apr 2017 16:19:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170406190847.29347-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ItDcE0uCrBsSFwgg3DAuNVPjo2BgS27vi"
Subject: Re: [Qemu-devel] [PATCH for-2.9] throttle: Remove block from group
 on hot-unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ItDcE0uCrBsSFwgg3DAuNVPjo2BgS27vi
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f2c42a58-098c-549d-31cf-32792835f03a@redhat.com>
Subject: Re: [PATCH for-2.9] throttle: Remove block from group on hot-unplug
References: <20170406190847.29347-1-eblake@redhat.com>
In-Reply-To: <20170406190847.29347-1-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 06.04.2017 21:08, Eric Blake wrote:
> When a block device that is part of a throttle group is hot-unplugged,
> we forgot to remove it from the throttle group. This leaves stale
> memory around, and causes an easily reproducible crash:
>=20
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio=
 \
> -device virtio-scsi-pci,bus=3Dpci.0 -drive \
> id=3Ddrive_image2,if=3Dnone,format=3Draw,file=3Dfile2,bps=3D512000,iops=
=3D100,group=3Dfoo \
> -device scsi-hd,id=3Dimage2,drive=3Ddrive_image2 -drive \
> id=3Ddrive_image3,if=3Dnone,format=3Draw,file=3Dfile3,bps=3D512000,iops=
=3D100,group=3Dfoo \
> -device scsi-hd,id=3Dimage3,drive=3Ddrive_image3
> {'execute':'qmp_capabilities'}
> {'execute':'device_del','arguments':{'id':'image3'}}
> {'execute':'system_reset'}
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1428810
>=20
> Suggested-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/block-backend.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--ItDcE0uCrBsSFwgg3DAuNVPjo2BgS27vi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljnn90SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AiE4H/j2UEjK8q4f/PtgytPTyNy6xlF+sPmMR
mQi2Zh3ygfbYMTy6sOt7rMvHHhdIfjnTt23AmPBE9Pi0JNgswy0ZW/tneLrdKNf6
1eCbYL2ekySpZo3w9zD1DAVbHqXZ46ivIbwNKmfkEuDNgOjk6tuk4Dih5GTY962s
y86p2Gdxsv/JcNF22hJfgJ11Wxd+VkYKlT9YXqCcjrb3Rv8ZVennh7fHZaesUmjb
9MZvOrB9U6vuQTBqcNsn2WHkujsDOS6H4+nRAV8XJkkBTOY3Wrj3lPceyTLg1yqh
SLspbT76bdv6/J8ctxoXFO+2uDaW2hipYHr+OXZ3bp8SIKr60MSSqQU=
=gHfM
-----END PGP SIGNATURE-----

--ItDcE0uCrBsSFwgg3DAuNVPjo2BgS27vi--
