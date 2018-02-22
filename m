Received: from eggs.gnu.org ([2001:4830:134:3::10]:56773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep09n-0008Sv-6d
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep08s-0001Wv-3Q
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:20:07 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-21-kwolf@redhat.com>
	<e489044a-0cb7-b7f1-3042-26ba1bbc7dfc@redhat.com>
Message-ID: <d69ccb00-f2be-5743-9ee4-4d5b3ed580b8@redhat.com>
Date: Fri, 23 Feb 2018 00:16:53 +0100
MIME-Version: 1.0
In-Reply-To: <e489044a-0cb7-b7f1-3042-26ba1bbc7dfc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hq8pgEYvThi2XJShyIsCrcLhXb9lEwxxM"
Subject: Re: [Qemu-devel] [PATCH v2 20/36] rbd: Remove non-schema options
 from runtime_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hq8pgEYvThi2XJShyIsCrcLhXb9lEwxxM
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <d69ccb00-f2be-5743-9ee4-4d5b3ed580b8@redhat.com>
Subject: Re: [PATCH v2 20/36] rbd: Remove non-schema options from runtime_opts
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-21-kwolf@redhat.com>
 <e489044a-0cb7-b7f1-3042-26ba1bbc7dfc@redhat.com>
In-Reply-To: <e489044a-0cb7-b7f1-3042-26ba1bbc7dfc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 00:13, Max Reitz wrote:
> On 2018-02-21 14:53, Kevin Wolf wrote:
>> Instead of the QemuOpts in qemu_rbd_connect(), we want to use QAPI
>> objects. As a preparation, fetch those options directly from the QDict=

>> that .bdrv_open() supports in the rbd driver and that are not in the
>> schema.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block/rbd.c | 55 ++++++++++++++++++++++++----------------------------=
---
>>  1 file changed, 24 insertions(+), 31 deletions(-)
>>
>> diff --git a/block/rbd.c b/block/rbd.c
>> index 4bbcce4eca..2e79c2d1fd 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -326,28 +326,6 @@ static QemuOptsList runtime_opts =3D {
>>          /*
>>           * server.* extracted manually, see qemu_rbd_mon_host()
>>           */
>> -        {
>> -            .name =3D "password-secret",
>> -            .type =3D QEMU_OPT_STRING,
>> -            .help =3D "ID of secret providing the password",
>> -        },
>=20
> Err, did we just forget this in the QAPI schema or is it really not
> supposed to be there?

Ah, we intentionally removed it after it was added.  OK, then.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Hq8pgEYvThi2XJShyIsCrcLhXb9lEwxxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPT2USHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARFgIALx7wvp2MODfDTCMttVBZCxj3pSPLuuz
+lnop137ERN6Q4d0Gg5Dhb759laqIe9XkFRtWYLYiqNtCUCtpIKqWveXg4iHcLyq
cs9Ftzh8SUUJt/IRPTPcw68kxqGtTyq7cvLuCcFcdd9ClVdrU0/OvrDes9Hrz78E
Lao6liKJpLmNWmiG3SzyLzZb3t6N4aZ1+Mzo+F+3sQ6cNsyRVvNSwRFNKL6Um1Da
1zYrrnWB8deSy39kq9eupPXt5RY8WOrd/HC7fIaEqBATFFEUFTRb+dKaaxeqtSAG
IMkJbkiRI7NMY5bEJ3Gg6Xa0L6caBzmugW7O8o1iPQfarKh3AC9wYS0=
=u0zt
-----END PGP SIGNATURE-----

--Hq8pgEYvThi2XJShyIsCrcLhXb9lEwxxM--
