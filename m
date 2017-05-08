Received: from eggs.gnu.org ([2001:4830:134:3::10]:42010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7k1d-0003LX-W1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7k1d-00010Z-5z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7k1c-00010M-SU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:52:37 -0400
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bae8e3d3-35fd-89ba-9afe-ae4dc83f9924@redhat.com>
Date: Mon, 8 May 2017 09:52:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170508141536.20690-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OSPDACcmANTQkWtgqDTHcrcrHqIKttfHp"
Subject: Re: [Qemu-devel] [PATCH v6 2/9] raw-format: add bdrv_measure()
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OSPDACcmANTQkWtgqDTHcrcrHqIKttfHp
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <bae8e3d3-35fd-89ba-9afe-ae4dc83f9924@redhat.com>
Subject: Re: [PATCH v6 2/9] raw-format: add bdrv_measure() support
References: <20170508141536.20690-1-stefanha@redhat.com>
 <20170508141536.20690-3-stefanha@redhat.com>
In-Reply-To: <20170508141536.20690-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 09:15 AM, Stefan Hajnoczi wrote:
> Maximum size calculation is trivial for the raw format: it's just the
> requested image size (because there is no metadata).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/raw-format.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OSPDACcmANTQkWtgqDTHcrcrHqIKttfHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEIYlAAoJEKeha0olJ0Nq+2YH/01S4jLyhXxOE7MQ7LROyo/U
gTl9DloocYq1Yjl+vju2XZYJafRAsWZQsvHNuyhUdO2KjVKNKnUVnnTt0+YkDKad
GGdfqo5JGEse46aUUu0tQHjrI1mJsVIMLfFRIXL6ZFD5JLB35rktNFugEkp2p5ZQ
lNvE9rcsxEbZ8WPUWBaxl7yfKP3NMSCgd18ULPRBvosHB8FMqnQaOBGLhwtfsbTo
Ybr8D+Of1TI4/XvVJ0Q8xxgIbSN4Pl8exo5/ZPa41by5louO1QB1GaWZN/QMLsbP
EcipGgfN0SxqBuiym8f61MOihu4/QUCAVgzIKr5EVjm6RK6DZDNSd5+ZEh6k5vo=
=5TuQ
-----END PGP SIGNATURE-----

--OSPDACcmANTQkWtgqDTHcrcrHqIKttfHp--
