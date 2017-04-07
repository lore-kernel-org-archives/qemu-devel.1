Received: from eggs.gnu.org ([2001:4830:134:3::10]:48291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwUSP-0000cC-PF
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwUSO-0005Ts-R4
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:01:45 -0400
References: <1491561165-12415-1-git-send-email-kwolf@redhat.com>
	<71657ad0-5d2f-5d26-1c42-854e50e6786c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1833e44f-e221-0c10-0e99-d6a499c5eb83@redhat.com>
Date: Fri, 7 Apr 2017 16:01:35 +0200
MIME-Version: 1.0
In-Reply-To: <71657ad0-5d2f-5d26-1c42-854e50e6786c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bj4GJfRBVkr4c1uoPqIA8GXijDFTDM1kh"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Don't check permissions for
 copy on read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: rjones@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bj4GJfRBVkr4c1uoPqIA8GXijDFTDM1kh
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Cc: rjones@redhat.com, qemu-devel@nongnu.org
Message-ID: <1833e44f-e221-0c10-0e99-d6a499c5eb83@redhat.com>
Subject: Re: [PATCH for-2.9] block: Don't check permissions for copy on read
References: <1491561165-12415-1-git-send-email-kwolf@redhat.com>
 <71657ad0-5d2f-5d26-1c42-854e50e6786c@redhat.com>
In-Reply-To: <71657ad0-5d2f-5d26-1c42-854e50e6786c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.04.2017 15:53, Eric Blake wrote:
> On 04/07/2017 05:32 AM, Kevin Wolf wrote:
>> The assertion is currently failing. We can't require callers to have
>> write permissions when all they are doing is a read, so comment it out=
=2E
>> Add a FIXME comment in the code so that the check is re-enabled when
>> copy on read is refactored into its own filter driver.
>>
>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block/io.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 2709a70..7321dda 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -945,7 +945,14 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(=
BdrvChild *child,
>>      size_t skip_bytes;
>>      int ret;
>> =20
>> -    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE))=
;
>> +    /* FIXME We cannot require callers to have write permissions when=
 all they
>> +     * are doing is a read request. If we did things right, write per=
missions
>> +     * would be obtained anyway, but internally by the copy-on-read c=
ode. As
>> +     * long as it is implemented here rather than in a separat filter=
 driver,
>=20
> s/separat/separate/
>=20
>> +     * the copy-on-read code doesn't have its own BdrvChild, however,=
 for which
>> +     * it could request permissions. Therefore we have to bypass the =
permission
>> +     * system for the moment. */
>> +    // assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRIT=
E));
>=20
> Makes checkpatch.pl unhappy - but that's intentional.

Is it? I don't know. But not that I mind, so for good measure:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> Reviewed-by: Eric Blake <eblake@redhat.com>



--Bj4GJfRBVkr4c1uoPqIA8GXijDFTDM1kh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljnm78SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4h0IAK/XtROsnjBuglchBD2KOLrAPXWF+PxL
pB3HOcCGHrXLkpDUBs4+S74SUm/4hoykiWzuswdKWf2D28X+8xrRcqVCpPcSvVfG
d9kTK+rS9fH8KeeeZRaLvC4kp7ZGFUEZeZgBb8Ox/jm8bh/KZLnjNKCv+0fZhNQC
HBMHMCx0dR9+q0AhmNLk+2V5sj54qDr5s5i/ETFmGvlReCxbnjEIkjywbb7F9/O0
uB6o097KaWI40sbf3Xh8rHw3Q7Hypzu8/h5lPLSY2a92HlByf2y7iYQOAkIkQBzt
9isdwSLFeY2+etiKTWhCce5LTgGNq/HZ7WN6WVh978m/8h2JIa1abHA=
=bly7
-----END PGP SIGNATURE-----

--Bj4GJfRBVkr4c1uoPqIA8GXijDFTDM1kh--
