Received: from eggs.gnu.org ([209.51.188.92]:50515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGxc-0006ut-B6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGxb-0002Y1-Hz
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:10:24 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20190206152919.5532-1-mreitz@redhat.com>
	<5940858f-5eca-3c47-3757-cc700d1743f0@redhat.com>
Message-ID: <7bd36a18-13ca-ceb9-9a2a-bdee76a7709d@redhat.com>
Date: Mon, 25 Feb 2019 15:10:06 +0100
MIME-Version: 1.0
In-Reply-To: <5940858f-5eca-3c47-3757-cc700d1743f0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WL5QaRh9NlYIAziOK7aRm9HPuKc3bAnGQ"
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
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WL5QaRh9NlYIAziOK7aRm9HPuKc3bAnGQ
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <7bd36a18-13ca-ceb9-9a2a-bdee76a7709d@redhat.com>
Subject: Re: [PATCH v2 0/2] block/ssh: Implement .bdrv_refresh_filename()
References: <20190206152919.5532-1-mreitz@redhat.com>
 <5940858f-5eca-3c47-3757-cc700d1743f0@redhat.com>
In-Reply-To: <5940858f-5eca-3c47-3757-cc700d1743f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.02.19 14:39, Max Reitz wrote:
> On 06.02.19 16:29, Max Reitz wrote:
>> This series implements .bdrv_refresh_filename() for the ssh block
>> driver, along with an appropriate .bdrv_dirname() so we don't chop off=

>> query strings for backing files with relative filenames.
>>
>> This series depends on my "block: Fix some filename generation issues"=

>> series.
>>
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
>=20
> Thanks for having had a look at this series, Rich; I've applied it to m=
y
> block branch.

Or maybe not.  It breaks iotests 104 (because the filename now includes
your username) and 207 (because the json:{} filename is a nice filename
now).  So I'll drop it and send a v3.

Max


--WL5QaRh9NlYIAziOK7aRm9HPuKc3bAnGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxz9z8ACgkQ9AfbAGHV
z0BquwgAlYElN+bDEitlP/VgqnnNZt3ytUT4iuSBDZBxmCjyW3oVgVnshyhoK71D
XN5QMsVK/gSIyQB3kLBKMlqaAiS6J4MJ9l6xccMKS2oBSv2IsfxqKY1gGq3NAizE
JyrFrr4+G3vRtdKT29YU/WImLyM+5fBie02I5w8SqkWCx7DWe9raUf+Zrv2bfVb5
7Rxr4yPzhtU4od+1aYLfJqClYcrMZHaOH1xRGHk+l2VN/M0nTV/K+67Ze584VGHL
xYzdVVR+leVRLAq4Fp/nj0ofye2TZQWw5gKBtG1qfSCxYyP0sKGqWhLGK7+wC6Vp
DdJ15H0W4w/F44Ful1Xvf9fLAvZwUg==
=Zp2P
-----END PGP SIGNATURE-----

--WL5QaRh9NlYIAziOK7aRm9HPuKc3bAnGQ--
