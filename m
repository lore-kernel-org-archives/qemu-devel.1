Received: from eggs.gnu.org ([209.51.188.92]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPfw-00027I-Pv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPUQ-0007HQ-2V
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:51:55 -0500
References: <20190206152919.5532-1-mreitz@redhat.com>
	<20190206154550.GT12500@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <95a078df-eb15-915b-8803-c7e5120e7713@redhat.com>
Date: Wed, 6 Feb 2019 16:51:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190206154550.GT12500@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MD8mVPqWUB2QdC1eeX0RdAp7d5DoKk4Qs"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MD8mVPqWUB2QdC1eeX0RdAp7d5DoKk4Qs
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <95a078df-eb15-915b-8803-c7e5120e7713@redhat.com>
Subject: Re: [PATCH v2 0/2] block/ssh: Implement .bdrv_refresh_filename()
References: <20190206152919.5532-1-mreitz@redhat.com>
 <20190206154550.GT12500@redhat.com>
In-Reply-To: <20190206154550.GT12500@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.02.19 16:45, Richard W.M. Jones wrote:
> On Wed, Feb 06, 2019 at 04:29:17PM +0100, Max Reitz wrote:
>> This series implements .bdrv_refresh_filename() for the ssh block
>> driver, along with an appropriate .bdrv_dirname() so we don't chop off=

>> query strings for backing files with relative filenames.
>>
>> This series depends on my "block: Fix some filename generation issues"=

>> series.
>=20
> Hey Max, I couldn't find a version of "block: Fix some filename
> generation issues" that applies to qemu master.  Do you have a git
> repo I could pull it from?

Ah, great, and I only sent it on Friday...

I pushed it here:

https://git.xanclic.moe/XanClic/qemu bds-base-filename-v13


Thanks,

Max

>> Based-on: 20190201192935.18394-1-mreitz@redhat.com
>>
>>
>> v2:
>> - No longer based on the libssh2 -> libssh patches
>> - Put /* and */ on their own lines to make checkpatch happy
>>
>>
>> Max Reitz (2):
>>   block/ssh: Implement .bdrv_refresh_filename()
>>   block/ssh: Implement .bdrv_dirname()
>>
>>  block/ssh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++---=
-
>>  1 file changed, 68 insertions(+), 5 deletions(-)
>>
>> --=20
>> 2.20.1
>=20



--MD8mVPqWUB2QdC1eeX0RdAp7d5DoKk4Qs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxbAn8ACgkQ9AfbAGHV
z0Cx1wf7B+eVQv6FiCiKtLEnWMlPuqgD3E+o1ZQ3OUeosvqncIY8+U4cU7s3OyY8
LWBjsv4y794HQLF9nU1mLzThUARLtFf8dMY9BaYban8PMrJYAT0gu3NIwUQoQE/+
/QvLhcX7BswuRnfoWJkWtW7jnqDpmOjRP2SCjLkwkYOjXNCErXXkssAeOH22+v2p
v78oAFOv5nLb4mGa8iUgAO0h/5DeGiKWeZcvy3Lrr45Ok85m3tdRkek9YdOE+oPa
8jM41zSTM4j08Tg6ApsvGunEiQyyCWX9gaDTewB+xMwRmmFwgIhVVIhYeVPMqsG6
dluRAeSFILw6OwqGY09qXzoYlYKpVg==
=NtDv
-----END PGP SIGNATURE-----

--MD8mVPqWUB2QdC1eeX0RdAp7d5DoKk4Qs--
