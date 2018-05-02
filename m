Received: from eggs.gnu.org ([2001:4830:134:3::10]:55272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzq1-0003ow-NW
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzq0-00031q-Qm
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:03:01 -0400
References: <20180502202051.15493-1-mreitz@redhat.com>
	<20180502202051.15493-3-mreitz@redhat.com>
	<eeef06be-6c71-df6a-6aeb-8a7c23316dee@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ca5f1a91-84fe-d11b-f805-c7a8aca84cc3@redhat.com>
Date: Thu, 3 May 2018 00:02:44 +0200
MIME-Version: 1.0
In-Reply-To: <eeef06be-6c71-df6a-6aeb-8a7c23316dee@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZLB9pTsXUgoPCOw0c5RWRzPFqlSZAmNen"
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use only string options in
 img_open_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZLB9pTsXUgoPCOw0c5RWRzPFqlSZAmNen
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <ca5f1a91-84fe-d11b-f805-c7a8aca84cc3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use only string options in
 img_open_opts
References: <20180502202051.15493-1-mreitz@redhat.com>
 <20180502202051.15493-3-mreitz@redhat.com>
 <eeef06be-6c71-df6a-6aeb-8a7c23316dee@redhat.com>
In-Reply-To: <eeef06be-6c71-df6a-6aeb-8a7c23316dee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-03 00:00, Eric Blake wrote:
> On 05/02/2018 03:20 PM, Max Reitz wrote:
>> img_open_opts() takes a QemuOpts and converts them to a QDict, so all
>> values therein are strings.=C2=A0 Then it may try to call qdict_get_bo=
ol(),
>> however, which will fail with a segmentation fault every time:
>=20
> I have no idea if it's worth fixing qdict_get_bool() to at least not
> segfault when called on a non-bool Dict member (but what should it
> return, true or false? or should it abort() for at least a cleaner
> failure than a segfault?)

There's qdict_get_try_bool() which returns a default.  For testing
whether the member is a bool I suppose you can use
qdict_to(QBool, qdict_get(qdict, member)).

Max

> But in the meantime, your fix is correct.
>=20
>>
>> $ ./qemu-img info -U --image-opts \
>> =C2=A0=C2=A0=C2=A0=C2=A0 driver=3Dfile,filename=3D/dev/null,force-shar=
e=3Doff
>> [1]=C2=A0=C2=A0=C2=A0 27869 segmentation fault (core dumped)=C2=A0 ./q=
emu-img info -U
>> --image-opts driver=3Dfile,filename=3D/dev/null,force-share=3Doff
>>
>> Fix this by using qdict_get_str() and comparing the value as a string.=

>> Also, when adding a force-share value to the QDict, add it as a string=

>> so it fits the rest of the dict.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qemu-img.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--ZLB9pTsXUgoPCOw0c5RWRzPFqlSZAmNen
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrqNYQACgkQ9AfbAGHV
z0BbXwf8C3hpYbt+J2DFo7ImwdMe4nR4pGKm+w8lxvUqgbIsc9PgBBIt9uLlDcq3
zL6xYt7d0o8h/Qgy1Lint99VYYjqXhzxts9QWxC58xNAMM3WxbyOC//IOORJEnZ7
tmtRLl7kqjG9FXuXu1tFU950KJCOf9DZg01d5PGw/nhvWfRqRNqztgenVgldvZHG
D7fQN7QFxmvNacv1bx5peQN2MGoTC0vTz0e0Xb+npKIpO5qoNzx59/JSWyt2djQr
m1DPtuzN9Hr5FlXB5HGI1RwzjrszVUN7oPeq7xis/IhO6X8QOAlN+D5ZlhAK55xt
ugkq83S5mQMp+3Jw/q0OVFAKLGBCKw==
=liio
-----END PGP SIGNATURE-----

--ZLB9pTsXUgoPCOw0c5RWRzPFqlSZAmNen--
