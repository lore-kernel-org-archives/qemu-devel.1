Received: from eggs.gnu.org ([2001:4830:134:3::10]:42833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eybsQ-00049N-FP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eybsP-0005yg-Gv
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:25:54 -0400
References: <20180228180507.3964-1-mreitz@redhat.com>
	<20180228180507.3964-16-mreitz@redhat.com>
	<fea69d15-d7e4-6772-c583-c224b3dbe4a1@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e49e36f0-88a0-9e5b-1c3d-fab3d24a3c63@redhat.com>
Date: Wed, 21 Mar 2018 12:25:30 +0100
MIME-Version: 1.0
In-Reply-To: <fea69d15-d7e4-6772-c583-c224b3dbe4a1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xJZ42SOkGZ8h5gBhTmxak0xPtEsbGkJso"
Subject: Re: [Qemu-devel] [PATCH v3 15/16] block/mirror: Add copy mode QAPI
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xJZ42SOkGZ8h5gBhTmxak0xPtEsbGkJso
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <e49e36f0-88a0-9e5b-1c3d-fab3d24a3c63@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 15/16] block/mirror: Add copy mode QAPI
 interface
References: <20180228180507.3964-1-mreitz@redhat.com>
 <20180228180507.3964-16-mreitz@redhat.com>
 <fea69d15-d7e4-6772-c583-c224b3dbe4a1@redhat.com>
In-Reply-To: <fea69d15-d7e4-6772-c583-c224b3dbe4a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-20 18:35, Eric Blake wrote:
> On 02/28/2018 12:05 PM, Max Reitz wrote:
>> This patch allows the user to specify whether to use active or only
>> background mode for mirror block jobs.=C2=A0 Currently, this setting w=
ill
>> remain constant for the duration of the entire block job.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++++++=
++--
>> =C2=A0 include/block/block_int.h |=C2=A0 4 +++-
>> =C2=A0 block/mirror.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 12 +++++++-----
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++++-
>> =C2=A0 4 files changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index c73b769c27..1186c007ae 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1573,6 +1573,9 @@
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 written. Both=
 will result in identical contents.
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Default is tr=
ue. (Since 2.4)
>> =C2=A0 #
>> +# @copy-mode: when to copy data to the destination; defaults to
>> 'background'
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (Since: 2.12)
>> +#
>=20
> Are we still aiming for 2.12, or is this a feature which missed
> softfreeze and should therefore be 2.13?

The latter, I'll change it in v4.

Max


--xJZ42SOkGZ8h5gBhTmxak0xPtEsbGkJso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqyQSoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxRoIAKCqzmGzBXZfQan92XSWk3En6W/8BX17
Q2bgy4zZtqbSqO4hoRikOJGIP3rFArnlOX+ZXGNow9+QuviQESm4ZICUPogSOlIG
s/15fVVfBRUB6W0ZYPrSmXAEfpNhzA9QF+eWv0kh913AArjg1iGOMf+gH9YXODZY
MuXep0CaqwyODMr3cogdUTi3eH+gRP2KIwe3As+vxv+0tvlNcHdrs8dSWXAPmn5g
xyb14so1tysmF7pLU4v9eZhXGJ9XopG1D67Qj6fHVbHXtNJvjyt0NGWNmtaRIQL9
Ivz+ZVxBDrlpnVPULHMAc5khSdAGJjzEMz9E5d+ipflIU3PNEcLTNxc=
=J9hZ
-----END PGP SIGNATURE-----

--xJZ42SOkGZ8h5gBhTmxak0xPtEsbGkJso--
