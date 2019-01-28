Received: from eggs.gnu.org ([209.51.188.92]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goCKU-0007Y5-IM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goCKT-0007aF-O8
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:12:22 -0500
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548700805-1016533-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5c4a099-d89c-6991-6644-98fc760b9106@redhat.com>
Date: Mon, 28 Jan 2019 13:11:55 -0600
MIME-Version: 1.0
In-Reply-To: <1548700805-1016533-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e2h9Oh9YrnZGpXxiV4SNVb7PaCD5E2wsB"
Subject: Re: [Qemu-devel] [PATCH v8 2/2] qemu-img info: bitmaps extension
 new test 239
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e2h9Oh9YrnZGpXxiV4SNVb7PaCD5E2wsB
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Message-ID: <c5c4a099-d89c-6991-6644-98fc760b9106@redhat.com>
Subject: Re: [PATCH v8 2/2] qemu-img info: bitmaps extension new test 239
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548700805-1016533-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548700805-1016533-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 12:40 PM, Andrey Shinkevich wrote:
> A new test file 239 added to the qemu-iotests set. It checks
> the output format of 'qemu-img info' for bitmaps extension of
> qcow2 specific information.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

> +++ b/tests/qemu-iotests/239.out
> @@ -0,0 +1,33 @@
> +{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 163=
84, "name": "bitmap-1", "node": "drive0", "persistent": true}}
> +{"return": {}}
> +{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 327=
68, "name": "bitmap-2", "node": "drive0", "persistent": true}}
> +{"return": {}}
> +{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 655=
36, "name": "bitmap-3", "node": "drive0", "persistent": true}}

Should the test also create a disabled bitmap ("enabled":false), to show
the change in flags, and/or a non-persistent bitmap (to show that it
does not affect the qcow2 information, but only the query-blocks output,
because it is transient)?



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--e2h9Oh9YrnZGpXxiV4SNVb7PaCD5E2wsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxPU/sACgkQp6FrSiUn
Q2rkrAf/YGpwEBXLHXtCd0N92QgZM4aZ7wBla6ph81jJn74XiLdTOJTCh3XQ0djF
D8BKKLrdOksThaWGtlbg8LI6M6ddkTfGRg9vkwVQrHjRkkpX+mQyYcJKB7JWUTl+
wjFwbLjmqPaNoIRBLJczJSIFjWkgtJa3gdhGMA0GAHZed9mub767J7rKNYSPVDoV
BnNAyLJDKSOvMQGB9fhdkdzpGbMuHbfe0q423btYkvwO1djBEtGtHaKfwhxq4CZY
J7Ca3P0VaIK2jfRw99RONqYKiChfEbqbpV1IszU4/HCDimoQOilaT1iFd693EQRv
Tl+MH744AN0LmBo21/YspADLMdwarg==
=JOgN
-----END PGP SIGNATURE-----

--e2h9Oh9YrnZGpXxiV4SNVb7PaCD5E2wsB--
