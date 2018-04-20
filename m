Received: from eggs.gnu.org ([2001:4830:134:3::10]:36398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9W1i-00024O-9x
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9W1e-0008Dv-CF
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:24:34 -0400
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-12-mreitz@redhat.com>
	<fec5bd7d-74e8-a3f7-f885-df0fb0d3b9bf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5ad09691-7a6f-1b63-d8e0-7b518dfd4e9a@redhat.com>
Date: Fri, 20 Apr 2018 15:24:19 +0200
MIME-Version: 1.0
In-Reply-To: <fec5bd7d-74e8-a3f7-f885-df0fb0d3b9bf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6MqHKH44SeEtqC6N7OVIok1MpWcFBsI2D"
Subject: Re: [Qemu-devel] [PATCH v4 11/13] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6MqHKH44SeEtqC6N7OVIok1MpWcFBsI2D
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <5ad09691-7a6f-1b63-d8e0-7b518dfd4e9a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/13] block/mirror: Add active mirroring
References: <20180411185425.2461-1-mreitz@redhat.com>
 <20180411185425.2461-12-mreitz@redhat.com>
 <fec5bd7d-74e8-a3f7-f885-df0fb0d3b9bf@redhat.com>
In-Reply-To: <fec5bd7d-74e8-a3f7-f885-df0fb0d3b9bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-12 00:14, Eric Blake wrote:
> On 04/11/2018 01:54 PM, Max Reitz wrote:
>> This patch implements active synchronous mirroring.  In active mode, t=
he
>> passive mechanism will still be in place and is used to copy all
>> initially dirty clusters off the source disk; but every write request
>> will write data both to the source and the target disk, so the source
>> cannot be dirtied faster than data is mirrored to the target.  Also,
>> once the block job has converged (BLOCK_JOB_READY sent), source and
>> target are guaranteed to stay in sync (unless an error occurs).
>>
>> Active mode is completely optional and currently disabled at runtime. =
 A
>> later patch will add a way for users to enable it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>  qapi/block-core.json |  18 ++++
>>  block/mirror.c       | 252 ++++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>  2 files changed, 265 insertions(+), 5 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index c50517bff3..8210d601f4 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1049,6 +1049,24 @@
>>  { 'enum': 'MirrorSyncMode',
>>    'data': ['top', 'full', 'none', 'incremental'] }
>> =20
>> +##
>> +# @MirrorCopyMode:
>> +#
>> +# An enumeration whose values tell the mirror block job when to
>> +# trigger writes to the target.
>> +#
>> +# @background: copy data in background only.
>> +#
>> +# @write-blocking: when data is written to the source, write it
>> +#                  (synchronously) to the target as well.  In
>> +#                  addition, data is copied in background just like i=
n
>> +#                  @background mode.
>> +#
>> +# Since: 2.12
>=20
> Missed an instance of 2.13

:-/

Will fix.

Max


--6MqHKH44SeEtqC6N7OVIok1MpWcFBsI2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrZ6gMACgkQ9AfbAGHV
z0BChwgAht4NITOX+zG9bg2PFtZtGHSw4yEAhH8scCRnAZmrUBkExzOVwEsvzc4g
tyilJqgJQc3CzW1siWWJYC78sTKlZtodKKH/1p5abf3MFTZm1OACsYmmdnaqk7g4
QSUKnJi+uC3V2WJEwrbqfyVO/HTsxA/JvjSkOdgDPwi1KkCJ/W7iuhGhiJ9q+9Wr
PIKm0P0cduDhcXARwhZvzZqD+yOTbn3zmvJpfoLe6EQWV/ATeRMtxHu22vFmly9+
zzzW/fE0Z6/d2e6/W1Up/zpwKCpY2gk7OUivsjugVea2VxMqMwyqm6/Znw4ev6sf
dNpf7hwR8VPstScs008vSgzyCTtpzQ==
=ZlyW
-----END PGP SIGNATURE-----

--6MqHKH44SeEtqC6N7OVIok1MpWcFBsI2D--
