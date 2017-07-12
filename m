Received: from eggs.gnu.org ([2001:4830:134:3::10]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJDq-0002Kl-U0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJDp-0003sw-Ki
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:06:38 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <793a9e5e-f782-5824-5b19-d2cf4da89d3a@redhat.com>
Date: Wed, 12 Jul 2017 10:06:20 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SS3UNquQT6rS6060X2xpNJBhGWKxbpjlJ"
Subject: Re: [Qemu-devel] [PATCH 2/9] block/qapi: Add qdev device name to
 query-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SS3UNquQT6rS6060X2xpNJBhGWKxbpjlJ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <793a9e5e-f782-5824-5b19-d2cf4da89d3a@redhat.com>
Subject: Re: [PATCH 2/9] block/qapi: Add qdev device name to query-block
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> With -blockdev/-device, users can indirectly create anonymous
> BlockBackends, in the state of which they are still interested. As a

Reads awkwardly.  Maybe:

BlockBackends, although it is still of interest to learn the state of
such backends.

> preparation for making such BBs visible in query-block, make sure that
> they can be identified even without a name by adding the ID/QOM path of=

> their qdev device to BlockInfo.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/qapi/block-core.json
> @@ -433,6 +433,9 @@
>  #
>  # @device: The device name associated with the virtual device.
>  #
> +# @qdev: The qdev ID, or if no ID is assigned the QOM path, of the blo=
ck

s/assigned the QOM path, of/assigned, the QOM path of/

> +#        device.

Missing a (since 2.10) tag.

> +#
>  # @type: This field is returned only for compatibility reasons, it sho=
uld
>  #        not be used (always returns 'unknown')
>  #
> @@ -458,7 +461,7 @@
>  # Since:  0.14.0
>  ##
>  { 'struct': 'BlockInfo',
> -  'data': {'device': 'str', 'type': 'str', 'removable': 'bool',
> +  'data': {'device': 'str', '*qdev': 'str', 'type': 'str', 'removable'=
: 'bool',
>             'locked': 'bool', '*inserted': 'BlockDeviceInfo',
>             '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus',
>             '*dirty-bitmaps': ['BlockDirtyInfo'] } }

Besides the testsuite, are there any example outputs that need to be
adjusted?

> diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
> index 782eae2..e3c4496 100644
> --- a/tests/qemu-iotests/067.out
> +++ b/tests/qemu-iotests/067.out
> @@ -57,6 +57,7 @@ Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow=
2,if=3Dnone,id=3Ddisk -device virti
>                  "file": "TEST_DIR/t.qcow2",
>                  "encryption_key_missing": false
>              },
> +            "qdev": "/machine/peripheral/virtio0/virtio-backend",
>              "type": "unknown"
>          }
>      ]
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SS3UNquQT6rS6060X2xpNJBhGWKxbpjlJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZjrsAAoJEKeha0olJ0NqxegH/RupGoukwshUu6Jumx8EK1Bm
csXtKqNiyZoraMqduOvqFpkRAm1XFz5gKoKlCavVRYHU8fk8KWgGGv8WWfvNtq1F
P/APlZrjpSHrbF6+VkA3vSh8Wy9luWdfH+hJtJxpRy48Aw5DW2+l53GtFH9C5N6M
GbNeRzwV3/XGoNvtiRc76ZHMd/xYPxH7e0NGjWZrSdAjT5SkPLS3CYTTzv+DsQSm
V4bE1AUiUnkpkB1Zt4LR+Zkt9GQu2aD5m6x5ZZOxPSvg+Lsrjfi+3GRFWNHM03Z2
N4R6+rBobGzZyIGK3GrBL1RAUTUC3vF4xFHgpzX1GKTdQNJIvBPeGCavOKsoi6w=
=GfQT
-----END PGP SIGNATURE-----

--SS3UNquQT6rS6060X2xpNJBhGWKxbpjlJ--
