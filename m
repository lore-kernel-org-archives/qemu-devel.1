Received: from eggs.gnu.org ([2001:4830:134:3::10]:59525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWHQ-0005mf-EP
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWHP-0005ol-IT
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:48:56 -0500
References: <20180130062503.32596-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0a1f5dd-dc2a-cb80-b1d2-f94215594cbb@redhat.com>
Date: Tue, 30 Jan 2018 07:48:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180130062503.32596-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FmHDUANxEpI3w9giNpyt4El5BlpBNO1Wb"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
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
--FmHDUANxEpI3w9giNpyt4El5BlpBNO1Wb
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <b0a1f5dd-dc2a-cb80-b1d2-f94215594cbb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
References: <20180130062503.32596-1-famz@redhat.com>
In-Reply-To: <20180130062503.32596-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 12:25 AM, Fam Zheng wrote:
> This reverts commit 76bf133c4 which updated the reference output, and
> fixed the reference image, because the code path we want to exercise is=

> actually the invalid image size.
>=20
> The descriptor block in the image, which includes the CID to verify, ha=
s been
> invalid since the reference image was added. Since commit 9877860e7bd w=
e report
> this error earlier than the "file too large", so 059.out mismatches.
>=20
> The binary change is generated along the operations of:
>=20
>   $ bunzip2 afl9.vmdk.bz2
>   $ qemu-img create -f vmdk fix.vmdk 1G
>   $ dd if=3Dafl9.vmdk.bz2 of=3Dfix.vmdk bs=3D512 count=3D1 conv=3Dnotru=
nc

Is the .bz2 suffix spurious here?

>   $ mv fix.vmdk afl9.vmdk
>   $ bzip2 afl9.vmdk
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FmHDUANxEpI3w9giNpyt4El5BlpBNO1Wb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwd7sACgkQp6FrSiUn
Q2rXYggAmEyiQxwxG5m3jAqu9tg+VLaBHrF2hj7XF3q9KsbQz18s5eIIDExbwwGN
7FmFwT6Xw5Pw6Wtqd9FWbLAKL9Q6YnBh181rt/oinQP4fryHQ+MCNrexxrFwD7jl
aht+riz4aJjgsDYtY2RA/pAneb7LqLjXn53AxqakFuKWu0b0ISlvmBzYONkuM/YK
SggLixmS1jO7TdburJlV/4XgaxLcoSVlrwI5y2xVQRsUNFHy9rXW15AnhSG/faHk
IEVyx7m8dc8T8eQKvxeIHenKNB8LvIQQ2bIrRHyiQbIv63RgK20yyLILpMvNAs74
3h3qstv85V4fOwTZiwku08l6OsjSvQ==
=pSpS
-----END PGP SIGNATURE-----

--FmHDUANxEpI3w9giNpyt4El5BlpBNO1Wb--
