Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPtlC-0006q3-LF
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPt72-0004wG-6e
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:13:13 -0400
Date: Tue, 27 Jun 2017 19:12:21 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170627161221.dfazy5n6cmzl6c33@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
	<20170626145234.GE29664@stefanha-x1.localdomain>
	<20170626165832.32mzemh4jiwpquo4@postretch>
	<w5160fhza8s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdgv4lnirpm5eetv"
Content-Disposition: inline
In-Reply-To: <w5160fhza8s.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 4/8] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--vdgv4lnirpm5eetv
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 06:05:55PM +0200, Alberto Garcia wrote:
>On Mon 26 Jun 2017 06:58:32 PM CEST, Manos Pitsidianakis wrote:
>> On Mon, Jun 26, 2017 at 03:52:34PM +0100, Stefan Hajnoczi wrote:
>>>On Fri, Jun 23, 2017 at 03:46:56PM +0300, Manos Pitsidianakis wrote:
>>>> +static bool throttle_group_exists(const char *name)
>>>> +{
>>>> +    ThrottleGroup *iter;
>>>> +    bool ret =3D false;
>>>> +
>>>> +    qemu_mutex_lock(&throttle_groups_lock);
>>>
>>>Not sure if this lock or the throttle_groups list are necessary.
>
>As Manos says accesses to the throttle_groups list need to be locked.
>
>What I don't like at first sight is the code duplication in
>throttle_group_incref() and throttle_group_obj_complete().
>
>>>Have you seen iothread.c:qmp_query_iothreads()?  All objects are put
>>>into a container (the parent object), so you can just iterate over its
>>>children.  There's no need for a separate list because QOM already has
>>>all the objects.
>
>I haven't looked into this yet but it could be a solution.

If throttle_groups_register_blk() uses QOM instead of calling=20
throttle_group_incref() the duplication could be eliminated. Then all of=20
throttle-groups.c uses QOM internally. I don't see any reason why not do=20
this.

>Berto
>

--vdgv4lnirpm5eetv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllSg+UACgkQc2J8L2kN
9xBxIRAAvGCQCLJ/Zrc4xGMViQi0xDbng5fljK7AVamhG0r4Bj0R2hmACo/Tc7BY
U3f910icVcySZ6E2GPZF2Ij/fouSfWaFD9TQgaV0CQes/peyH8OqAGunvZcQPdMb
jY1D7ud2dqTQUB2Zj4N68+lVL9/f+sqD/yS2HuaURzVV4xqz0SiKE2LsfWmvDsuI
7NUgsKBkZwBckIaAnpgDGEAQ4e5KoUDHA2su2y4VQyACBQEz8lpMR6TUUaxpd50/
isST8rxa/P//xNp+4QbjzbY6BBL3TOPL196jF1D4uFmXGpkHyivPYAFRHTyAeh4d
TWg4DSXcpKbsI+xym8SRVP2VRTYc0OFrxBCkn365AkHxdhB1LU9caT1jKnw+YNEK
Nvtks8I0ilq7EbN1jqox3YZuxDkXt8U/pgx738BHeUXMwQxDWvJ6olwgpZYC3F5m
u9fKnF+5u1bSyz+BT4bvVBwWVJyE79ymruNYeYtlo2dLtlcdN+K6PKVE9hl/ITAW
ZbxGhtqqG70X+DI1St9lwGdSDq657S4qosixeZcBIgHLEN0fFej7uAu5ezg3SnYo
nNJY1JY++xVgHzUZiG1YbHZ2JVYINYItH5mN7AOfzK3gcVhpvAB7Ym6vStk1xVwh
QXtA29vl/oP2nb5Xa1xsHuOEwbgsHTXNGbJZYDuEp+athuekUfw=
=pQXC
-----END PGP SIGNATURE-----

--vdgv4lnirpm5eetv--
