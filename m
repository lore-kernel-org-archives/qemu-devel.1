Received: from eggs.gnu.org ([2001:4830:134:3::10]:45192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxwd-0006Vl-0J
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxwc-0001P4-1D
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:21:18 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35ed5611-7dc3-eac1-58f0-6edcce9b0696@redhat.com>
Date: Wed, 31 Jan 2018 13:21:12 -0600
MIME-Version: 1.0
In-Reply-To: <c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BOMn6ZrFwHKtMLDV2ODbzuMFl2JHZfdE1"
Subject: Re: [Qemu-devel] [PATCH v3 37/39] iotests: Test valid values of
 l2-cache-entry-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BOMn6ZrFwHKtMLDV2ODbzuMFl2JHZfdE1
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <35ed5611-7dc3-eac1-58f0-6edcce9b0696@redhat.com>
Subject: Re: [PATCH v3 37/39] iotests: Test valid values of
 l2-cache-entry-size
References: <cover.1516978645.git.berto@igalia.com>
 <c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
In-Reply-To: <c034843507c57cc91762702070307d0aa88e56b1.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 09:00 AM, Alberto Garcia wrote:
> The l2-cache-entry-size setting can only contain values that are
> powers of two between 512 and the cluster size.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/103     | 17 +++++++++++++++++
>  tests/qemu-iotests/103.out |  3 +++
>  2 files changed, 20 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BOMn6ZrFwHKtMLDV2ODbzuMFl2JHZfdE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpyFygACgkQp6FrSiUn
Q2rTrwf7BvJYkVxdA/kFH9hCh780rTxAH3Ppwc0rnW1MTMlsxXfgBxQRIPgrXdZh
7NLDCLzZfkRbnivAFy7ty5CYeGD2PkO62SFzWKMDWXfEftWa1MR5cGIee2FCGHOy
34Z/D2INlFwWzwIENtXEREPB7vgsCx8dZQrEJnf5qsNI5TFjowMU8/69mey4S6KJ
efpB4t4CvJGqTXshLy0Hiy6Eie2MgkR4nxCv72maFPr4k8KmzBq1K8uo+9g7ziV+
qPQHdyeQFWe/KUIEMQQOzo2T13PciYgkM9vs+6h2mXyBG+gd1MfCXK79Hv8retv4
OmZNXdH/QQDCXe2BdpouTsX+AMR41Q==
=S904
-----END PGP SIGNATURE-----

--BOMn6ZrFwHKtMLDV2ODbzuMFl2JHZfdE1--
