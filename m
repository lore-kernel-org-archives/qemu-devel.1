Received: from eggs.gnu.org ([2001:4830:134:3::10]:45256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzNmg-00047v-L1
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzNmc-0008NN-Fc
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:02:54 -0400
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e77d7b78-a2ff-51a3-360e-c7d5d4e7006b@redhat.com>
Date: Tue, 3 Oct 2017 09:02:27 -0500
MIME-Version: 1.0
In-Reply-To: <1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mCHSRBdFCAxCFVwLn40AcXk5X1bFwV9Vb"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] virtio: introduce `query-virtio'
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mCHSRBdFCAxCFVwLn40AcXk5X1bFwV9Vb
From: Eric Blake <eblake@redhat.com>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <e77d7b78-a2ff-51a3-360e-c7d5d4e7006b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] virtio: introduce `query-virtio' QMP
 command
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/03/2017 07:47 AM, Jan Dakinevich wrote:
> The command is intended for gathering virtio information such as status=
,
> feature bits, negotiation status. It is convenient and useful for debug=

> purpose.
>=20
> The commands returns generic virtio information for virtio such as
> common feature names and status bits names and information for all
> attached to current machine devices.
>=20
> To retrieve names of device-specific features `get_feature_name'
> callback in VirtioDeviceClass also was introduced.
>=20
> Cc: Denis V. Lunev <den@virtuozzo.com>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> ---
>  hw/block/virtio-blk.c       |  21 +++++++++
>  hw/char/virtio-serial-bus.c |  15 +++++++
>  hw/display/virtio-gpu.c     |  13 ++++++
>  hw/net/virtio-net.c         |  35 +++++++++++++++
>  hw/scsi/virtio-scsi.c       |  16 +++++++
>  hw/virtio/Makefile.objs     |   2 +
>  hw/virtio/virtio-balloon.c  |  15 +++++++
>  hw/virtio/virtio-stub.c     |   9 ++++
>  hw/virtio/virtio.c          | 101 ++++++++++++++++++++++++++++++++++++=
++++++++
>  include/hw/virtio/virtio.h  |   2 +
>  qapi-schema.json            |   1 +
>  qapi/virtio.json            |  94 ++++++++++++++++++++++++++++++++++++=
+++++
>  12 files changed, 324 insertions(+)
>  create mode 100644 hw/virtio/virtio-stub.c
>  create mode 100644 qapi/virtio.json

This creates a new .json file, but does not touch MAINTAINERS.  Our idea
in splitting the .json files was to make it easier for each sub-file
that needs a specific maintainer in addition to the overall *.json line
for QAPI maintainers, so this may deserve a MAINTAINERS entry.


> +++ b/qapi/virtio.json
> @@ -0,0 +1,94 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# =3D Virtio devices
> +##
> +
> +{ 'include': 'common.json' }
> +
> +##
> +# @VirtioInfoBit:
> +#
> +# Named virtio bit
> +#
> +# @bit: bit number
> +#
> +# @name: bit name
> +#
> +# Since: 2.11.0
> +#
> +##
> +{
> +    'struct': 'VirtioInfoBit',
> +    'data': {
> +        'bit': 'uint64',

Why is this a 64-bit value? Are the values 0-63, or are they 1, 2, 4, 8,
=2E..?  The documentation on 'bit number' is rather sparse.

> +        'name': 'str'

Wouldn't an enum type be better than an open-ended string?

> +    }
> +}
> +
> +##
> +# @VirtioInfoDevice:
> +#
> +# Information about specific virtio device
> +#
> +# @qom_path: QOM path of the device

Please make this 'qom-path' - new interfaces should prefer '-' over '_'.

> +#
> +# @feature-names: names of device-specific features
> +#
> +# @host-features: bitmask of features, provided by devices
> +#
> +# @guest-features: bitmask of features, acknowledged by guest
> +#
> +# @status: virtio device status bitmask
> +#
> +# Since: 2.11.0
> +#
> +##
> +{
> +    'struct': 'VirtioInfoDevice',
> +    'data': {
> +        'qom_path': 'str',
> +        'feature-names': ['VirtioInfoBit'],
> +        'host-features': 'uint64',
> +        'guest-features': 'uint64',
> +        'status': 'uint64'

I'm wondering if this is the best representation (where the caller has
to parse the integer and then lookup in feature-names what each bit of
the integer represents).  But I'm not sure I have anything better off
the top of my head.

> +    }
> +}
> +
> +##
> +# @VirtioInfo:
> +#
> +# Information about virtio devices
> +#
> +# @feature-names: names of common virtio features
> +#
> +# @status-names: names of bits which represents virtio device status
> +#
> +# @devices: list of per-device virtio information
> +#
> +# Since: 2.11.0
> +#
> +##
> +{
> +    'struct': 'VirtioInfo',
> +    'data': {
> +        'feature-names': ['VirtioInfoBit'],

Why is feature-names listed at two different nestings of the return value=
?

> +        'status-names': ['VirtioInfoBit'],
> +        'devices': ['VirtioInfoDevice']
> +    }
> +}
> +
> +
> +##
> +# @query-virtio:
> +#
> +# Returns generic and per-device virtio information
> +#
> +# Since: 2.11.0
> +#
> +##
> +{
> +    'command': 'query-virtio',
> +    'returns': 'VirtioInfo'
> +}
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mCHSRBdFCAxCFVwLn40AcXk5X1bFwV9Vb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnTmHMACgkQp6FrSiUn
Q2orswf+KPHL9GhKfaFK6IQjLoupIhxR8okRTI3DL8NMBlHIZTkApKLdT/2afNJm
10wOpcqzIyYfO5AxYX3xqd1/vbH0a6HOC+3QqW2jTSRAMYrbivNY8ErFe6WfXd+B
jNNPPjhO1mIOD4iQWgTI0E1QD1zys0JkQYI6DwdoR+tokaj8Gzah2/tWP98DaJaT
nHIuT4qMacnA1rrmq+dfJObceew8UV/4cck89XIRjgwwaOhdiDsDbGkpqRT3Jv4p
C94yH+wxZTFEgHO9cLTswnCzi9CNIK6jUCe73kQULi/vpFBAB3dCIkDNMljec+do
A9c8oBwntxJjuajXyA6UJqQqVm7Rhg==
=IwSr
-----END PGP SIGNATURE-----

--mCHSRBdFCAxCFVwLn40AcXk5X1bFwV9Vb--
