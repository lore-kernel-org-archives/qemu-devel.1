Received: from eggs.gnu.org ([2001:4830:134:3::10]:54556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csX0Q-0004Fr-59
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csX0M-0007sl-BL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csX0M-0007rw-1c
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:56:26 -0400
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aea80d19-4a6f-8791-9b10-34734d238206@redhat.com>
Date: Mon, 27 Mar 2017 10:56:18 -0500
MIME-Version: 1.0
In-Reply-To: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7rHHx2TmebJai7oJQmmbH8TtDmWTdPLpM"
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com
Cc: Abhijit.Dey@veritas.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7rHHx2TmebJai7oJQmmbH8TtDmWTdPLpM
From: Eric Blake <eblake@redhat.com>
To: Ashish Mittal <ashmit602@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 berrange@redhat.com, jcody@redhat.com, famz@redhat.com,
 ashish.mittal@veritas.com, stefanha@gmail.com, Ketan.Nilangekar@veritas.com,
 jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com,
 Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com
Cc: Abhijit.Dey@veritas.com
Message-ID: <aea80d19-4a6f-8791-9b10-34734d238206@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
In-Reply-To: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/26/2017 09:50 PM, Ashish Mittal wrote:
> Source code for the qnio library that this code loads can be downloaded=
 from:
> https://github.com/VeritasHyperScale/libqnio.git

When sending a multi-patch series, please include a 0/2 cover letter
('git config format.coverletter auto' can help).

>=20
> Sample command line using JSON syntax:
> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0=
=2E0.0:0
> -k en-us -vga cirrus -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci=
=2E0,addr=3D0x5
> -msg timestamp=3Don
> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410=
",
> "server":{"host":"172.172.17.4","port":"9999"}}'
>=20
> Sample command line using URI syntax:
> qemu-img convert -f raw -O raw -n
> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0

Do we really need URI syntax, now that we have -blockdev-add going into 2=
=2E9?

>=20
> Sample command line using TLS credentials (run in secure mode):
> ./qemu-io --object
> tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu/vxhs,endpoint=3Dclient -c =
'read
> -v 66000 2.5k' 'json:{"server.host": "127.0.0.1", "server.port": "9999"=
,
> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
>=20
> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
> ---
>=20

I'm just doing a high-level review of the interface, and leaving the
actual code review to others.

> +++ b/block/vxhs.c
> @@ -0,0 +1,595 @@
> +/*
> + * QEMU Block driver for Veritas HyperScale (VxHS)
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + *

No Copyright notice?  The GPL works by virtue of copyright law, so
generally a copyright holder should be mentioned.


> +++ b/qapi/block-core.json
> @@ -2118,6 +2118,7 @@
>  # @iscsi: Since 2.9
>  # @rbd: Since 2.9
>  # @sheepdog: Since 2.9
> +# @vxhs: Since 2.10
>  #
>  # Since: 2.0
>  ##
> @@ -2127,7 +2128,7 @@
>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'n=
fs',
>              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed'=
,
>              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
> -            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
> +            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }

Markus has patches pending (to promote x-blockdev-del over to
blockdev-del) that will conflict in context with this patch.  You may
have to rebase again, but hopefully the conflicts should be easy to
figure out.

> =20
>  ##
>  # @BlockdevOptionsFile:
> @@ -2820,6 +2821,22 @@
>    'data': { '*offset': 'int', '*size': 'int' } }
> =20
>  ##
> +# @BlockdevOptionsVxHS:
> +#
> +# Driver specific block device options for VxHS
> +#
> +# @vdisk-id:    UUID of VxHS volume
> +# @server:      vxhs server IP, port
> +# @tls-creds:   TLS credentials ID
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'BlockdevOptionsVxHS',
> +  'data': { 'vdisk-id': 'str',
> +            'server': 'InetSocketAddress',

Do you want to use the new InetSocketAddressBase (just host and port,
eliminating things like 'to' that don't make much sense in this context)?=


> +            '*tls-creds': 'str' } }
> +
> +##
>  # @BlockdevOptions:
>  #
>  # Options for creating a block device.  Many options are available for=
 all
> @@ -2881,7 +2898,8 @@
>        'vhdx':       'BlockdevOptionsGenericFormat',
>        'vmdk':       'BlockdevOptionsGenericCOWFormat',
>        'vpc':        'BlockdevOptionsGenericFormat',
> -      'vvfat':      'BlockdevOptionsVVFAT'
> +      'vvfat':      'BlockdevOptionsVVFAT',
> +      'vxhs':       'BlockdevOptionsVxHS'
>    } }
> =20
>  ##
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7rHHx2TmebJai7oJQmmbH8TtDmWTdPLpM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2TYiAAoJEKeha0olJ0NqmUkH/3fKGfi9Rb6jUkJrzrgbczGP
ewqWjpDAFu6XEeMicYxw/1cP9D0zcZ17lKeq9uNhl/bPKE0ZAX11x3xFMxkrtzdI
LybEcGq5eZunNX53Z6lGo8PqALd4qhDA6B/Wiq+BTY/8VDhVserswgBFFSkFtWtz
hupicp15wu8VdQbeME3sML4alRo8Mz7SWwjJBguL8TCh7maXqbOPAdxOVscTQMxf
uDPu3pr+DGcawcRGORRyrTzDmo8cjWfo7zHXQlyyHA2NF8JZQNXFHPopx1E9F6et
gWbOIBRx5PucjeUDxkjtV98uJ2QqyYBM5TMeQQ+z+q+lfzKZRVm7sWQIr5/NNC8=
=YdwI
-----END PGP SIGNATURE-----

--7rHHx2TmebJai7oJQmmbH8TtDmWTdPLpM--
