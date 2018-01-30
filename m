Received: from eggs.gnu.org ([2001:4830:134:3::10]:37135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYKn-0006P5-Va
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYKj-00041L-EI
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:00:34 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
	<3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
	<563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
	<f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fa7970fe-edbd-fd67-795b-84e83d216198@redhat.com>
Date: Tue, 30 Jan 2018 10:00:08 -0600
MIME-Version: 1.0
In-Reply-To: <f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iDmAEn2uYvKS45gD89Vngj7XOkOz0uxni"
Subject: Re: [Qemu-devel] [PATCH v7 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iDmAEn2uYvKS45gD89Vngj7XOkOz0uxni
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Max Reitz
 <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 berto@igalia.com
Message-ID: <fa7970fe-edbd-fd67-795b-84e83d216198@redhat.com>
Subject: Re: [PATCH v7 1/9] mirror: inherit supported write/zero flags
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
 <3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
 <563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
 <f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
In-Reply-To: <f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 06:15 AM, Anton Nefedov wrote:

>>>> @@ -1064,6 +1064,11 @@ static void
>>>> bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(bs->backing->bs=
);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(bs->exact_filename, sizeof(bs=
->exact_filename),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bs->backing->bs->filename);
>>>> +=C2=A0=C2=A0=C2=A0 bs->supported_write_flags =3D BDRV_REQ_FUA &
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->backing->bs->support=
ed_write_flags;

>>> Fundamentally OK, but why is this in *_refresh_filename()?
>>
>> Indeed, I missed that (or maybe it got moved during a botched rebase?)=
=2E
>> For comparison, blkdebug sets it during blkdebug_open(), and nbd sets =
it
>> during nbd_client_init() (called during nbd_open()).
>>
>=20
> We need a backing bs here and I believe it's not generally set at the
> time of .bdrv_open()

Then is mirror_start_job() a better location, right after we call
bdrv_new_open_driver()?  (Maybe this just goes to show I haven't fully
traced the lifecycle of the mirror driver, and it may all be changing
anyways as we try to fix the BDS graph modifications related with mirrors=
).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iDmAEn2uYvKS45gD89Vngj7XOkOz0uxni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwlogACgkQp6FrSiUn
Q2q5bwf/S4A/Th0gUrrRkqotrkFE2ZKdm8SFzARq9wJjLdPOf8X13UQ4Z+GG0zoU
1sPr3GPgZG/L1MpK6rztqkVyRzwNCfvqTQFMphe4P4W0phKtX5YJtWrVkTLQrYfh
e0vujZeoPYaj+6PyzmgYgLmPZtwkc0JDfvBDtGy5ahT6XlNd18aAcw4mPRId5rUl
15blLH64Pe+o7hmhQP7Dd6pDzdV35fE0udRZvWseU3iDHH8BVxiIXO7kP2LCS69s
3luHNWOFhqJow1t+/uQ0noE3hwRo63ZenvgKsl1us56uCy/K/msxLJcrKFYYq6n0
eyW7A20xV3ncYHHAwfS0f+znANRMeg==
=SGTj
-----END PGP SIGNATURE-----

--iDmAEn2uYvKS45gD89Vngj7XOkOz0uxni--
