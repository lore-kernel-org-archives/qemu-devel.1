Received: from eggs.gnu.org ([2001:4830:134:3::10]:52392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcoS-000145-Km
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcoQ-0000Pv-O5
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:07:44 -0500
References: <20171113150026.4743-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6dcfec3-310e-bd86-5d43-97da38b23c7c@redhat.com>
Date: Tue, 14 Nov 2017 16:07:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171113150026.4743-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="35LX63kukWEqwHXwQjcQk2hU18FfWrMC2"
Subject: Re: [Qemu-devel] [PATCH] iotests: 077: Filter out 'resume' lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--35LX63kukWEqwHXwQjcQk2hU18FfWrMC2
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <e6dcfec3-310e-bd86-5d43-97da38b23c7c@redhat.com>
Subject: Re: [PATCH] iotests: 077: Filter out 'resume' lines
References: <20171113150026.4743-1-famz@redhat.com>
In-Reply-To: <20171113150026.4743-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-13 16:00, Fam Zheng wrote:
> In the "Overlapping multiple requests" cases, the 3rd reqs (the break
> point B) doesn't wait for the 2nd, and once resumed the I/O will just
> continue.  This is because the 2nd is already waiting for the 1st, and
> in wait_serialising_requests() there is:
>=20
>     /* If the request is already (indirectly) waiting for us, or
>      * will wait for us as soon as it wakes up, then just go on
>      * (instead of producing a deadlock in the former case). */
>     if (!req->waiting_for) {
>         /* actually break */
>         ...
>     }
>=20
> Consequently, the following "sleep 100; resume A" command races with th=
e
> completion of that request, and sometimes results in an unexpected
> order of output:
>=20
>> @@ -56,9 +56,9 @@
>>  wrote XXX/XXX bytes at offset XXX
>>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>  blkdebug: Resuming request 'B'
>> +blkdebug: Resuming request 'A'
>>  wrote XXX/XXX bytes at offset XXX
>>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -blkdebug: Resuming request 'A'
>>  wrote XXX/XXX bytes at offset XXX
>>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>  wrote XXX/XXX bytes at offset XXX
>=20
> Filter out the "Resuming request" lines to make the output
> deterministic.
>=20
> Reported-by: Patchew <no-reply@patchew.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/077     |  3 ++-
>  tests/qemu-iotests/077.out | 48 ++++++++++++++++----------------------=
--------
>  2 files changed, 18 insertions(+), 33 deletions(-)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--35LX63kukWEqwHXwQjcQk2hU18FfWrMC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLBqgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASFQH/3fVLYuF/X1G/9Onw/8nXy2vWPGLi2x3
0bul0fpAn/fD+1fzENKvBV9zgarmOAvYFKaUEAGxINgKgdfg27Yt2+KL9IpgBqbw
GYGDwt3Pb5vaGRV/uWGlQ8aw1n6jyx8ZrIKe6r5imdYO3xSpIaFkwGRZmGeqXweZ
Bjz4QrypSe2gRjASKzrPrfraKVEP+ydPo9lQ2GjFSJks4IvhvP9vZOzB0Pwn+xEZ
hmBzJWsSFIQ0/247CJ4S35jODUnniLquwoPe73FLjgdFYGUN74lNB8quIdGKJRTJ
IGy80hjPgtKd9D+/hy01ybECTHJkieBfk5XMursAgACwYgO3AoGsOvc=
=cyHH
-----END PGP SIGNATURE-----

--35LX63kukWEqwHXwQjcQk2hU18FfWrMC2--
