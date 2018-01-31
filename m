Received: from eggs.gnu.org ([2001:4830:134:3::10]:36721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egw3m-0003u7-Ht
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egw3l-000135-Oi
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:20:34 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
	<3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
	<563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
	<f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e349960e-686c-a48e-f6a1-c4857ff58a64@redhat.com>
Date: Wed, 31 Jan 2018 18:20:18 +0100
MIME-Version: 1.0
In-Reply-To: <f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="icVesgj1uqWZiquELlvQV1qGNyayAawF8"
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--icVesgj1uqWZiquELlvQV1qGNyayAawF8
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 berto@igalia.com
Message-ID: <e349960e-686c-a48e-f6a1-c4857ff58a64@redhat.com>
Subject: Re: [PATCH v7 1/9] mirror: inherit supported write/zero flags
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
 <3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
 <563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
 <f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
In-Reply-To: <f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-30 13:15, Anton Nefedov wrote:
>=20
>=20
> On 29/1/2018 10:26 PM, Eric Blake wrote:
>> On 01/29/2018 01:21 PM, Max Reitz wrote:
>>> On 2018-01-18 18:48, Anton Nefedov wrote:
>>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>> ---
>>>> =C2=A0 block/mirror.c | 5 +++++
>>>> =C2=A0 1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/block/mirror.c b/block/mirror.c
>>>> index c9badc1..d18ec65 100644
>>>> --- a/block/mirror.c
>>>> +++ b/block/mirror.c
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
>>>> +=C2=A0=C2=A0=C2=A0 bs->supported_zero_flags =3D
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (BDRV_REQ_FUA | BDRV_REQ=
_MAY_UNMAP) &
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->backing->bs->support=
ed_zero_flags;
>>>> =C2=A0 }
>>>> =C2=A0 =C2=A0 static void bdrv_mirror_top_close(BlockDriverState *bs=
)
>>>
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
> time of .bdrv_open().

Well, but *_refresh_filename() is just wrong.

This driver doesn't have .bdrv_open() at all, and we create it fully
manually in mirror_start_job() anyway (as Eric has said).  Therefore, we
can just do this right after bdrv_append() there has succeeded.

Max


--icVesgj1uqWZiquELlvQV1qGNyayAawF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpx+tISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0GcH/01WlK0EATZjeKSnMg3T9SToBwOfGSyy
2fsNwmEU7e4mOQLHYM/g7S8niIW7ZySoH3HuFebqbPjEA2x4+RomsDQkQcz9zqHW
hCwc36u9ADe0eC9fObYL2JAXWlT+LsNx06aFlmfYqjycnq2h3U5JqIkB9HUC7SGN
P2pmtjjzvkr0+0Ng9Gonvc3PEqxJVIMLo+P15dwKVrt+sEyplwUo9wmNuFkiLoWQ
E0SNE7OJ75ZYgQmvxpBUh1Nht7kCyhQe/MQ82n3eei5cGdF+O5tUbFPhVTFaggfz
RNhvfugO7wZUMKtpTXdF5BWBEvR3nRw4mK7X1Mzy3sS/jOkSNp2JNkw=
=feos
-----END PGP SIGNATURE-----

--icVesgj1uqWZiquELlvQV1qGNyayAawF8--
