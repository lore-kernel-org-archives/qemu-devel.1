Received: from eggs.gnu.org ([2001:4830:134:3::10]:42248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRal-0008LG-Ns
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRaa-0006q6-Kn
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:01:11 -0400
References: <20181015172817.19796-1-mreitz@redhat.com>
	<20181015172817.19796-2-mreitz@redhat.com>
	<8736t5nk1a.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <adc77702-07dd-8aa7-c88c-3144597652da@redhat.com>
Date: Fri, 19 Oct 2018 12:00:47 +0200
MIME-Version: 1.0
In-Reply-To: <8736t5nk1a.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oTK9lz6h4RXqvJwdAx1L10AC59udXy2aY"
Subject: Re: [Qemu-devel] [PATCH 1/5] option: Make option help nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oTK9lz6h4RXqvJwdAx1L10AC59udXy2aY
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <adc77702-07dd-8aa7-c88c-3144597652da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] option: Make option help nicer to read
References: <20181015172817.19796-1-mreitz@redhat.com>
 <20181015172817.19796-2-mreitz@redhat.com>
 <8736t5nk1a.fsf@dusky.pond.sub.org>
In-Reply-To: <8736t5nk1a.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.10.18 08:50, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This adds some whitespace into the option help (including indentation)=

>> and replaces '=3D' by ': ' (not least because '=3D' should be used for=

>> values, not types).  Furthermore, the list name is no longer printed a=
s
>> part of every line, but only once in advance, and only if the caller d=
id
>> not print a caption already.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/qemu/option.h      |   2 +-
>>  qemu-img.c                 |   4 +-
>>  util/qemu-option.c         |  31 +-
>>  tests/qemu-iotests/082.out | 956 ++++++++++++++++++------------------=
-
>>  4 files changed, 505 insertions(+), 488 deletions(-)
>=20
> 082 fails for me in master (dddb37495b8).  If this patch fixes the
> failure, its commit message should mention it.

Ah, yeah, totally forgot that...

Max

> 091 and 142 also fail, but look unrelated.



--oTK9lz6h4RXqvJwdAx1L10AC59udXy2aY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJq08ACgkQ9AfbAGHV
z0BlbAf9GcGEVDuTL9hGVdPozIuYK1PIWXQA9dUU69BG7aSFhRrlpdA3oMZn/8xB
mE023KGoajWmAT9y8mjjOLVkxVcCG22T7uHbtM3m2WGo5h8MmJV9RojvAGv2TnRx
3pKU1zwM/yWvR/A8dqyU3eFFssUA4t7hKRmSMoOvKvmrxn7nz1+8539X6B9QM+In
02KFT4EW+AIFaycTA0JJX5Y+nrDHIk6bXKhPydjxeiOWoBSzFTG5jlcgtF9amrcD
ghAasHj7p0c971mwl92ELvxPV+v4eAkjUtxxTt3i451xcc2p4Qj8yBapkKIjz/Qx
ylXIxPOG/2wc1nr971ca4Wvbds0gcA==
=yCAn
-----END PGP SIGNATURE-----

--oTK9lz6h4RXqvJwdAx1L10AC59udXy2aY--
