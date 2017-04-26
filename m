Received: from eggs.gnu.org ([2001:4830:134:3::10]:58879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Nnn-0007F7-7x
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Nnj-0007jo-7X
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:20:19 -0400
References: <20170426141407.10161-1-mreitz@redhat.com>
	<c4d1a9fa-a155-3760-bb4e-69200764476e@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a92db0a8-d0dc-0352-ffcc-4b50a1a48133@redhat.com>
Date: Wed, 26 Apr 2017 16:20:07 +0200
MIME-Version: 1.0
In-Reply-To: <c4d1a9fa-a155-3760-bb4e-69200764476e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8HGpBhnfs3uj77DwESOI0nRK6bM8IMFa2"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Launch qemu-nbd with
 -e 42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8HGpBhnfs3uj77DwESOI0nRK6bM8IMFa2
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a92db0a8-d0dc-0352-ffcc-4b50a1a48133@redhat.com>
Subject: Re: [Qemu-block] [PATCH] iotests: Launch qemu-nbd with -e 42
References: <20170426141407.10161-1-mreitz@redhat.com>
 <c4d1a9fa-a155-3760-bb4e-69200764476e@redhat.com>
In-Reply-To: <c4d1a9fa-a155-3760-bb4e-69200764476e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.04.2017 16:18, Eric Blake wrote:
> On 04/26/2017 09:14 AM, Max Reitz wrote:
>> There is no reason for the qemu-nbd server used for tests not to accep=
t
>> an arbitrary number of clients. In fact, test 181 will require it to
>> accept two clients at the same time (and thus it fails before this
>> patch).
>>
>> This patch updates common.rc to launch qemu-nbd with -e 42 which shoul=
d
>> be enough for all of our current and future tests.
>=20
> Perfect place for you to inject some jibe about "life, the universe, an=
d
> everything" ;)

Everybody knows anyway. ;-)

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/common.rc | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
>=20
>>
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.=
rc
>> index 7d4781d4ad..31b888d4e9 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -168,7 +168,9 @@ _make_test_img()
>> =20
>>      # Start an NBD server on the image file, which is what we'll be t=
alking to
>>      if [ $IMGPROTO =3D "nbd" ]; then
>> -        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT  $TEST=
_IMG_FILE >/dev/null &"
>> +        # Pass a sufficiently high number to -e that should be enough=
 for all
>> +        # tests
>> +        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42 =
 $TEST_IMG_FILE >/dev/null &"
>=20
> Worth dropping the double-space before $TEST_IMG_FILE while touching th=
is?

I wasn't sure myself. It somehow is a nice separation between the option
arguments and the image file name so I thought that maybe it was
intended and was afraid to remove it... Well, and it doesn't really hurt.=


Why don't we have CODING_STYLE for shell scripts? :-)

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--8HGpBhnfs3uj77DwESOI0nRK6bM8IMFa2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkArJcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AVwQIALhWR6nQViK5gZOyrA+aRO7oE2fA7ot/
jWQF1/viPPfvfdkZNhojfWfInDoc7vFfLn1x8mZGcrl7342jacpgMqsLWrLXWHbd
32uAHMHC0xkKVhDAyshdMzVtrkfJZbKqMA3hDIQwDeyL+wQecNfIvoDhVvKxVyr1
fn/kp5Xk122LjfhWbH1wTaErDjVUYMOx5+U8/GWzkxbu92socJqPd6U3ywk5Q0IH
3IG8EAQmyLgbeXBuZhppxOdnGsjLNBPAKDMbE3g/94NaMdWUKZff5EloLsd9yojp
7iexr85Jcyoos09FZK5Nz2qZn35AujnbXA3xkBYT223HRCyfu9oA5T0=
=UpDH
-----END PGP SIGNATURE-----

--8HGpBhnfs3uj77DwESOI0nRK6bM8IMFa2--
