Received: from eggs.gnu.org ([2001:4830:134:3::10]:57624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Njh-0003ix-An
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Nja-0005O2-PJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:16:05 -0400
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-2-mreitz@redhat.com>
	<30f7fab5-7e25-5648-f6b3-c60452c6b8f3@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d45441ea-3adb-5667-b0cf-8739734ade48@redhat.com>
Date: Wed, 26 Apr 2017 16:15:48 +0200
MIME-Version: 1.0
In-Reply-To: <30f7fab5-7e25-5648-f6b3-c60452c6b8f3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8xVOcBEUO0KhMlsmSlk64anrEfAPQhWfQ"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-img/convert: Use @opts for one
 thing only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8xVOcBEUO0KhMlsmSlk64anrEfAPQhWfQ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d45441ea-3adb-5667-b0cf-8739734ade48@redhat.com>
Subject: Re: [PATCH v2 1/3] qemu-img/convert: Use @opts for one thing only
References: <20170426134649.9042-1-mreitz@redhat.com>
 <20170426134649.9042-2-mreitz@redhat.com>
 <30f7fab5-7e25-5648-f6b3-c60452c6b8f3@redhat.com>
In-Reply-To: <30f7fab5-7e25-5648-f6b3-c60452c6b8f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.04.2017 16:03, Eric Blake wrote:
> On 04/26/2017 08:46 AM, Max Reitz wrote:
>> After storing the creation options for the new image into @opts, we
>> fetch some things for our own information, like the backing file name,=

>> or whether to use encryption or preallocation.
>>
>> With the -n parameter, there will not be any creation options; this is=

>> not too bad because this just means that querying a NULL @opts will
>> always return the default value.
>>
>> However, we also use @opts for the --object options. Therefore, @opts =
is
>> not necessarily NULL if -n was specified; instead, it may contain thos=
e
>> options. In practice, this probably does not cause any problems becaus=
e
>> there most likely is no object that supports any of the parameters we
>> query here, but this is neither something we should rely on nor does
>> this variable reuse make the code very nice to read.
>>
>> Therefore, just use an own variable for the --object options.
>=20
> Reads better with s/an own/a separate/

I certainly wouldn't mind if someone (*cough*) were to update this while
applying. O:-)

Max

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  qemu-img.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>=20
> R-b still stands.


--8xVOcBEUO0KhMlsmSlk64anrEfAPQhWfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkAq5QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2poIAJk/p0WgHxLoIKt2ZqWDZ5fBMJB2/S64
iE6fGxikHj1I7c3tZLuDGOKbcZBaZaon3m15MAHt+/hjD+6iIYssJtgXxMOD4lQv
pXhNXjQSK55XAmmnXSrin4Tq52VG2gu1SopfCLT4V4kqKR2IAPSTJo/E3CoBqqrA
8TOPo+ga7bt+I2+DkCuwr16atlXON7yu+NRpYSSOb9av0nf5j6TCfwOT9i1wXQ0t
zCu+cspdSwZcDm2kbEZHJK1w4i0V7XJQetyY0L0tVuxBBFG4XTJiSMFag/PM91lc
0mzmDYG1veg+GW1OPbYZ3nyTXWtDhEnTId0dgyXwLNSmMgrmxus4nAs=
=xWKI
-----END PGP SIGNATURE-----

--8xVOcBEUO0KhMlsmSlk64anrEfAPQhWfQ--
