Received: from eggs.gnu.org ([209.51.188.92]:55353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs8LX-0004YI-Io
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs8LW-0001E5-LL
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:45:43 -0500
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549638368-530182-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b4693e9-ac04-22b0-11e8-176f023f70c1@redhat.com>
Date: Fri, 8 Feb 2019 09:45:17 -0600
MIME-Version: 1.0
In-Reply-To: <1549638368-530182-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4VMad1ESXQO98OtdULMkQAudbvvSQjkER"
Subject: Re: [Qemu-devel] [PATCH v14 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4VMad1ESXQO98OtdULMkQAudbvvSQjkER
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <5b4693e9-ac04-22b0-11e8-176f023f70c1@redhat.com>
Subject: Re: [PATCH v14 3/3] qcow2: list of bitmaps new test 242
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1549638368-530182-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1549638368-530182-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/8/19 9:06 AM, Andrey Shinkevich wrote:
> A new test file 242 added to the qemu-iotests set. It checks
> the format of qcow2 specific information for the new added
> section that lists details of bitmaps.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/242     | 103 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/242.out | 165 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 269 insertions(+)
>  create mode 100755 tests/qemu-iotests/242
>  create mode 100644 tests/qemu-iotests/242.out
>=20

> +
> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
> +
> +disk =3D file_path('disk')
> +chunk =3D 256*1024
> +bitmap_flag_unknown =3D 1 << 2
> +#flag_offset =3D 5*cluster_size + flag_offset_in_bitmap_directory_entr=
y

pep8 didn't like the comment (missing space after #). I guess it doesn't
care about spaces or lack of spaces around binary operators (I might
have pug spaces around * in the assignment to chunk, but since pep8
didn't complain, I didn't change it).

As mentioned in the cover letter, adding:

log('Test complete')

at the end of 242, and adjusting 242.out accordingly, silences the
checkpatch warning. So with that change, I've now queued your series for
my next NBD pull request, probably on Monday.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4VMad1ESXQO98OtdULMkQAudbvvSQjkER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxdpA0ACgkQp6FrSiUn
Q2oRDQf+L3u8Go07lYZvez02Emht7X8sByKZwqt3afd0wRe3tvylSS+1++pkSPGz
8fWPUoy7LedY1Srxd/10BQ0s9tuG/W+KdhSVIzVcnOuCzJNAlrocsC+qDW/icvPU
W8J7U0Zx2nKFwsSIwyQjWzqVq5YIjdHKoMGM27aXgS0Y7efkSdA212Uqw9v1WdsY
bVhas1AeD/PV4+vc7EPL02l7AlZ6SdcaSjs8ZtNjIaDBIXMvLOKyfa+NXTOePjVD
RvuKy08DWAi9zMjBrjQF7+ZTvDuzMawRfRu/od4dpAATJJAwNtMrg36VdkS0o60F
ziBNcBw0FEcRZgwOoJ/dsojRnlztag==
=jSFy
-----END PGP SIGNATURE-----

--4VMad1ESXQO98OtdULMkQAudbvvSQjkER--
