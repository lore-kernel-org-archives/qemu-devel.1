Received: from eggs.gnu.org ([2001:4830:134:3::10]:55234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPqIL-000114-7G
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPqIK-0008Aa-6S
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:12:41 -0400
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-6-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a7e5169-1070-9888-1311-cf03ad5e11f5@redhat.com>
Date: Tue, 27 Jun 2017 08:12:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170623124700.1389-6-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pHBOSCfXgjPAk8iQJpkuVBgfrCkrI0AS1"
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pHBOSCfXgjPAk8iQJpkuVBgfrCkrI0AS1
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>
Message-ID: <6a7e5169-1070-9888-1311-cf03ad5e11f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
 <20170623124700.1389-6-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-6-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2017 07:46 AM, Manos Pitsidianakis wrote:
> This is needed to configure throttle filter driver nodes with QAPI.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  qapi/block-core.json | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f85c2235c7..1d4afafe8c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2119,7 +2119,7 @@
>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'n=
fs',
>              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed'=
,
>              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
> -            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
> +            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' =
] }

We already have a '@vxhs: Since 2.10' comment, you should add a similar
one for @throttle.


> +
> +##
> +# @BlockdevOptionsThrottle:
> +#
> +# Driver specific block device options for Throttle
> +#
> +# @throttling-group: the name of the throttling group to use
> +#
> +# @options:        BlockIOThrottle options
> +# Since: 2.9

You missed 2.9; this should be 2.10.

> +##
> +{ 'struct': 'BlockdevOptionsThrottle',
> +  'data': { 'throttling-group': 'str',
> +            'file' : 'BlockdevRef',

Missing documentation for 'file'.

> +            '*options' : 'BlockIOThrottle'
> +             } }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pHBOSCfXgjPAk8iQJpkuVBgfrCkrI0AS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUlm9AAoJEKeha0olJ0NqDJgIAJw7t+l1k7w6WrIX6i2fQQbf
1d4H22w2TgXnj3foETfsxEDUpyUb5tYGz5Cbbvnrgjkh5q5z9yXjDYl8p+5QZOAk
1MEPedpNyMs9VDv9AxmlLRtEFyy43tqByW2R9P24OLrIWLsWcxTt5f6CJuoMKc8V
ZuNN1XlCIuuo39B+2D1zdbqxsbtbJaylk6qwcU1OuR/RSx73d6OD9wAdAt0zMvYF
/TkM3LRYivpgZRUeJ/9LFXuvhnMoTAyYRTb+KbDK/JuBb5QUlquStBAj6Uiwrgjv
rdasdauIHU8I//CJwdOxpVAJ8009Y/Mmvfvg7EeeW5bXGtLHTV8WAfTYoi35fhw=
=isQj
-----END PGP SIGNATURE-----

--pHBOSCfXgjPAk8iQJpkuVBgfrCkrI0AS1--
