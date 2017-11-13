Received: from eggs.gnu.org ([2001:4830:134:3::10]:46380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEGnw-0002hj-IW
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEGnv-0007EK-Gb
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:37:44 -0500
References: <20171113150026.4743-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1ccbb52-9465-62a5-3bd5-743987243f62@redhat.com>
Date: Mon, 13 Nov 2017 09:37:33 -0600
MIME-Version: 1.0
In-Reply-To: <20171113150026.4743-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ADuTLKcoASGIr23NXd6DEbnOpjldOSAWD"
Subject: Re: [Qemu-devel] [PATCH] iotests: 077: Filter out 'resume' lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ADuTLKcoASGIr23NXd6DEbnOpjldOSAWD
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <d1ccbb52-9465-62a5-3bd5-743987243f62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 077: Filter out 'resume' lines
References: <20171113150026.4743-1-famz@redhat.com>
In-Reply-To: <20171113150026.4743-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 09:00 AM, Fam Zheng wrote:
> In the "Overlapping multiple requests" cases, the 3rd reqs (the break
> point B) doesn't wait for the 2nd, and once resumed the I/O will just
> continue.  This is because the 2nd is already waiting for the 1st, and
> in wait_serialising_requests() there is:
>=20

> Filter out the "Resuming request" lines to make the output
> deterministic.
>=20
> Reported-by: Patchew <no-reply@patchew.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/077     |  3 ++-
>  tests/qemu-iotests/077.out | 48 ++++++++++++++++----------------------=
--------
>  2 files changed, 18 insertions(+), 33 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> @@ -4,17 +4,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D13=
4217728
>  =3D=3D Some concurrent requests involving RMW =3D=3D
>  wrote XXX/XXX bytes at offset XXX
>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -blkdebug: Resuming request 'A'
> -wrote XXX/XXX bytes at offset XXX
> -XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote XXX/XXX bytes at offset XXX
> -XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -blkdebug: Resuming request 'A'
> -wrote XXX/XXX bytes at offset XXX
> -XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote XXX/XXX bytes at offset XXX
> -XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -blkdebug: Resuming request 'A'

git diff does a really lousy job of displaying this one, but the end
result looks correct.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ADuTLKcoASGIr23NXd6DEbnOpjldOSAWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJvD0ACgkQp6FrSiUn
Q2oJowf/cxL/Lz15jzVckdfO4vrkwnU6cQJugQ31XMOSXd2mzmw5AQ24IvWbjWeo
HRrMrIMLtMe6l5NwkagZi0xsPwP9gwtf8k5vIQYuGEejgmmB8CmrTbRxxinle7kH
nACszs4mGm1Wp0buGnqHQca9OBEZ4KZLuB/B2dq32nqRlwvCN4KhXAy60UMat9dk
mNkBjr5g8Yfj41acx+YPPVn1q9ar7CIIWf7qJ31bv6GP5CsEbxKp3HWcybHyth2L
sh575vM2FPL10lr4erzXTbs4WEEX7/07+IzaAiCtGY2TNPL5aQviWzC826XoXrCo
YenUnn9wP/n0FK81wVTpLth8iNDcXQ==
=aHIq
-----END PGP SIGNATURE-----

--ADuTLKcoASGIr23NXd6DEbnOpjldOSAWD--
