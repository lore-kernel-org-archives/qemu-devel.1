Received: from eggs.gnu.org ([2001:4830:134:3::10]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUdM-00061q-D3
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUdL-0000Dr-9c
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:20:32 -0500
References: <20170103170459.27662-1-berrange@redhat.com>
	<20170103170459.27662-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed60223f-5468-6ebf-ee44-e8e262759256@redhat.com>
Date: Tue, 3 Jan 2017 13:20:24 -0600
MIME-Version: 1.0
In-Reply-To: <20170103170459.27662-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vqHwXq48gVtScnEBsTTSDVHMD0mtmgJAh"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] iotests: chown LUKS device before
 qemu-io launches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vqHwXq48gVtScnEBsTTSDVHMD0mtmgJAh
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <ed60223f-5468-6ebf-ee44-e8e262759256@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] iotests: chown LUKS device before
 qemu-io launches
References: <20170103170459.27662-1-berrange@redhat.com>
 <20170103170459.27662-6-berrange@redhat.com>
In-Reply-To: <20170103170459.27662-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 11:04 AM, Daniel P. Berrange wrote:
> On some distros, whenever you close a block device file
> descriptor there is a udev rule that resets the file
> permissions. This can race with the test script when
> we run qemu-io multiple times against the same block
> device. Occassionally the second qemu-io invokation

s/Occassionally/Occasionally/
s/invokation/invocation/

> will find udev has reset the permissions causing failure.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/149     |  13 +-
>  tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++---------------=
--------
>  2 files changed, 178 insertions(+), 179 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vqHwXq48gVtScnEBsTTSDVHMD0mtmgJAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa/l4AAoJEKeha0olJ0NqbQsH/ikcPmkn+OzO88jCMO3w/ZL3
94wv8DNfbUNqoRowhhpm8jrFNxaEjst/YdGjxUHJizgczk0c2AEARijj/Ajk3wqm
g9DIWJqrOP/OtkArTEhqIR6tenQc8OyQMybkAypJbXt/PKEIwgrPJUCwZ+JG32J5
UO3eYybsjglgM0xXsxjmPolIPJOQxLVP2wll/t7g/rLwoS+jF9oAycZVHdOngv57
yTEgvWP+FiaHvmioaqFSiOQg2mT1eynqFlYI/jfc2vyvtXmpYnu63SmTg3x0IA1k
kp0qRtMS8mbUH0ng3Nw7gjizIwvlTM9kkQtwS3ys7bwmW+fTCQcCMQBUl1nhbYs=
=kdXy
-----END PGP SIGNATURE-----

--vqHwXq48gVtScnEBsTTSDVHMD0mtmgJAh--
