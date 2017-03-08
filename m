Received: from eggs.gnu.org ([2001:4830:134:3::10]:55267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clf12-0003ql-Jr
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clf11-0007o2-Br
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:04:44 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195407.16415-1-mreitz@redhat.com>
	<20170307104748.GG5871@noname.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2ef39017-b7f1-6216-43de-a49360f26ce3@redhat.com>
Date: Wed, 8 Mar 2017 18:04:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170307104748.GG5871@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qtgEjpF5SUqDA6o64RvdHAlN3eIWKPqwc"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/3] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qtgEjpF5SUqDA6o64RvdHAlN3eIWKPqwc
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <2ef39017-b7f1-6216-43de-a49360f26ce3@redhat.com>
Subject: Re: [PATCH for-2.10 1/3] block: Add errp to b{lk,drv}_truncate()
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195407.16415-1-mreitz@redhat.com>
 <20170307104748.GG5871@noname.str.redhat.com>
In-Reply-To: <20170307104748.GG5871@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07.03.2017 11:47, Kevin Wolf wrote:
> Am 06.03.2017 um 20:54 hat Max Reitz geschrieben:
>> For one thing, this allows us to drop the error message generation fro=
m
>> qemu-img.c and blockdev.c and instead have it unified in
>> bdrv_truncate().
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>>  block/commit.c                 |  5 +++--
>>  block/mirror.c                 |  2 +-
>=20
> These still pass NULL after the series. Fixing it would require to add =
a
> way to complete jobs with an Error object, but maybe we should do this
> sooner or later anyway. Not necessarily part of this series, though.
>=20
>>  block/vhdx.c                   |  6 +++---
>>  block/vpc.c                    |  2 +-
>=20
> vpc can easily be fixed to pass the actual errp from vpc_create() to th=
e
> blk_truncate() call. In vhdx.c, the blk_truncate() call is a bit more
> deeply nested, but it doesn't seem completely unreasonable there either=
=2E

vhdx is insofar not completely unreasonable because it already sometimes
generates Error objects and sometimes doesn't; so if I were to expand on
that inconsistent behavior, I wouldn't make matters worse. But still I
don't feel quite comfortable touching that.

Let's see, maybe I prepend a patch that makes vhdx_create() always
generate Error objects.

Max


--qtgEjpF5SUqDA6o64RvdHAlN3eIWKPqwc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljAOZ4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdGsIAIkY8Eu6pF3w8z8JxBBabdHjnJ1KuCJg
/Jsm05wjvCcNdPwKmJTa7YWAbqDRd23NQ+eKT2UkP08MeLpaFP5kG2yn6cXhVPZn
6/JaLt39KHNb/Os+ETi3QPUQ/9HVDcy93eZnQa8A2HncgoF7OEe32r5jarFAs1+b
fqXePg/8YdQH0UOae5YNIYhpdXS2iiDhw2YFXOUqfomtfjx36ttR8VT8V44Is/3R
NONsn3RjXeQuw2vohoefeU+WPxoJR4UJSdWG6ErtKDUdOKlOvcxUKtqDQqwe4guZ
8y7ktGLnnKhYn5pwCf/rzUh5ovn29bnE44nVoiJH4fDS6Ih7zNjTNRo=
=bELm
-----END PGP SIGNATURE-----

--qtgEjpF5SUqDA6o64RvdHAlN3eIWKPqwc--
