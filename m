Received: from eggs.gnu.org ([2001:4830:134:3::10]:38045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEPB-00037l-1k
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEP6-0007fi-FD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:41:05 -0500
References: <20171205104141.28882-1-stefanha@redhat.com>
	<20171205104141.28882-9-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d097c24-26d0-ded1-a750-58c5750298a8@redhat.com>
Date: Tue, 5 Dec 2017 08:40:42 -0600
MIME-Version: 1.0
In-Reply-To: <20171205104141.28882-9-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FKCg3l66OUViad7awgalaim2qrXta2dIP"
Subject: Re: [Qemu-devel] [PATCH 8/9] blockdev: add x-blockdev-set-iothread
 testing command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FKCg3l66OUViad7awgalaim2qrXta2dIP
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <3d097c24-26d0-ded1-a750-58c5750298a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/9] blockdev: add x-blockdev-set-iothread
 testing command
References: <20171205104141.28882-1-stefanha@redhat.com>
 <20171205104141.28882-9-stefanha@redhat.com>
In-Reply-To: <20171205104141.28882-9-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 04:41 AM, Stefan Hajnoczi wrote:
> Currently there is no easy way for iotests to ensure that a BDS is boun=
d
> to a particular IOThread.  Normally the virtio-blk device calls
> blk_set_aio_context() when dataplane is enabled during guest driver
> initialization.  This never happens in iotests since -machine
> accel=3Dqtest means there is no guest activity (including device driver=

> initialization).
>=20
> This patch adds a QMP command to explicitly assign IOThreads in test
> cases.  See qapi/block-core.json for a description of the command.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

> +##
> +# @x-blockdev-set-iothread:
> +#
> +# Move @node and its children into the @iothread.  If @iothread is emp=
ty then
> +# move @node and its children into the main loop.
> +#
> +# The node must not be attached to a BlockBackend.
> +#
> +# @node-name: the name of the block driver node
> +#
> +# @iothread: the name of the IOThread object
> +#

> +# 2. Move a node into the main loop
> +# -> { "execute": "x-blockdev-set-iothread",
> +#      "arguments": { "node-name": "disk1",
> +#                     "iothread": "" } }

Eww. Special casing of the empty string.  Would it be better design to
have iothread be optional, and to omit it to move a node into the main
loop?  Or use the StrOrNull type to allow JSON null instead of "" to
mean the main loop?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FKCg3l66OUViad7awgalaim2qrXta2dIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomr+oACgkQp6FrSiUn
Q2ob/AgAnBt1e4LERj4yDXA4vwqmm2wwI2vKRDHZZ1ySEs/B61Y/l6AN5Vupbv3w
6+NQY/4k+dPuqOrVpTp4CIUDn0tvPK60ySG2qyhvVFTeLCLS/OAO6pyXwtTD8pJh
vEpJ23ZgZEKgtferJWVEO9PH2okU4fXHQG7dWZFOHeEHvC4Xo3/uwBh2RezF9SkE
6w6JEpnoNMVxrFp42oFaqFbLzGzMKQxeIj/A+5nbGmAOV+VfKudjc4Hrlm0rMEld
2/tXUGJu9lBZygk12Gvs/qdQDK8rph081TBq4OQMFTM1ZfM0d/CnvyrxA/TOMnvW
ZmH1k6cum5D18Vabddz6VU3lNabD/A==
=3IMI
-----END PGP SIGNATURE-----

--FKCg3l66OUViad7awgalaim2qrXta2dIP--
