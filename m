Received: from eggs.gnu.org ([2001:4830:134:3::10]:58645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4Hs-0006UC-DF
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4Hr-0003cS-Fh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:05:00 -0500
References: <20171207201320.19284-1-stefanha@redhat.com>
	<20171207201320.19284-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50b97dbd-ebee-d84c-939b-bd7d8a6c0f13@redhat.com>
Date: Thu, 7 Dec 2017 16:04:49 -0600
MIME-Version: 1.0
In-Reply-To: <20171207201320.19284-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6UJS8RTMbIlNM4nm57Ct5RttjN8vLJJX6"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] block: avoid recursive AioContext
 acquire in bdrv_inactivate_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6UJS8RTMbIlNM4nm57Ct5RttjN8vLJJX6
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50b97dbd-ebee-d84c-939b-bd7d8a6c0f13@redhat.com>
Subject: Re: [PATCH v2 1/6] block: avoid recursive AioContext acquire in
 bdrv_inactivate_all()
References: <20171207201320.19284-1-stefanha@redhat.com>
 <20171207201320.19284-2-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 02:13 PM, Stefan Hajnoczi wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> BDRV_POLL_WHILE() does not support recursive AioContext locking.  It
> only releases the AioContext lock once regardless of how many times the=

> caller has acquired it.  This results in a hang since the IOThread does=

> not make progress while the AioContext is still locked.
>=20
> The following steps trigger the hang:
>=20
>   $ qemu-system-x86_64 -M accel=3Dkvm -m 1G -cpu host \
>                        -object iothread,id=3Diothread0 \
>                        -device virtio-scsi-pci,iothread=3Diothread0 \
>                        -drive if=3Dnone,id=3Ddrive0,file=3Dtest.img,for=
mat=3Draw \
>                        -device scsi-hd,drive=3Ddrive0 \
>                        -drive if=3Dnone,id=3Ddrive1,file=3Dtest.img,for=
mat=3Draw \
>                        -device scsi-hd,drive=3Ddrive1
>   $ qemu-system-x86_64 ...same options... \
>                        -incoming tcp::1234
>   (qemu) migrate tcp:127.0.0.1:1234
>   ...hang...
>=20
> Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6UJS8RTMbIlNM4nm57Ct5RttjN8vLJJX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopuwEACgkQp6FrSiUn
Q2pRyQgAg78qfkC2FxzlIM2O/1NX0nPhi3AkG0ObNXjApYcpAnoy8H2UZhfm3UPS
evSGXOrsIZUDvwvq99qrT6zp0ljlfYOxuVWJD9S0AglBX1MmtRsB3E3UkC2ya2al
MarsoYVWD3PRs3wx/P14drlJlphQLtkhrvTN43qLTnDHzBpKAKV9Q0NJylQKDv/l
YyU7uoEDQ08DLkx6p9GFKdS5JT/HG/ElCcO5SXEOnkOjDOlHuX6H6WqwBof1HDzw
WdXZQM5d4+NsjZg1HfTFAm40hq94rqeFtWGxPjwXgN98BrVt3DieQU2nTKlHJ+rw
XouYka4XjR+bDzMX6pAJ5SBFEf/Jug==
=/wu9
-----END PGP SIGNATURE-----

--6UJS8RTMbIlNM4nm57Ct5RttjN8vLJJX6--
